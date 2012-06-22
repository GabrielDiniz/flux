<?php
//notas sem livros
$query = ("SELECT * FROM notas WHERE codigo NOT IN(SELECT codnota FROM livro_notas) AND estado <> 'C' ORDER BY datahoraemissao");
$sql_pesquisa = mysql_query ($query);
$result = mysql_num_rows($sql_pesquisa);
if($result){
?>

<!-- Início da Tabela -->
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999">
	<?php
        if($result <= 1){
            echo "<center><b>Foi encontrado $result  Resultado</b></center>";
        }else{
            echo "<center><b>Foram encontrados $result  Resultados</b></center>";
        }
    ?>
	</tr>
	
	<tr style="background-color:#999999; font-weight:bold" align="center">
		<td>Contribuinte</td>
		<td>CPF/CNPJ</td>
		<td>Data emiss&atilde;o</td>
        <td>C&oacute;d. Nota</td>
        <td>ISS Retido</td>
        <td>Base de C&aacute;lculo</td>
        <td>Valor Total</td>
	</tr>
	<?php
        while ($dados = mysql_fetch_array($sql_pesquisa)){
			$explode = explode(" ", $dados['datahoraemissao']);
			$data = $explode[0];
            $codemissor = $dados['codemissor'];
            $pesquisa_emissor = ("SELECT nome, cpf, cnpj FROM cadastro WHERE codigo = '$codemissor'");
            $resultado_emissor = mysql_query($pesquisa_emissor);
            $emissor = mysql_num_rows($resultado_emissor);
            while($dados_emissor = mysql_fetch_array($resultado_emissor)){
				if($dados_emissor['cpf'] == ''){
					$cpfcnpj = $dados_emissor['cnpj'];
				}else{
					$cpfcnpj = $dados_emissor['cpf'];
				}
    ?>
	<tr>
    	<td bgcolor="white"  align="left"><font size="1"><?php echo $dados_emissor['nome']; ?></font></td>
		<td bgcolor="white"  align="center"><font size="1"><?php echo $cpfcnpj; ?></font></td>
		<td bgcolor="white" align="center"><font size="1"><?php echo DataPt($data); ?></font></td>
        <td bgcolor="white"  align="center"><font size="1"><?php echo $dados['codigo']; ?></font></td>
        <td bgcolor="white"  align="center"><font size="1"><?php echo "R$ ".DecToMoeda($dados['issretido']); ?></font></td>
        <td bgcolor="white"  align="center"><font size="1"><?php echo "R$ ".DecToMoeda($dados['basecalculo']); ?></font></td>
        <td bgcolor="white"  align="center"><font size="1"><?php echo "R$ ".DecToMoeda($dados['valortotal']); ?></font></td>
	</tr>
<?php
		}
	}// fim while ($dados = mysql_fetch_array($sql_pesquisa))
?>
</table>
<!-- Fim da Tabela -->
		<?php
}else{ 
		?>
<table width="95%" class="tabela" border="1" cellspacing="0" style="page-break-after: always" align="center">
	<tr style="background-color:#999999;font-weight:bold;" align="center">
		<td>N&atilde;o h&aacute; resultados!</td>
	</tr>
</table>
<?php 
}
?>
