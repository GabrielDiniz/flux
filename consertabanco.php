<?php
    include(autoload);
    $sql = mysql_query("select * from municipios");
    while($result = mysql_fetch_array($sql)){
        $result['nome'] = utf8_decode($result['nome']);
        mysql_query("update municipios set nome='{$result['nome']}' where codigo='{$result['codigo']}'");
    }
?>
