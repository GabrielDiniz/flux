<?php
    require_once("../conect.php");
    require_once("../../funcoes/util.php");
?>
<title>Imprimir</title>
<link href="../../css/padrao.css" rel="stylesheet" type="text/css">
<title>Imprimir</title><input name="btImprimir" id="btImprimir" type="button" class="botao" value="Imprimir" 
 onClick="document.getElementById('btImprimir').style.display = 'none';print();document.getElementById('btImprimir').style.display = 'block';">
<br /><br />
<table width="800" align="center" border="0" cellspacing="0" cellpadding="2" style="border:1px solid #000000;">
  <tr>
    <td rowspan="4" width="20%" align="center" valign="top">
		<?php if($CONF_BRASAO){ ?><img src="../../img/brasoes/<?php echo rawurlencode($CONF_BRASAO);?>" width="100" height="100" /><?php }?>
		<br />
	</td>
    <td width="80%" class="cab01"><?php print "Prefeitura Municipal de ".strtoupper($CONF_CIDADE); ?></td>
  </tr>
  <tr>
    <td class="cab03"><?php print strtoupper($CONF_SECRETARIA); ?></td>
  </tr>
  <tr>
    <td class="cab02">NOTA FISCAL ELETRÔNICA DE SERVIÇOS - e-NOTA</td>
  </tr>
  <?php if($rps_numero){ ?>
  <tr>
    <td>RPS N&ordm; <?php print $rps_numero; ?>, emitido em <?php print (substr($rps_data,8,2)."/".substr($rps_data,5,2)."/".substr($rps_data,0,4)); ?>.</td>
  </tr>
  <?php }// fim if se tem rps ?>
</table>
<br /><br />
<?php 
    $query = $_POST['hdQuery'];

    if(empty ($query)){
        echo "<center><b>Nenhum débito a ser impresso</b></center>";
    }else{
        ?>
        <table width="800" align="center" border="0" cellspacing="0" style="border:1px solid #000000;">
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
        $sql = mysql_query($query);
        while($debitos = mysql_fetch_object($sql)){
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
        ?></table><?php
    }
?>