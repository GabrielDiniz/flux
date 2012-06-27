 <br/>
<?php
	include("../../../include/conect.php"); 
	include("../../../funcoes/util.php");
	
	$cnpj = $_GET['cnpj'];
	$ano  = $_GET['cmbAno'];
	$mes  = $_GET['cmbMes'];
	
    $sql = mysql_query("
        SELECT 
            cadastro.cpf,
            cadastro.cnpj,
			notas.codigo,
            notas.numero,
            notas.valortotal,
            notas.issretido,
			notas.codemissor,
			notas.estado
        FROM
            notas
        INNER JOIN
            cadastro ON cadastro.codigo = notas.codemissor
        WHERE
            notas.tomador_cnpjcpf = '$cnpj' AND 
			notas.issretido > 0 AND 
			notas.estado != 'E' AND
			MONTH(notas.datahoraemissao) = '$mes' AND 
			YEAR(notas.datahoraemissao) = '$ano'
    ");
    if(mysql_num_rows($sql)){
 ?>
<table width="100%" border="0" cellspacing="1">
	<tr bgcolor="#999999">
		<td colspan="5" align="center" > Dados dos Emissores: </td>
	</tr>
	<tr bgcolor="#999999">
		<td align="center"> Cnpj/Cpf </td>
		<td align="center"> Número Nota </td>
		<td align="center"> Valor Nota </td>
		<td align="center"> ISS Retido </td>
		<td></td>
	</tr>
	<?php
    while(list($cad_cpf,$cad_cnpj,$codigo,$numero,$valortotal,$issretido,$codemissor,$estadonota) = mysql_fetch_array($sql)){
        $cad_cnpjcpf = $cad_cpf.$cad_cnpj;
		
		$bgcolor = "bgcolor=\"#FFFFFF\"";

		if(($estadonota == "E") || ($estadonota == "C")){
			$bgcolor = "bgcolor=\"#FFAC84\"";
			$display = "style=\"display:none\"";
		}else{
			$bgcolor = "bgcolor=\"#FFFFFF\"";
			$display = "";
		}
		
		
		
    ?>
	<tr <?php echo $bgcolor;?>>
		<td align="center"><?php echo $cad_cnpjcpf;?></td>
		<td align="center"><?php echo $numero;?></td>
		<td align="center"><?php echo DecToMoeda($valortotal);?></td>
		<td align="center"><?php echo DecToMoeda($issretido);?></td>
		<td align="center"><input name="btGerarGuia" type="submit" value="Guia" class="botao" onclick="document.getElementById('hdCodigoGuia').value='<?php echo $codigo;?>'" <?php echo $display;?> /></td>
	</tr>
	<?php
    }
  ?>
  <input name="hdCodigoGuia" id="hdCodigoGuia" type="hidden" />
</table>
<?php
    }else{
        echo "<center><b>N&atilde;o h&aacute; declara&ccedil;&otilde;es de servi&ccedil;os tomados!</b></center>";
    }
  ?>
</br>
</br>
