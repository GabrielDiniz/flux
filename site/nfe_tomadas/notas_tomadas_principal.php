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
	
	$codLogado = $_SESSION['codempresa'];
?>
<form action="notas_tomadas.php" id="FormNotasTomadas" method="post" >
	<input type="hidden" name="hdCodLogado" id="hdCodLogado" value="<?php echo $codLogado;?>" />
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td align="center">
				<input name="btDeclararNotaTomada" type="submit" value="Declarar Nota Tomada" class="botao" />
				<input name="btPesquisar" type="submit" value="Pesquisar Notas declaradas" class="botao" />
			</td>
		</tr>
	</table>
</form>
<?php
	if($_POST['btDeclararNotaTomada'] == "Declarar Nota Tomada"){
		include("../site/nfe_tomadas/notas_tomadas_declarar.php");
	}
	
	if($_POST['btPesquisar']){
		include("../site/nfe_tomadas/notas_tomadas_pesquisar.php");
	}
?>