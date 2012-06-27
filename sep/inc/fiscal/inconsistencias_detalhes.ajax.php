<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	require_once("../nocache.php");
	
	$codNota = $_GET['hdcod'];
	
	$sql_detalhes = mysql_query("
		SELECT 
			notas.codigo, 
			notas.codemissor, 
			notas.tomador_cnpjcpf,
			notas.codverificacao,
			DATE(notas.datahoraemissao) AS data, 
			notas.numero, 
			notas.valortotal,
			notas.valoriss,
			notas_tomadas.codigo AS codnotatomada,
			notas_tomadas.codprestador,
			notas_tomadas.codtomador,
			notas_tomadas.codverificacao AS codverificacaoNT,
			notas_tomadas.data,
			notas_tomadas.numero,
			notas_tomadas.total,
			notas_tomadas.iss
		FROM
			notas
		INNER JOIN
			notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador
		WHERE
			notas.codigo = '$codNota'
	");
	$dadosNotas = mysql_fetch_object($sql_detalhes);
	$testeValor = "";
	$testeCodverificacao = "";
	$testeISS = "";
	
	if($dadosNotas->valortotal != $dadosNotas->total){
		$testeValor = true;
	}
	
	if($dadosNotas->codverificacao != $dadosNotas->codverificacaoNT){
		$testeCodverificacao = true;
	}
	
	if($dadosNotas->valoriss != $dadosNotas->iss){
		$testeISS = true;
	}
	
	$sql_servicos_nota_emitida = mysql_query("
		SELECT 
			codservico,
			basecalculo,
			issretido,
			iss
		FROM
			notas_servicos
		WHERE
			codnota = '$codNota'
		ORDER BY
			codservico
	");

	
	$cnpjcpf_emissorNota = buscaCnpjCpf($dadosNotas->codemissor);
	$cnpjcpf_emissorNotaTomada = buscaCnpjCpf($dadosNotas->codprestador);
	$cnpjcpf_tomadorNotaTomada = buscaCnpjCpf($dadosNotas->codtomador);
?>
<center>
	<div style="width:95%;">
		<div style="float:left; width:49%; border:1px #000000 solid">
			<table width="100%">
				<caption style="background-color:#999999">Nota Emitida</caption>
				<tr>
					<td align="left">CNPJ/CPF do Emissor: </td>
					<td align="left"><?php echo $cnpjcpf_emissorNota;?></td>
				</tr>
				<tr>
					<td align="left">CNPJ/CPF do Tomador: </td>
					<td align="left"><?php echo $dadosNotas->tomador_cnpjcpf;?></td>
				</tr>
				<tr bgcolor="#000000" style="height:1px;">
					<td colspan="2"></td>
				</tr>
				<tr <?php if($testeCodverificacao == true){ echo "class=\"inconsistente\""; }?>>
					<td align="left">Cód. Verificação: </td>
					<td align="left"><?php echo $dadosNotas->codverificacao;?></td>
				</tr>
				<?php
				$sql_servicos_nota_emitida = mysql_query("
					SELECT 
						codservico,
						basecalculo,
						issretido,
						iss
					FROM
						notas_servicos
					WHERE
						codnota = '$codNota'
					ORDER BY
						codservico
				");
				while($notaEmitida = mysql_fetch_object($sql_servicos_nota_emitida)){
				?>
				<tr>
					<td align="left">Cod. Atividade: </td>
					<td align="left"><?php echo $notaEmitida->codservico;?></td>
				</tr>
				<?php
				}
				?>
				<tr <?php if($testeISS == true){ echo "class=\"inconsistente\""; }?>>
					<td align="left">ISS: </td>
					<td align="left"><?php echo DecToMoeda($dadosNotas->valoriss);?></td>
				</tr>
				<tr <?php if($testeValor == true){ echo "class=\"inconsistente\""; }?>>
					<td align="left">Valor Nota: </td>
					<td align="left"><?php echo DecToMoeda($dadosNotas->valortotal);?></td>
				</tr>
			</table>
		</div>
		<div style="float:right; width:49%; border:1px #000000 solid">
			<table width="100%">
				<caption style="background-color:#999999">Nota Tomada</caption>
				<tr>
					<td align="left">CNPJ/CPF do Emissor: </td>
					<td align="left"><?php echo $cnpjcpf_emissorNotaTomada;?></td>
				</tr>
				<tr>
					<td align="left">CNPJ/CPF do Tomador: </td>
					<td align="left"><?php echo $cnpjcpf_tomadorNotaTomada;?></td>
				</tr>
				<tr bgcolor="#000000" style="height:1px;">
					<td colspan="2"></td>
				</tr>
				<tr <?php if($testeCodverificacao == true){ echo "class=\"inconsistente\""; }?>>
					<td align="left">Cód. Verificação: </td>
					<td align="left"><?php echo $dadosNotas->codverificacaoNT;?></td>
				</tr>
				<?php
				$sql_servicos_nota_tomada = mysql_query("
					SELECT 
						codservico,
						basecalculo,
						issretido,
						iss
					FROM
						notas_tomadas_servicos
					WHERE
						codnota_tomada = '{$dadosNotas->codnotatomada}'
					ORDER BY
						codservico
				");
				while($notaTomada = mysql_fetch_object($sql_servicos_nota_tomada)){
				?>
				<tr>
					<td align="left">Cod. Atividade: </td>
					<td align="left"><?php echo $notaTomada->codservico;?></td>
				</tr>
				<?php
				}
				?>
				<tr <?php if($testeISS == true){ echo "class=\"inconsistente\""; }?>>
					<td align="left">ISS: </td>
					<td align="left"><?php echo DecToMoeda($dadosNotas->iss);?></td>
				</tr>
				<tr <?php if($testeValor == true){ echo "class=\"inconsistente\""; }?>>
					<td align="left">Valor Nota: </td>
					<td align="left"><?php echo DecToMoeda($dadosNotas->total);?></td>
				</tr>
			</table>
		</div>
	</div>
</center>