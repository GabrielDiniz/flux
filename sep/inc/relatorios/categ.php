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
<input type="button" onClick="print();this.style.display = 'none';" value="Imprimir" /></div>
<center>

<table width="95%" height="120" border="2" cellspacing="0" class="tabela">
  <tr>
    <td width="106"><center><img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
    </center></td>
    <td width="584" height="33" colspan="2"><span class="style1">
      <center>
             <p>LISTA ESTAT&Iacute;STICA DE SERVI&Ccedil;OS POR CATEGORIA</p>
             <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
        <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
      </center>
    
    
    </span></td>
  </tr>
  </table>
  <br />
  <table width="95%" border="2" cellspacing="0" class="tabela" style="page-break-after: always">
      <tr bgcolor="grey">
          <td align="center">Categoria</td>
          <td align="center">Quantidade de Servi&ccedil;os</td>
          <td align="center">Percentual</td>
      </tr>
      <?php  //comando sql que mostrará as categorias e a quantidade de cada um (Lista Estatística)
        $sqlTotal = mysql_query("SELECT COUNT(codigo) FROM servicos");
        list($total) = mysql_fetch_array($sqlTotal);

        $sql_categ = mysql_query("
            SELECT
                servicos_categorias.nome, COUNT(servicos_categorias.nome), servicos_categorias.codigo
            FROM
                servicos_categorias
            INNER JOIN
                servicos ON servicos.codcategoria = servicos_categorias.codigo
            GROUP BY servicos_categorias.nome
         ");
        $cont = 0;
        $percentual = 0;
        while(list($nome,$qtd,$codCategoria)=mysql_fetch_array($sql_categ)){
            $percent = $qtd*100/$total;
            echo "
                <tr>
                    <td align=\"center\">$nome</td>
                    <td align=\"center\">$qtd</td>
                    <td align=\"center\">".DecToMoeda($percent)."%</td>
                </tr>
                <tr bgcolor=\"grey\">
                    <td align=\"center\" colspan=\"2\">Servi&ccedil;os da categoria $nome</td>
                    <td align=\"center\">Quantidade de Prestadores</td>
                </tr>
            ";

            $sqlServicos = mysql_query("
               SELECT servicos.descricao, COUNT(cadastro_servicos.codigo) AS qtdPrestadores
               FROM servicos INNER JOIN servicos_categorias
               ON servicos.codcategoria = servicos_categorias.codigo
               INNER JOIN cadastro_servicos
               ON cadastro_servicos.codservico = servicos.codigo
               WHERE servicos_categorias.codigo = $codCategoria
               GROUP BY servicos.descricao
               ORDER BY servicos.descricao
            ");
            $contServicos = 0;
            while($servicos = mysql_fetch_object($sqlServicos)){
                if(strlen($servicos->descricao) > 50){
                    $desc = ResumeString($servicos->descricao,50)."...";
                }else{
                    $desc = $servicos->descricao;
                }

                echo "
                    <tr>
                        <td colspan=\"2\" title=\"{$srvicos->descricao}\">$desc</td>
                        <td align=\"center\">{$servicos->qtdPrestadores}</td>
                    </tr>
                ";
                $contServicos++;
            }

            $cont++;
            $percentual += $percent;

            if($cont == 45 || (($cont - 45) % 50 == 0)){
                echo "</table>";
                echo "<table width=\"95%\" border=\"2\" cellspacing=\"0\" class=\"tabela\" style=\"page-break-after: always\">
                  <tr bgcolor=\"grey\">
                      <td align=\"center\">Categoria</td>
                      <td align=\"center\">Quantidade de Servi&ccedil;os</td>
                      <td align=\"center\">Percentual</td>
                  </tr>";
            }
        }
    ?>
    <tr bgcolor="grey">
        <td align="center">Total de Categorias: <?php echo $cont; ?></td>
        <td align="center">Total de Servi&ccedil;os: <?php echo $total; ?></td>
        <td align="center">Total: <?php echo DecToMoeda($percentual); ?>%</td>
    </tr>
</table>