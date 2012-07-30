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
	$codLogado = $_POST['cmbEmissor'];
?>
<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Solicita&ccedil;&atilde;o de RPS</td>
      <td width="400" bgcolor="#FFFFFF"></td>
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
			<?php
				if(isset($_POST['btSolicitarRPS'])){
					if($_POST['btSolicitarRPS'] == "Solicitar RPS"){
						include("solicitar_rps.php");
					}
				}
				
				$sql_rps_controle = mysql_query("SELECT ultimorps, limite FROM rps_controle WHERE codcadastro = '$codLogado'");
				if(mysql_num_rows($sql_rps_controle)){
					list($ultimoRPS,$limiteRPS) = mysql_fetch_array($sql_rps_controle);
				}else{
					$ultimoRPS = 0;
					$limiteRPS = 0;
					$mensagem  = "Faça uma solicitação de RPS";
				}
				
				
				$sql_testa_solicitacao = mysql_query("SELECT codigo FROM rps_solicitacoes WHERE codcadastro = '$codLogado' AND estado = 'A'");
				if(mysql_num_rows($sql_testa_solicitacao)){
					$disabled = "disabled=\"disabled\"";
					$styleSpan = "";
					$mensagem = "Aguarde liberação da prefeitura";
				}else{
					$disabled = "";
					if($limiteRPS > 0){
						$styleSpan = "style=\"display:none\"";
					}
				}
			?>
			<form method="post">
				<input name="cmbEmissor" type="hidden" value="<?php echo $codLogado;?>" />
				<input name="btOK" type="hidden" value="<?php echo $_POST['btOK'];?>" />
				<input name="codLogado" type="hidden" value="<?php echo $codLogado;?>" />
				<table width="100%" cellpadding="0" cellspacing="2">
					<tr>
						<td width="22%" align="right">Ultimo RPS emitido: </td>
						<td width="78%" align="left"><strong><?php echo $ultimoRPS;?></strong></td>
					</tr>
					<tr>
						<td align="right">RPS limite: </td>
						<td align="left"><strong><?php echo $limiteRPS;?></strong></td>
					</tr>
					<tr>
						<td align="right" valign="bottom" height="22">
							<input name="btSolicitarRPS" type="submit" value="Solicitar RPS" class="botao" <?php echo $disabled;?> />
						</td>
						<td align="left">
							<span <?php echo $styleSpan;?>><strong><?php echo $mensagem;?></strong></span>
						</td>
					</tr>
				</table>
			</form>
			
		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>
</table>

<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Arquivo para Importa&ccedil;&atilde;o</td>
      <td width="400" bgcolor="#FFFFFF"></td>
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
        
<table width="100%" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		
			<?php
			//SELECIONA A ULTIMA NOTA INSERIDA PELA EMPRESA
			$sql_ultimanota = mysql_query("SELECT ultimanota, notalimite FROM cadastro WHERE codigo = '$codLogado'");
			list($ultimanota,$notalimite)=mysql_fetch_array($sql_ultimanota);
			$proximaNota = $ultimanota + 1;
			//Verifica se o prestador pode ou não emitir notas
			if(($proximaNota > $notalimite) && ($notalimite != 0)){ 
			  echo "<center><font color=\"#000000\"><b>Voc&ecirc; excedeu o limite de AIDFe, por favor solicite um limite maior!</b></font></center>";
			?>
			
			<?php		
			}else{
			?>
			<form action="importar_verifica.php" method="post" name="frmPagamento" target="_blank"  enctype="multipart/form-data" onsubmit="window.location='importar.php'">
				<input name="cmbEmissor" type="hidden" value="<?php echo $codLogado;?>" />
				<input name="btOK" type="hidden" value="<?php echo $_POST['btOK'];?>" />
				<input name="codLogado" type="hidden" value="<?php echo $codLogado;?>" />
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
					<?php
						if($notalimite){
							$restante = $notalimite - $ultimanota;
					?>
					<tr>
						<td align="left"><font color="#FF0000">Você ainda pode gerar:</font> </td>
						<td align="left"><b><?php echo $restante;?></b> <font color="#FF0000"><?php if($restante == 1){ echo "nota"; }else{ echo "notas";}?></font>.</td>
					</tr>
					<?php
						}
					?>
					<tr>
						<td align="left" width="28%"> Arquivo de RPS </td>
						<td align="left" width="72%">
							<input type="file" name="import" class="botao" />
						</td>
					</tr>
					<td colspan="2" align="center">
							<input type="submit" value="Importar" name="btImportar" class="botao">
						</td>
					</tr>
				</table>
			</form>
			<?php
			}
			?>
			</fieldset>
		</td>
	</tr>
</table>

		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>
</table>  


<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Gerar Relat&oacute;rio</td>
      <td width="400" bgcolor="#FFFFFF"></td>
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
        
<form action="inc/importar_gerarelatorio.php" method="post" name="frmGeraRelatorio" target="_blank" id="frmGeraRelatorio">
	<input name="cmbEmissor" type="hidden" value="<?php echo $codLogado;?>" />
	<input name="btOK" type="hidden" value="<?php echo $_POST['btOK'];?>" />
	<input name="codLogado" type="hidden" value="<?php echo $codLogado;?>" />
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
        <tr>
            <td align="left" width="30%"> Defina o período: </td>
            <td align="left" width="70%">
                <select name="cmbMes" class="combo">
                    <option value=""> selecione m&ecirc;s </option>
                    <option value="01">janeiro</option>
                    <option value="02">fevereiro</option>
                    <option value="03">mar&ccedil;o</option>
                    <option value="04">abril</option>
                    <option value="05">maio</option>
                    <option value="06">junho</option>
                    <option value="07">julho</option>
                    <option value="08">agosto</option>
                    <option value="09">setembro</option>
                    <option value="10">outubro</option>
                    <option value="11">novembro</option>
                    <option value="12">dezembro</option>
                </select>
                /
                <select name="cmbAno" class="combo" id="cmbAno">
                    <option value=""> selecione ano </option>
                    <?php
                        $ano = date("Y");
                        for($x=0; $x<=4; $x++)
                            {
                                $year=$ano-$x;
                                echo "<option value=\"$year\">$year</option>";
                            }
                    ?>
                </select>
            </td>
        </tr>
        <td colspan="2" align="center">
                <input name="btGerarRelatorio" type="submit" class="botao" id="btGerarRelatorio" value="Gerar Relat&oacute;rio">
            </td>
        </tr>
    </table>
</form>

		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>
</table>    


<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Padr&atilde;o XML</td>
      <td width="400" bgcolor="#FFFFFF"></td>
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

<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
    <tr>
        <td align="center"> Documento referencial do arquivo XML, para importa&ccedil;&atilde;o do Sistema NF-e da Prefeitura Municipal.<br />
            <br />
            <a href="xml/padraoxml.pdf" target="_blank">Download</a> </td>
    </tr>
    <tr>
        <td align="center">Para fazer download de um exemplo de arquivo XML <a href="xml/exemplo_de_xml.php?arquivo=exemplo_notaxml.xml" target="_blank" >clique aqui</a></td>
    </tr>
</table>



		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>
</table> 

<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Impress&atilde;o de RPS</td>
      <td width="400" bgcolor="#FFFFFF"></td>
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
		
			<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
				<tr>
					<td align="center">Documento de RPS do Sistema e-Nota da Prefeitura Municipal.<br />
						<br />
						<?php
							$codUserCrypto = base64_encode($cmbEmissor);
						?>
						<a href="../site/imprimir_rps.php?codUser=<?php echo $codUserCrypto;?>" target="_blank">Imprimir RPS</a>
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>
</table> 
