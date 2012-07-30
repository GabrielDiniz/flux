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
<input name="hdInputs" id="hdInputs" type="hidden" value="0" />
<input name="hdCodemissor" id="hdCodemissor" type="hidden" value="<?php echo $CODIGO_DA_EMPRESA;?>" />
<input name="hdLimite" id="hdLimite" type="hidden" value="<?php echo mysql_num_rows($sql_servicos);?>"  />

<table width="100%" id="tblServicos" cellpadding="3">
	<tr>
		<td align="left"><b>Observa&ccedil;&otilde;es da nota: </b></td>
	</tr>
	<tr>
		<td align="center"><textarea name="txtObsNota" rows="0" cols="0" style="width:90%; height:60px;"></textarea></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td align="left">
			<label><strong>Clique para informar os servi&ccedil;os<br /><br /></strong>
			<input name="btServico" type="button" value="Serviços" class="botao" 
			onclick="mostraDivServicos()" /></label>
			<div id="divServicosNota" class="divServicosNota">
				<table border="0" cellspacing="0" cellpadding="0"  height="100%">
					<tr>
						<td width="18" align="left" background="../img/form/cabecalho_fundo.jpg"></td>
						<td width="95%" background="../img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho"></td>  
						<td width="19" align="right" valign="top" background="../img/form/cabecalho_fundo.jpg">
							<a href="#" onclick="escondeMostraDiv('divServicosNota');return false">
								<img src="../img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" />
							</a>
						</td>
					</tr>
					<tr>
						<td width="18" background="../img/form/lateralesq.jpg"></td>
						<td align="left" width="100%" height="100%" valign="top">
						
				<div style="overflow:auto; height:250px;">		
				<table id="retornoDivLinha" width="100%">
                    <tr>
						<td>
							<!--<table width="100%">
								<tr align="center" >
									<td width="33%" align="center"><b>Seleciona o Serviço</b></td>
									<td width="20%" align="center"><b>Base Calc.(R$)</b></td>
									<td width="15%" align="center"><b>Aliquota(%)</b></td>
									<td width="12%" align="center"><b>ISS(R$)</b></td>
									<td width="17%" align="center"><b>ISSRetido(R$)</b></td>
								</tr>
							</table>-->
						</td>
					</tr>
				</table>
				</div>
				<div>
					<table>
						<tr>
							<td width="93%" align="right">
								<input name="btAdicionar" id="btAdicionar" type="button" class="botao" value="Adicionar" 
								onclick="addLinhaNota()" style="display:none" />
								&nbsp;
								<input name="btRemover" id="btRemover" type="button" class="botao" value="Remover" onclick="removeLinha('retornoDivLinha','btAdicionar')" 
								disabled="disabled" style="display:none" /> 
                                &nbsp;
                                <input name="btConfirmar" id="btConfirmar" type="button" class="botao"
                                value="Confirmar" onclick="escondeMostraDiv('divServicosNota');" />
							</td>
						</tr>
					</table>
				</div>
				
				
					</td>
						<td width="19" background="../img/form/lateraldir.jpg"></td>
					</tr>
					<tr>
						<td align="left" background="../img/form/rodape_fundo.jpg"><img src="../img/form/rodape_cantoesq.jpg" /></td>
						<td background="../img/form/rodape_fundo.jpg"></td>
						<td align="right" background="../img/form/rodape_fundo.jpg"><img src="../img/form/rodape_cantodir.jpg" /></td>
					</tr>
				</table>

			</div>
		</td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td>
		<fieldset style="margin-bottom:5px;"><legend><strong>Valores da nota</strong></legend>
<table width="100%">
	<!-- busca a relacao dos servicos por empresa -->
	<tr>
		<td align="left">Base de C&aacute;lculo</td>
		<td align="left">
			R$ <input name="txtBaseCalculo" type="text" size="10" class="texto" id="txtBaseCalculo" style="text-align:right;" 
			onkeyup="MaskMoeda(this);" onkeydown="return NumbersOnly(event);" onblur="ValorIss('<?php echo $regras_credito;?>')" readonly="readonly" value="0,00">
			<input name="txtBaseCalculoAux" type="hidden" id="txtBaseCalculoAux" />
			<input name="hdCalculos" id="hdCalculos" type="hidden" />
			<input name="hdValorInicial" id="hdValorInicial" type="hidden" />
            <input type="hidden" id="hdBkpBaseCalculo" value="a" />
		</td>
	</tr>
	<tr>
		<td width="21%" align="left">Dedu&ccedil;&otilde;es</td>
		<td width="26%" align="left">R$
			<input name="txtValorDeducoes" type="text" size="12" class="texto" id="txtValorDeducoes"  style="text-align:right;" value="0,00"
			onkeydown="MaskMoeda(this); return NumbersOnly(event);" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
		<td width="13%" align="left">Acr&eacute;scimos</td>
		<td width="40%" align="left">
			R$ 
			<input name="txtValorAcrescimos" type="text" size="12" class="texto" id="txtValorAcrescimos" style="text-align:right" value="0,00" 
			onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
	</tr>
</table>
		</fieldset>
		<fieldset><legend><strong>Dados da nota</strong></legend>
<table width="100%">
	<tr>
		<td width="21%" align="left">PIS/PASEP</td>
		<td width="26%" align="left">R$ 
			<input name="txtPISPASEP" id="txtPISPASEP" type="text" class="texto" size="12" value="0,00" onkeyup="MaskMoeda(this);" 
			onkeydown="return NumbersOnly(event);" style="text-align:right" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
	</tr>
	<tr>
		<td align="left"> ISS </td>
		<td align="left">R$
			<input name="txtISS" type="text" size="10" class="texto" readonly="yes" style="text-align:right;" id="txtISS" value="0,00" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
		<td width="13%" align="left">ISS Retido </td>
		<td width="40%" align="left"> R$
			<input id="txtIssRetido" name="txtIssRetido" onkeyup="MaskMoeda(this);" onkeydown="return NumbersOnly(event);" type="text" size="10" 
			class="texto" readonly="yes" style="text-align:right;" value="0,00" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
	</tr>
	<tr>
		<td align="left">INSS </td>
		<td align="left"> R$
			<input id="txtValorINSS" name="txtValorINSS" type="text" size="10" class="texto" onkeyup="MaskMoeda(this);" 
			onkeydown="return NumbersOnly(event);" onblur="ValorIss('<?php echo $regras_credito;?>')" style="text-align:right;" value="0,00"/>
		</td>
		<td align="left">IRRF</td>
		<td align="left"> R$
			<input id="txtValorFinalIRRF" name="txtValorFinalIRRF" type="text" size="10" class="texto" onkeyup="MaskMoeda(this);" 
			onkeydown="return NumbersOnly(event);" onblur="ValorIss('<?php echo $regras_credito;?>');
            descontaValor('txtValorINSS','txtValorFinalIRRF','txtIssRetido')" style="text-align:right;" value="0,00"/>
		</td>
	</tr>
    <tr>
        <td width="21%" align="left">Cofins</td>
		<td width="26%" align="left">R$
            <input name="txtCofins" id="txtCofins" type="text" class="texto" size="10" value="0,00" onkeyup="MaskMoeda(this);"
			onkeydown="return NumbersOnly(event);" style="text-align:right" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
        <td width="21%" align="left">Contribui&ccedil;&atilde;o Social</td>
		<td width="26%" align="left">R$
            <input name="txtContribuicaoSocial" id="txtContribuicaoSocial" type="text" class="texto" size="10" value="0,00" onkeyup="MaskMoeda(this);"
			onkeydown="return NumbersOnly(event);" style="text-align:right" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
    </tr>
</table>
		</fieldset>
	<?php
  	$sql_verifica_creditos = mysql_query("SELECT ativar_creditos FROM configuracoes");
	list($ativar_creditos) = mysql_fetch_array($sql_verifica_creditos);
	
	if($ativar_creditos == "n"){
		$display = "style=\"display:none\"";
	}else{
		$display = "";
	}
  ?>
 <fieldset><legend><strong>Total da nota</strong></legend>
<table width="100%">
	<tr>
		<td width="21%" align="left"><b>Valor liquido</b></td>
		<td width="26%" align="left">
			R$ <input name="txtValTotal" id="txtValTotal" type="text" size="10" class="texto" readonly="yes" style="text-align:right;" value="0,00" onblur="ValorIss('<?php echo $regras_credito;?>')" >&nbsp;
		</td>
		<td width="13%" align="left">
			Retenç&otilde;es		</td>
		<td width="40%" align="left">
			R$ 
				<input name="txtValTotalRetencao" id="txtValTotalRetencao" type="text" class="texto" size="10" readonly="readonly" style="text-align:right" value="0,00" onblur="ValorIss('<?php echo $regras_credito;?>')" />
		</td>
	</tr>
	<tr <?php echo $display;?>>
		<td align="left">Cr&eacute;dito</td>
		<td align="left">R$
			<input name="txtCredito" id="txtCredito" type="text" size="10" class="texto" readonly="yes" style="text-align:right" value="0,00" onblur="ValorIss('<?php echo $regras_credito;?>')" >
		</td>
	</tr>

	<tr>
		<td  align="left">
			<input name="btInserirNota" type="submit" value="Emitir" class="botao" onclick="return ValidaFormulario('txtTomadorUF|txtTomadorNome')&&VerificaCPF();"  >
		</td>
		<td align="right" colspan="8"><font color="#FF0000">*</font>Campos obrigat&oacute;rios<br />
		</td>
	</tr>
</table>
</fieldset>
		</td>
	</tr>
</table>
