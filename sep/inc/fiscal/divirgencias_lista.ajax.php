<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	require_once("../nocache.php");
	$dataInicial = date("Y-m")."-01";
	$dataFinal   = retornaUltDiaMes(date("m"));
	$dataInicialMysql = DataMysql($dataInicial);
	$dataFinalMysql   = DataMysql($dataFinal);

	$tipo = $_GET['tipo'];
	
	switch($tipo){
		case 1:
			$query = ("
				SELECT 
					notas.codigo, 
					codemissor, 
					datahoraemissao, 
					notas.numero, 
					valortotal 
				FROM 
					notas 
				INNER JOIN 
					notas_tomadas AS nt ON notas.codemissor = nt.codtomador AND notas.numero = nt.numero
				WHERE 
					DATE(datahoraemissao) BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
			
			");
		break;
		case 2:
				$query = ("
		SELECT codigo, codtomador, data, numero, total FROM notas_tomadas
		WHERE codtomador NOT IN (SELECT codemissor FROM notas )
		AND data BETWEEN '$dataInicialMysql' AND '$dataFinalMysql'
		GROUP BY codtomador,numero
			
	");
		break;
	
	}
    $sql=Paginacao($query,"frmInconsistencias","divInconsistenciasDetalhes",5);
	//cria a lista de campos	
	if(mysql_num_rows($sql)){
		?>
				  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
	                <tr>
	                  <td align="center" bgcolor="#CCCCCC">Código</td>
	                  <td align="center" bgcolor="#CCCCCC">Prestador</td>
	                  <td align="center" bgcolor="#CCCCCC">Data</td>
	                  <td align="center" bgcolor="#CCCCCC">Número nota</td>
	                  <td align="center" bgcolor="#CCCCCC">Valor (R$)</td>
	                  <td align="center" bgcolor="#CCCCCC">Imprimir</td>
	                 </tr>
		<?php
		$cont=1;
		while(list($codigo, $codemissor, $data, $numero, $valor) = mysql_fetch_array($sql)){
			list($prestador)=mysql_fetch_array(mysql_query("SELECT nome FROM cadastro WHERE codigo=$codemissor"));
		?>  
		                <tr>
		                  <td align="center">
						  	<input name="txtCodigoGuia<?php echo $cont;?>" id="txtCodigoGuia<?php echo $cont;?>" type="hidden" value="<?php echo $codigo;?>" />
		                  	<input name="txtCodguia<?php echo $cont;?>" type="text" class="texto" id="txtCodguia<?php echo $cont;?>" value="<?php echo $codigo; ?>" size="12" style="text-align:center;" readonly />	                  
		                  </td>
		                  <td align="center">
	                      	<input name="txtDataEmissao<?php echo $cont;?>" type="text" class="texto" id="txtDataEmissao<?php echo $cont;?>" value="<?php echo $prestador ?>" size="35" readonly />		              
	                      </td>
		                  <td align="center">
	                      	<input name="txtValor<?php echo $cont;?>" type="text" class="texto" id="txtValor<?php echo $cont;?>" value="<?php echo DataPt(substr($data,0,10)); ?>" size="10" readonly style="text-align:right" />                      
	                      </td>
		                  <td align="center">
		                  	<input name="txtDataEmissao<?php echo $cont;?>" type="text" class="texto" id="txtDataEmissao<?php echo $cont;?>2" value="<?php echo $numero; ?>" size="5" readonly />
		                  </td>
		                  <td align="center">
		                  	<input name="txtSituacao<?php echo $cont;?>" type="text" class="texto" id="txtSituacao<?php echo $cont;?>2" value="<?php echo DecToMoeda($valor); ?>" size="8" style="text-align:center" readonly />
		                  </td>
		                  <td align="center">		                  	
		                  	<input name="imgImprimir<?php echo $cont;?>" id="imgImprimir" type="image" src="img/botoes/botao_imprimir.jpg" onClick="document.getElementById('CODIGO').value='<?php echo base64_encode($codigo)?>';return SubmitSegundaViaGuia('<?php echo $cont;?>');">                 	
		                  </td>
		                </tr>
		<?php
		$cont++;
		}//fim while listagem dos campos pra declaracao
		?>
		</table>
		<?php
	}else{
		echo("<center><b>Nenhuma NFe encontrada!!</b></center>");
		
	}
	?>  