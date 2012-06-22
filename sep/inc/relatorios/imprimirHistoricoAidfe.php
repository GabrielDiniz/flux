<?php
	$query = ("
		SELECT
			*
		FROM 
			cadastro
		WHERE 
			notalimite <> '0'
	");
	$sql_pesquisa = mysql_query ($query);
	$result = mysql_num_rows($sql_pesquisa); //Pega quantos resultados voltaram
	if($result){ //Se existir algum registro, mostra na tabela
?>


<!-- Início da Tabela -->
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999">
		<?php
			if($result == 1)
				echo "<center><b>Foi encontrado $result  Resultado</b></center>";
			else
				echo "<center><b>Foram encontrados $result  Resultados</b></center>";
		?>
	</tr>
		
	<tr style="background-color:#999999; font-weight:bold" align="center">
		<td>Solicitante</td>
		<td>CPF/CNPJ</td>
		<td>Notas emitidas</td>
		<td>Nota Limite</td>
		<td>Solicita&ccedil;&atilde;o</td>
	</tr>
	
<?php
while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
	if($dados_pesquisa['cpf'] == ''){
		$cpfcnpj = $dados_pesquisa['cnpj'];
	}else{
		$cpfcnpj = $dados_pesquisa['cpf'];
	}

	$codsolicitante = $dados_pesquisa['codigo'];
	$pesquisa = ("SELECT * FROM aidfe_solicitacoes WHERE solicitante = '$codsolicitante'");
	$resultado = mysql_query($pesquisa);
	$solicitante = mysql_num_rows($resultado);
	//while($dados_solicitante = mysql_fetch_array($resultado)){
?>
	<tr align="center">
		<td align="left"><?php echo $dados_pesquisa['nome'];?></td>
		<td><?php echo $cpfcnpj;?></td>
		<td><?php echo $dados_pesquisa['ultimanota'];?></td>
		<td><?php echo $dados_pesquisa['notalimite'];?></td>
        <?php
        	if($solicitante){
				$solic = "Solicita&ccedil;&atilde;o Pendente";
			}else{
				$solic = "Nenhuma solicita&ccedil;&atilde;o pendente";
			}
		?>
		<td><?php echo $solic; ?></td>
	</tr>
<?php
	//}
}//Fim do while($dados_pesquisa = mysql_fetch_array($sql_pesquisa))
?>
</table>
<!-- Fim da Tabela -->


<?php
}else{ //Se if(mysql_num_rows($sql_pesquisa)) der falso
?>
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999;font-weight:bold;" align="center">
		<td>N&atilde;o h&aacute; resultados!</td>
	</tr>
</table>
<?php
}
?>
