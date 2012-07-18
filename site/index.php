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
  
  // arquivo de conex�o com o banco
  include("../include/conect.php"); 
  
  // arquivo com funcoes uteis
  include("../funcoes/util.php");
  //print("<a href=index.php target=_parent><img src=../img/topos/$TOPO></a>");
  
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<title>NFSe - Nota Fiscal de Serviço Eletrônica</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen">
<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/script.js"></script>
<script src="js/superfish.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<!--[if lt IE 8]>
   <div style=' clear: both; text-align:center; position: relative;'>
     <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
       <img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
    </a>
  </div>
<![endif]-->
<!--[if lt IE 9]>
	<script src="js/html5.js"></script>
	<link rel="stylesheet" href="css/ie.css"> 
<![endif]-->
</head>
<body>
  <?php include("inc/topo.php"); ?>

<!-- content -->
<section>
<div class=" container_12">
	<div class="wrapper">
		<div class="grid_4">
			<div class="box1">
				<div class="imgs">
					<img src="images/1page_img2.png" alt="" class="img-1">
					<img src="images/1page_img2-hover.png" alt="" class="img-2">
				</div>
				<h3>Prestadores</h3>
				<p>
					Unean auctor wisi eturna aliquam volutpat adipiscing duisac.
				</p>
				<a href="#"></a>
			</div>
		</div>
		<div class="grid_4">
			<div class="box1">
				<div class="imgs">
					<img src="images/1page_img1.png" alt="" class="img-1">
					<img src="images/1page_img1-hover.png" alt="" class="img-2">
				</div>
				<h3>Tomadores</h3>
				<p>
					Área destinada aos tomadores de serviços para consulta
				</p>
				<a href="#"></a>
			</div>
		</div>
		<div class="grid_4">
			<div class="box1">
				<div class="imgs">
					<img src="images/1page_img2.png" alt="" class="img-1">
					<img src="images/1page_img2-hover.png" alt="" class="img-2">
				</div>
				<h3>Contadores</h3>
				<p>
					Unean auctor wisi eturna aliquam volutpat adipiscing duisac.
				</p>
				<a href="#"></a>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<div class="grid_12">
		</div>
	</div>
	<div class="wrapper">
		<div class="grid_12 padtop2">
			<h2 class="padbot">Como Funciona?</h2>
		</div>
	</div>
	<div class="wrapper">
		<div class="grid_4 padRt">
			<div class="dropcap">
				1
			</div>
			<div class="extra-wrap">
				<a href="#" class="link2">Peça a Nota</a>
				<div class="padtop3">
					Natoqe penatus magnis parturient montes. Ridius nula fusegin alesda. Morb nuncodio, gravida cursus ...
				</div>
			</div>
		</div>
		<div class="grid_4 padRt">
			<div class="dropcap">
				2
			</div>
			<div class="extra-wrap">
				<a href="#" class="link2">Acesse o Sistema</a>
				<div class="padtop3">
					Natoqe penatus magnis parturient montes. Ridius nula fusegin alesda. Morb nuncodio, gravida cursus ...
				</div>
			</div>
		</div>
		<div class="grid_4 padRt">
			<div class="dropcap">
				3
			</div>
			<div class="extra-wrap">
				<a href="#" class="link2">Emita sua NF-e</a>
				<div class="padtop3">
					Natoqe penatus magnis parturient montes. Ridius nula fusegin alesda. Morb nuncodio, gravida cursus ...
				</div>
			</div>
		</div>
	</div>
</div>
</section>
<div class=" container_12">
	<div class="wrapper">
		<div class="grid_12">
			<div class="lineH">
			</div>
		</div>
	</div>
</div>
<?php include("inc/rodape.php"); ?>

</body>
</html>
