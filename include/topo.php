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
//rawurlencode($CONF_BRASAO);
?>
<?    session_start();	
  // arquivo de conexão com o banco
  include_once("conect.php"); 
  
  // arquivo com funcoes uteis
  include_once("../funcoes/util.php");
  
  //arquivo com a funcao de logs
  include_once("../funcoes/funcao_logs.php");
  
  // arquivo com funcoes uteis
 // include_once("../include/teclado.php");
?>
<!-- header -->
<header>
<div class="container_12">
	<div class="grid_12">
		<h1><a href="">NFSe</a></h1><?//= "Prefeitura Municipal de ".$CONF_CIDADE;?>
		<nav class="main-menu">
		<ul class="sf-menu">
			<li class="current"><a href="#"><span>Acesso</span><strong class="grad"><em class="gr-left"></em><em class="gr-right"></em></strong><strong class="gr-bot"></strong></a>
			<ul>
				<li><a href="../site/prestadores.php">Prestadores</a></li>
				<li><a href="../site/tomadores.php">Tomadores</a></li>
				<li><a href="../site/contadores.php">Contadores</a></li>
				<li><a href="../sep/">Fiscalização</a></li>
			</ul>
			</li>
			<li><a href="#"><span>legislação</span><strong class="grad"><em class="gr-left"></em><em class="gr-right"></em></strong><strong class="gr-bot"></strong></a></li>
			<li><a href="#"><span>Ouvidoria</span><strong class="grad"><em class="gr-left"></em><em class="gr-right"></em></strong><strong class="gr-bot"></strong></a></li>
			<li><a href="#"><span>suporte</span><strong class="grad"><em class="gr-left"></em><em class="gr-right"></em></strong><strong class="gr-bot"></strong></a></li>
		</ul>
		<div class="clear">
		</div>
		</nav>
		<div class="clear">
		</div>
	</div>
	<div class="clear">
	</div>
</div>
</header>