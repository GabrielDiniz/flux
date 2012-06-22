<!-- Início da Tabela -->
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
      <tr style="background-color:#999999; font-weight:bold" align="center">
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
                <tr style=\"background-color:#999999; font-weight:bold\" align=\"center\">
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
        }
    ?>
</table>
<!-- Fim da Tabela -->