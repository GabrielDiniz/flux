<?php
	if($mes>=1 and $mes<=12) //Se algum mes tiver sido selecionado
		$where = "AND datahoraemissao LIKE '___%-$mes-%__'";
	else
		$where = "";
	//Seleciona os municipios nas notas, que forem diferentes do municipio cadastrado nas configurações.
	$query =("
		SELECT 
			tomador_uf
		FROM
			notas
		WHERE 
			tomador_uf <> '$ESTADO' $where
		GROUP BY
			tomador_uf
		ORDER BY
			tomador_uf
	");
	
	$sql_pesquisa = mysql_query ($query);
	$result = mysql_num_rows($sql_pesquisa);
	
	if($result){ //Se existir algum registro, mostra na tabela
?>

<!-- Início da Tabela -->
	<?php
	while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
		$uf = ($dados_pesquisa['tomador_uf']);
		//Seleciona os tomadores
		$query_tomador = ("
			SELECT
				notas.tomador_uf,
				servicos.descricao,
				COUNT(notas_servicos.codservico) as incidencia
			FROM 
				notas
			INNER JOIN
				notas_servicos
			ON
				notas.codigo = notas_servicos.codnota
			INNER JOIN
				servicos
			ON
				notas_servicos.codservico = servicos.codigo
			WHERE 
				tomador_uf='$uf' $where
			GROUP BY 
				notas_servicos.codservico
		");
		$sql_tomador = mysql_query ($query_tomador);
		$result_tomador = mysql_num_rows($sql_tomador);		
	?>
<table width="95%" class="tabela" border="1" cellspacing="0" align="center">
	<tr style="background-color:#999999">
		<?php
			if($result_tomador == 1)
				echo "<center><b>Foi encontrado $result_tomador  Resultado</b></center>";
			else
				echo "<center><b>Foram encontrados $result_tomador  Resultados</b></center>";
		?>
	</tr>
	
	<tr style="font-weight:bold;" align="center">
		<td colspan="3"><?php echo $uf; ?></td>
	</tr>
	<tr style="background-color:#999999;font-weight:bold;">
		<td width="650">Descri&ccedil;&atilde;o</td>
		<td>Incid&ecirc;ncia</td>
	</tr>
	<?php
		while($dados_servicos = mysql_fetch_array($sql_tomador)){ //enquanto receber tomadores, exibe seu nome e a descrição do  serviço que tomou
			if(strlen($dados_servicos['descricao']) > 100)
				$desc = ResumeString($dados_servicos['descricao'],100);
			else
				$desc = $dados_servicos['descricao'];
	?>
	<tr>
		<td><?php echo $desc; ?></td>
		<td><?php echo $dados_servicos['incidencia']; ?></td>
	</tr>
	<?php
		}//Fim do while($dados_servicos = mysql_fetch_array($sql_tomador))
	?>
</table>
<br />
	<?php
	}//Fim do while($dados_pesquisa = mysql_fetch_array($sql_pesquisa))
?>
<!-- Fim da Tabela -->


<?php
}else{ //Se if(mysql_num_rows($sql_pesquisa)) der falso
?>
<table width="95%" class="tabela" border="1" cellspacing="0" align="center">
	<tr style="background-color:#999999;font-weight:bold;" align="center">
		<td>N&atilde;o h&aacute; resultados!</td>
	</tr>
</table>
<?php
}
?>
