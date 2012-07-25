	<?php
/*
COPYRIGHT 2008 - 2010 DO PORTAL PUBLICO INFORMATICA LTDA

Este arquivo e parte do programa E-ISS / SEP-ISS

O E-ISS / SEP-ISS e um software livre; voce pode redistribui-lo e/ou modifica-lo
dentro dos termos da Licenca Publica Geral GNU como publicada pela Fundacao do
Software Livre - FSF; na versao 2 da Licenca

Este sistema e distribuido na esperanca de ser util, mas SEM NENHUMA GARANTIA,
sem uma garantia implicita de ADEQUACAO a qualquer MERCADO ou APLICACAO EM PARTICULAR
Veja a Licenca Publica Geral GNU/GPL em portugues para maiores detalhes

Voce deve ter recebido uma copia da Licenca Publica Geral GNU, sob o titulo LICENCA.txt,
junto com este sistema, se nao, acesse o Portal do Software Publico Brasileiro no endereco
www.softwarepublico.gov.br, ou escreva para a Fundacao do Software Livre Inc., 51 Franklin St,
Fith Floor, Boston, MA 02110-1301, USA
*/
?>
<?php
session_start();
$_SESSION['autenticacao'] = rand(10000,99999);
if(isset($_SESSION["logado"]))
{   ?>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>NFSe - Nota Fiscal de Serviço Eletrônica</title>
<link href="css/padrao.css" rel="stylesheet" type="text/css">
<link href="css/menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/jquery.tabs.css" type="text/css" media="print, projection, screen">
<link type="text/css" href="css/dark-hive/jquery-ui-1.8.2.custom.css" rel="stylesheet" />	
<?php include("scripts.php");?>



<meta content="width=device-width; initial-scale=1.0" name="viewport">
<link rel="stylesheet" href="../include/css/style.css" type="text/css" media="screen">
<script src="../include/js/jquery-1.7.1.min.js"></script>
<script src="../include/js/script.js"></script>
<script src="../include/js/superfish.js"></script>
<script src="../include/js/jquery.easing.1.3.js"></script>
<!--[if lt IE 8]>
   <div style=' clear: both; text-align:center; position: relative;'>
     <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
       <img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
    </a>
  </div>
<![endif]-->
<!--[if lt IE 9]>
	<script src="../include/js/html5.js"></script>
	<link rel="stylesheet" href="../include/css/ie.css"> 
<![endif]-->
</head>











</head>
<body >
<header>
<div class="container_12">
	<div class="grid_12">
		<h1 class="sep-logo"><a href="#">NFSe</a></h1>
		<nav class="main-menu">
		<ul class="sf-menu">
	<?php include("inc/menu.php"); ?>
</ul></nav>
</div></div>
</header>
<section>
<div class=" container_12">
	<div class="wrapper">
    <div class="grid_12">
			<div class="box2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  
  <tr>
  
    <td align="left" valign="top">	
    <?php
	if($_GET['d']){
		if(substr($_GET['d'],0,6)== 'janela'){
			include_janela(substr($_GET['d'],8),'JANELA',substr($_GET['d'],6,1));
			//Mensagem(substr('janela1:a',7,1));
		}else{
			include $_GET['d'];
		}
	}else if($_GET['j']){
		if($btDetalhesPrestadorVisualizar){
			$_POST['include'] = str_replace('tomadores','prestadores',$_POST['include']);
			$_POST['CODEMISSOR']  = $_POST['CODTOMADOR'];
		}	
 		include_janela($_POST['include']);
	}else
    if($_POST['include']){  
		if($btDetalhesPrestadorVisualizar){
			$_POST['include'] = str_replace('tomadores','prestadores',$_POST['include']);
			$_POST['CODEMISSOR']  = $_POST['CODTOMADOR'];
		}	
	
 		include($_POST['include']);
	}
	?>	
	</td>
  </tr>
</table>
</div></div></div></div></section>
<footer>
<div class=" container_12">
	<div class="wrapper">
		<div class="grid_6">
			<div class="pad2">
				<span class="text1"><a href="#"></a></span>Copyright &copy 2012 - Todos os Direitos Reservados
			</div>
		</div>
	</div>
</div>
</footer>
</body>
</html>



<?php

}
else
{
  include("funcoes/util.php");
  Mensagem('Sem permiss&atilde;o de acesso!!!');
 print("<script language=JavaScript>parent.location='login.php';</script>"); 
}

?>
