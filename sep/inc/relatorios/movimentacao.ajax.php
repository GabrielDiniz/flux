<?php
include "../conect.php";

$cont= $_GET['hdContador'];
$codcategoria= explode("|", $_GET['cmbCategoria'.$cont]);

$result="SELECT codigo, codservico, descricao
FROM servicos
WHERE
codcategoria = ".$codcategoria[0];
?>

<select id="cmbServicos<?php echo $cont;?>" name="cmbServicos<?php echo $cont;?>" style="width:150px" >
	<option value="">Escolha o Serviço </option>
     <?php
		$respo=mysql_query($result);
		while($dados=mysql_fetch_array($respo)){
			echo "<option value='".$dados['codigo']."'>".$dados['descricao']."</option>";
		}
	?>
</select>
