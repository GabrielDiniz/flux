<?php
    include(autoload);
    $sql = mysql_query("select * from menus_cadastro");
    while($result = mysql_fetch_array($sql)){
        $result['menu'] = utf8_decode($result['menu']);
        mysql_query("update menus_cadastro set menu='{$result['menu']}' where codigo='{$result['codigo']}'");
    }
?>
