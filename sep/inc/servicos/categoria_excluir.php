<?php
	include('../conect.php');
	
	$codcategoria = $_POST['txtCodCategoria'.$_POST['txtNum']];
	$sql = mysql_query("SELECT codigo FROM servicos WHERE codcategoria = '$codcategoria'");	
	if(mysql_num_rows($sql) > 0){
		echo "<script>alert('Antes de remover uma categoria deve-se remover todos os serviços da mesma');</script>";
	}else{
		mysql_query("DELETE FROM servicos_categorias WHERE codigo  = '$codcategoria'");
		echo "<script>alert('Categoria removida com sucesso!');</script>";
	}
?>
<form method="post" action="../../principal.php" id="frmVoltar">
	<input type="hidden" name="include" id="include" value="<?php echo $_POST['include']; ?>" />
</form>
<script>document.getElementById('frmVoltar').submit();</script>