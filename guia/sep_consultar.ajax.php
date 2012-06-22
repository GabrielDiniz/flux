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
require_once("../sep/inc/conect.php");
require_once("../sep/inc/nocache.php");
require_once("../sep/funcoes/util.php");

$cnpj = $_GET['txtCnpjPrestador'];
$mes_ini = $_GET['cmbMes'] < 10? '0'.$_GET['cmbMes'] : $_GET['cmbMes'];
$ano_ini = $_GET['cmbAno'];
$mes_fim = $_GET['cmbMesFim'] < 10? '0'.$_GET['cmbMesFim'] : $_GET['cmbMesFim'];
$ano_fim = $_GET['cmbAnoFim'];
$cnpj;
$sql_where = array();

if ($cnpj) {
	$sql_where[] = "(cadastro.cpf = '$cnpj' OR cadastro.cnpj = '$cnpj')";
}
if ($mes_ini && $ano_ini) {
	$sql_where[] = "guia_pagamento.dataemissao >= '$ano_ini-$mes_ini'";
}
if ($mes_fim && $ano_fim) {
	$sql_where[] = "guia_pagamento.datavencimento <= '$ano_fim-$mes_fim'";
}

//testa se tem algum filtro do where
if ($sql_where) {
	$WHERE = 'WHERE ' . implode(' AND ', $sql_where);
} else {
	$WHERE = '';
}

$query = ("SELECT guia_pagamento.codigo, 
				  guia_pagamento.dataemissao, 
				  guia_pagamento.datavencimento, 
				  guia_pagamento.valor, 
				  guia_pagamento.valormulta, 
				  guia_pagamento.nossonumero, 
				  guia_pagamento.chavecontroledoc, 
				  guia_pagamento.pago, 
				  guia_pagamento.estado,
				  guia_pagamento.motivo_cancelamento,
				  cadastro.nome, 
				  cadastro.razaosocial, 
				  cadastro.cnpj, 
				  cadastro.cpf
		FROM
				  guia_pagamento INNER JOIN livro ON livro.codigo = guia_pagamento.codlivro 
				  				 INNER JOIN cadastro ON cadastro.codigo = livro.codcadastro
				  
				$WHERE
	
");



$sql = Paginacao($query,'frmGuia','dvResultdoGuia');

if (mysql_num_rows($sql) == 0) {
	?><strong><center>Nenhum resultado encontrado.</center></strong><?php
} else {
	?>
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
			<td bgcolor="#999999" align="center">C&oacute;digo</td>
			<td bgcolor="#999999" align="center">Data Emiss&atilde;o</td>
            <td bgcolor="#999999" align="center">Data do vencimento</td>
			<td bgcolor="#999999" align="center">CNPJ / CPF</td>
			<td bgcolor="#999999" align="center">Valor Guia</td>
			<td bgcolor="#999999" align="center">Valor Multa</td>
			<td bgcolor="#999999" align="center">Pago</td>
			<td bgcolor="#999999" align="center">Estado</td>
            <td bgcolor="#999999" align="center">Nosso N&deg;</td>
            <td bgcolor="#999999" align="center">A&ccedil;&atilde;o</td>
			
		</tr>
		<?php
		while ($dados = mysql_fetch_array($sql)) {
		//junta o cnpj com o cpf para ficar no mesmo campo
		$dados['cnpj'] .= $dados['cpf'];
		?>
		<tr>
			<td bgcolor="#FFFFFF" align="right"><?php echo $dados['codigo']; ?></td>
			<td bgcolor="#FFFFFF" align="center"><?php echo implode('/', array_reverse(explode('-', $dados['dataemissao']))); ?></td>
             <td bgcolor="#FFFFFF" align="center" ><?php echo implode('/', array_reverse(explode('-', $dados['datavencimento']))); ?></td>
			<td bgcolor="#FFFFFF" align="center"><?php echo $dados['cnpj']; ?></td>
			<td bgcolor="#FFFFFF" align="right"><?php echo DecToMoeda($dados['valor']); ?></td>
			<td bgcolor="#FFFFFF" align="right"><?php echo DecToMoeda($dados['valormulta']); ?></td>
			<td bgcolor="#FFFFFF" align="right"><?php echo ($dados['pago']); ?></td>
			<td bgcolor="#FFFFFF" align="right"><?php echo ($dados['estado']); ?></td>
            <td bgcolor="#FFFFFF" align="right"><?php echo ($dados['nossonumero']); ?></td>
            <td><input type="submit" class="botao" id="btnImprimirr" name="btnImprimir" 
            onclick="document.getElementById('frmGuia').action='../guia/imprimirguia.php?guia=<?php echo base64_encode($dados['codigo']); ?>';document.getElementById('frmGuia').target='_blank'" value="Imprimir"/>&nbsp;</td>
			
		</tr>
		<?php
		}//fim while
		?>
	</table>
<?php
}//fim else se tem resultado
?>
</fieldset>
