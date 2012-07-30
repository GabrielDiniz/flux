<?php

if(!$_POST['cmbEmpresaCliente']){
    $empresa = $_SESSION['codempresa'];
}else{
    $empresa = $_POST['cmbEmpresaCliente'];
}
$empresas=mysql_query("SELECT * FROM cadastro WHERE codigo='{$empresa}'");
$dados=mysql_fetch_array($empresas);
?>
<?php $meses=array("1"=>"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"); ?>
    <form method="post" id="FrmLivro" onsubmit="return ValidaFormulario('txtObs|cmbMes|cmbAno');">
	<table border="0" align="center" cellpadding="0" cellspacing="1">
		<tr>
			<td width="10" height="10" bgcolor="#FFFFFF"></td>
			<td width="120" align="center" bgcolor="#FFFFFF" rowspan="3">Gerar Livro</td>
			<td width="450" bgcolor="#FFFFFF"></td>
		</tr>
		<tr>
			<td height="1" ></td>
			<td ></td>
		</tr>
		<tr>
			<td height="10" bgcolor="#FFFFFF"></td>
			<td bgcolor="#FFFFFF"></td>
		</tr>
		<tr>
			<td colspan="3" height="1" ></td>
		</tr>
		<tr>
			<td height="60" colspan="3" >        
	            <br />
                 <input type="hidden" name="txtCodCadastro" value="<?php echo $empresa; ?>" id="txtCodCadastro">


                 <table  width="100%">
                    <tr>
                        <td>
                         Período
                        </td>
                        <td>
				<?php
				$diaatual=date("Y-m-d");
				if($dados['datainicio']==NULL || $dados['datainicio']==0000-00-00){ $dados['datainicio'] = $diaatual; }
				$anoatual=date("Y");
				$anoempresa=substr($dados['datainicio'],0,-6);
				$anofimempresa=substr($dados['datafim'],0,-6);
				if($dados['datafim']<$dados['datainicio']){ $dados['datafim']=NULL; } if($dados['datafim']>$dados['diaatual']){ $dados['datafim']=NULL; }
                ?>
                 <table cellpadding="0" cellspacing="0"><tr><td>
                 <input type="hidden" name="codempresa" id="codempresa" value="<?php echo $_POST['cmbEmpresaCliente']; ?>" />
				  <select name="cmbAno" id="cmbAno" onchange="acessoAjax('./listaperiodo.ajax.php','FrmLivro','divSelect');" >
	                  <option value="">Escolha o ano</option>
						<?php
						if($dados['datafim']==NULL){
							for($ano=$anoatual;$ano>=$anoempresa;$ano--){
								echo "<option value=\"$ano\">$ano</option>";
							}
						}else{
							for($ano=$anoempresa;$ano<=$anofimempresa;$ano++){
								echo "<option value=\"$ano\">$ano</option>";
							}
						}
				?>
                  </select>
                  </td>
                  <td id="divSelect" style="float:left">
                  <select name="cmbMes" id="cmbMes">
					  <option value=""></option>
	              </select>
                  </td></tr></table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                         	Obs
                        </td>
                        <td align="left">
                        	 <textarea class="texto" name="txtObs" rows="10" cols="40"></textarea><font style="color:#FF0000">*</font>        
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="btGerar" value="Gerar Livro" class="botao">
                        </td>
                        <td align="right"> 
				&nbsp;&nbsp;&nbsp;<font color="#FF0000">*</font>Campos Obrigatórios
                        </td>
                    </tr>
                </table>

        </td>
            </tr>
            <tr>
                <td height="1" colspan="3" ></td>
            </tr>
        </table>
    </form>            

