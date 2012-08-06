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
/* Inicia a sessão */

session_start();
$_SESSION['autenticacao'] = rand(10000,99999);
if(!(isset($_SESSION["logado"])))
{?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>SEP-ISS</title>

<script src="scripts/jquery.js" type="text/javascript"></script>
<script src="../scripts/padrao.js" type="text/javascript"></script>

	<? include ("../include/site-head.php"); ?>
 	<script src=""></script>
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
