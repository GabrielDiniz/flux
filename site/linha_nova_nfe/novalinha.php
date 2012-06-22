<?php
	//REQUIRES
	require_once("../../include/conect.php");
    include("../../funcoes/util.php");

	//PEGANDO POR GET
	$quantidade = $_GET['quantidade'];
	$codemissor = $_GET['codemissor'];

    $simples = coddeclaracao("Simples Nacional");
	$mei     = coddeclaracao("MEI");
	
    //PEGANDO DECLARAÇÃO
	$sqlSimples = mysql_query("
		SELECT 
			codtipodeclaracao 
		FROM 
			cadastro 
		WHERE 
			codigo = '$codemissor'
	");
	
    list($coddeclaracao) = mysql_fetch_array($sqlSimples);
	
    if($simples == $coddeclaracao){
		$display = "";
        $disabled = "";
		$readonly = "readonly='readonly'";

    }else{
        $display = "";
        $disabled = "";
		$readonly = "readonly='readonly'";
    }

	//PEGANDO ISENÇÃO
	$sqlIsento = mysql_query("
		SELECT 
			isentoiss 
		FROM 
			cadastro 
		WHERE 
			codigo = '$codemissor'
	");
	
    list($isento) = mysql_fetch_array($sqlIsento);
	
    $isento = ($isento == "S") ? $isento = "style='display:none;' disabled='disabled'" : $isento = "";

	//PEGANDO SERVIÇOS
	$sql_servicos = mysql_query("
		SELECT 
			cadastro_servicos.codigo,
			servicos.codigo,
			servicos.codservico,
			servicos.descricao,
			servicos.aliquota, 
			servicos.aliquotair, 
			servicos.basecalculo
		FROM 
			servicos
		INNER JOIN 
			cadastro_servicos ON servicos.codigo = cadastro_servicos.codservico
		WHERE 
			cadastro_servicos.codemissor = '$codemissor'
	");
	
    if($quantidade != 1){
        $style = "style='display:none;'";
    }else{
        $style = "";
    }
	
?>

<input type="hidden" name="hdAliqServico<?php echo $quantidade;?>" id="hdAliqServico<?php echo $quantidade;?>" />
<table width="100%" id="tbl<?php echo $quantidade;?>">

    <tr align="center" bgcolor="#999999" <?php echo $style; ?>>
        <td width="23%"><b>Seleciona o Serviço</b></td>
        <td width="10%"><b>Base Calc.(R$)</b></td>
        <td width="10%"><b>Aliquota(%)</b></td>
        <td width="10%"<?php echo $isento; echo $display; echo $disabled; ?>><b>ISS(R$)</b></td>
        <td width="10%"<?php echo $isento; ?>><b>ISSRetido(R$)</b></td>
        <td width="10%"><b>Dedu&ccedil;&otilde;es(R$)</b></td>
        <td width="10%"><b>Acr&eacute;scimos(R$)</b></td>
        <td width="10%"><b>Valor L&iacute;q(R$)</b></td>
    </tr>
	
	<tr bgcolor="#FFFFFF" align="center">
		<td width="23%">
			<select name="cmbCodServico<?php echo $quantidade;?>" id="cmbCodServico<?php echo $quantidade;?>" style="width:180px;"
				onchange="MostraAliquota('txtAliqServico<?php echo $quantidade;?>', 'txtISSRetidoManual<?php echo $quantidade;?>', '<?php echo $quantidade;?>'); calculaISSNfe('hdInputs', '<?php echo $quantidade;?>'); notaIssRetido('<?php echo $quantidade;?>'); aliquotaEditavel('<?php echo $quantidade; ?>','<?php echo $simples; ?>','<?php echo $coddeclaracao; ?>')"
				onkeypress="if(event.keyCode==13){document.getElementById('txtBaseCalcServico<?php echo $quantidade;?>').focus(); return false;}">
				<option value="0">Selecione o Serviço</option>	   	        
				<?php 
					while(list($codigo_empresas_servicos,$codigo,$codservico,$descricao,$aliquota,$issretido,$basecalculo)=mysql_fetch_array($sql_servicos)){	   
						print("<option value=\"$aliquota|$codigo|$issretido|$basecalculo\"> $descricao </option>");
					}	
				?>
			</select>
			
            <input type="hidden" name="hdBaseServico<?php echo $quantidade;?>" id="hdBaseServico<?php echo $quantidade;?>"/>
		</td>
		
		<td width="10%">
			<input name="txtBaseCalcServico<?php echo $quantidade;?>" id="txtBaseCalcServico<?php echo $quantidade;?>" 
				type="text" class="texto" size="10" value="0,00" 
				onkeypress="if(event.keyCode==13){document.getElementById('txtAliqServico<?php echo $quantidade;?>').focus(); return false;}" 
				onkeyup="MaskMoeda(this);" 
				onkeydown="return NumbersOnly(event);" 
				onblur="calculaISSNfe('hdInputs','<?php echo $quantidade;?>');validaMei('<?php echo $quantidade;?>','<?php echo $mei;?>','<?php echo $coddeclaracao; ?>')"/>
			<font color="#FF0000">*</font>
            <input type="hidden" id="hdBaseCalcServico<?php echo $quantidade;?>" value="a" />
		</td>
		
		<td width="10%">
            <?php
                if($simples == $coddeclaracao){
                    $config = "";
                    $onblur = "validaAliquota($quantidade)";
                }else{
                    $config = $readonly;
                    $onblur = "";
                }
            ?>
			<input name="txtAliqServico<?php echo $quantidade;?>" id="txtAliqServico<?php echo $quantidade;?>" 
				type="text" class="texto" size="4" maxlength="5" 
				onkeypress="if(event.keyCode==13){document.getElementById('txtDeducoes<?php echo $quantidade;?>').focus(); return false;}" 
				onkeyup="MaskMoeda(this);" 
				onkeydown="return NumbersOnly(event);" 
				onblur="calculaISSNfe('hdInputs','<?php echo $quantidade;?>');<?php echo $onblur; ?>" <?php echo $config; ?>  />
			
			<input type="checkbox" name="ckbAliq<?php echo $quantidade;?>" id="ckbAliq<?php echo $quantidade;?>" value="S" style="visibility:hidden" 
			onclick="verificaCkbAliq(this, '<?php echo $quantidade;?>')" />
		</td>
		
		<td width="10%" <?php echo $isento; ?> <?php echo $disabled; echo $display; ?>>
			<input name="txtValorIssServico<?php echo $quantidade;?>" id="txtValorIssServico<?php echo $quantidade;?>" 
				type="text" class="texto" size="6" value="0,00" readonly="readonly" <?php echo $disabled; echo $display; ?>
				onkeypress="if(event.keyCode==13){return false;}"/>
            
		</td>
		
		<td width="10%" <?php echo $isento; ?>>
			<input name="txtISSRetidoManual<?php echo $quantidade;?>" id="txtISSRetidoManual<?php echo $quantidade;?>" 
				type="text" class="texto" size="8" value="0,00" readonly="readonly" 
				onkeypress="if(event.keyCode==13){return false;}"/>
            
            <input name="ckISSRetidoManual<?php echo $quantidade;?>" id="ckISSRetidoManual<?php echo $quantidade;?>" type="checkbox" class="texto" size="8" value="n" 
			onclick="verificaISSRetidoNota();calculaISSNfe('hdInputs','<?php echo $quantidade;?>');aliquotaEditavel('<?php echo $quantidade; ?>','<?php echo $simples; ?>','<?php echo $coddeclaracao; ?>');"/>
		</td>
		
        <td width="10%">
            <input type="text" name="txtDeducoes<?php echo $quantidade;?>" id="txtDeducoes<?php echo $quantidade;?>" 
				class="texto" size="8" value="0,00" 
				onkeypress="if(event.keyCode==13){document.getElementById('txtAcrescimo<?php echo $quantidade;?>').focus(); return false;}"
				onkeyup="MaskMoeda(this);" 
				onkeydown="return NumbersOnly(event);" 
				onblur="calculaISSNfe('hdInputs','<?php echo $quantidade;?>');"/>
        </td>
		
        <td width="10%">
            <input name="txtAcrescimo<?php echo $quantidade;?>" id="txtAcrescimo<?php echo $quantidade;?>"  
				class="texto" size="8" value="0,00" type="text" 
				onkeypress="if(event.keyCode==13){document.getElementById('txtValorLiquido<?php echo $quantidade;?>').focus(); return false;}" 
				onkeyup="MaskMoeda(this);" 
				onkeydown="return NumbersOnly(event);" 
				onblur="calculaISSNfe('hdInputs','<?php echo $quantidade;?>');"/>
        </td>
		
        <td width="10%">
            <input name="txtValorLiquido<?php echo $quantidade;?>" id="txtValorLiquido<?php echo $quantidade;?>" 
				type="text" class="texto" size="8" value="0,00" readonly="readonly"
				onkeypress="if(event.keyCode==13){document.getElementById('txtDiscriminacaoServico<?php echo $quantidade;?>').focus(); return false;}" />
        </td>
    </tr>
	
	<tr>
		<td align="center" colspan="8">
			<textarea name="txtDiscriminacaoServico<?php echo $quantidade;?>" id="txtDiscriminacaoServico<?php echo $quantidade;?>" 				rows="0" cols="0" style="width:100%; height:40px">Discriminação do serviço</textarea>
		</td>
	</tr>
</table>