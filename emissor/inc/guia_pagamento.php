<?php
/*
COPYRIGHT 2008 - 2010 DO PORTAL PUBLICO INFORMATICA LTDA

Este arquivo e parte do programa E-ISS / SEP-ISS

O E-ISS / SEP-ISS e um software livre; voce pode redistribui-lo e/ou modifica-lo
dentro dos termos da Licenca Publica Geral GNU como publicada pela Fundacao do
Software Livre - FSF; na versao 2 da Licenca

Este sistema e distribuido na esperanca de ser util, mas SEM NENHUMA GARANTIA,
sem uma garantia implicita de ADEQUACAO a qualquer MERCADO ou APLICACAO EM PARTICULAR
Veja a Licenca Publica Geral GNU/GPL em portugues para maiores detalhes

Voce deve ter recebido uma copia da Licenca Publica Geral GNU, sob o titulo LICENCA.txt,
junto com este sistema, se nao, acesse o Portal do Software Publico Brasileiro no endereco
www.softwarepublico.gov.br, ou escreva para a Fundacao do Software Livre Inc., 51 Franklin St,
Fith Floor, Boston, MA 02110-1301, USA
*/
?>

<script src="../scripts/jquery.js" language="javascript" type="text/javascript"></script>
<?php 
//recebe os dados
$cnpj=$_SESSION['login'];

//determina o emissor
$sql_login=mysql_query("SELECT * FROM cadastro WHERE cnpj='$cnpj' OR cpf='$cnpj'");
$dados=mysql_fetch_array($sql_login);

if(mysql_num_rows($sql_login)<1){
	Mensagem("CNPJ/CPF ou senha inv&aacute;lidos");
	Redireciona("site/des.php");
}

// carrega as regras de multa por ataso
listaRegrasMultaDes();
?>
<script type="text/javascript">
function AbrirGuias(ano, mes){
	$('#divResultado').html('carregando');	
	$.ajax({			
		url: "./inc/guia_pagamento.ajax.php?cmbAno=" + document.getElementById(ano).value + "&cmbMes=" + document.getElementById(mes).value,			
		success: function(msg){
		  $('#divResultado').html(msg);
		}
	});
}
</script>
<table width="580" border="0" cellpadding="0" cellspacing="1">
    <tr>
		<td width="5%" height="10" bgcolor="#FFFFFF"></td>
        <td width="40%" align="center" bgcolor="#FFFFFF" rowspan="3" class="fieldsetCab">Emiss&atilde;o da Guia de Pagamento</td>
        <td width="55%" bgcolor="#FFFFFF"></td>
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
	<?php
    $qryano=mysql_query("SELECT DISTINCT SUBSTRING(periodo,1,4) FROM livro WHERE codcadastro='{$dados['codigo']}' AND estado='N'");
    $diaatual=date("Y-m-d");
    if($dados['datainicio']==NULL || $dados['datainicio']==0000-00-00){ $dados['datainicio'] = $diaatual; }
    $anoatual=date("Y");
    $anoempresa=substr($dados['datainicio'],0,-6);
    $anofimempresa=substr($dados['datafim'],0,-6);
    if($dados['datafim']<$dados['datainicio']){ $dados['datafim']=NULL; } if($dados['datafim']>$dados['diaatual']){ $dados['datafim']=NULL; }
    if(mysql_num_rows($qryano)>0){
    $qtdanos=mysql_num_rows($qryano);
    $codcript=base64_encode('des');
    ?>
	<tr>
		<td height="60" colspan="3"  align="center">
			<p align="center">Escolha o per&iacute;odo da compet&ecirc;ncia e o tipo</p>				
			<form method="post" id="frmPeriodo">
				<input type="hidden" name="txtMenu" value="guia_pagamento" />
				<table>
					<tr>
						<td>
                    <!--<input type="hidden" name="pg" id="pg" value="<?php echo $codcript; ?>" />
                    <input type="hidden" name="codempresa" id="codempresa" value="<?php echo $dados['codigo']; ?>" />
                    <input type="hidden" name="stringsql" id="stringsql" value="<?php echo " AND estado='N'"; ?>" />-->
					  <select name="cmbAno" id="cmbAno" onchange="acessoAjax('./listaperiodo.ajax.php','frmPeriodo','divSelect')">
						  <option value="">Selecione o ano</option>
			              <?php
						  	if($datafim==NULL){
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
                      <td>
                      <div id="divSelect">
                      <select name="cmbMes" id="cmbMes">
		                  <option value="">Selecione o mes</option>
	                  </select>
                      </div>
						</td>
						<td><input type="submit" class="botao" name="btBuscar" value="Buscar" onclick="AbrirGuias('cmbAno','cmbMes','cmbTipo'); return false;"/></td> 
					</tr>
					
				</table>
                <div id="divResultado"></div>
			</form><br>
		</td>
	</tr>
	<?php 
	}else{
		?>
		<tr>
			<td height="60" colspan="3"  align="center">Nenhum livro fechado ou guias j&aacute; emitidas.</td>
        </tr>
		<?php
	} ?>
</table>

