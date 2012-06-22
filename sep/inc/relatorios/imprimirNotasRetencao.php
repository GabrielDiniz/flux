<?php
	if($mes){
		$where = "AND datahoraemissao LIKE '%-$mes-%'";
	}
	
	//Seleciona os dados do prestador e das notas que tiverem iss retido
	$query = ("
		SELECT
			cadastro.nome,
			cadastro.cpf,
			cadastro.cnpj,
			notas.numero,
			notas.datahoraemissao,
			notas.issretido,
			notas.basecalculo,
			notas.valortotal
		FROM 
			cadastro 
		INNER JOIN 
			notas 
		ON 
			cadastro.codigo = notas.codemissor
		WHERE notas.issretido > 0 $where
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
		<td>Prestador</td>
		<td width="150">CPF/CNPJ</td>
		<td width="70">N&uacute;mero</td>
		<td width="100">Data Emiss&atilde;o</td>
		<td width="80">ISS Retido</td>
		<td width="120">Base de C&aacute;lculo</td>
		<td width="120">L&iacute;quido</td>
	</tr>
	
<?php
while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
	$explode = explode(" ",$dados_pesquisa['datahoraemissao']);
	$separa = explode("-",$explode[0]);
?>
	<tr align="center">
		<td align="left"><?php echo $dados_pesquisa['nome'];?></td>
		<td><?php echo $dados_pesquisa['cnpj'];?></td>
		<td><?php echo $dados_pesquisa['numero'];?></td>
		<td><?php echo $separa[2]."/".$separa[1]."/".$separa[0]; ?></td>
		<td><?php echo 'R$ '.DecToMoeda($dados_pesquisa['issretido']);?></td>
		<td><?php echo 'R$ '.DecToMoeda($dados_pesquisa['basecalculo']);?></td>
		<td><?php echo 'R$ '.DecToMoeda($dados_pesquisa['valortotal']);?></td>
	</tr>
<?php
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
