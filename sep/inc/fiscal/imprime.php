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

include("../../inc/conect.php");
include("../../funcoes/util.php");
// variaveis vindas do conect.php
// $CODPREF,$PREFEITURA,$USUARIO,$SENHA,$BANCO,$TOPO,$FUNDO,$SECRETARIA,$LEI,$DECRETO,$CREDITO,$UF

$sql_brasao = mysql_query("SELECT brasao FROM configuracoes");
//preenche a variavel com os valores vindos do banco
list($BRASAO) = mysql_fetch_array($sql_brasao);

//print_r($_POST);
?>
<title>Listagem por Categoria</title>
<style type="text/css">
.tabela {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	border-collapse:collapse;
	border: 1px solid #000000;
}
</style>
<div id="DivImprimir">
	<input type="button" onClick="print();this.style.display = 'none';" value="Imprimir" />
</div>
<center>
<table width="700px" height="120" border="2" cellspacing="0" class="tabela">
	<tr>
		<td width="106">
			<center>
				<img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
			</center></td>
		<td width="584" height="33" colspan="2"><span class="style1">
			<center>
				<p>NOTA FISCAL ELETRONICA</p>
			</center>
			</span>
		</td>
	</tr>
</table>
<table width="700px" height="120" border="2" cellspacing="0" class="tabela">
	<?php  //comando sql que mostrará as categorias e a quantidade de cada um (Lista Estatística)
$sql = mysql_query("SELECT * FROM notas WHERE codigo={$_POST['nota']}");
//preenche a variavel com os valores vindos do banco
$nota = mysql_fetch_array($sql);
$data=DataPt(substr($nota['datahoraemissao'],0,10));
$valor=DecToMoeda($nota['valortotal']);
echo "<tr bgcolor=\"grey\"><td align=\"center\">Numero nota</td>
	  <td align=\"center\">Código verificacao</td>
	  <td align=\"center\">Data</td>
	  <td align=\"center\">Emissor</td>
	  <td align=\"center\">Tomador</td>
	  <td align=\"center\">CPF/CNPJ TOMADOR</td>
	  <td align=\"center\">Valor total</td>
	  </tr>";
echo	"<tr><td align=\"center\">{$nota['numero']}</td>
		<td align=\"center\">{$nota['codverificacao']}</td>
		<td align=\"center\">$data</td>
		<td align=\"center\">{$nota['codemissor']}</td>
		<td align=\"center\">{$nota['tomador_nome']}</td>
		<td align=\"center\">{$nota['tomador_cnpjcpf']}</td>
   		<td align=\"center\">$valor</td></tr>";			

?>
</table>
