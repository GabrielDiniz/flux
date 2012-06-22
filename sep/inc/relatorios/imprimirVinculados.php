  
<?php
$query =("SELECT * FROM cadastro WHERE codtipo = '$codigo'");
$sql_pesquisa = mysql_query ($query);
$result = mysql_num_rows($sql_pesquisa);
$verifica='n'; //Se não entrar em if($result2), continua valendo n
if($result){
	while ($dados = mysql_fetch_array($sql_pesquisa)){
		$codcontador = $dados['codigo'];
		$query2 =("SELECT * FROM cadastro WHERE codcontador = '$codcontador'");
		$sql_pesquisa2 = mysql_query ($query2);
		$result2 = mysql_num_rows($sql_pesquisa2); //Pega quantos resultados voltaram
		
		if($result2){ //Se existir algum registro, mostra na tabela
			$verifica='s';
?>

<!-- Início da Tabela -->
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999">
		<?php
			if($result2 <= 1){
				echo "<center><b>Foi encontrado $result2  Resultado</b></center>";
			}else{
				echo "<center><b>Foram encontrados $result2  Resultados</b></center>";
			}
		?>
	</tr>
	
	<tr style="background-color:#999999; font-weight:bold" align="center">
		<td width="33%">Contador</td>
		<td width="33%">Nome</td>
		<td width="33%">CPF/CNPJ</td>
	</tr>
		<?php
			while ($dadoscont = mysql_fetch_array($sql_pesquisa2)){
				if($dadoscont['cpf'] == ''){
					$cpfcnpj = $dadoscont['cnpj'];
				}else{
					$cpfcnpj = $dadoscont['cpf'];
				}
		?>
	<tr>
    	<td bgcolor="white"  align="left"><font size="1"><?php echo $dados['nome']; ?></font></td>
		<td bgcolor="white"  align="left"><font size="1"><?php echo $dadoscont['nome']; ?></font></td>
		<td bgcolor="white" align="center"><font size="1"><?php echo $cpfcnpj; ?></font></td>
	</tr>
		<?php
			}// Fim while ($dadoscont = mysql_fetch_array($sql_pesquisa2))
		?>
</table>
<!-- Fim da Tabela -->
		<?php
		}// Fim if(mysql_num_rows($sql_pesquisa2))
	}// fim while ($dados = mysql_fetch_array($sql_pesquisa))
}// Fim if($result)
if($verifica=='n'){ //Se ainda vale n é pq n entrou resultado nenhum
		?>
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999;font-weight:bold;" align="center">
		<td>N&atilde;o h&aacute; resultados!</td>
	</tr>
</table>
<?php 
}
?>