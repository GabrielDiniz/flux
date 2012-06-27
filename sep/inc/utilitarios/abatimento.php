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
	if($_POST['btEditar'] == "Salvar"){
		include("inc/utilitarios/abatimento_editar.php");
	}
?>
<?php
$abat = mysql_query("SELECT abatimento_iptu FROM configuracoes");
list($porc_iptu)=mysql_fetch_array($abat);
?>
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
	<tr>
		<td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
		<td width="500" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Abatimento Iptu</td>
		<td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
	</tr>
	<tr>
		<td width="18" background="img/form/lateralesq.jpg"></td>
		<td align="left">
		
			<form method="post" name="formAbatimento" id="formAbatimento">
				<input name="include" id="include" value="<?php echo $_POST['include'];?>" type="hidden" />
				<fieldset>
				<legend>Porcentagem de abatimento</legend>
				<table width="100%">
					<tr>
						<td align="left" width="30"><input type="text" value="<?php echo $porc_iptu; ?>" name="txtPorc" id="txtPorc" class="texto" onkeyup="MaskPercent(this)" size="8" onblur="limitePct('txtPorc')" ></td>
                        <td align="left">%  <font color="#FF0000">* Digite o valor m&aacute;ximo para abatimento.</font></td>
					</tr>
					<tr>
						<td align="left" colspan="2">							
							<input name="btEditar" type="submit" class="botao" value="Salvar" 
                            onclick="return (ValidaFormulario('txtPorc','Preencha os dados obrigatórios'))">
						</td>
					</tr>
				</table>
				</fieldset>
			</form>
			
			</td>
		<td width="19" background="img/form/lateraldir.jpg"></td>
	</tr>
	<tr>
		<td align="left" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantoesq.jpg" /></td>
		<td background="img/form/rodape_fundo.jpg"></td>
		<td align="right" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantodir.jpg" /></td>
	</tr>
</table>
