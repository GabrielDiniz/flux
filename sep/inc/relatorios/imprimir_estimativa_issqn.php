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
    ?>

        <title>Imprimir Estimativa de ISSQN</title>


        <style type="text/css"  media="screen">
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
                     <p>RELAT&Oacute;RIO DE <b>ESTIMATIVA DE ISSQN</b> </p>
                     <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
                     <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
                  </center>
              </span>
            </td>
          </tr>
        </table>
        <?php


            //Recebe as variaveis enviadas pelo form por post
            //$codPrestador = $_POST["cmbPrestador"];
            $ano          = $_POST["cmbAno"];
            $mes          = $_POST["cmbMes"];
            $nomeMes      = $meses[$mes];
            if(!empty($mes)){
                while(strlen($mes) < 2){
                    $mes = "0".$mes;
                }
            }
			$nomeMes = $meses[$mes];

            $where = "";
            if(empty($ano) && empty($mes)){
                $where = "";
                $sqlPeriodo = mysql_query("
                    SELECT DATE_FORMAT(MAX(datahoraemissao),'%m/%Y') AS final,
                    DATE_FORMAT(MIN(datahoraemissao),'%m/%Y') AS inicio
                    FROM notas
                ");
                $historico = mysql_fetch_object($sqlPeriodo);
                $periodo = "<b>Per&iacute;odo:</b> {$historico->inicio} at&eacute; {$historico->final}";
            }elseif(!empty($ano) && empty($mes)){
                $where = "WHERE DATE_FORMAT(notas.datahoraemissao,'%Y') = '$ano'";
                $periodo = "<b>Per&iacute;odo:</b> 01/$ano at&eacute; 12/$ano";
            }elseif(empty($ano) && !empty($mes)){
                $where = "WHERE DATE_FORMAT(notas.datahoraemissao,'%m') = '$mes'";
                $periodo = "<b>Per&iacute;odo:</b> Hist&oacute;rico do m&ecirc;s de $nomeMes";
            }elseif(!empty($ano) && !empty($mes)){
                $where = "WHERE DATE_FORMAT(notas.datahoraemissao,'%Y-%m') = '$ano-$mes'";
                $periodo = "<b>Per&iacute;odo:</b> $mes/$ano";
            }

            if(empty($where)){
                $where = "WHERE notas.estado <> 'C'";
            }else{
                $where .= " AND notas.estado <> 'C'";
            }
			
			
            $sqlValores = mysql_query("
               SELECT
			   	   DAY(notas.datahoraemissao) AS dia,	
                   SUM(notas_servicos.basecalculo) AS arrecadacao,
                   SUM(notas_servicos.issretido) AS issretido,
                   SUM(notas_servicos.iss) AS iss
               FROM notas_servicos
               INNER JOIN notas ON notas.codigo = notas_servicos.codnota
               $where
           ");
           $valores = mysql_fetch_object($sqlValores);
        ?>
        <table width="95%" border="1" cellspacing="0" class="tabelameio">
            <tr>
                <td width="32%" >
                   <?php echo $periodo; ?>
                </td>
                <td>
                    <?php
                       echo "<b>Estimativa de ISS:</b> R$ ".DecToMoeda($valores->iss);
                    ?>
                </td>
                <td>
                    <?php
                       echo "<b>Estimativa de ISS Retido:</b> R$ ".DecToMoeda($valores->issretido);
                    ?>
                </td>
            </tr>
        </table>
        <?php
            //Sql buscando as informações que o usuario pediu e com o limit estipulado pela função
            $varcont= $_POST['hdContador'];

            $query = ("
                SELECT
					DAY(notas.datahoraemissao) AS dia,
                    SUM(notas_servicos.basecalculo) AS arrecadacao,
                    SUM(notas_servicos.issretido) AS issretido,
                    SUM(notas_servicos.iss) AS iss
                FROM notas_servicos
                INNER JOIN notas ON notas_servicos.codnota = notas.codigo
                $where
                GROUP BY dia
                ORDER BY dia ASC
            ");
            $sql = mysql_query($query);
            $result = mysql_num_rows($sql);
            $x = 0;
            if($result == 1){
                echo "<b>Foi encontrado $result  Resultado</b>";
            }elseif($result > 1){
                echo "<b>Foram encontrados $result  Resultados</b>";
            }elseif($result < 1){
                echo "<b>Nenhum Resultado encontrado</b>";
            }
            if($result > 0){
            ?>
                <table width="95%" class="tabela" border="1" cellspacing="0">
                    <tr style="background-color:#999999">
                      <td align="center"><strong>Dia</strong></td>
                      <td align="center"><strong>Valor Arrecadado</strong></td>
                      <td align="center"><strong>ISS</strong></td>
                      <td align="center"><strong>ISS Retido</strong></td>

                  </tr>
                <?php
            }
            $cont = 0;
            while($dados_pesquisa = mysql_fetch_array($sql)){
         ?>
            <tr id="trDecc<?php echo $x;?>">
                <td bgcolor="white" align="center" title="<?php echo $dados_pesquisa['dia']; ?>"><?php echo $dados_pesquisa['dia']; ?></td>
                <td bgcolor="white" align="center">R$ <?php echo DecToMoeda($dados_pesquisa['arrecadacao']);?></td>
                <td bgcolor="white" align="center">R$ <?php echo DecToMoeda($dados_pesquisa['iss']);?></td>
                <td bgcolor="white" align="center">R$ <?php echo DecToMoeda($dados_pesquisa['issretido']);?></td>

           </tr>
           <?php
                $x++;
            }//fim while
            ?>
        </table>
        </center>
    </body>
</html>