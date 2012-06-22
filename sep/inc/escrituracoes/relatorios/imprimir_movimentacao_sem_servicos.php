<?php

if ($datahoraemissao =="-")
{
	$datahoraemissao="";
}

/*$query = ("SELECT codigo FROM notas_servicos");

			
$sql_pesquisa = mysql_query($query);
$result = mysql_num_rows($sql_pesquisa);*/
?>
<table width="700px" class="tabela">
	<tr style="background-color:#999999">
    <?php echo "<b>Foram encontrados $result  Resultados</b>"; ?>
      <td width="40%" align="center"><strong>Serviço</strong></td>
      <td width="25%" align="center"><strong>Movimentação Financeira</strong></td>
      <td width="15%" align="center"><strong>ISS</strong></td>
      <td width="20%" align="center"><strong>ISS Retido</strong></td>

</tr>
<?php	
	
	
if(mysql_num_rows($sql_pesquisa)){
while(list($codServ)=mysql_fetch_array($sql_pesquisa)){
	$query_serv=mysql_query("
        SELECT
            SUM(notas_servicos.basecalculo) as movimentacao,
            SUM(notas_servicos.issretido) as issretido,
            SUM(notas_servicos.iss) as iss
        FROM
            notas_servicos
        INNER JOIN
            notas ON notas.codigo = notas_servicos.codnota
        WHERE
            notas.datahoraemissao like '$datahoraemissao%'
        AND
            codservico = $codServ
        AND
            notas.estado <> 'C'
	");
				
?>
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
		while(list($movimentacao, $issretido, $iss, $codigo) = mysql_fetch_array($query_serv)){
		//print_array($dados_pesquisa);

			$nomeServico="
					SELECT 
						descricao 
					FROM 
						servicos
					WHERE codigo = '$codServ'
					";
			$varnome=mysql_query($nomeServico);
					
		if (mysql_num_rows($varnome)>0)
		{
			
			$resposta=mysql_fetch_array($varnome);
			$resposta['resumo']=substr($resposta['descricao'], 0, 40);

	if ($movimentacao=="")
	{
		$movimentacao='0.00';
	}
	
	if ($issretido=="")
	{
		$issretido='0.00';
	}
	
	if ($iss=="")
	{
		$iss='0.00';
	}


 ?>
<input type="hidden" name="txtCodigoGuia<?php echo $x;?>" id="txtCodigoGuia<?php echo $x;?>" value="<?php echo $dados_pesquisa['tipo'];?>" />

    <tr id="trDecc<?php echo $x;?>">
        <td bgcolor="white"  align="center" title="<?php echo $resposta['descricao'];?>"><?php echo $resposta['resumo'];?>...</td>
        <td bgcolor="white"  align="center">R$ <?php echo $movimentacao;?></td>
     	<td bgcolor="white" align="center">R$ <?php echo $issretido;?></td>
        <td bgcolor="white"  align="center">R$ <?php echo $iss;?></td>

  </tr>
      
 
  <?php
			$x++;
		}//fim while
	}
}
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
