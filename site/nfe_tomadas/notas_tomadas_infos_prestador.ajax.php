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
	require_once("../../include/conect.php");
	require_once("../../funcoes/util.php");
	require_once("../../include/nocache.php");
		

	$cnpj = $_GET['cnpj'];
	$codLogado = $_GET['logado'];
	$codTipoTomador = codtipo("tomador");
	
	$sql_infos_prestador = mysql_query("
		SELECT 
			codigo,
			nome, 
			razaosocial, 
			logradouro, 
			numero, 
			bairro, 
			municipio, 
			uf 
		FROM 
			cadastro 
		WHERE 
			(cnpj = '$cnpj' OR cpf = '$cnpj') AND codtipo <> '$codTipoTomador'
	");
	$infos_prestador = mysql_fetch_object($sql_infos_prestador);
	
	if(!$infos_prestador->razaosocial){
		$nome = $infos_prestador->nome;
	}else{
		$nome = $infos_prestador->razaosocial;
	}
	
	$endereco = $infos_prestador->logradouro.", ".$infos_prestador->numero;
	
	if($infos_prestador->bairro){
		$endereco .= ", ".$infos_prestador->bairro;
	}
	
if(mysql_num_rows($sql_infos_prestador)){
	if($infos_prestador->codigo != $codLogado){
?>
<fieldset><legend><strong>Dados do Prestador</strong></legend>
<table width="100%">
	<tr>
		<td width="24%" align="left">Nome/Razão Social: </td>
		<td align="left" colspan="3" bgcolor="#FFFFFF"><?php echo $nome;?> </td>
	</tr>
	<tr>
		<td align="left">Logradouro: </td>
		<td align="left" colspan="3" bgcolor="#FFFFFF"><?php echo $endereco;?> </td>
	</tr>
	<tr>
		<td width="24%" align="left">UF: </td>
		<td width="3%" align="left" bgcolor="#FFFFFF"><?php echo $infos_prestador->uf;?> </td>
		<td width="5%" align="left">Município: </td>
		<td width="68%" align="left" bgcolor="#FFFFFF"><?php echo $infos_prestador->municipio;?> </td>
	</tr>
</table>
</fieldset>
<fieldset><legend><strong>Serviços da nota</strong></legend>
	<?php
	$sql_num_servicos = mysql_query("
		SELECT 
			servicos.codigo,
			servicos.descricao, 
			servicos.aliquota, 
			servicos.aliquotair,
			servicos.basecalculo
		FROM 
			servicos
		INNER JOIN
			cadastro_servicos ON cadastro_servicos.codservico = servicos.codigo
		WHERE
			cadastro_servicos.codemissor = '{$infos_prestador->codigo}'
	");
	$numServicos = mysql_num_rows($sql_num_servicos);
	if($numServicos){
?>
<input name="hdInputs" id="hdInputs" type="hidden" value="<?php echo mysql_num_rows($sql_num_servicos);?>"  />
<?php
		$cont = 0;
		while($dadosServicos = mysql_fetch_object($sql_num_servicos)){
	?>
	<table width="100%" style="border:1px solid #000000">
		<tr>
			<td align="left"  style="border-bottom:1px solid #000; border-right:1px solid #000">Serviço <?php echo $cont+1;?></td>
			<td align="left" colspan="4"></td>
		</tr>
		<tr >
			<td align="center"><strong>Atividade</strong></td>
			<td align="center"><strong>B. cálculo</strong></td>
			<td align="center"><strong>Aliq.</strong></td>
			<td align="center"><strong>ISS</strong></td>
			<td align="center"><strong>ISS Retido</strong></td>
		</tr>
		<tr>
			<td align="center"><?php if($cont == 0){ echo "<font color=\"#FF0000\">*</font>";}else{ echo "&nbsp;";}?>
				<select name="cmbCodServico<?php echo $cont;?>" id="cmbCodServico<?php echo $cont;?>" class="combo" style="width:250px;"
				 onchange="MostraAliquotaNFTomada(this,'txtAliqServico<?php echo $cont;?>', <?php echo $cont; ?>);notaIssRetido('<?php echo $cont;?>');
				 calculaISSNfeTomadas('hdInputs','<?php echo $cont;?>');" >
					<option value=""></option>
					<?php
					$sql_servicos = mysql_query("
						SELECT 
							servicos.codigo AS codDoServico,
							servicos.descricao, 
							servicos.aliquota, 
							servicos.aliquotair,
							servicos.basecalculo
						FROM 
							servicos
						INNER JOIN
							cadastro_servicos ON cadastro_servicos.codservico = servicos.codigo
						WHERE
							cadastro_servicos.codemissor = '{$infos_prestador->codigo}'
					");
					while($servico = mysql_fetch_object($sql_servicos)){?>
						<option value="<?php echo $servico->aliquota."|".$servico->codDoServico."|".$servico->aliquotair."|".$servico->basecalculo;?>">
							<?php echo $servico->descricao; ?> 
						</option>
					
					<?php 
					}
					?>
				</select>
			</td>
			<td align="center">
				<?php if($cont == 0){ echo "<font color=\"#FF0000\">*</font>";}else{ echo "&nbsp;";}?>
				<input type="text" name="txtBaseCalcServico<?php echo $cont;?>" id="txtBaseCalcServico<?php echo $cont;?>" size="8" class="texto" 
				onkeyup="MaskMoeda(this);" onkeydown="return NumbersOnly(event);" 
				onblur="calculaISSNfeTomadas('hdInputs','<?php echo $cont;?>');" value="0,00" />
                <input type="hidden" name="hdBaseServico<?php echo $cont;?>" id="hdBaseServico<?php echo $cont;?>"/>
			</td>
			<td align="center"><input type="text" name="txtAliqServico<?php echo $cont;?>" id="txtAliqServico<?php echo $cont;?>" size="5" class="texto" readonly="readonly" /></td>
			<td align="center">
				<input type="text" name="txtValorIssServico<?php echo $cont;?>" id="txtValorIssServico<?php echo $cont;?>" value="0,00" 
				size="8" class="texto" readonly="readonly" />
			</td>
			<td align="center">
				<input type="text" name="txtISSRetidoManual<?php echo $cont;?>" id="txtISSRetidoManual<?php echo $cont;?>" size="8" class="texto" 
				onkeyup="MaskMoeda(this);" onkeydown="return NumbersOnly(event);" 
				onblur="calculaISSNfeTomadas('hdInputs','<?php echo $cont;?>');" value="0,00"/>
			</td>
		</tr>
		<tr>
			<td colspan="5" align="left">Discriminação: </td>
		</tr>
		<tr>
			<td colspan="5" align="center">
				<textarea name="txtDiscriminacaoServico<?php echo $cont;?>" id="txtDiscriminacaoServico<?php echo $cont;?>" 
				cols="0" rows="0" style="width:95%; height:30px;"></textarea>
			</td>
		</tr>
		<input type="hidden" name="txtValorLiquido<?php echo $cont;?>" id="txtValorLiquido<?php echo $cont;?>" />
	</table>
	<?php
			$cont++;
		}
	}else{
		$mensagem = "<center><strong>O prestador não possui Serviços cadastrados</strong></center>";
		$erro = 1;
		$retorno = $mensagem."==>".$erro;
		echo $retorno;
	}
	?>
	<table width="100%" style="border:1px solid #000000">
		<tr>
			<td align="left" colspan="4"  style="border-bottom:1px solid #000; border-right:1px solid #000">Total nota</td>
		</tr>
		<tr>
			<td width="19%" align="left"><strong>ISS: </strong></td>
			<td width="26%" align="left"><input name="txtTotalISS" id="txtTotalISS" type="text" class="texto" size="8" readonly="readonly" /></td>
			<td width="15%" align="left"><strong>ISS Retido: </strong></td>
			<td width="40%" align="left"><input name="txtTotalISSRetido" id="txtTotalISSRetido" type="text" class="texto" size="8" readonly="readonly" /></td>
		</tr>
		<tr>
			<td align="left"><strong>Valor Liquido: </strong></td>
			<td align="left" colspan="3"><input name="txtValorTotal" id="txtValorTotal" type="text" class="texto" size="10" readonly="readonly" /></td>
		</tr>
	</table>
</fieldset>
<?php
		}else{
			$mensagem = "<center><strong>Não é possivel declarar notas tomadas da empresa logada no sistema!</strong></center>";
			$erro = 1;
			$retorno = $mensagem."==>".$erro;
			echo $retorno;
		}
	}else{
		$mensagem = "<center><strong>Este cnpj não pertence a nenhum prestador cadastrado!</strong></center>";
		$erro = 1;
		$retorno = $mensagem."==>".$erro;
		echo $retorno;
	}
?>