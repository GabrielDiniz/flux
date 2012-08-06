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
.style1 {
	font-family: Georgia, "Times New Roman", Times, serif;
	font-size:15px;
}

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
            <i><b>Este relat&oacute;rio &eacute; melhor visualizado em formato de impress&atilde;o em paisagem.</b></i>
            <br /><br />
        </div>
        <center>

        <table width="95%" height="120" border="2" cellspacing="0" class="tabela">
          <tr>
            <td width="106"><center><img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
            </center></td>
            <td width="584" height="33" colspan="2"><span class="style1">
              <center>
                     <p>RELAT&Oacute;RIO DE <b>PRESTADORES</b> </p>
                     <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
                     <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
              </center>


            </span></td>
          </tr>
          </table>
        <br>
        <table width="95%" border="1" cellspacing="0" class="tabelameio"  >
        <tr>
                <td width="32%" >
                    <table>
                        <?php
                        //Comando sql que selecionara do banco os tipos de prestadores e a quantidade de cada e o total geral

                        $sql_tipo = mysql_query("
                            SELECT
                                tipo.nome,
                                COUNT(cadastro.codigo)
                            FROM
                                cadastro
                            INNER JOIN
                                tipo ON tipo.codigo = cadastro.codtipo
                            GROUP BY
                                tipo.nome
                        ");
                        echo "<b><center><font class=\"fonte\">Tipos de Prestadores</center></b> <br>";

                        $qtdtotal=0;
                        while(list($nome,$qtd)=mysql_fetch_array($sql_tipo)){
                            echo"<tr><td align=\"center\"><font class=\"fonte\">$nome:</font></td><td align=\"center\"><font class=\"fonte\">$qtd</font></td></tr>";
                            $qtdtotal=$qtdtotal+$qtd;
                            }
                        ?>
                        <tr>
                            <td align="center"><font class="fonte"> Total:</font></td><td><?php echo "<font class=\"fonte\"> $qtdtotal<font>"; ?></td>
                        </tr>
                      </table>
                <td width="34%" valign="top">
                  <table  border="0" >
               <tr >
        <?php

        //Comando sql que selecionarï¿½ do banco a quantidade de prestadores por estado
        $sql = mysql_query ("
            SELECT
                uf ,
                COUNT(*)
            FROM
                cadastro
            INNER JOIN
                tipo ON cadastro.codtipo = tipo.codigo
            GROUP BY
                uf
        ");

        echo "<b><center>Qnt. de Prestadores por Estado (UF)</center></b> <br>";

        $qtdtotal=0;
        $cont = 0;
        while(list($uf,$qtd)=mysql_fetch_array($sql)){
			if($uf == '')$uf='outros';
        if($cont == '5'){
        echo "</tr><tr>";		
        $cont = 0;
        }
        echo"<td align=\"center\" ><font class=\"fonte\">$uf:</td><td align=\"center\"><font class=\"fonte\">$qtd</font></td>";
        $qtdtotal=$qtdtotal+$qtd;

        $cont++;
        }

        ?>

        <?php
        $ano=mysql_query("SELECT year (datahoraemissao) from notas");
        ?>
        </tr>
            <tr>
                <td align="left"><font class="fonte">Total:</font></td><td><?php echo "<font class=\"fonte\">$qtdtotal</font>"; ?></td>
            </tr>
              </table>
              </td>                
        </tr>
        <?php
            //Recebe as variaveis enviadas pelo form por post
            $uf           = trataString($_POST['cmbEstado']);
            $municipio    = trataString($_POST['txtInsMunicipioEmpresa']);
            $categoria = $_POST['cmbCategoria'];
            $estado       = $_POST['rgpEstado'];

            //verifica quais campos foram preenchidos e concatena na variavel str_where
            if(!empty($estado)){
                $where = "AND cadastro.estado = '$estado'";
            }else{
                $where = "";
            }

            if(empty($categoria)){
                $innerjoin = "";
            }else{
                $innerjoin = "
                    INNER JOIN cadastro_servicos ON cadastro.codigo = cadastro_servicos.codemissor
                    INNER JOIN servicos ON servicos.codigo = cadastro_servicos.codservico
                    INNER JOIN servicos_categorias ON servicos.codcategoria = servicos_categorias.codigo
                ";
                $where .= " AND servicos.codcategoria = '$categoria' ";
            }

            $query = ("
                    SELECT
                      `cadastro`.`razaosocial`, `cadastro`.`cnpj`, `cadastro`.`cpf`,
                      `cadastro`.`municipio`, `cadastro`.`uf`, `cadastro`.`nome`,
                      `cadastro`.`codigo`, `cadastro`.`codtipo`, `cadastro`.`codtipodeclaracao`,
                      `cadastro`.`isentoiss`, cadastro.estado,
                      declaracoes.declaracao
                    FROM
                      `cadastro`
                    LEFT JOIN
                        declaracoes ON declaracoes.codigo = cadastro.codtipodeclaracao
                        $innerjoin
                    WHERE
                        cadastro.uf LIKE '%$uf%' AND cadastro.municipio LIKE '%$municipio%'
                        $where

                    GROUP BY
                      `cadastro`.`codigo`
                      ORDER BY
                      `cadastro`.`nome`

                    ");
            $sql_pesquisa = mysql_query ($query);
            $result = mysql_num_rows($sql_pesquisa);
        if(mysql_num_rows($sql_pesquisa)){
        ?>


        <table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always">
            <tr style="background-color:#999999">
            <?php
            if($result <= 1)
            {
                echo "<b>Foi encontrado $result  Resultado</b>";
            }
            else
            {
                echo "<b>Foram encontrados $result  Resultados</b>";
            }
            ?>
              <td width="50%" align="center"><strong>Raz&atilde;o Social</strong></td>
              <td width="16%" align="center"><strong>CPF/CNPJ</strong></td>
              <td width="10%" align="center"><strong>Simples Nacional</strong></td>
              <td width="5%" align="center"><strong>Estado</strong></td>
              <td width="5%" align="center"><strong>Isento</strong></td>
              <td width="23%" align="center"><strong>Munic&iacute;pio</strong></td>

          </tr>
          <?php
                $x = 0;
                $tipos_extenso = array(
                    "prestador"              => "Prestador",
                    "empreiteira"            => "Empreiteira",
                    "instituicao_financeira" => "Institui&ccedil;&atilde;o Financeira",
                    "cartorio"               => "Cart&oacute;rio",
                    "operadora_credito"      => "Operadora de Cr&eacute;dito",
                    "grafica"                => "Gr&aacute;fica",
                    "contador"               => "Contador",
                    "tomador"                => "Tomador",
                    "orgao_publico"          => "Org&atilde;o P&uacute;blico",
                    "simples"                => "Simples"
                );

                while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
                    $declaracoes = $dados_pesquisa['declaracao'];
                if ($declaracoes!="Simples Nacional"){
                       $declaracoes="";
                   }else{
                       $declaracoes="Optante";
                   }

                switch($dados_pesquisa['estado']){
                    case "A": $dados_pesquisa['estado'] = "Ativo"; break;
                    case "I": $dados_pesquisa['estado'] = "Inativo"; break;
                    case "NL": $dados_pesquisa['estado'] = "N&atilde;o Liberado"; break;
                }

                if($dados_pesquisa['isentoiss'] == "S"){
                    $dados_pesquisa['isentoiss'] = "Sim";
                }else{
                    $dados_pesquisa['isentoiss'] = "N&atilde;o";
                }

                //print_array($dados_pesquisa);
         ?>
        <input type="hidden" name="txtCodigoGuia<?php echo $x;?>" id="txtCodigoGuia<?php echo $x;?>" value="<?php echo $dados_pesquisa['tipo'];?>" />
            <tr id="trDecc<?php echo $x;?>">
                <td bgcolor="white"  align="left">
                    <font size="1"><?php echo $dados_pesquisa['razaosocial'];?></font>
                </td>
                <td bgcolor="white" align="center">
                    <font size="1"><?php echo $dados_pesquisa['cnpj'].$dados_pesquisa['cpf'];?></font>
                </td>
                <td bgcolor="white"  align="center">
                    <font size="1"><?php echo $declaracoes;?></font>
                </td>
                <td bgcolor="white"  align="center">
                    <font size="1"><?php echo $dados_pesquisa['estado'];?></font>
                </td>
                <td bgcolor="white"  align="center">
                    <font size="1"><?php echo $dados_pesquisa['isentoiss'];?></font>
                </td>
                <td bgcolor="white"  align="center">
                    <font size="1"><?php echo $dados_pesquisa['municipio']."/".$dados_pesquisa['uf'];?></font>
                </td>

          </tr>
          <?php
                    $x++;
                    if($x == 25 || (($x-25) % 45 == 0)){
                        ?>
                        </table>
                        <table width="95%" class="tabela" border="1" cellspacing="0" style="margin-top:10px;
                        page-break-after: always">
                            <tr style="background-color:#999999">
                                <td width="50%" align="center"><strong>Raz&atilde;o Social</strong></td>
                              <td width="16%" align="center"><strong>CPF/CNPJ</strong></td>
                              <td width="10%" align="center"><strong>Simples Nacional</strong></td>
                              <td width="5%" align="center"><strong>Estado</strong></td>
                              <td width="5%" align="center"><strong>Isento</strong></td>
                              <td width="23%" align="center"><strong>Munic&iacute;pio</strong></td>
                          </tr>
                        <?php
                    }
                }//fim while
            ?>
        </table>
        <table width="95%" class="tabela">
        <?php
        }else{
         //caso não encontre resultados, a mensagem 'Não há resultados!' será mostrada na tela
            echo "<tr style=\"background-color:#999999\"><td colspan=\"3\"><center><b><font class=\"fonte\">N&atilde;o h&aacute; resultados!</font></center></td></b></tr>";
        }
        ?>
        </table>
    </div>
</body>
</html>