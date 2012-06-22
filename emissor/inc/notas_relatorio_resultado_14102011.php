<html>
<head><link href="../../css/livrodigital.css" rel="stylesheet" type="text/css" /></head>
<body>
<center><input type="button" value="Imprimir" onclick="javascript:window.print()"></center>
<?php 
	include("../../include/conect.php");
	include("../../funcoes/util.php");
	
	//$notas = $_POST['hdNota'];
	
	$CnpjPrestador = $_POST['txtCnpjPrestador'];
	
	$anoi = $_POST['cmbAno'];
	$anof = $_POST['cmbAnoFim'];
	$mesi = $_POST['cmbMes'];
	$mesf = $_POST['cmbMesFim'];
	
	if($mesi < 10)$mesi = "0".$mesi;
	if($mesf < 10)$mesf = "0".$mesf;
	
	//print_r($_POST);
	
	$datai = $anoi."-".$mesi; //2011-01
	$dataf = $anof."-".$mesf;
	
	$sql_prestador = "SELECT 
						  `c`.`codigo`,
						  `c`.`razaosocial`, 
						  `c`.`nome`, 
						  `c`.`cnpj`,
						  `c`.`cpf`,
						  `c`.`inscrmunicipal`, 
						  `c`.`inscrestadual`,
						  `c`.`logradouro`,
						  `c`.`numero`,
						  `c`.`municipio`, 
						  `c`.`uf`, 
						  `c`.`logo`,
						  `c`.`pispasep`
					 FROM cadastro c WHERE c.cnpj = '$CnpjPrestador' OR c.cpf = '$CnpjPrestador'";
	$sql_prestador_res = mysql_query($sql_prestador) or die(mysql_error()." Erro prestador");
	list($codemissor,$empresa_razaosocial, $empresa_nome, $empresa_cnpj, $empresa_cpf, $empresa_inscrmunicipal,$empresa_inscrestadual,$empresa_endereco, $empresa_numero, $empresa_municipio, $empresa_uf, $empresa_logo,$cadastropispasep) = mysql_fetch_array($sql_prestador_res);
	
	//die($empresa_logo);
	
	$sql_notas = "SELECT n.codigo FROM notas n WHERE date_format(n.datahoraemissao, '%Y-%m') BETWEEN '$datai' AND '$dataf' AND n.estado <> 'C' AND codemissor = $codemissor";
	
	//die($sql_notas);
	
	$sql_res_notas = mysql_query($sql_notas) or die(mysql_error()." Erro consultar notas");
	$qtd_notas = mysql_num_rows($sql_res_notas);
	while($n = mysql_fetch_array($sql_res_notas)){
		$notas[] = $n['codigo'];
	}
?>

<style type="text/css">
<!--

#divCabecalhoEmitidas {
	margin-top:2px;
	margin-bottom:1px;
	border-bottom: solid 1px #000000;
}
#divPrincipalEmitidas {
	margin-bottom:100px;
	width:90%;
	margin:auto;
}
#divTotais {
	margin-top:10px;
	margin-bottom:10px;
}
-->
</style>
</head>

<body>
<div id="divPrincipalEmitidas" style="">
	<div id="divCabecalhoEmitidas">	
    
    <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center" style="margin: 0 auto;">
		  <tr>
			<td rowspan="7" width="120" align="center">
			<?php
			// verifica o logo
			if ($empresa_logo != "") {
				echo "<img src=\"../../img/logos/$empresa_logo\" width=\"100\" height=\"100\" >";
			}else echo "sem imagem";
			?>
			</td>
			<td colspan="4" class="titulo1" align="center">PRESTADOR DE SERVI&Ccedil;OS</td>
            <td rowspan="7" width="120" align="center">
			<?php
			if($CONF_BRASAO ==NULL) {echo 'sem imagem';} else {echo "<img src=\"../../img/brasoes/".rawurlencode($CONF_BRASAO)."\" width=\"120\" height=\"120\"/>";}; ?>
			</td>
            </tr>
            <tr>
			<td align="left" class="field1">CNPJ/CPF: </td><td><?php print $empresa_cnpj.$empresa_cpf; ?></td>
			<td align="left" class="field1">Inscri&ccedil;&atilde;o Estadual:</td><td><?php print verificaCampo($empresa_inscrestadual); ?></td>
		  </tr>
		  <tr>
			<td align="left" class="field1">Nome:</td><td><?php print $empresa_razaosocial; ?></td>
			<td align="left" class="field1">Inscri&ccedil;&atilde;o Municipal:</td><td><?php print verificaCampo($empresa_inscrmunicipal); ?></td>
		  </tr>
		  <tr>
			<td align="left" class="field1">Raz&atilde;o Social:</td><td><?php echo $empresa_nome; ?></td>
            <td align="left" class="field1">PIS/PASEP:</td><td><?php echo verificaCampo($cadastropispasep); ?></td>
		  </tr>
		  <tr>
			<td align="left" class="field1">Endere&ccedil;o:</td><td colspan="3"><?php print $empresa_endereco; if($empresa_numero != '')echo ", $empresa_numero"; ?></td>
		  </tr>
		  <tr>
			<td align="left" class="field1">Munic&iacute;pio:</td><td><?php print $empresa_municipio; ?></td>
			<td align="left" class="field1">UF:</td><td><?php print $empresa_uf; ?></td>
		  </tr>
		</table>
	
	
	</div>
    
    <div id="divTotais">
        <table align="center" border="1" cellspacing="5" cellpadding="5">
        	<th align="center" colspan="2"><b>Informa&ccedil;&otilde;es</b></th>
        	<tr>
            	<td class="field1">Per&iacute;odo</td>
                <td><?php echo implode("/",array_reverse(explode("-",$datai)))." - ".implode("/",array_reverse(explode("-",$dataf)));  ?></td>
            </tr>
           <tr>
            	<td class="field1">Total de notas</td>
                <td><?php echo $qtd_notas;  ?></td>
            </tr>
        </table>
    </div>
    
    <div id="divIssEmitidas">
    <table width="100%" border="1" cellpadding="5" cellspacing="0" style="margin: 0 auto;">
      <tr>
        <td colspan="12" align="center" class="titulo1">NOTAS FISCAIS ELETR&Ocirc;NICAS EMITIDAS </td>
        </tr>
      <tr>
        <td colspan="3" align="center" class="field2">NFEletr&ocirc;nica</td>
        <td colspan="2" align="center" class="field2">Tomador</td>
        <td colspan="3" align="center" class="field2">Servi&ccedil;os</td>
        <td colspan="2" align="center" class="field2">Imposto Pr&oacute;prio </td>
        <td colspan="2" align="center" class="field2">Imposto Retido </td>
      </tr>
      <tr align="center">
        <td width="5%">Data</td>
        <td width="3%">N&uacute;mero</td>
        <td width="3%">Estado</td>
        <td width="12%">CNPJ/CPF</td>
        <td width="12%">Inscr. Municipal </td>
        <td width="6%">C&oacute;d. Servi&ccedil;o </td>
        <td width="6%">Valor Servi&ccedil;os </td>
        <td width="6%">Valor L&iacute;quido </td>
        <td width="10%">Base C&aacute;lculo </td>
        <td width="6%">Valor ISS </td>
        <td width="12%">Base C&aacute;lculo </td>
        <td width="17%">Valor ISS </td>
      </tr>
    
	<?php
	if($qtd_notas > 0){
		
    for($c=0;$c < sizeof($notas);$c++){
	$codigo = $notas[$c];
		$sql = mysql_query("
		SELECT
		  `notas`.`aliq_percentual`, 
		  `notas`.`cofins`, 
		  `notas`.`contribuicaosocial`,
		  `notas`.`codigo`, 
		  `notas`.`numero`, 
		  `notas`.`codverificacao`,
		  `notas`.`datahoraemissao`, 
		  `notas`.`rps_numero`,
		  `notas`.`rps_data`, 
		  `notas`.`tomador_nome`, 
		  `notas`.`tomador_cnpjcpf`,
		  `notas`.`tomador_inscrmunicipal`,
		  `notas`.`tomador_inscrestadual`, 
		  `notas`.`tomador_endereco`,
		  `notas`.`tomador_logradouro`,
		  `notas`.`tomador_numero`,
		  `notas`.`tomador_complemento`,
		  `notas`.`tomador_cep`, 
		  `notas`.`tomador_municipio`, 
		  `notas`.`tomador_uf`,
		  `notas`.`tomador_email`, 
		  `notas`.`discriminacao`, 
		  `notas`.`valortotal`,
		  `notas`.`estado`, 
		  `notas`.`credito`,
		  `notas`.`pispasep`,
		  `notas`.`valordeducoes`,
		  `notas`.`valoracrescimos`,
		  `notas`.`basecalculo`, 
		  `notas`.`valoriss`,
		  `notas`.`valorinss`,
		  `notas`.`aliqinss`,
		  `notas`.`valorirrf`,
		  `notas`.`aliqirrf`,
		  `notas`.`deducao_irrf`,
		  `notas`.`total_retencao`,
		  `notas`.`issretido`,
		  `notas`.`observacao`,
		  `notas`.`motivo_cancelamento`,
		  `notas_servicos`.`codservico`
		FROM
		  `notas` LEFT JOIN notas_servicos ON(notas.codigo = notas_servicos.codnota)
		WHERE
		  `notas`.`codigo` = '$codigo'
		");
		list($aliquotapercentual,$cofins,$contribuicaosocial, $codigo, $numero, $codverificacao, $datahoraemissao, $rps_numero, $rps_data,
				$tomador_nome, $tomador_cnpjcpf, $tomador_inscrmunicipal, $tomador_inscrestadual, $tomador_endereco,
				$tomador_logradouro, $tomador_numero, $tomador_complemento, $tomador_cep,
				$tomador_municipio, $tomador_uf, $tomador_email, $discriminacao, $valortotal,
				$estado, $credito, $pispasep,$valordeducoes, $valoracrescimos, $basecalculo,
				$valoriss,$valorinss,$aliqinss,$valorirrf,$aliqirrf, $deducao_irrf, $total_retencao,
				$issretido,$observacao,$motivoCanc,$codservico,) = mysql_fetch_array($sql);
				
?>
  <tr>
    <td class="field3" align="center"><?php echo date("d/m/Y",strtotime($datahoraemissao)); ?> </td>
    <td class="field3" align="center"><?php echo $numero; ?></td>
    <td class="field3" align="center"><?php if($estado == 'N') {echo 'Normal';} 
								elseif($estado =='E') {echo 'Escriturada';}
								elseif($estado == 'B' ){echo 'Boleto';} 
									elseif($estado =='C'){echo 'Cancelada';} 
										else{echo 'Erro';} ;?></td>
    <td class="field3" align="center"><?php echo $tomador_cnpjcpf; ?></td>
    <td class="field3" align="center"><?php echo $tomador_inscrmunicipal; ?></td>
    <td class="field3" align="center"><?php echo $codservico ;?></td>
    <td class="field3" align="center"><?php echo DecToMoeda($basecalculo); ?></td>
    <td class="field3" align="center"><?php echo DecToMoeda($valortotal); ?> </td>
    <td class="field3" align="center"><?php echo DecToMoeda($basecalculo); ?></td>
    <td class="field3" align="center"><?php echo DecToMoeda($valoriss); ?></td>
    <td class="field3" align="center"><?php echo DecToMoeda($basecalculo); ?></td>
    <td class="field3" align="center"><?php echo DecToMoeda($issretido); ?></td>
  </tr>
<?php
	$total_basecalculo += $basecalculo;
	$total_valoriss += $valoriss;
	$total_issretido += $issretido;

 } // fecha while 
?> 
 
  
  <tr>
    <td colspan="8" align="right" class="field4">Total Geral </td>
    <td class="field4" align="center"><?php echo DecToMoeda($total_basecalculo); ?></td>
    <td class="field4" align="center"><?php echo DecToMoeda($total_valoriss); ?></td>
    <td class="field4" align="center"><?php echo DecToMoeda($total_basecalculo); ?></td>
    <td class="field4" align="center"><?php echo DecToMoeda($total_issretido); ?></td>
  </tr>
</table>
	
  </div>

<?php
}else{
	echo "<div id=\"divIssEmitidas\"><table width=\"1100\" style=\"margin:0 auto;\" border=\"0\" cellpadding=\"5\" cellspacing=\"0\"><tr><td colspan=\"12\" align=\"center\" class=\"titulo1\">NENHUMA NOTA FISCAL ELETR&Ocirc;NICA EMITIDA </td></tr></table></div>";	
}
?>

</div>
</body>
</html>


