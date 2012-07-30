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
<table border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
    <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Fiscal Inteligente - Inconsist&ecirc;ncias</td>  
    <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg">
		<a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a>
	</td>
  </tr>
  <tr>
    <td width="18" background="img/form/lateralesq.jpg"></td>
    <td align="center">

<?php
	//Pega a data inicial e final padrao: que eh o periodo do mes atual
	$dataInicial = date("Y-m")."-01";
	$dataFinal   = retornaUltDiaMes(date("m"));
		
	if($_POST['btBuscar']){
		$dataInicial = $_POST['txtDataInicial'];
		$dataFinal   = $_POST['txtDataFinal'];
		
		include("divirgentes_dados.php");
	}else{
		include("divirgentes_dados.php");
	}
?>
<form method="post" id="frmDivirgenciasA1">
<input name="include" type="hidden" id="include" value="<?php echo $_POST['include'];?>" />
<fieldset><legend>Resumo</legend>
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">


	<tr>
		<td width="22%" align="left">Data Inicial: </td>
		<td width="23%" align="left"><input name="txtDataInicial" type="text" id="txtDataInicial" size="20" value="<?php echo DataPt($dataInicial);?>" class="texto" /></td>
		<td width="23%" align="left">Data Final: </td>
		<td width="23%" align="left"><input name="txtDataFinal" type="text" id="txtDataFinal" size="20" value="<?php echo DataPt($dataFinal);?>" class="texto" /></td>
		<td width="9%" align="center"><input type="submit" name="btBuscar" id="btBuscar" value="Buscar" class="botao" /></td>
	</tr>
	<tr>
		<td colspan="2" align="left">N&uacute;mero de NFe divirgentes: </td>
		<td align="left"><input name="txtNfEmitidas" type="text" id="txtNfEmitidas" size="20" class="texto" value="<?php echo $nf_emitidas?>" /></td>
		<td align="left" colspan="2"><input name="btNfEmitidas" type="button" id="btNfEmitidas" value="Detalhes" class="botao"
		onclick="document.getElementById('tipo').value=1;acessoAjax('inc/fiscal/divirgencias_lista.ajax.php','frmDivirgencias','divDivirgenciasDetalhes')" /></td>
	</tr>
	

	
	</table>

	
</fieldset>
</form>

<form method="post" id="frmDivirgencias" target="_blank" action="inc/nfe/imprimir.php">
<input name="tipo" type="hidden" id="tipo" />
<input name="CODIGO" type="hidden" id="CODIGO" />
<div id="divDivirgenciasDetalhes"></div>
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

