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
<?php
	if($btSolicitar!="")
		{
			$codigoempresa = $_POST['cmbEmpresa'];
			$notaempresa=mysql_query("SELECT ultimanota, notalimite FROM cadastro WHERE codigo = '$codigoempresa'");
			list($ultimanota,$notalimite)=mysql_fetch_array($notaempresa);
			$sql_aidfe=mysql_query("SELECT codigo FROM aidfe_solicitacoes WHERE solicitante = '$codigoempresa'");
			$numero_de_solicitacoes = mysql_num_rows($sql_aidfe);
			if($numero_de_solicitacoes>0){
				Mensagem('Sua solicita&ccedil;&atilde;o j&aacute; foi enviada a prefeitura.');
				Redireciona('aidf.php');
			}else{
				if($notalimite==0){
					mysql_query("INSERT INTO aidfe_solicitacoes SET solicitante = '$codigoempresa'");
					Mensagem('Uma solicita&ccedil;&aring;o de aumento de AIDF foi enviada &agrave; prefeitura!');
					add_logs('Solicitou um aumento no AIDF');
					Redireciona('aidf.php');
				}else{
					Mensagem('Uma solicita&ccedil;&aring;o de aumento de AIDF foi enviada &agrave; prefeitura!');
					Redireciona('aidf.php');	
				}
			}
		}
	$sql=mysql_query("SELECT ultimanota, notalimite, razaosocial FROM cadastro WHERE codigo = '$CODIGO_DA_EMPRESA'");
	list($ultimanota,$notalimite,$razaocontador)=mysql_fetch_array($sql);
	if($notalimite==0){$notalimite="Liberado";}
	$sqlempresas=mysql_query("SELECT ultimanota, notalimite, razaosocial FROM cadastro WHERE codcontador = '$CODIGO_DA_EMPRESA'");
?>
<form method="post">
<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="100" align="center" bgcolor="#FFFFFF" rowspan="3">AIDF Eletr&ocirc;nico</td>
      <td width="470" bgcolor="#FFFFFF"></td>
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

        <table align="center" width="100%">
        	<tr>
            	<td colspan="2" bgcolor="#666666">
                <?php echo "Razão Social: ".$razaocontador; ?>
                </td>
            </tr>
            <tr align="left" bgcolor="#FFFFFF">
                <td width="50%">N&uacute;mero da &uacute;ltima nota emitida:</td>
                <td width="50%"><?php echo $ultimanota; ?></td>
            </tr>
            <tr align="left" bgcolor="#FFFFFF">
                <td>Nota limite / AIDF:</td>
                <td><?php echo $notalimite; ?></td>
            </tr>
        </table>
        <?php
		if(mysql_num_rows($sqlempresas)>0){
			while(list($ultimanotaemp,$notalimiteemp,$razaocontadoremp)=mysql_fetch_array($sqlempresas)){
				if($notalimiteemp==0){
					$notalimiteemp="Liberado";
				}
				?>
				<table align="center" width="100%">
					<tr>
						<td colspan="2" bgcolor="#666666">
						<?php echo "Razão Social: ".$razaocontadoremp; ?>
						</td>
					</tr>
					<tr align="left" bgcolor="#FFFFFF">
						<td width="50%">N&uacute;mero da &uacute;ltima nota emitida:</td>
						<td width="50%"><?php echo $ultimanotaemp; ?></td>
					</tr>
					<tr align="left" bgcolor="#FFFFFF">
						<td>Nota limite / AIDF:</td>
						<td><?php echo $notalimiteemp; ?></td>
					</tr>
				</table>
				<?php
			}
		}
	        if($notalimite != "Liberado"){
    	    $sqlcontadores=mysql_query("SELECT codigo, razaosocial,contadornfe FROM cadastro WHERE codcontador='$CODIGO_DA_EMPRESA' AND contadornfe = 'S'");?>	
        		<table align="center" width="100%">
					<tr>
                        <td align="left" width="25%">Solicitante de Aidf-e:</td>
                        <td align="left">
                            <select name="cmbEmpresa" id="cmbEmpresa">
                                <option value="<?php echo $CODIGO_DA_EMPRESA; ?>"><?php echo $razaocontador; ?></option>
									<?php
                                        if(mysql_num_rows($sqlcontadores)>0){
                                            while(list($codigo,$razaosocial,$Nfe)= mysql_fetch_array($sqlcontadores)){
                                                echo "<option value=\"$codigo\">$razaosocial </option>";
                                            }
                                        }
                                    ?>
                            </select>
                        </td>
					</tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" name="btSolicitar" value="Solicitar mais notas" class="botao" 
                        </td>
					</tr>
        		</table>
        <?php } ?>
		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>
</table>   
</form>	
