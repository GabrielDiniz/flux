<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	require_once("../nocache.php");
	
	$dataInicial = $_GET['txtDataInicial'];
	$dataFinal   = $_GET['txtDataFinal'];
	$dataInicialMysql = DataMysql($dataInicial);
	$dataFinalMysql   = DataMysql($dataFinal);
	$tipo = $_GET['hdTipo'];
	
?>
<fieldset>
<?php
	switch($tipo){
		case 1:
			$query = ("
				SELECT 
					notas.codigo, 
					notas.codemissor, 
					DATE(notas.datahoraemissao), 
					COUNT(notas.numero), 
					SUM(notas.valortotal)
				FROM
					notas
				INNER JOIN
					cadastro ON notas.codemissor = cadastro.codigo
				LEFT JOIN
					notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
				WHERE
					notas_tomadas.numero IS NULL AND DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
				GROUP BY 
					notas.codemissor
				ORDER BY
					DATE(notas.datahoraemissao)
				DESC
			");
		  break;
		case 2:
			$query = ("
				SELECT 
					notas_tomadas.codigo, 
					notas_tomadas.codtomador, 
					notas_tomadas.data, 
					COUNT(notas_tomadas.numero), 
					SUM(notas_tomadas.total)
				FROM 
					notas_tomadas 
				INNER JOIN
					cadastro ON notas_tomadas.codprestador = cadastro.codigo
				LEFT JOIN 
					notas ON notas_tomadas.numero = notas.numero AND notas_tomadas.codprestador = notas.codemissor AND notas.codtomador = notas_tomadas.codtomador
				WHERE 
					notas.numero IS NULL AND DATE(data) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
				GROUP BY 
					notas_tomadas.codtomador
				ORDER BY
					DATE(notas.datahoraemissao)
				DESC
			");
		  break;
		case 3:
			$query = ("
				SELECT 
					notas.codigo, 
					notas.codemissor, 
					DATE(notas.datahoraemissao), 
					notas.numero, 
					notas.valortotal 
				FROM
					notas
				INNER JOIN
					notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
				INNER JOIN
					cadastro ON notas.codemissor = cadastro.codigo
				WHERE
					notas_tomadas.numero IS NOT NULL AND 
					(notas.valortotal <> notas_tomadas.total OR notas.codverificacao <> notas_tomadas.codverificacao OR notas.valoriss <> notas_tomadas.iss) AND 
					DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' AND notas.estado <> 'C'
				ORDER BY
					notas.codemissor
			");
		  break;
	
	}
	
    $sql = Paginacao($query,"frmInconsistencias","divInconsistenciasDetalhes",10);
	//cria a lista de campos	
	if(mysql_num_rows($sql)){
		?>
		<input type="hidden" name="hdPrestador" id="hdPrestador" />
		<table width="100%" border="0" align="center" >
			<tr>
				<td align="left" colspan="6">
					<input name="btImprimirLista" value="Imprimir lista" type="button" class="botao" 
					onclick="document.getElementById('hdPrestador').value='';
					cancelaAction('frmInconsistencias','inc/fiscal/imprimir_inconsistencias.php','_blank');" />
				</td>
			</tr>
			<tr bgcolor="#999999">
				<td width="12%" align="center">CNPJ</td>
				<td width="49%" align="center">Emissor</td>
				<?php 
				if($tipo == "3"){
				?>
				<td width="11%" align="center">Data</td>
				<td width="8%" align="center">N&deg; Nota</td>
				<td width="12%" align="center">Valor (R$)</td>
				<?php
				}else{
				?>
				<td width="11%" align="center">Data Ultima</td>
				<td width="8%" align="center">Qtd</td>
				<td width="12%" align="center">Valor Total</td>
				<?php
				}
				?>
				<td width="8%" align="center">Detalhes</td>
			</tr>
		<?php
		$cont=0;
		while(list($codigo, $codemissor, $data, $numero, $valor) = mysql_fetch_array($sql)){
			$sql_busca_info_emissor = mysql_query("SELECT nome, razaosocial, cnpj, cpf FROM cadastro WHERE codigo = $codemissor");
			list($nome, $razao, $cnpj, $cpf) = mysql_fetch_array($sql_busca_info_emissor);
			if(!$razao){
				$nome_prestador = $nome;
			}else{
				$nome_prestador = $razao;
			}
			
			$nome_curto = ResumeString($nome_prestador,38);
			
			$cnpjcpf = $cnpj.$cpf;
		?>
			<tr bgcolor="#FFFFFF">
				<td align="center"><?php echo $cnpjcpf;?></td>
				<td align="left" title="<?php echo nome_prestador;?>"><?php echo $nome_curto;?></td>
				<td align="center"><?php echo DataPt($data);?></td>
				<?php 
				if($tipo == "3"){
				?>
				<td align="center"><?php echo $numero;?></td>
				<td align="center"><?php echo DecToMoeda($valor);?></td>
				<td align="center">
					<input name="btVizualizar" type="button" id="btLupa" class="botao" value="" 
					onclick="VisualizarNovaLinha('<?php echo $codigo;?>','tdInconsistencias<?php echo $cont;?>',this,'inc/fiscal/inconsistencias_detalhes.ajax.php');" 
					 title="Detalhes" />
				</td>
				<?php
				}else{
				?>
				<td align="center"><?php echo $numero;?></td>
				<td align="center"><?php echo DecToMoeda($valor);?></td>
				<td align="center">
					<input name="btVizualizar" type="button" id="btLupa" class="botao" value="" 
					onclick="document.getElementById('hdPrestador').value=<?php echo $codemissor;?>;
					cancelaAction('frmInconsistencias','inc/fiscal/imprimir_inconsistencias.php','_blank');" title="Detalhes" />
				</td>
				<?php
				}
				?>
			</tr>
			<tr>
				<td colspan="6" id="tdInconsistencias<?php echo $cont;?>" bgcolor="#FFFFFF"></td>
			</tr>
		<?php
			$cont++;
		}//fim while listagem dos campos pra declaracao
		?>
		</table>
		<?php
	}else{
		echo("<center><b>Nenhuma NFe encontrada!</b></center>");
	}
	?>
</fieldset>