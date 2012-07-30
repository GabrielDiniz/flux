<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	require_once("../nocache.php");
	
	$dataInicial = $_POST['txtDataInicial'];
	$dataFinal   = $_POST['txtDataFinal'];
	$dataInicialMysql = DataMysql($dataInicial);
	$dataFinalMysql   = DataMysql($dataFinal);
	$codprestador = $_POST['hdPrestador'];
	$tipo = $_POST['hdTipo'];
	
	
?>
<table width="95%" border="2" cellspacing="0" class="tabela">
	<tr>
		<td width="106">
			<center>
				<img src="../../img/brasoes/<?php print $CONF_BRASAO; ?>" width="96" height="105"   />
			</center>
		</td>
		<td colspan="2">
			<span class="style1">
				<center>
					<p>RELAT&Oacute;RIO DE NOTAS INCONSIST&Ecirc;NCIAS </p>
					<p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
					<p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
				</center>
			</span>
		</td>
	</tr>
</table>

<?php

if(!$codprestador){
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
					notas.valortotal,
					notas.valoriss,
					notas.codverificacao,
					notas_tomadas.total,
					notas_tomadas.iss,
					notas_tomadas.codverificacao
				FROM
					notas
				INNER JOIN
					notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
				INNER JOIN
					cadastro ON notas.codemissor = cadastro.codigo
				WHERE
					notas_tomadas.numero IS NOT NULL AND 
					(notas.valortotal <> notas_tomadas.total OR notas.codverificacao <> notas_tomadas.codverificacao OR notas.valoriss <> notas_tomadas.iss) AND 
					DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' 
				ORDER BY
					notas.codemissor
			");
		  break;
	
	}
	
    $sql_lista = mysql_query($query);
	//cria a lista de campos	
	if(mysql_num_rows($sql_lista)){
		?>
		<center><strong>Foram encontrado(s) <?php echo mysql_num_rows($sql_lista);?> resultado(s)</strong></center>
		<table width="95%" border="2" cellspacing="0" class="tabela">
			<tr >
				<td width="4%" align="center">CNPJ</td>
				<td width="33%" align="center">Emissor</td>
				<?php 
				if($tipo == "3"){
				?>
				<td width="4%" align="center">Data</td>
				<td width="6%" align="center">N&deg; Nota</td>
				<td width="6%" align="center">Valor (R$)</td>
				<td width="25%" align="center">Inconsistência(s)</td>
				<?php
				}else{
				?>
				<td width="9%" align="center">Data Ultima</td>
				<td width="5%" align="center">Qtd</td>
				<td width="8%" align="center">Valor Total</td>
				<?php
				}
				?>
			</tr>
		<?php
		while(list($codigo, $codemissor, $data, $numero, $valor, $iss, $codverificacao, $totalTomada, $issTomada, $codverificacaoTomada) = mysql_fetch_array($sql_lista)){
			$sql_busca_info_emissor = mysql_query("SELECT nome, razaosocial, cnpj, cpf FROM cadastro WHERE codigo = $codemissor");
			list($nome, $razao, $cnpj, $cpf) = mysql_fetch_array($sql_busca_info_emissor);
			if(!$razao){
				$nome_prestador = $nome;
			}else{
				$nome_prestador = $razao;
			}
			
			$nome_curto = ResumeString($nome_prestador,38);
			
			$cnpjcpf = $cnpj.$cpf;
			
			$inconsistencia = array();
			if($valor != $totalTomada){
				$inconsistencia[] = "Notas com valores diferentes";
			}
			
			if($codverificacao != $codverificacaoTomada){
				$inconsistencia[] = "Codigo de verificação incorreto";
			}
			
			if($iss != $issTomada){
				$inconsistencia[] = "Notas com valores de iss diferentes";
			}
			
			$inconsistencia = implode(", ", $inconsistencia);

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
				<td align="center"><?php echo $inconsistencia;?></td>
				<?php
				}else{
				?>
				<td align="center"><?php echo $numero;?></td>
				<td align="center"><?php echo DecToMoeda($valor);?></td>
				<?php
				}
				?>
			</tr>
		<?php
		}//fim while listagem dos campos pra declaracao
		?>
		</table>
		<?php
	}else{
		echo("<center><b>Nenhuma NFe encontrada!</b></center>");
	}
}else{
	switch($tipo){
		case 1:
			$query = ("
				SELECT 
					notas.codigo, 
					notas.codemissor, 
					DATE(notas.datahoraemissao) AS data, 
					notas.numero, 
					notas.valortotal AS total,
					notas.estado
				FROM
					notas
				INNER JOIN
					cadastro ON notas.codemissor = cadastro.codigo
				LEFT JOIN
					notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
				WHERE
					notas_tomadas.numero IS NULL AND DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' AND cadastro.codigo LIKE '%$codprestador%'
				ORDER BY
					cadastro.nome				
			");
			
			$inconsistencia = "Nota não foi declarada pelo tomador";
		  break;
		case 2:
			$query = ("
				SELECT 
					notas_tomadas.codigo, 
					notas_tomadas.codtomador AS codemissor, 
					notas_tomadas.codprestador,
					notas_tomadas.data, 
					notas_tomadas.numero, 
					notas_tomadas.total,
					notas_tomadas.estado
				FROM 
					notas_tomadas 
				INNER JOIN
					cadastro ON notas_tomadas.codprestador = cadastro.codigo
				LEFT JOIN 
					notas ON notas_tomadas.numero = notas.numero AND notas_tomadas.codprestador = notas.codemissor AND notas.codtomador = notas_tomadas.codtomador
				WHERE 
					notas.numero IS NULL AND DATE(data) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' AND notas_tomadas.codtomador LIKE '%$codprestador%' 
				ORDER BY
					cadastro.nome				
			");
			$inconsistencia = "Nota não foi emitida pelo prestador";
		  break;
		case 3:
			$query = ("
				SELECT 
					notas.codigo, 
					notas.codemissor,
					notas.codverificacao, 
					notas.tomador_cnpjcpf,
					DATE(notas.datahoraemissao) AS data, 
					notas.numero, 
					notas.valortotal,
					notas.valoriss,
					notas_tomadas.codigo AS codnotatomada,
					notas_tomadas.codprestador,
					notas_tomadas.codtomador,
					notas_tomadas.codverificacao AS codverificacaoNT,
					notas_tomadas.data,
					notas_tomadas.numero,
					notas_tomadas.total,
					notas_tomadas.iss,
					notas.estado
				FROM
					notas
				INNER JOIN
					notas_tomadas ON notas.numero = notas_tomadas.numero AND notas.codemissor = notas_tomadas.codprestador AND notas.codtomador = notas_tomadas.codtomador
				INNER JOIN
					cadastro ON notas.codemissor = cadastro.codigo
				WHERE
					notas_tomadas.numero IS NOT NULL AND 
					(notas.valortotal <> notas_tomadas.total OR notas.codverificacao <> notas_tomadas.codverificacao OR notas.valoriss <> notas_tomadas.iss) AND 
					DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql' 
				ORDER BY
					cadastro.nome				
			");
		  break;
	}
	$sql_lista = mysql_query($query);
	if(mysql_num_rows($sql_lista)){
	?>
	<center><strong>Foram encontrado(s) <?php echo mysql_num_rows($sql_lista);?> resultado(s)</strong></center>
	<table width="95%" border="2" cellspacing="0" class="tabela">
		<tr >
			<td width="11%" align="center">CNPJ</td>
			<td width="38%" align="center">Emissor</td>
			<td width="6%" align="center">Data</td>
			<td width="5%" align="center">N&deg; nota</td>
			<td width="10%" align="center">Valor (R$)</td>
            <td width="8%" align="center">Situaçao</td>
			<td width="30%" align="center">Inconsistência(s)</td>
		</tr>
	
		<?php
		while($dadosImprimir = mysql_fetch_object($sql_lista)){
			$sql_busca_info_emissor = mysql_query("SELECT nome, razaosocial, cnpj, cpf FROM cadastro WHERE codigo = '{$dadosImprimir->codemissor}'");
			list($nome, $razao, $cnpj, $cpf) = mysql_fetch_array($sql_busca_info_emissor);
			if(!$razao){
				$nome_prestador = $nome;
			}else{
				$nome_prestador = $razao;
			}
			
			$cnpjcpf = $cnpj.$cpf;
			
			switch($dadosImprimir->estado){
				case 'C'; $situacao = 'Cancelada'; break;
				case 'B'; $situacao = 'Boleto'; break;
				case 'N'; $situacao = 'Normal'; break;
				case 'E'; $situacao = 'Escriturada'; break;
			}
		?>
		<tr>
			<td align="center"><?php echo $cnpjcpf;?></td>
			<td align="left"><?php echo $nome_prestador;?></td>
			<td align="center"><?php echo DataPt($dadosImprimir->data);?></td>
			<td align="center"><?php echo $dadosImprimir->numero;?></td>
			<td align="right"><?php echo DecToMoeda($dadosImprimir->total);?></td>
            <td align="center"><?php echo $situacao;?></td>
			<td align="center"><?php echo $inconsistencia;?></td>
		</tr>
		<?php
		}
		?>
	</table>
	<?php
	}else{
	?>
		<table width="95%" border="2" cellspacing="0" class="tabela">
			<tr>
				<td align="center">Não foram encontradas notas para esta competencia</td>
			</tr>
		</table>
	<?php
	}
}
?>