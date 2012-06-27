<?php
	if($mes){
		$where = "AND datahoraemissao LIKE '%-$mes-%'";
	}
	$query = ("
		SELECT
			*
		FROM 
			notas
		WHERE 
			estado = 'C'
			$where
		ORDER BY 
			datahoraemissao
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
		<td>Emissor</td>
		<td>CPF/CNPJ</td>
		<td>Tomador</td>
		<td>CPF/CNPJ</td>
		<td>Total</td>
        <td>Motivo Cancelamento</td>
	</tr>
	
<?php
while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
	$codemissor = $dados_pesquisa['codemissor'];
	$pesquisa = ("SELECT nome, cpf, cnpj FROM cadastro WHERE codigo = '$codemissor'");
	$resultado = mysql_query($pesquisa);
	$emissor = mysql_num_rows($resultado);
	while($dados_emissor = mysql_fetch_array($resultado)){
		if($dados_emissor['cpf'] == ''){
			$cpfcnpj = $dados_emissor['cnpj'];
		}else{
			$cpfcnpj = $dados_emissor['cpf'];
		}
?>
	<tr align="center">
		<td align="left"><?php echo $dados_emissor['nome'];?></td>
		<td><?php echo $cpfcnpj;?></td>
		<td><?php echo $dados_pesquisa['tomador_nome'];?></td>
		<td><?php echo $dados_pesquisa['tomador_cnpjcpf'];?></td>
		<td><?php echo "R$ ".DecToMoeda($dados_pesquisa['valortotal']);?></td>
        <td><?php echo $dados_pesquisa['motivo_cancelamento'];?></td>
	</tr>
<?php
	}
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
