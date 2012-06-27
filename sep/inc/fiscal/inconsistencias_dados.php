<?php
	$dataInicialMysql = DataMysql($dataInicial);
	$dataFinalMysql   = DataMysql($dataFinal);
	
	$sql_nf_emitidas = mysql_query("
		SELECT 
			notas.codigo 
		FROM 
			notas
		INNER JOIN
			cadastro ON notas.codemissor = cadastro.codigo
		WHERE 
			DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
	");
	$nf_emitidas = mysql_num_rows($sql_nf_emitidas);
	
	
		
	$sql_nf_divirgentes = mysql_query("
		SELECT 
			notas.codigo 
		FROM
			notas
		INNER JOIN
			cadastro ON notas.codemissor = cadastro.codigo
		LEFT JOIN
			notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
		WHERE
			notas_tomadas.numero IS NULL AND DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
		GROUP BY 
			notas.codemissor
	");
	$nf_divirgentes = mysql_num_rows($sql_nf_divirgentes);


	
	$sql_nf_emitidas_tomador = mysql_query("
		SELECT 
			* 
		FROM 
			notas_tomadas
		INNER JOIN
			cadastro ON notas_tomadas.codprestador = cadastro.codigo
		WHERE 
			data BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
	");
	$nf_emitidas_tomador = mysql_num_rows($sql_nf_emitidas_tomador);
		
	$sql_nf_emitidas_tomador_divirgentes = mysql_query("
		SELECT 
			notas_tomadas.codigo 
		FROM 
			notas_tomadas 
		INNER JOIN
			cadastro ON notas_tomadas.codprestador = cadastro.codigo
		LEFT JOIN 
			notas ON notas_tomadas.numero = notas.numero AND notas_tomadas.codprestador = notas.codemissor AND notas.codtomador = notas_tomadas.codtomador
		WHERE 
			notas.numero IS NULL AND DATE(data) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
		GROUP BY
			notas_tomadas.codtomador
	");
	$nf_emitidas_tomador_divirgentes = mysql_num_rows($sql_nf_emitidas_tomador_divirgentes);
	
	$sql_nf_inconsistentes = mysql_query("
		SELECT 
			notas.codigo 
		FROM
			notas
		INNER JOIN
			notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
		INNER JOIN
			cadastro ON notas.codemissor = cadastro.codigo
		WHERE
			notas_tomadas.numero IS NOT NULL AND 
			(notas.valortotal <> notas_tomadas.total OR notas.codverificacao <> notas_tomadas.codverificacao) AND 
			DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' AND notas.estado <> 'C'
	");
	$nf_inconsistentes = mysql_num_rows($sql_nf_inconsistentes);
?>