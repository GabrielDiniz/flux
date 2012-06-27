<!-- Início da Tabela -->
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
    <tr style="background-color:#999999; font-weight:bold" align="center">
        <td width="50%" align="center">Descri&ccedil;&atilde;o</td>
        <td width="12%" align="center">Base de C&aacute;lculo</td>
        <td width="10%" align="center">Al&iacute;quota</td>
        <td width="10%" align="center">Al&iacute;quota Ret.</td>
        <td width="10%" align="center">Cod. Servi&ccedil;o</td>
        <td width="8%" align="center">Estado</td>
    </tr>
  <?php  //comando sql que mostrará as categorias e os serviços 
					
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
        GROUP BY
            servicos.descricao
        ORDER BY
            servicos.descricao
    ");
        while($servico = mysql_fetch_object($sql_serv)){

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
            <td width="50%" align="left" title="<?php echo $servico->descricao; ?>"><?php echo $desc; ?></td>
            <td width="12%" align="center"><?php echo DecToMoeda($servico->basecalculo); ?></td>
            <td width="10%" align="center"><?php echo DecToMoeda($servico->aliquota); ?>%</td>
            <td width="10%" align="center"><?php echo DecToMoeda($servico->aliquotair); ?>%</td>
            <td width="10%" align="center"><?php echo $servico->codservico; ?></td>
            <td width="8%" align="center"><?php echo $servico->estado; ?></td>
        </tr>
    <?php
        
	}			

?>

  </table>
<!-- Fim da Tabela -->