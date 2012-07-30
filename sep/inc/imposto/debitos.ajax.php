<?php
    include("../../../funcoes/util.php");
    include("../../../include/conect.php");

    $ano        = $_GET['cmbAnoDebito'];
    $mes        = $_GET['cmbMesDebito'];
    $codEmissor = $_GET['cmbEmissorDebito'];
    $estado     = $_GET['cmbEstadoDebito'];

    if(empty ($ano) && empty ($mes) && empty ($codEmissor) && empty ($estado)){
        $where = "";
    }elseif (!empty($ano) && empty ($mes) && empty ($codEmissor) && empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao,'%Y') = '$ano'";
    }elseif(empty ($ano) && empty ($mes) && !empty ($codEmissor) && empty ($estado)){
        $where = "WHERE codemissor = '$codEmissor'";
    }elseif(empty ($ano) && empty ($mes) && empty ($codEmissor) && !empty ($estado)){
        switch($estado){
            case "P": $where = "WHERE notas.estado = 'E'"; break;
            case "A": $where = "WHERE notas.estado IN('N','B')"; break;
        }
    }elseif(!empty ($ano) && empty ($mes) && !empty ($codEmissor) && empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao,'%Y') = '$ano' AND codemissor = '$codEmissor'";
    }elseif(!empty ($ano) && empty ($mes) && empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao,'%Y') = '$ano' AND ";
        switch ($estado){
            case "P": $where .= "notas.estado = 'E'"; break;
            case "A": $where .= "notas.estado IN ('N','B')"; break;
        }
    }elseif(empty ($ano) && empty ($mes) && !empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE codemissor = '$codEmissor' AND ";
        switch ($estado){
            case "P": $where .= "notas.estado = 'E'"; break;
            case "A": $where .= "notas.estado IN ('N','B')"; break;
        }
    }elseif(!empty ($ano) && empty ($mes) && !empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE codemissor = '$codEmissor' ";
        $where .= " AND DATE_FORMAT(datahoraemissao,'%Y') = '$ano' ";
        switch ($estado){
            case "P": $where .= "AND notas.estado = 'E'"; break;
            case "A": $where .= "AND notas.estado IN ('N','B')"; break;
        }
    }elseif(empty ($ano) && !empty ($mes) && empty ($codEmissor) && empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%m') = '$mes'";
    }elseif(!empty ($ano) && !empty ($mes) && empty ($codEmissor) && empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%Y/%m') = '$ano/$mes'";
    }elseif(empty ($ano) && !empty ($mes) && !empty ($codEmissor) && empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%m') = '$mes' AND codemissor = $codEmissor";
    }elseif(empty ($ano) && !empty ($mes) && empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%m') = '$mes' AND ";
        switch ($estado){
            case "P": $where .= "notas.estado = 'E'"; break;
            case "A": $where .= "notas.estado IN ('B','N')"; break;
        }
    }elseif(empty ($ano) && !empty ($mes) && !empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%m') = '$mes' AND codemissor = $codEmissor";
        switch ($estado){
            case "P": $where .= " AND notas.estado = 'E'"; break;
            case "A": $where .= " AND notas.estado IN ('B','N')"; break;
        }
    }elseif(!empty ($ano) && !empty ($mes) && !empty ($codEmissor) && empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%Y/%m') = '$ano/$mes' AND codemissor = '$codEmissor'";
    }elseif(!empty($ano) && !empty ($mes) && empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%Y/%m') = '$ano/$mes'";
        switch ($estado){
            case "P": $where .= " AND notas.estado = 'E'"; break;
            case "A": $where .= " AND notas.estado IN ('B','N')"; break;
        }
    }elseif(!empty ($ano) && !empty ($mes) && !empty ($codEmissor) && !empty ($estado)){
        $where = "WHERE DATE_FORMAT(datahoraemissao, '%Y/%m') = '$ano/$mes' AND codemissor = '$codEmissor'";
        switch ($estado){
            case "P": $where .= " AND notas.estado = 'E'"; break;
            case "A": $where .= " AND notas.estado IN ('B','N')"; break;
        }
    }

    $where = (empty($where))
    ? $where = "WHERE cadastro.nfe='S' AND cadastro.estado='A' AND notas.estado<>'C'"
    : $where .= " AND cadastro.nfe='S' AND cadastro.estado='A' AND notas.estado<>'C'";
    $query = "
        SELECT SUM(notas.valoriss) AS valor,
        notas.estado,
        DATE_FORMAT(notas.datahoraemissao, '%Y/%m') AS competencia,
        cadastro.razaosocial AS emissor
        FROM notas
        INNER JOIN cadastro
        ON cadastro.codigo = notas.codemissor
    ";
    $query .= $where;
    $query .= " GROUP BY cadastro.razaosocial,competencia ORDER BY competencia DESC";
    
    if(mysql_num_rows(mysql_query($query)) == 0){
        echo "<center><b>Nenhum débito encontrado</b></center>";
    }else{
   
        $resultado = Paginacao($query,'formDebitos','divRetorno',15);
        ?>
        <table cellspacing="0" width="100%" style="border:1px solid #000000;">
            <tr>
                <td  align="center"
                style="border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    Emissor
                </td>
                <td  align="center"
                style="border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    Competência
                </td>
                <td  align="center"
                style="border-right:1px solid #000000; border-bottom:1px solid #000000;">
                    Débito
                </td>
                <td  align="center" style=" border-bottom:1px solid #000000;">
                    Estado
                </td>
            </tr>
        <?php
        while($debitos = mysql_fetch_object($resultado)){
            $debitos->estado = ($debitos->estado == 'E') ? $debitos->estado = "Pago" : $debitos->estado = "Aberto";
            ?>
            <tr>
                <td bgcolor="#FFFFFF" style="border-right:1px solid #000000;
                 border-bottom:1px solid #000000;"><?php echo $debitos->emissor; ?></td>
                <td bgcolor="#FFFFFF" style="border-right:1px solid #000000;
                 border-bottom:1px solid #000000;"><?php echo $debitos->competencia; ?></td>
                <td bgcolor="#FFFFFF" style="border-right:1px solid #000000;
                 border-bottom:1px solid #000000;">
                 R$ <?php echo DecToMoeda($debitos->valor); ?>
                </td>
                <td bgcolor="#FFFFFF" style=" border-bottom:1px solid #000000;"><?php echo $debitos->estado; ?></td>
            </tr>
            <?php
        }
        ?>
        </table>
        <input type="hidden" name="hdQuery" id="hdQuery" value="<?php echo $query; ?>" />
        <?php
    }
?>