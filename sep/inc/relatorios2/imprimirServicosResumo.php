<?php
	if($mes>=1 && $mes<=12){ //Se algum mes tiver sido selecionado
		$where = "WHERE datahoraemissao LIKE '___%-$mes-%__'";
	}else{
		$where = "";
	}
	//Seleciona os serviços e a discriminação
	$query = ("
		SELECT 
			servicos.descricao,
			notas_servicos.discriminacao
		FROM 
			servicos
		LEFT JOIN 
			notas_servicos 
		ON 
			notas_servicos.codservico = servicos.codigo 
		INNER JOIN 
			notas 
		ON notas.codigo = notas_servicos.codnota
		$where
		GROUP BY 
			servicos.codigo
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
	
	<tr style="background-color:#999999;font-weight:bold;" align="center">
		<td width="430">Descri&ccedil;&atilde;o</td>
		<td>Discriminação</td>
	</tr>
	
<?php
while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
	if(strlen($dados_pesquisa['descricao']) > 60)
		$desc = ResumeString($dados_pesquisa['descricao'],60);
	else
		$desc = $dados_pesquisa['descricao'];
?>
	<tr>
		<td><?php echo $desc; ?></td>
		<td><?php echo $dados_pesquisa['discriminacao']; ?></td>
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
