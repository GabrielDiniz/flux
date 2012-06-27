<?php
require_once("../conect.php");
require_once("../../funcoes/util.php");

$sql_brasao = mysql_query("SELECT brasao_nfe FROM configuracoes");
//preenche a variavel com os valores vindos do banco
list($BRASAO) = mysql_fetch_array($sql_brasao);


?>

<style type="text/css">

.tabela {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	border-collapse:collapse;
	border: 1px solid #000000;
}
</style>

<?php
$datainicial 	= dataMysql($_POST['txtDataInicial']);
$datafinal 		= dataMysql($_POST['txtDataFinal']);
$cnpjprestador 	= $_POST['txtCnpjPrestador'];

$sql_where = array();

//where para notas escrituradas
$sql_where[] = "notas.estado = 'E'";

if ($datainicial) {
	$sql_where[] = "DATE(notas.datahoraemissao) >= '$datainicial'";
}
if ($datafinal) {
	$sql_where[] = "DATE(notas.datahoraemissao) <= '$datafinal'";
}
if ($cnpjprestador) {
	$sqlEmissor = mysql_query("SELECT codigo FROM cadastro WHERE cpf='$cnpjprestador' OR cnpj='$cnpjprestador'");
    list($codEmissor) = mysql_fetch_array($sqlEmissor);
    $sql_where[] = "notas.codemissor = '$codEmissor'";
}

$sql_where = implode(' AND ', $sql_where);

$sql = mysql_query("
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

if (mysql_num_rows($sql) <= 0) {
	?><strong><center>Nenhum resultado encontrado.</center></strong><?php
	exit();
}
?>
<html>
<head>
<title>Relat&oacute;rio de Notas escrituradas</title>
<style type="text/css">
@media print {
	#DivImprimir {
		display:none;
	}
}
@media all {
	table.relatorio {
		font-size:10px; 
		font-family:Verdana, Arial, Helvetica, sans-serif; border:thick;
		border-collapse:collapse;
	}
	table.relatorio tr td {
		border:1px solid #000000;
	}
}

</style>
</head>
<body>
<div id="DivImprimir"><input type="button" onClick="print();" value="Imprimir" /></div>
<table width="95%" height="120" border="2" cellspacing="0" class="tabela">
  <tr>
    <td width="106"><center><img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
    </center></td>
    <td width="584" height="33" colspan="2"><span class="style1">
      <center>
             <p>RELAT&Oacute;RIO DE NOTAS ESCRITURADAS</p>
             <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
             <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
      </center>


    </span></td>
  </tr>
</table>
<table>
	<?php if($_POST["txtNossonumero"]){?>
	<tr>
		<td><strong>Nosso N&uacute;mero:</strong></td>
		<td><?php echo $_POST["txtNossonumero"]; ?></td>
	</tr>
	<?php } if($_POST["txtDataIni"]){ ?>
	<tr>
		<td><strong>A partir da data:</strong></td>
		<td><?php echo $_POST["txtDataIni"]; ?></td>
	</tr>
	<?php } if($_POST["txtDataFim"]){ ?>
	<tr>
		<td><strong>Até a data:</strong></td>
		<td><?php echo $_POST["txtDataFim"]; ?></td>
	</tr>
	<?php } if($_POST["txtCnpjPrestador"]) {?>
	<tr>
		<td><strong>CNPJ/CPF:</strong></td>
		<td><?php echo $_POST["txtCnpjPrestador"]; ?></td>
	</tr>
	<?php }//fim if mostrar os dados usados no filtro ?>
	<tr>
		<td colspan="2"><b><?php echo mysql_num_rows($sql); ?> notas escrituradas</b></td>
	</tr>
</table>
<table width="100%" class="relatorio">
    <tr bgcolor="grey">
        <td align="center"><b>Emissor</b></td>
		<td align="center"><b>N&ordm;</b></td>
		<td align="center"><b>Data de emiss&atilde;o</b></td>
		<td align="center"><b>CNPJ/CPF Tomador</b></td>
		<td align="center"><b>Tomador</b></td>
		<td align="center"><b>Valor</b></td>
		<td align="center"><b>Iss</b></td>
	</tr>
	<?php
	while($dados = mysql_fetch_array($sql)){
	?>
	<tr>
        <td align="center"><?php echo $dados['razaosocial']; ?></td>
		<td align="center"><?php echo $dados['numero']; ?></td>
		<td align="center"><?php echo $dados['datahoraemissao']; ?></td>
		<td align="center"><?php echo $dados['tomador_cnpjcpf']; ?></td>
		<td align="center"><?php echo $dados['tomador_nome']; ?></td>
		<td align="center"><?php echo DecToMoeda($dados['valortotal']); ?></td>
		<td align="center"><?php echo DecToMoeda($dados['valoriss']); ?></td>
	</tr>
	<?php
	}//fim while
	?>
</table>
</body>