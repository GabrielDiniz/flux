<?php
	$sql_testa_solicitacao = mysql_query("SELECT codigo FROM rps_solicitacoes WHERE codcadastro = '$CODIGO_DA_EMPRESA' AND estado = 'A'");
	if(!mysql_num_rows($sql_testa_solicitacao)){
		$data = date("Y-m-d");
		mysql_query("INSERT INTO rps_solicitacoes SET codcadastro = '$CODIGO_DA_EMPRESA', data = '$data', estado = 'A'");
		Mensagem_onload('Foi solicitado novo limite de RPS, aguarde liberaчуo da prefeitura');
	}
?>