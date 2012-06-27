<?php
	$dataInicialMysql = DataMysql($dataInicial);
	$dataFinalMysql   = DataMysql($dataFinal);
	//Verifica o numero de NF emitidas
	/*$sql_nf_emitidas = mysql_query("
		SELECT 
			COUNT(codigo) AS quantidade 
		FROM 
			notas
		WHERE
			DATE(datahoraemissao) >= '$dataInicialMysql' AND DATE(datahoraemissao) <= '$dataFinalMysql'
	");*/
	$sql_nf_emitidas = mysql_query("
		SELECT * FROM notas
		INNER JOIN notas_tomadas AS nt ON notas.codemissor=nt.codtomador and notas.numero=nt.numero
		WHERE datahoraemissao BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'");
	$nf_emitidas = mysql_num_rows($sql_nf_emitidas);
	
	
	
	
?>