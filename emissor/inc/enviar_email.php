<?php
	include("conect.php");
	include("../../funcoes/util.php");

	$codnota = $_POST['txtNotaEmail'];
	$sql = mysql_query("
		SELECT
			notas.numero,
			notas.codemissor
		FROM
			notas
		WHERE
			codigo = '$codnota'		
	");
	$dados = mysql_fetch_array($sql);
	
	if(notificaTomador($dados['codemissor'],$dados['numero'])){
		Mensagem("Nota enviada ao tomador");
	}else{
		Mensagem("Erro ao enviar a nota ao tomador");
	}
?>
<script>window.close();</script>