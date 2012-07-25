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
<!-- box de conteúdos -->
<form name="frmTomadoresBox" method="post" action="tomadores.php" id="frmTomadoresBox">
	<input type="hidden" name="txtMenu" id="txtMenu" />
	<input type="hidden" name="txtCNPJ" id="txtCNPJ" />
	<div class="grid_3 suffix_1">
			<h2></h2>
			<ul class="list1">
				<li>
					<a title="Permite que o tomador de servi&ccedil;os que recebeu um  Recibo Provis&oacute;rio de Servi&ccedil;os &ndash; RPS consulte a sua convers&atilde;o em NFe." 
					onclick="document.getElementById('txtMenu').value='rps';frmTomadoresBox.submit();" 
					href="#">Consulta RPS</a>
				</li>
				<li>
					<a title="Acesse e compare os n&uacute;meros de aprova&ccedil;&atilde;o da NFe de ISS." 
					onclick="document.getElementById('txtMenu').value='autenticidade';frmTomadoresBox.submit();"
					href="#">Autenticidade de NFe</a>
				</li>
				<li>
					<a title="Gerar guia de declara&ccedil;&otilde;es com ISS retido." 
					onclick="document.getElementById('txtMenu').value='issretido';frmTomadoresBox.submit();" 
					href="#">Gerar guia</a>
				</li>
				<li>
					<a title="Gerar guia de declara&ccedil;&otilde;es com ISS retido." 
					onclick="document.getElementById('txtMenu').value='issretido';frmTomadoresBox.submit();" 
					href="#">Gerar guia</a>
				</li>
			</ul>
	</div>
</form>