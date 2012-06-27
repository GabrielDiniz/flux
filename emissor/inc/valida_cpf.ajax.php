<?php 
	include("../../funcoes/util.php");
	

	if(is_cpf($_GET['txtTomadorCNPJ'])||(strlen($_GET['txtTomadorCNPJ'])!=14)){
		echo "<input type=\"hidden\" value=\"T\" name=\"hdValidaCPF\" id=\"hdValidaCPF\">";
	}else{
		echo "<font color=\"#FF0000\"><b>Verifique o CPF !</b></font>";
 	    echo "<input type=\"hidden\" value=\"F\" name=\"hdValidaCPF\" id=\"hdValidaCPF\">";			
	}



?>