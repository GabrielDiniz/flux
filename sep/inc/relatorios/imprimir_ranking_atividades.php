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

        <title>Imprimir Ranking de atividades</title>


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
                     <p>RELAT&Oacute;RIO DE <b>RANKING DE ATIVIDADES</b></p>
                     <p>PREFEITURA MUNICIPAL DE <b><?php print strtoupper($CONF_CIDADE); ?></b> </p>
                     <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
                  </center>
              </span>
            </td>
          </tr>
        </table>
        <?php	
			$ordem = $_POST['cmbOrdem'];
        ?>
        <table width="95%" border="1" cellspacing="0" class="tabelameio"  >
            <tr>
                <td>
                   Ordem: 
				   <?php
				   		switch($ordem){
							case 'arrecadacao DESC': echo 'Maior faturamento';break;
							case 'arrecadacao ASC': echo 'Menor faturamento';break;
							case 'iss DESC': echo 'Maior Gera&ccedil;&atilde;o de ISSQN';break;
							case 'iss ASC': echo 'Menor Gera&ccedil;&atilde;o de ISSQN';break;
							case 'qtdnotas DESC': echo 'Maior n&uacute;mero de notas emitidas';break;
							case 'qtdnotas ASC': echo 'Menor n&uacute;mero de notas emitidas';break;
						}
                   ?>
                </td>
            </tr>
        </table>
        <?php
            //Sql buscando as informações que o usuario pediu e com o limit estipulado pela função
            $varcont= $_POST['hdContador'];
			
			//$sqlnotas = "SELECT COUNT(codigo) AS qtdnotas FROM notas GROUP BY codemissor ORDER BY qtdnotas ASC";

            $query = ("
                SELECT  
					servicos.descricao AS servico, 
					COUNT(notas.codigo) AS qtdnotas, 
					SUM(notas_servicos.basecalculo) AS arrecadacao, 
					SUM(notas_servicos.issretido) AS issretido, 
					SUM(notas_servicos.iss) AS iss 
				FROM notas_servicos 
				INNER JOIN notas ON notas_servicos.codnota = notas.codigo
				INNER JOIN servicos ON notas_servicos.codservico = servicos.codigo 
				GROUP BY servico 
				ORDER BY $ordem
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
                      <td align="center"><strong>Posi&ccedil;&atilde;o</strong></td>
                      <td align="center"><strong>Servi&ccedil;o</strong></td>
                      <td align="center">
                      	<strong>Valor Arrecadado</strong>
                      </td>
                      <td align="center">
                      	<strong>ISS</strong>
                      </td>
                      <td align="center">
                      	<strong>ISS Retido</strong>
                      </td>
                      <td align="center">
                      	<strong>Quantidade Notas</strong>
                      </td>                      

                  </tr>
                <?php
            }
            $cont = 0;
            while($dados_pesquisa = mysql_fetch_array($sql)){
                if(strlen($dados_pesquisa['nome']) > 40){
                    $descricao = ResumeString($dados_pesquisa['nome'],40);
                }else{
                    $descricao = $dados_pesquisa['nome'];
                }
         ?>
            <tr id="trDecc<?php echo $x;?>">
            	<td bgcolor="white" align="center"><?php echo ($x+1)."&ordm;"; ?></td>
                <td bgcolor="white" align="center"><?php echo $dados_pesquisa['servico'];?></td>
                <td bgcolor="white" align="center">R$ <?php echo DecToMoeda($dados_pesquisa['arrecadacao']);?></td>
                <td bgcolor="white" align="center">R$ <?php echo DecToMoeda($dados_pesquisa['iss']);?></td>
                <td bgcolor="white" align="center">R$ <?php echo DecToMoeda($dados_pesquisa['issretido']);?></td>
                <td bgcolor="white" align="center"><?php echo $dados_pesquisa['qtdnotas'];?></td>
                

           </tr>
           <?php
                $x++;
            }//fim while
            ?>
        </table>
        </center>
    </body>
</html>