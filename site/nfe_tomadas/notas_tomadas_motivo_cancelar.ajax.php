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
	require_once("../../include/conect.php");
	require_once("../../funcoes/util.php");
	require_once("../../include/nocache.php");
	
	$codNotaTomada = $_GET['hdcod'];
?>
<input name="hdCodNotaTomada" type="hidden" value="<?php echo $codNotaTomada;?>" />
<table width="100%" align="center">
	<tr>
		<td align="left">Motivo do cancelamento: </td>
	</tr>
	<tr>
		<td align="center"><textarea name="txtMotivoCancelar" id="txtMotivoCancelar" rows="0" cols="0" style="width:350px;"></textarea></td>
	</tr>
	<tr>
		<td align="center">
			<input name="btCancelar" type="submit" value="Cancelar" class="botao" 
			onClick="return (ValidaFormulario('txtMotivoCancelar','Preencha o motivo do cancelamento!') && confirm('Deseja cancelar esta nota?'))" />
		</td>
	</tr>
</table>