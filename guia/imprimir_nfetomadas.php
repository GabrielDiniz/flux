<?php
// busca Guia
$sql_topo = mysql_query("
		    SELECT
  				 cadastro.razaosocial, 
				 cadastro.cnpj, 
				 cadastro.cpf,
  				 cadastro.inscrmunicipal, 
				 cadastro.logo,
				 livro.periodo,
			     livro.obs, 
				 DATE_FORMAT(livro.geracao, '%d/%m/%Y') as geracao
				 FROM cadastro			 
				 INNER JOIN livro ON livro.codcadastro = cadastro.codigo
				 WHERE livro.codigo = $livro"); 

$topo = mysql_fetch_object($sql_topo);

$sql_notas = mysql_query("
			 SELECT
				 DATE_FORMAT(`notas`.`datahoraemissao`, '%d/%m/%Y') as datahoraemissao, 
				`notas`.`numero`, `notas`.`estado`, `notas`.`codemissor` AS codprestador, `cadastro`.`razaosocial`, `cadastro`.`cnpj`,
				`cadastro`.`cpf`, `cadastro`.`inscrmunicipal`, `servicos`.`descricao`, `notas`.`valortotal` AS total,
				`notas`.`valoriss` AS iss, `notas`.`issretido`, `livro_notas`.`tipo`
				 FROM			 
				`cadastro` 
			
			
			INNER JOIN
  				`livro` ON `cadastro`.`codigo` = `livro`.`codcadastro`
				
			INNER JOIN
  				`livro_notas` ON `livro`.`codigo` = `livro_notas`.`codlivro` 	
			
			INNER JOIN
  				`notas` ON `notas`.`codigo` = `livro_notas`.`codnota` 
				
			INNER JOIN 
	 		 	notas_servicos ON notas.codigo = notas_servicos.codnota	
				
			INNER JOIN
  				`servicos` ON `servicos`.`codigo` = `notas_servicos`.`codservico`
				
			WHERE
  			`livro`.`codigo` = $livro AND
  			`livro_notas`.`tipo` = 'T' 
			
			
			 ");		



			


?>

<style type="text/css">

#divPrincipalTomadas {
		margin-bottom:100px;
	
}
</style>

<div id="divPrincipalTomadas" >
	<div id="divCabecalhoTomadas">
<table border="0" cellpadding="5" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td width="150" rowspan="4" align="center">
		<?php if(!$topo->logo){echo 'sem imagem';} else{echo "<img src=../img/logos/".$CONF_TOPO." width=\"100\" height=\"100\">";}; ?>
	</td>
    <td width="800" colspan="4" align="center" class="titulo1">REGISTRO E APURA&Ccedil;&Atilde;O DO ISS </td>
    <td width="150" rowspan="4" align="center">
		<?php if($CONF_BRASAO ==NULL) {echo 'sem imagem';} else {echo "<img src=../img/brasoes/".rawurlencode($CONF_BRASAO)." width=\"100\" height=\"100\">";} ?>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="150" class="field1">Contribuinte:</td>
    <td colspan="3" class="field1"><?php echo $topo->razaosocial; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">CNPJ/CPF:</td>
    <td width="250"><?php echo $topo->cnpj; ?>&nbsp;</td>
    <td width="150" class="field1">Per&iacute;odo:</td>
    <td width="250"><?php
			$periodof = substr($topo->periodo,5,2); 
			$periodof = $periodof."/".substr($topo->periodo,0,4);
			echo $periodof; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">Inscr. Municipal: </td>
    <td colspan="3" class="field1"><?php echo $topo->inscrmunicipal; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">Observa&ccedil;&otilde;es:</td>
    <td colspan="5"><?php echo $topo->obs; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">Data da Gera&ccedil;&atilde;o: </td>
    <td colspan="5"><?php echo $topo->geracao; ?>&nbsp;</td>
    </tr>
</table>
	
	
	
	</div>
	<?php
    if(mysql_num_rows($sql_notas)>0){
    ?>    
	<div id="divIssTomadas">
<table width="1100" border="0" cellpadding="5" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td colspan="11" align="center" class="titulo1">NOTAS FISCAIS ELETR&Ocirc;NICAS TOMADAS </td>
    </tr>
  <tr>
    <td colspan="3"  width="30%" align="center" class="field2">NFEletr&ocirc;nica</td>
    <td colspan="3" width="20%" align="center" class="field2">Prestador Emissor </td>
    <td colspan="5" align="center" class="field2">Servi&ccedil;os</td>
    </tr>
  <tr align="center">
    <td width="4%">Data</td>
    <td width="6%">N&uacute;mero</td>
    <td width="8%">Canc.</td>
    <td width="7%">CNPJ/CPF</td>
    <td width="15%">Inscr. Municipal </td>
    <td width="15%">Nome</td>
    <td width="20%" colspan="2">Atividade Operacional </td>
    <td>Valor Servi&ccedil;os </td>
    <td width="15%">ISS Pr&oacute;prio </td>
    <td width="10%">ISS Retido </td>
  </tr>
<?php 
	while($notas = mysql_fetch_object($sql_notas)) { 
		$sql_infos_prestador = mysql_query("
			SELECT 
				razaosocial, 
				cnpj, 
				cpf, 
				inscrmunicipal
			FROM
				cadastro
			WHERE 
				codigo = '{$notas->codprestador}'
		");
		$notas_prestador = mysql_fetch_object($sql_infos_prestador);
?>
  <tr>
    <td align="center" class="field3"><?php echo $notas->datahoraemissao; ?> </td>   
    <td align="center" class="field3"><?php echo $notas->numero; ?> </td>
    <td align="center" class="field3"><?php if($notas->estado == N){echo 'Normal';}
										elseif($notas->estado=='E') {echo 'Escriturada';}
										elseif($notas->estado == 'B' ){echo 'Boleto';} 
										elseif($notas->estado=='C'){echo 'Cancelada';} 
										else{echo 'Erro';} ;?> </td>
    <td align="center" class="field3"><?php echo $notas_prestador->cnpj; ?></td>
    <td align="center" class="field3"><?php echo $notas_prestador->inscrmunicipal; ?> &nbsp;</td>
    <td align="center" class="field3"><?php echo $notas_prestador->razaosocial; ?> </td>
    <td colspan="2" align="center" class="field3"><?php echo $notas->descricao; ?> </td>
    <td align="center" class="field3"><?php echo $notas->total; ?></td>
    <td align="center" class="field3"><?php echo $notas->iss; ?></td>
	<td align="center" class="field3"><?php echo $notas->issretido; ?></td>   
</tr>
 
<?php } // fecha while 

$sql_totais = mysql_query("
SELECT
 `livro`.`codigo`, 
  Sum(`notas_tomadas`.`total`) as basecalculo,
  Sum(`notas_tomadas`.`iss`) as valoriss,
  Sum(`notas_tomadas`.`issretido`) as issretido
FROM
  `notas_tomadas` INNER JOIN
  `livro_notas` ON `notas_tomadas`.`codigo` = `livro_notas`.`codnota` INNER JOIN
  `livro` ON `livro_notas`.`codlivro` = `livro`.`codigo`
WHERE
  `livro`.`codigo` = '$livro' AND
  `livro_notas`.`tipo` = 'T'
			  ");
			 	
		 
$totais= mysql_fetch_object($sql_totais); 


?> 
  
  <tr>
    <td colspan="8" align="right" class="field4"><strong>Total Geral</strong></td>
	<td width="20%" align="center" class="field4"><?php echo $totais->basecalculo; ?>&nbsp;</td>
	<td class="field4" align="center"><?php echo $totais->valoriss;?>&nbsp;</td>
	<td class="field4" align="center"><?php echo $totais->issretido; ?>&nbsp;</td>
  </tr>
</table>
	
  </div>
<?php
}else{
	echo "<div id=\"divIssTomadas\"><table style=\"margin:0 auto;\" width=\"1100\" border=\"0\" cellpadding=\"5\" cellspacing=\"0\"><tr><td colspan=\"12\" align=\"center\" class=\"titulo1\">NENHUMA NOTA FISCAL ELETR&Ocirc;NICA TOMADA </td></tr></table></div>";	
}
?>

</div>


