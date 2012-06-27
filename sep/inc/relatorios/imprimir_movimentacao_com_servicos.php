<?php
if ($datahoraemissao =="-")
{
	$datahoraemissao="";
}

$query = ("
			SELECT SUM(notas_servicos.basecalculo) as movimentacao, 
				SUM(notas_servicos.issretido) as issretido, 
				SUM(notas_servicos.iss) as iss 
			FROM notas_servicos 
			INNER JOIN 
				notas on notas.codigo = notas_servicos.codnota
					
			WHERE 
				notas.datahoraemissao like '$datahoraemissao%'
				AND codservico = $codServ
                AND notas.estado <> 'C'
			");
			
$sql_pesquisa = mysql_query($query);
	$result = mysql_num_rows($sql_pesquisa);
	
	
	
if(mysql_num_rows($sql_pesquisa)){
?>


<table width="700px" class="tabela">
	<tr style="background-color:#999999">
    <?php
	if ($result = 1)
	{
		echo "<b>Foi encontrado $result  Resultado</b>";
	}
	else
	{
		echo "<b>Foram encontrados $result  Resultados</b>";
	} ?>
      <td width="40%" align="center"><strong>Serviço</strong></td>
      <td width="25%" align="center"><strong>Movimentação Financeira</strong></td>
      <td width="15%" align="center"><strong>ISS</strong></td>
      <td width="20%" align="center"><strong>ISS Retido</strong></td>

  </tr>
  <?php
  		
		$x = 0;
		$tipos_extenso = array(
			"prestador"              => "Prestador",
			"empreiteira"            => "Empreiteira",
			"instituicao_financeira" => "Instituição Financeira",
			"cartorio"               => "Cartório",
			"operadora_credito"      => "Operadora de Crédito",
			"grafica"                => "Gráfica",
			"contador"               => "Contador",
			"tomador"                => "Tomador",
			"orgao_publico"          => "Orgão Público",
			"simples"                => "Simples"
		);
		while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
			$declaracoes = $dados_pesquisa['declaracao'];
		//print_array($dados_pesquisa);

			$nomeServico="
					SELECT 
						descricao
					FROM 
						servicos
					WHERE
						codigo = $codServ
					";
			$varnome=mysql_query($nomeServico);
			$resposta=mysql_fetch_array($varnome);
			$resposta['resumo']=substr($resposta['descricao'], 0, 40);

	if ($dados_pesquisa['movimentacao']=="")
	{
		$dados_pesquisa['movimentacao']='0.00';
	}
	
	if ($dados_pesquisa['issretido']=="")
	{
		$dados_pesquisa['issretido']='0.00';
	}
	
	if ($dados_pesquisa['iss']=="")
	{
		$dados_pesquisa['iss']='0.00';
	}


 ?>
<input type="hidden" name="txtCodigoGuia<?php echo $x;?>" id="txtCodigoGuia<?php echo $x;?>" value="<?php echo $dados_pesquisa['tipo'];?>" />

    <tr id="trDecc<?php echo $x;?>">
        <td bgcolor="white"  align="center" title="<?php echo $resposta['descricao'];?>"><?php echo $resposta['resumo'];?>...</td>
        <td bgcolor="white"  align="center">R$ <?php echo $dados_pesquisa['movimentacao'];?></td>
     	<td bgcolor="white" align="center">R$ <?php echo $dados_pesquisa['issretido'];?></td>
        <td bgcolor="white"  align="center">R$ <?php echo $dados_pesquisa['iss'];?></td>

  </tr>
      
 
  <?php
			$x++;
		}//fim while
	?>
</table>

<table width="700px" class="tabela">
<?php
}else{
 //caso não encontre resultados, a mensagem 'Não há resultados!' será mostrada na tela
	echo "<tr style=\"background-color:#999999\"><td colspan=\"3\"><center><b><font class=\"fonte\">Não há resultados!</font></center></td></b></tr>";
}
?>
</table>

