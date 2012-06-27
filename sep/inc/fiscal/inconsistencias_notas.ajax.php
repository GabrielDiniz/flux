<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	require_once("../nocache.php");
	
	$dataInicial = $_GET['txtDataInicial'];
	$dataFinal   = $_GET['txtDataFinal'];
	$dataInicialMysql = DataMysql($dataInicial);
	$dataFinalMysql   = DataMysql($dataFinal);
	$tipo = $_GET['tipo'];
	$codEmissor = $_GET['hdcod'];
	
	switch($tipo){
		case 1:
			$query = ("
				SELECT 
					notas.codigo, 
					notas.codemissor, 
					DATE(notas.datahoraemissao), 
					COUNT(notas.numero), 
					SUM(notas.valortotal)
				FROM
					notas
				INNER JOIN
					cadastro ON notas.codemissor = cadastro.codigo
				LEFT JOIN
					notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
				WHERE
					notas_tomadas.numero IS NULL AND DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' AND notas.estado <> 'C'
				GROUP BY 
					notas.codemissor
				ORDER BY
					DATE(notas.datahoraemissao)
				DESC
			");
		  break;
		case 2:
			$query = ("
				SELECT 
					notas_tomadas.codigo, 
					notas_tomadas.codtomador, 
					notas_tomadas.data, 
					COUNT(notas_tomadas.numero), 
					SUM(notas_tomadas.total)
				FROM 
					notas_tomadas 
				INNER JOIN
					cadastro ON notas_tomadas.codprestador = cadastro.codigo
				LEFT JOIN 
					notas ON notas_tomadas.numero = notas.numero AND notas_tomadas.codprestador = notas.codemissor AND notas.codtomador = notas_tomadas.codtomador
				WHERE 
					notas.numero IS NULL AND DATE(data) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' AND notas_tomadas.estado <> 'C'
				GROUP BY 
					notas.codtomador
				ORDER BY
					DATE(notas.datahoraemissao)
				DESC
			");
		  break;
	}
	
	$sql_notas = mysql_query($query);
?>