
<?php 
/* Inicia a sessão */

session_start();
$_SESSION['autenticacao'] = rand(10000,99999);
if(!(isset($_SESSION["logado"])))
{?>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>NFe - Ficalização</title>

<script src="scripts/jquery.js" type="text/javascript"></script>
<script src="../scripts/padrao.js" type="text/javascript"></script>


	<? include ("../include/site-head.php"); ?>

</head>
<body>
 <?php include("../include/topo.php"); ?> 
 
<!-- formulario de login --> 
<form action="inc/verifica.php" method="post" name="frmLogin">

	  <!-- content -->
<section>
<div class=" container_12">
	<div class="wrapper">
		<div class="grid_6 prefix_3">
			<div class="box3">
				<span>Acesso à área dos fiscais</span> <br><br>
				<h4>Login</h4>
				<p>
					<input type="text" name="txtLogin" id="txtLogin" size="30" class="texto"/>
				</p>
				
				<h4> Senha</h4>
				<p>
					<input type="password" name="txtSenha" id="txtSenha" size="30" class="texto" />
				</p>
				<h4> Código de verificação</h4>
				<p>
					<input type="text" name="codseguranca" id="codseguranca" size="6" class="texto" />  &nbsp;
	   	   <?php include("inc/cod_verificacao.php"); ?>
				</p>
				<p><input type="submit" name="btEntrar" size="30" value="Entrar" class="botao" /></p>
			</div>
		</div>
	</div>
</div>
</section>

</form>  


<?php include("../include/rodape.php"); ?>

</body>
</html>


<?php 

}else {

print("<script language=JavaScript>parent.location='principal.php';</script>");
 
} 

?>  
