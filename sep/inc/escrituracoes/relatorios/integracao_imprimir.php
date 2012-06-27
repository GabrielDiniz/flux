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
$codintegracao = base64_decode($_GET['ci']);
include("../../inc/conect.php");
include("../../funcoes/util.php");
// variaveis vindas do conect.php
// $CODPREF,$PREFEITURA,$USUARIO,$SENHA,$BANCO,$TOPO,$FUNDO,$SECRETARIA,$LEI,$DECRETO,$CREDITO,$UF	

$sql_brasao = mysql_query("SELECT brasao_nfe FROM configuracoes");
//preenche a variavel com os valores vindos do banco
list($BRASAO) = mysql_fetch_array($sql_brasao);
?>
<title>Imprimir Relat&oacute;rio Integraçao</title>


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

<body>
    <div class="pagina">
        <div id="DivImprimir">
            <input type="button" onClick="print();" value="Imprimir" />
            <br />
            <i><b>Este relatório é melhor visualizado em formato de impressão em paisagem.</b></i>
            <br /><br />
        </div>
        <table width="95%" height="120" border="2" cellspacing="0" class="tabela" align="center">
          <tr>
            <td width="106"><center><img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
            </td>
            <td width="584" height="33" colspan="2"><span class="style1">
              <center>
                     <p>RELAT&Oacute;RIO DE INTEGRA&Ccedil;&Atilde;O E-CIDADE/E-NOTA </p>
                     <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
                     <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
              </center>
			</td>
          </tr>
        </table>
        <br />
        <?php
		$query = mysql_query("SELECT * FROM dados_integracao WHERE codigo = $codintegracao");
		$dados = mysql_fetch_array($query);
		$dadosinseridos = $dados['prestadores']+$dados['prestadoressocios']+$dados['prestadoresservicos']+$dados['contadores']+$dados['contadoressocios']+$dados['guias']+$dados['guiaspagas']+$dados['guiascanceladas']+$dados['servicos']+$dados['prestadoresecidade'];
		$dadosnaoinseridos = $dados['prestadoreserros']+$dados['prestadoressocioserros']+$dados['prestadoresservicoserros']+$dados['contadoreserros']+$dados['contadoressocioserros']+$dados['guiaserros']+$dados['servicoserros']+$dados['prestadoresecidadeerros'];
		if(mysql_num_rows($query)>0){
		?>
        <table width="45%" border="2" cellspacing="0" class="tabela" align="center">
          <tr bgcolor="#999999">
          	<td colspan="9" align="center">Informa&ccedil;&otilde;es</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="16%" align="center">Data</td>
            <td width="17%" align="center">Hor&aacute;rio</td>
            <td width="17%" align="center">Dados Inseridos</td>
            <td width="17%" align="center">Dados n&atilde;o Inseridos</td>
          </tr>
          <tr>
            <td width="16%" align="center"><?php echo DataPt(substr($dados['data'],0,10)); ?></td>
            <td width="17%" align="center"><?php echo substr($dados['data'],10,10); ?></td>
            <td width="17%" align="center"><?php echo $dadosinseridos; ?></td>
            <td width="17%" align="center"><?php echo $dadosnaoinseridos; ?></td>
          </tr>
        </table>
        <br />
        <table width="75%" border="2" cellspacing="0" class="tabela" align="center">
          <tr bgcolor="#999999">
          	<td colspan="9" align="center">Prestadores</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="16%" align="center">Inseridos</td>
            <td width="17%" align="center">N&atilde;o Inseridos</td>
            <td width="17%" align="center">S&oacute;cios</td>
            <td width="18%" align="center">S&oacute;cios N&atilde;o Inseridos</td>
            <td width="15%" align="center">Servi&ccedil;os</td>
            <td width="17%" align="center">Servi&ccedil;os N&atilde;o Inseridos</td>
          </tr>
          <tr>
            <td width="16%" align="center"><?php echo $dados['prestadores']; ?></td>
            <td width="17%" align="center"><?php echo $dados['prestadoreserros']; ?></td>
            <td width="17%" align="center"><?php echo $dados['prestadoressocios']; ?></td>
            <td width="18%" align="center"><?php echo $dados['prestadoressocioserros']; ?></td>
            <td width="15%" align="center"><?php echo $dados['prestadoresservicos']; ?></td>
            <td width="17%" align="center"><?php echo $dados['prestadoresservicoserros']; ?></td>
          </tr>
        </table>
        <br />
        <table width="45%" border="2" cellspacing="0" class="tabela" align="center">
          <tr bgcolor="#999999">
          	<td colspan="9" align="center">Contadores</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="16%" align="center">Inseridos</td>
            <td width="17%" align="center">N&atilde;o Inseridos</td>
            <td width="17%" align="center">S&oacute;cios</td>
            <td width="18%" align="center">S&oacute;cios N&atilde;o Inseridos</td>
          </tr>
          <tr>
            <td width="16%" align="center"><?php echo $dados['contadores']; ?></td>
            <td width="17%" align="center"><?php echo $dados['contadoreserros']; ?></td>
            <td width="17%" align="center"><?php echo $dados['contadoressocios']; ?></td>
            <td width="18%" align="center"><?php echo $dados['contadoressocioserros']; ?></td>
          </tr>
        </table>
        <br />
        <table width="40%" border="2" cellspacing="0" class="tabela" align="center">
          <tr bgcolor="#999999">
          	<td colspan="9" align="center">Recibos</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="16%" align="center">Inseridos</td>
            <td width="17%" align="center">N&atilde;o Inseridos</td>
            <td width="17%" align="center">Pagos</td>
            <td width="18%" align="center">Cancelados</td>
          </tr>
          <tr>
            <td width="16%" align="center"><?php echo $dados['guias']; ?></td>
            <td width="17%" align="center"><?php echo $dados['guiaserros']; ?></td>
            <td width="17%" align="center"><?php echo $dados['guiaspagas']; ?></td>
            <td width="18%" align="center"><?php echo $dados['guiascanceladas']; ?></td>
          </tr>
        </table>

        <br />
        <table width="30%" border="2" cellspacing="0" class="tabela" align="center">
          <tr bgcolor="#999999">
          	<td colspan="9" align="center">Servi&ccedil;os</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="16%" align="center">Inseridos</td>
            <td width="17%" align="center">N&atilde;o inseridos</td>
          </tr>
          <tr>
            <td width="16%" align="center"><?php echo $dados['servicos']; ?></td>
            <td width="17%" align="center"><?php echo $dados['servicoserros']; ?></td>
          </tr>
        </table>
        <br />
        <table width="30%" border="2" cellspacing="0" class="tabela" align="center">
          <tr bgcolor="#999999">
          	<td colspan="9" align="center">Cadastros e-Nota/e-Cidade</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="16%" align="center">Inseridos</td>
            <td width="17%" align="center">N&atilde;o Inseridos</td>
          </tr>
          <tr>
            <td width="16%" align="center"><?php echo $dados['prestadoresecidade']; ?></td>
            <td width="17%" align="center"><?php echo $dados['prestadoresecidadeerros']; ?></td>
          </tr>
        </table>
        <?php
		}
        ?>
        <br>
    </div>
</body>
</html>