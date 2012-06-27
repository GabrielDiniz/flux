<?php
	
		$query =("
			SELECT
				servicos.codigo,
				servicos.descricao,
				servicos.aliquota,
				servicos.estado,
				servicos.codservico,
				servicos.basecalculo
			FROM
				servicos
			ORDER BY
				servicos.descricao
		");
	
	$sql_pesquisa = mysql_query ($query);
	$result = mysql_num_rows($sql_pesquisa); //Pega quantos resultados voltaram
	
	if($result){ //Se existir algum registro, mostra na tabela
?>


<!-- Início da Tabela -->
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999">
		<?php
			if($result == 1)
				echo "<center><b>Foi encontrado $result  Resultado</b></center>";
			else
				echo "<center><b>Foram encontrados $result  Resultados</b></center>";
		?>
	</tr>
		
	<tr style="background-color:#999999; font-weight:bold" align="center">
		<td>Descri&ccedil;&atilde;o</td>
		<td>Regime Fixo</td>
		<td>Al&iacute;quota</td>
		<td>Incid&ecirc;ncia</td>
		<td>Estado</td>
	</tr>
	
<?php
while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
	switch($dados_pesquisa['estado']){ //Define estado como Ativo, Inativo ou não liberado
		case "A":
			$dados_pesquisa['estado'] = "Ativo";
			break;
		case "I":
			$dados_pesquisa['estado'] = "Inativo";
			break;
		case "NL":
			$dados_pesquisa['estado'] = "N&aatilde; Liberado";
			break;
	}//Fim do switch
	
	if(strlen($dados_pesquisa['descricao']) > 55) //Contas os caracteres da descrição; se passar de 55, coloca "..."
		$desc = ResumeString($dados_pesquisa['descricao'],55);
	else
		$desc = $dados_pesquisa['descricao'];
	
	//pega a incindencia caso não tenha vindo mes
	if($mes<1 || $mes>12){
		$cod = $dados_pesquisa['codigo'];
		$query_incidencia =("
			SELECT 
				servicos.codigo,
				servicos.descricao, 
				COUNT(notas_servicos.codservico) as incidencia
			FROM 
				servicos 
			INNER JOIN 
				notas_servicos 
			ON 
				notas_servicos.codservico = servicos.codigo
			WHERE 
				notas_servicos.codservico = $cod
		");
		$sql_incidencia = mysql_query ($query_incidencia);
		$result_incidencia = mysql_num_rows($sql_incidencia);
		if($result_incidencia)
			$incidencia = mysql_fetch_array($sql_incidencia);
		else
			$incidencia = 0;
	}else
		$incidencia = $dados_pesquisa['incidencia'];
?>
	<tr align="center">
		<td align="left"><?php echo $desc;?></td>
		<td><?php echo DecToMoeda($dados_pesquisa['basecalculo']);?></td>
		<td><?php echo DecToMoeda($dados_pesquisa['aliquota']);?>%</td>
		<td><?php echo $incidencia['incidencia'];?></td>
		<td><?php echo $dados_pesquisa['estado'];?></td>
	</tr>
<?php
}//Fim do while($dados_pesquisa = mysql_fetch_array($sql_pesquisa))
?>
</table>
<!-- Fim da Tabela -->


<?php
}else{ //Se if(mysql_num_rows($sql_pesquisa)) der falso
?>
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999;font-weight:bold;" align="center">
		<td>N&atilde;o h&aacute; resultados!</td>
	</tr>
</table>
<?php
}
?>
