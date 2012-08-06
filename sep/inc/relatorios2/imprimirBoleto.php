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

$sql_brasao = mysql_query("SELECT brasao_nfe FROM configuracoes");
//preenche a variavel com os valores vindos do banco
list($BRASAO) = mysql_fetch_array($sql_brasao);
?>

<title>Imprimir Relat&oacute;rio</title>

<style type="text/css" media="screen">
<!--
.style1 {font-family: Georgia, "Times New Roman", Times, serif}

.tabela {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	border-collapse:collapse;
	border: 1px solid #000000;
}
.tabelameio {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	border-collapse:collapse;
	border: 1px solid #000000;
}
.tabela tr td{
	border: 1px solid #000000;
}
.fonte{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
div.pagina {
    writing-mode: tb-rl;
    height: 100%;
    /*margin: 10% 0%;*/
}
-->
</style>
<style type="text/css" media="print">
    #DivImprimir{
        display: none;
}
</style>
</head>
<?php
	$codigo = $_POST['rdbBoleto'];
	$estado = $_POST['rdbEstado'];
?>
<body>
    <div class="pagina">
        <div id="DivImprimir">
            <input type="button" onClick="print();" value="Imprimir" />
            <br />
            <i><b>Este relat&oacute;rio &eacute; melhor visualizado em formato de impress&atilde;o em paisagem.</b></i>
            <br /><br />
        </div>
        <center>

        <table width="95%" height="120" border="2" cellspacing="0" class="tabela">
          	<tr>
            	<td width="106">
					<center>
						<img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"/>
					</center>
				</td>
            	<td width="584" height="33" colspan="2">
					<span class="style1">
					<center>
						 <p>RELAT&Oacute;RIO DE BOLETOS GERADOS </p>
						 <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
						 <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
					</center>
					</span>
				</td>
			</tr>
		</table>
        <br />
        
        <?php
			$mes = $_POST['cmbMes'];
				if($mes>=1 and $mes<=12){
					$where = "AND datavencimento LIKE '___%-$mes-%__'";
				}else{
					$where = "";
				}
			$query =("SELECT 
						   guia.codigo AS codguia, 
						   guia.dataemissao, 
						   guia.datavencimento, 
						   guia.valor AS total, 
						   guia.valormulta AS multa, 
						   guia.nossonumero, 
						   guia.chavecontroledoc, 
						   guia.pago AS pago, 
						   guia.estado,
						   guia.motivo_cancelamento, 
						   guia.codlivro, 
						   guia.codnota AS codnota, 
						   nota.tomador_nome, 
						   nota.tomador_cnpjcpf, 
						   nota.codverificacao, 
						   livros.codigo, 
						   livros.periodo,
						   livros.codcadastro AS codcadatro,
						   (SELECT nome FROM cadastro WHERE livros.codcadastro = codigo) AS tomador
					FROM guia_pagamento AS guia 
					LEFT JOIN notas AS nota ON nota.codigo = guia.codnota 
					LEFT JOIN livro AS livros ON livros.codigo = guia.codlivro 
					WHERE pago = 'N' AND $codigo <> '' && guia.estado = '$estado' $where
					");
		
		$sql_pesquisa = mysql_query ($query);
		$result = mysql_num_rows($sql_pesquisa);
		if(mysql_num_rows($sql_pesquisa)){
        ?>
        
        <table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always">
            	<tr style="background-color:#999999">
					<?php
					if($result <= 1){
						echo "<b>Foi encontrado $result  Resultado</b>";
					}else{
						echo "<b>Foram encontrados $result  Resultados</b>";
					}
					?>
					<td align="center">
						<strong>Nome</strong>
					</td>
					<td align="center">
						<strong>CPF/CNPJ</strong>
					</td>
					<td align="center">
						<strong>Data Emiss&atilde;o</strong>
					</td>
                    <td align="center">
						<strong>Data Vencimento</strong>
					</td>
					<td align="center">
						<strong>Valor</strong>
					</td>
                    <td align="center">
						<strong>Multa</strong>
					</td>
                    <td align="center">
						<strong>Total</strong>
					</td>
                    <td align="center">
						<strong>Pago</strong>
					</td>
                    <td align="center">
						<strong>Estado</strong>
					</td>
                    <td align="center">
						<strong>Motivo Cancelamento</strong>
					</td>
          		</tr>
				<?php
					while ($dados = mysql_fetch_array($sql_pesquisa)){
						if($dados['tomador_nome'] != ''){
							$nome = $dados['tomador_nome'];
						}else{
							$nome = $dados['tomador'];
						}
						if(($dados['codnota'] != 0) && ($dados['codlivro'] == 0)){
							$total = $dados['total'] + $dados['multa'];
						}else{
							$total = 0;
						}
						if(($dados['codnota'] == 0) && ($dados['codlivro'] != 0)){
							$total2 = $dados['total'] + $dados['multa'];
						}else{
							$total2 = 0;
						}
						
						$sql = mysql_query("SELECT cpf, cnpj FROM cadastro WHERE nome = '$nome'");
						$result = mysql_fetch_array($sql);
						if($result['cpf'] == ''){
							$cpfcnpj = $result['cnpj'];
						}else{
							$cpfcnpj = $result['cpf'];
						}
			 	?>
				<tr>
					<td bgcolor="white"  align="left">
						<font size="1"><?php echo $nome; ?></font>
					</td>
					<td bgcolor="white" align="center">
						<font size="1"><?php if($result){ echo $cpfcnpj;}else{ echo $dados['tomador_cnpjcpf'];} ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php echo DataPt($dados['dataemissao']); ?></font>
					</td>
					<td bgcolor="white"  align="center">
						<font size="1"><?php echo DataPt($dados['datavencimento']); ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php echo "R$ ".DecToMoeda($dados['total']); ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php echo "R$ ".DecToMoeda($dados['multa']); ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php echo "R$ ".DecToMoeda($dados['total'] + ($dados['multa'])); ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php if($dados['pago'] == 'N'){echo "Em aberto";}else{echo "Pago";}; ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php if($dados['estado'] == 'N'){echo "Normal";}else{echo "Cancelada";} ?></font>
					</td>
                    <td bgcolor="white"  align="center">
						<font size="1"><?php echo $dados['motivo_cancelamento']; ?></font>
					</td>
				</tr>
        	<?php
					}//fim while
			}else{
			//caso não encontre resultados, a mensagem 'Não há resultados!' será mostrada na tela
            	echo "<tr style=\"background-color:#999999\"><td colspan=\"3\"><center><b><font class=\"fonte\">N&atilde;o h&aacute; resultados!</font></center></td></b></tr>";
        	}
        	?>
        	</table>
      
		</center>
	</div>
</body>
</html>