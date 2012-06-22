<link href="../css/livrodigital.css" rel="stylesheet" type="text/css" />
<html>
<head></head>
<body>
<?php 
	include("../include/conect.php");
	
	include("../funcoes/util.php");

	$livro = base64_decode($_GET['livro']);
	
	require("imprimir_controlearrec.php");
	
	$livro = base64_decode($_GET['livro']);
	
	require("imprimir_nfeemitidas.php");
	
	$livro = base64_decode($_GET['livro']);
	
	require("imprimir_nfetomadas.php");
?>
</body>