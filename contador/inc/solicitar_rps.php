<?php
	$codLogado = $_POST['codLogado'];
	$sql_testa_solicitacao = mysql_query("SELECT codigo FROM rps_solicitacoes WHERE codcadastro = '$codLogado' AND estado = 'A'");
	if(!mysql_num_rows($sql_testa_solicitacao)){
		$data = date("Y-m-d");
		mysql_query("INSERT INTO rps_solicitacoes SET codcadastro = '$codLogado', data = '$data', estado = 'A'");
		Mensagem_onload('Foi solicitado novo limite de RPS, aguarde liberaчуo da prefeitura');
	}
?>