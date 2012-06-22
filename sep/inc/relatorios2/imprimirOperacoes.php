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

<?php //Includes
	include("../../inc/conect.php");
	include("../../funcoes/util.php");
?>

<?php //Pega o brasão
	$sql_brasao = mysql_query("SELECT brasao_nfe FROM configuracoes");
	list($BRASAO) = mysql_fetch_array($sql_brasao);
?>

<?php
	$codigo = $_POST['rdbContador'];
?>

<!-- Início do css da visualização da página -->
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
<!-- Fim do css da visualização da página -->


<!-- Início do css da Impressão da página -->
	<style type="text/css" media="print">
    #DivImprimir{
		display: none; /*Tira a div imprimir na hora da impressão*/
	}
	</style>
<!-- Fim do css da Impressão da página -->

<title>Imprimir Relat&oacute;rio</title>

<div class="pagina"> <!-- Início div página -->
	<div id="DivImprimir">
		<input type="button" onClick="print();" value="Imprimir" /><br />
		<i><b>Este relat&oacute;rio &eacute; melhor visualizado em formato de impress&atilde;o em paisagem.</b></i>
	</div>
	
	<!-- Início do topo com as informações -->
	<div id="DivTopo">
		<table width="95%" height="120" border="2" cellspacing="0" class="tabela" align="center">
			<tr>
				<td width="106">
					<center>
						<img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"/>
					</center>
				</td>
				<td width="584" height="33" colspan="2">
					<span class="style1">
						<center>
							<p>RELAT&Oacute;RIO DE OPRERA&Ccedil;&Otilde;ES EFETUADAS POR CONTADOR </p>
							<p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
							<p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
						</center>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<!-- Fim do topo com as informações -->
	
	<br>
					<?php
					$query =("SELECT * FROM cadastro WHERE codtipo = '$codigo'");
					$sql_pesquisa = mysql_query ($query);
					$result = mysql_num_rows($sql_pesquisa);
					
				if($result){
				while ($dados = mysql_fetch_array($sql_pesquisa)){
					$codcontador = $dados['codigo'];
					$query2 = ("SELECT * FROM cadastro WHERE codcontador = '$codcontador'");
				
				$sql_pesquisa2 = mysql_query ($query2);
				$result2 = mysql_num_rows($sql_pesquisa2);
				if(mysql_num_rows($sql_pesquisa2)){
					if($result2 <= 1){
						echo "<b>Foi encontrado $result2 Resultado</b>";
					}else{
						echo "<b>Foram encontrados $result2 Resultados</b>";
					}
					?>
                    <td width="20%" align="center">
						<strong>Contador</strong>
					</td>
                    <td width="10%" align="center">
						<strong>CPF/CNPJ</strong>
					</td>
                    <td width="20%" align="center">
						<strong>Contribuinte</strong>
					</td>
					<td align="center">
						<strong>EAIDF</strong>
					</td>
					<td align="center">
						<strong>NFE</strong>
					</td>
                    <td align="center">
						<strong>LIVRO</strong>
					</td>
                    <td align="center">
						<strong>GUIA</strong>
					</td>
                    <td align="center">
						<strong>RPS</strong>
					</td>
          		</tr>
                <?php
					while ($dados2 = mysql_fetch_array($sql_pesquisa2)){
					
						if($dados['cpf'] == ''){
							$cpfcnpj = $dados['cnpj'];
						}else{
							$cpfcnpj = $dados['cpf'];
						}
			 	?>
				<tr>
                	<td bgcolor="white"  align="left">
						<font size="1"><?php echo $dados['nome']; ?></font>
					</td>
                    <td bgcolor="white" align="center">
						<font size="1"><?php echo $cpfcnpj; ?></font>
					</td>
                    <td bgcolor="white"  align="left">
						<font size="1"><?php echo $dados2['nome']; ?></font>
					</td>
					<td bgcolor="white"  align="center">
						<font size="1"><?php if($dados2['contadoreaidf'] == 'S'){echo "SIM";}else{echo "N&Atilde;O";} ?></font>
					</td>
					<td bgcolor="white" align="center">
						<font size="1"><?php if($dados2['contadornfe'] == 'S'){echo "SIM";}else{echo "N&Atilde;O";} ?></font>
					</td>
                    <td bgcolor="white" align="center">
						<font size="1"><?php if($dados2['contadorlivro'] == 'S'){echo "SIM";}else{echo "N&Atilde;O";} ?></font>
					</td>
					<td bgcolor="white"  align="center">
						<font size="1"><?php if($dados2['contadorguia'] == 'S'){echo "SIM";}else{echo "N&Atilde;O";} ?></font>
					</td>
					<td bgcolor="white" align="center">
						<font size="1"><?php if($dados2['contadorrps'] == 'S'){echo "SIM";}else{echo "N&Atilde;O";} ?></font>
					</td>
				</tr>
        	<?php
						}
					}
				}//fim while
			}
        	?>
        	</table>
            <?php
				if(!$result2){
			?>
            <table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
                <tr style="background-color:#999999;font-weight:bold;" align="center">
                    <td>N&atilde;o h&aacute; resultados!</td>
                </tr>
            </table>
			<?php
				}
            ?>
		</center>
	</div>
</body>
</html>