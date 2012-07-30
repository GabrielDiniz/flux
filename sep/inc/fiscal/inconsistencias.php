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
    <td width="750" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Fiscal Inteligente - Dados divergentes</td>  
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
				
				include("inconsistencias_dados.php");
			}else{
				include("inconsistencias_dados.php");
			}
		?>
		<script>
			function detalhesInconsistencias(tipo){
				document.getElementById('hdTipo').value = tipo;
				acessoAjax('inc/fiscal/inconsistencias_lista.ajax.php','frmInconsistencias','divInconsistenciasDetalhes');
			}
		</script>
		<form method="post" id="frmInconsistencias">
		<input name="include" type="hidden" id="include" value="<?php echo $_POST['include'];?>" />
		<input name="hdTipo" id="hdTipo" type="hidden" />
		<fieldset><legend>Resumo</legend>
			<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
				<tr>
					<td width="22%" align="left">Data Inicial: </td>
					<td width="23%" align="left">
						<input name="txtDataInicial" type="text" id="txtDataInicial" size="12" value="<?php echo DataPt($dataInicial);?>" class="texto"
						 readonly="readonly" />
					</td>
					<td width="12%" align="left">Data Final: </td>
					<td width="13%" align="left">
						<input name="txtDataFinal" type="text" id="txtDataFinal" size="12" value="<?php echo DataPt($dataFinal);?>" class="texto" 
						readonly="readonly" />
					</td>
					<td width="30%" align="left">
						<input type="submit" name="btBuscar" id="btBuscar" value="Buscar" class="botao" 
						onclick="cancelaAction('frmInconsistencias','','')" />
					</td>
				</tr>
				<tr>
					<td align="left" colspan="5"><strong>Resumo do periodo de: <?php echo DataPt($dataInicial)." até ".DataPt($dataFinal);?></strong></td>
				</tr>
				<tr>
					<td colspan="2" align="left">N&uacute;mero de NFe emitidas </td>
					<td align="left">
						<input name="txtNfEmitidas" type="text" id="txtNfEmitidas" size="10" class="texto" value="<?php echo $nf_emitidas;?>" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left">N&uacute;mero de NFe tomadas (declaradas) </td>
					<td align="left">
						<input name="txtNfTomadas" type="text" id="txtNfTomadas" size="10" class="texto" value="<?php echo $nf_emitidas_tomador;?>"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left">N&uacute;mero de Prestadores com Nfe sem par:</td>
					<td align="left">
						<input name="txtNfDivergentesPrestador" type="text" id="txtNfDivergentesPrestador" size="10" class="texto" value="<?php echo $nf_divirgentes;?>" />
					</td>
					<td align="left" colspan="2">
						<input name="btDetalheNfDivergentesPrestador" type="button" id="btDetalheNfDivergentesPrestador" value="Detalhes" class="botao"
						onclick="detalhesInconsistencias('1');" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left">Nro. de Tomadores com Nfe (declaradas) sem par:</td>
					<td align="left">
						<input name="txtNfDivergentesTomador" type="text" id="txtNfDivergentesTomador" size="10" class="texto" 
						value="<?php echo $nf_emitidas_tomador_divirgentes;?>" />
					</td>
					<td align="left" colspan="2">
						<input name="btDetalheNfDivergentesPrestador" type="button" id="btDetalheNfDivergentesPrestador" value="Detalhes" class="botao"
						onclick="detalhesInconsistencias('2');" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left">Nro. de notas com inconsistências: </td>
					<td align="left">
						<input name="txtNfInconsistencias" type="text" id="txtNfInconsistencias" size="10" class="texto" 
						value="<?php echo $nf_inconsistentes;?>" />
					</td>
					<td align="left" colspan="2">
						<input name="btNfInconsistencias" type="button" id="btNfInconsistencias" value="Detalhes" class="botao"
						onclick="detalhesInconsistencias('3');" />
					</td>
				</tr>
			</table>
			</fieldset>
			<div id="divInconsistenciasDetalhes"></div>
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

