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
<fieldset>
<?php
require_once("../../inc/conect.php");
require_once("../../inc/nocache.php");
require_once("../../funcoes/util.php");

$cnpj = $_GET['txtCnpjPrestador'];
if($cnpj!=""){
	$sql_where = array();

if ($cnpj) {
	$sql_where[] = "(c.cpf = '$cnpj' OR c.cnpj = '$cnpj')";
}

//testa se tem algum filtro do where
if ($sql_where) {
	$WHERE = 'WHERE ' . implode(' AND ', $sql_where);
} else {
	$WHERE = '';
}

$query = ("
	SELECT
		*
	FROM
		cadastro as c
	$WHERE
	ORDER BY
		c.codigo
	LIMIT 1
");

$sql = mysql_query($query);

if (mysql_num_rows($sql) == 0) {
	?><strong><center>Nenhum resultado encontrado.</center></strong><?php
} else {
	$dados = mysql_fetch_array($sql);
	$dados['cnpj'] .= $dados['cpf'];
	if($dados['nfe']=="S"){
		?><strong><center>Este contribuinte n&atilde;o gera Nota Avulsa.</center></strong><?php
	}else{
	$notas = ("SELECT * FROM notas WHERE codemissor = '$dados[codigo]' ORDER BY codigo DESC");
	$sql = Paginacao($notas,'frmNota','dvResultadoNota');
	if (mysql_num_rows($sql) == 0) {
		?><strong><center>Nenhum resultado encontrado.</center></strong><?php
	} else {
		$x=1;
		?>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr >
				<td width="10%" align="center">Nro. nota</td>
				<td width="25%" align="center">Cod. Verifica&ccedil;&atilde;o</td>
				<td width="25%" align="center">Valor</td>
				<td width="25%" align="center">Estado</td>
				<td width="15%" align="center">A&ccedil;&otilde;es</td>
			</tr>
			<?php
			while($dadosnota=mysql_fetch_array($sql)){
				$guia = mysql_query("SELECT codigo FROM guia_pagamento WHERE codnota = '{$dadosnota[codigo]}'");
				$notaslivro = mysql_query("SELECT * FROM livro_notas WHERE codnota = '{$dadosnota[codigo]}'");
				if(mysql_num_rows($guia)>0){ 
					list($codguia)=mysql_fetch_array($guia); 
				}
				$estado = $dadosnota['estado'];
				$cor = "#FFFFFF";
				switch ($estado) { 
					case "C": 
						$estado = "Cancelado"; 
						$cor = "#FFAC84";
					break;
					case "N": $estado = "Normal"; break;
					case "B": $estado = "Boleto Gerado"; break;
					case "E": $estado = "Escriturada"; break;
				} 
				?>
				<tr bgcolor="<?php echo $cor;?>" height="27">
					<td align="center"> <?php echo $dadosnota['numero']; ?></td>
					<td align="center"> <?php echo $dadosnota['codverificacao']; ?></td>
					<td align="center"> <?php echo "R$ ". DecToMoeda($dadosnota['valortotal']); ?></td>
					<td align="center"> <?php echo $estado; ?></td>
					<td align="center" bgcolor="#FFFFFF">
                    	<?php
						if(mysql_num_rows($notaslivro)==0){
							if(($estado != "Cancelado") && ($estado != "Escriturada")){
						?>
                        <img  style="cursor:pointer;" title="Imprimir Nota" src="img/botoes/botao_imprimir.jpg" onclick="document.getElementById('CODIGO').value='<?php echo $crypto;?>';cancelaAction('frmNota','../boleto/recebimento/index.php?COD=<?php echo base64_encode($codguia) ?>','_blank')" />
                        <?php
							}
						}
						?>
                    </td>
				</tr>
				<?php
			}
			?>
		</table>
		<input type="hidden" name="CODIGO" id="CODIGO" />
	<?php
	}
	}
}//fim else se tem resultado
}else{
	?><strong><center>Digite um CNPJ ou CPF.</center></strong><?php
}
?>
</fieldset>