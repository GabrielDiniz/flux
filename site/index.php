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
  
  // arquivo de conexÃ£o com o banco
  include("../include/conect.php"); 
  
  // arquivo com funcoes uteis
  include("../funcoes/util.php");
  //print("<a href=index.php target=_parent><img src=../img/topos/$TOPO></a>");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<? include ("../include/site-head.php"); ?>
</head>
<body>
  <?php include("../include/topo.php"); ?>

<!-- content -->
<section>
<div class=" container_12">
	<div class="wrapper">
		<div class="grid_4">
			<div class="box1">
				<div class="imgs">
					<img src="../include/images/prestador.png" alt="" class="img-1">
					<img src="../include/images/prestador-hover.png" alt="" class="img-2">
				</div>
				<h3>Prestadores</h3>
				<p>
						Área destinada aos prestadores de serviços para acesso ao sistema de emissão e cadastro.
				</p>
				<a href="prestadores.php"></a>
			</div>
		</div>
		<div class="grid_4">
			<div class="box1">
				<div class="imgs">
					<img src="../include/images/tomador.png" alt="" class="img-1">
					<img src="../include/images/tomador-hover.png" alt="" class="img-2">
				</div>
				<h3>Tomadores</h3>
				<p>
					Área destinada aos tomadores de serviços para consulta
				</p>
				<a href="tomadores.php"></a>
			</div>
		</div>
		<div class="grid_4">
			<div class="box1">
				<div class="imgs">
					<img src="../include/images/contador.png" alt="" class="img-1">
					<img src="../include/images/contador-hover.png" alt="" class="img-2">
				</div>
				<h3>Contadores</h3>
				<p>
					Área destinada aos contadores para acesso ao sistema de emissão e cadastro.
				</p>
				<a href="contadores.php"></a>
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
					Ao pagar um serviço solicite a emissão da NFe. Informe sempre o prestador de servições o seu CPF/CNPJ. Esta é a sua garantia para obter os beneficios da NF-e.
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
					O prestador por meio da senha acessa o sistema e emite a NF-e. Obs.: Caso não seja possivel a emissão da NFe deverá ser entregue ao cliente um Recibo Provisório de Serviços - RPS.
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
					O sistema efetuará o cálculo do ISS devido pelo prestador e o valor do tributo será impresso na NF-e. Parte do ISS recolhido pertence ao cliente.
				</div>
			</div>

		</div>
	</div>



	<div class="wrapper">

		<div class="grid_4 padtop5">
			<div class="dropcap">
				4
			</div>
			<div class="extra-wrap">
				<a href="#" class="link2">Pagamento do ISS</a>
				<div class="padtop3">
				 O prestador deverá gerar no sistema o documento de arrecadação relativo às NFe emitidas.
				</div>
			</div>
		</div>
<div class="grid_4 padtop5">
			<div class="dropcap">
				5
			</div>
			<div class="extra-wrap">
				<a href="#" class="link2">Crédito do ISS</a>
				<div class="padtop3">
				Após o recolhimento será creditado automaticamente aos clientes a parcela do imposto constante na NF-e.
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
<?php include("../include/rodape.php"); ?>

</body>
</html>
