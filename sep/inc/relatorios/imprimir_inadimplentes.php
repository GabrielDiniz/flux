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
<html>
    <head>
        <?php

        include("../../inc/conect.php");
        include("../../funcoes/util.php");
        // variaveis vindas do conect.php
        // $CODPREF,$PREFEITURA,$USUARIO,$SENHA,$BANCO,$TOPO,$FUNDO,$SECRETARIA,$LEI,$DECRETO,$CREDITO,$UF

        $sql_brasao = mysql_query("SELECT brasao FROM configuracoes");
        //preenche a variavel com os valores vindos do banco
        list($BRASAO) = mysql_fetch_array($sql_brasao);

        $meses = array(
            1  => "Janeiro",
            2  => "Fevereiro",
            3  => "Mar&ccedil;o",
            4  => "Abril",
            5  => "Maio",
            6  => "Junho",
            7  => "Julho",
            8  => "Agosto",
            9  => "Setembro",
            10 => "Outubro",
            11 => "Novembro",
            12 => "Dezembro"
        );
        
        $codprestador = $_POST['cmbPrestador'];
        $mes          = $_POST['cmbMes'];
        $ano          = $_POST['cmbAno'];
        $mesAtual     = date("m");
        $anoAtual     = date("Y");

        if(!empty($mes) && empty($ano)){
            $where = "WHERE DATE_FORMAT(notas.datahoraemissao, '%m') = '$mes'";
        }elseif(empty($mes)&& !empty($ano)){
            $where = "WHERE DATE_FORMAT(notas.datahoraemissao, '%Y') = '$ano'";
        }elseif(!empty($mes) && !empty($ano)){
            $where = "WHERE DATE_FORMAT(notas.datahoraemissao, '%Y/%m') = '$ano/$mes'";
        }else{
            $where = "WHERE 1 = 1";
        }

        if(!empty($codprestador) && !empty($where)){
            $where .= " AND notas.codemissor = $codprestador";
        }elseif(!empty($codprestador) && empty($where)){
            $where = "WHERE notas.codemissor = $codprestador";
        }
        ?>
        <title>Imprimir Relat&oacute;rio</title>
        <style type="text/css"  media="screen">
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
        </style>
        <style type="text/css"  media="print">
            #DivImprimir{
                display: none;
            }
        </style>
    </head>
    <body>
        <div id="DivImprimir"><input type="button" onClick="print();" value="Imprimir" /></div>
        <br />
        <center>
            <table width="95%" border="2" cellspacing="0" class="tabela">
              <tr>
                <td width="106">
                    <center>
                        <img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
                    </center>
                </td>
                <td width="584" height="33" colspan="2">
                    <span class="style1">
                        <center>
                            <p>RELAT&Oacute;RIO DE PRESTADORES INADIMPLENTES</p>
                            <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
                            <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
                        </center>
                    </span>
                </td>
              </tr>
            </table>
            <br /><br />
            <?php
                $sql = mysql_query("SELECT COUNT(notas.codigo) FROM notas $where ");
                list($emitidas) = mysql_fetch_array($sql);

                $sql = mysql_query("
                    SELECT COUNT(notas.codigo)
                    FROM notas
                    INNER JOIN livro_notas
                    ON notas.codigo = livro_notas.codnota
                    INNER JOIN livro
                    ON livro.codigo = livro_notas.codlivro
                    $where AND notas.estado = 'C'
                    AND livro.vencimento < NOW()
                ");
                list($canceladas) = mysql_fetch_array($sql);

                $sql = mysql_query("
                    SELECT COUNT(notas.codigo) FROM notas
                    INNER JOIN cadastro ON notas.codemissor = cadastro.codigo
                    INNER JOIN livro_notas
                    ON notas.codigo = livro_notas.codnota
                    INNER JOIN livro
                    ON livro.codigo = livro_notas.codlivro
                    $where
                    AND notas.estado <> 'C'
                    AND notas.estado <> 'E'
                    AND livro.vencimento < NOW()
                    
                ");
                list($vencidas) = mysql_fetch_array($sql);
            ?>
            <table width="95%" border="2" cellspacing="0" class="tabela">
                <tr>
                    <td><b>Notas emitidas no per&iacute;odo:</b> <?php echo $emitidas; ?></td>
                    <td><b>Notas canceladas no per&iacute;odo:</b> <?php echo $canceladas; ?></td>
                    <td><b>Notas vencidas no per&iacute;odo:</b> <?php echo $vencidas; ?></td>
                </tr>
            </table>
             <?php
                    $sql = mysql_query("
                        SELECT
                            notas.tomador_nome AS tomador,
                            notas.valortotal AS valor,
                            notas.valoriss AS iss,
                            notas.issretido,
                            DATE_FORMAT(notas.datahoraemissao, '%d/%m/%Y %H:%i:%s') AS time,
                            cadastro.nome,
                            if(cadastro.cpf<>'',cadastro.cpf,cadastro.cnpj) AS doc
                        FROM notas INNER JOIN cadastro
                            ON notas.codemissor = cadastro.codigo
                        INNER JOIN livro_notas
                            ON notas.codigo = livro_notas.codnota
                        INNER JOIN livro
                            ON livro.codigo = livro_notas.codlivro
                        $where
                            AND notas.estado <> 'C'
                            AND notas.estado <> 'E'
                            AND livro.vencimento < NOW()
                            
                    ");
                    if(mysql_num_rows($sql) > 0){
                        ?>
                            <table width="95%" border="2" cellspacing="0" class="tabela">
                                <tr >
                                    <td align="center">Prestador</td>
                                    <td align="center">CNPJ/CPF</td>
                                    <td align="center">Tomador</td>
                                    <td align="center">Data/Hora</td>
                                    <td align="center">ISS</td>
                                    <td align="center">ISS Retido</td>
                                    <td align="center">Valor Total</td>
                                </tr>
                                <?php
                                    while($notasVencidas = mysql_fetch_object($sql)){
                                        ?>
                                        <tr>
                                            <td align="center"><?php echo $notasVencidas->nome; ?></td>
                                            <td align="center"><?php echo $notasVencidas->doc; ?></td>
                                            <td align="center"><?php echo $notasVencidas->tomador; ?></td>
                                            <td align="center"><?php echo $notasVencidas->time; ?></td>
                                            <td align="center"><?php echo DecToMoeda($notasVencidas->iss); ?></td>
                                            <td align="center"><?php echo DecToMoeda($notasVencidas->issretido); ?></td>
                                            <td align="center"><?php echo DecToMoeda($notasVencidas->valor); ?></td>
                                        </tr>
                                        <?php
                                    }
                                ?>
                            </table>
                        <?php
                    }else{
                        echo "<br />Nenhum prestador com indaimpl&ecirc;ncia no per&iacute;odo";
                    }
                ?>
        </center>
    </body>
</html>