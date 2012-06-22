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
<fieldset><legend>Resultado</legend>
<?php
require_once("../conect.php");
require_once("../nocache.php");
require_once("../../funcoes/util.php");

$datainicial 	= dataMysql($_GET['txtDataInicial']);
$datafinal 		= dataMysql($_GET['txtDataFinal']);
$cnpjprestador 	= $_GET['txtCnpjPrestador'];

$sql_where = array();

//where para notas escrituradas
$sql_where[] = "notas.estado = 'E'";

if($datainicial) {
	$sql_where[] = "DATE(notas.datahoraemissao) >= '$datainicial'";
}
if($datafinal) {
	$sql_where[] = "DATE(notas.datahoraemissao) <= '$datafinal'";
}
if($cnpjprestador) {
    $sqlEmissor = mysql_query("SELECT codigo FROM cadastro WHERE cpf='$cnpjprestador' OR cnpj='$cnpjprestador'");
    list($codEmissor) = mysql_fetch_array($sqlEmissor);
	$sql_where[] = "notas.codemissor = '$codEmissor'";
}

$sql_where = implode(' AND ', $sql_where);

$query = ("
	SELECT 
		notas.codigo,
		notas.numero,
		DATE_FORMAT(notas.datahoraemissao, '%d/%m/%Y') AS 'datahoraemissao',
		notas.tomador_nome,
		notas.tomador_cnpjcpf,
		notas.valortotal,
		notas.valoriss,
        cadastro.razaosocial
	FROM 
		notas
    INNER JOIN cadastro
        ON cadastro.codigo = notas.codemissor
	WHERE 
		$sql_where
	ORDER BY
		codigo DESC
");
$sql = Paginacao($query,'frmRelatorio','dvResultdoRelatorio');

if (mysql_num_rows($sql) < 1) {
	?><strong><center>Nenhum resultado encontrado.</center></strong><?php
} else {
	?>
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
			<tr>
                <td bgcolor="#999999" align="center">Emissor</td>
				<td bgcolor="#999999" align="center">N&ordm;</td>
				<td bgcolor="#999999" align="center">Data de emiss&atilde;o</td>
				<td bgcolor="#999999" align="center">CNPJ/CPF Tomador</td>
				<td bgcolor="#999999" align="center">Tomador</td>
				<td bgcolor="#999999" align="center">Valor</td>
				<td bgcolor="#999999" align="center">Iss</td>
			</tr>
			<?php
			while ($dados = mysql_fetch_array($sql)){
			?>
			<tr>
                <td bgcolor="#FFFFFF" align="center"><?php echo $dados['razaosocial']; ?></td>
				<td bgcolor="#FFFFFF" align="right"><?php echo $dados['numero']; ?></td>
				<td bgcolor="#FFFFFF" align="center"><?php echo $dados['datahoraemissao']; ?></td>
				<td bgcolor="#FFFFFF" align="center"><?php echo $dados['tomador_cnpjcpf']; ?></td>
				<td bgcolor="#FFFFFF" align="center"><?php echo $dados['tomador_nome']; ?></td>
				<td bgcolor="#FFFFFF" align="right"><?php echo DecToMoeda($dados['valortotal']); ?></td>
				<td bgcolor="#FFFFFF" align="right"><?php echo DecToMoeda($dados['valoriss']); ?></td>
			</tr>
			<?php
			}//fim while
			?>
		</table>
	<?php
}
?>
</fieldset>