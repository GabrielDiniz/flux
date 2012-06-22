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
<title>Listagem por &Aacute;rea de Atua&ccedil;&atilde;o</title>

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
             <p>LISTA DE SERVI&Ccedil;OS POR CATEGORIA E SERVI&Ccedil;O</p>
             <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
             <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
      </center>
    
    
    </span></td>
  </tr>
  </table>
  
    <table width="95%" height="120" cellspacing="0" class="tabela" style="page-break-after: always">
  <?php  //comando sql que mostrará as categorias e os serviços 

$sql_descr = mysql_query("SELECT
						  servicos_categorias.codigo, servicos_categorias.nome, COUNT(servicos_categorias.nome),
						  servicos.descricao 
						  FROM 
						  servicos_categorias 
						INNER JOIN
						  servicos ON servicos.codcategoria = servicos_categorias.codigo
						GROUP BY
						  servicos_categorias.nome
 ");
$cont = 0;
while(list($cod,$nome)=mysql_fetch_array($sql_descr)){
	echo"<tr><td bgcolor=\"grey\" > ->$nome</td></tr>";
							
	$sql_serv = mysql_query("
        SELECT
            servicos.descricao,
            servicos.aliquota,
            servicos.estado,
            servicos.codservico,
            servicos.aliquotair,
            servicos.basecalculo
        FROM
            servicos_categorias
        INNER JOIN
            servicos ON servicos.codcategoria = servicos_categorias.codigo
        WHERE
            servicos_categorias.codigo = '$cod'
        GROUP BY
            servicos.descricao
        ORDER BY
            servicos.descricao
    ");
										  
	?>
        <tr>
            <td align="center">
                <table width="100%" cellspacing="0" class="tabela">
                    <tr>
                        <td width="50%" align="center">Descri&ccedil;&atilde;o</td>
                        <td width="12%" align="center">Base de C&aacute;lculo</td>
                        <td width="10%" align="center">Al&iacute;quota</td>
                        <td width="10%" align="center">Al&iacute;quota Ret.</td>
                        <td width="10%" align="center">Cod. Servi&ccedil;o</td>
                        <td width="8%" align="center">Estado</td>
                    </tr>
                </table>
            </td>
        </tr>
    <?php
        while($servico = mysql_fetch_object($sql_serv)){
            $cont++;
            if(($cont == 45) || (($cont - 45) % 50 == 0)){
                echo '</table><br /><table width="95%" cellspacing="0" style="page-break-after: always">';
                echo "<tr><td bgcolor=\"grey\" > -> $nome</td></tr>";
                ?>
                    <tr>
                        <td align="center">
                            <table width="100%" cellspacing="0" class="tabela">
                                <tr>
                                    <td width="50%" align="center">Descri&ccedil;&atilde;o</td>
                                    <td width="12%" align="center">Base de C&aacute;lculo</td>
                                    <td width="10%" align="center">Al&iacute;quota</td>
                                    <td width="10%" align="center">Al&iacute;quota Ret.</td>
                                    <td width="10%" align="center">Cod. Servi&ccedil;o</td>
                                    <td width="8%" align="center">Estado</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                <?php
            }

            switch($servico->estado){
                case "A"  : $servico->estado = "Ativo";               break;
                case "I"  : $servico->estado = "Inativo";             break;
                case "NL" : $servico->estado = "N&aatilde; Liberado"; break;
            }

            if(strlen($servico->descricao) > 50){
                $desc = ResumeString($servico->descricao,50)."...";
            }else{
                $desc = $servico->descricao;
            }

    ?>
        <tr>
            <td align="center">
                <table width="100%" class="tabela">
                    <tr>
                        <td width="50%" align="left" title="<?php echo $servico->descricao; ?>"><?php echo $desc; ?></td>
                        <td width="12%" align="center"><?php echo DecToMoeda($servico->basecalculo); ?></td>
                        <td width="10%" align="center"><?php echo DecToMoeda($servico->aliquota); ?>%</td>
                        <td width="10%" align="center"><?php echo DecToMoeda($servico->aliquotair); ?>%</td>
                        <td width="10%" align="center"><?php echo $servico->codservico; ?></td>
                        <td width="8%" align="center"><?php echo $servico->estado; ?></td>
                    </tr>
                </table>
            </td>
        </tr>
    <?php
        
	}
}			

?>

  </table>