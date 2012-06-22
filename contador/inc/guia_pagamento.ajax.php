<?php
session_name('contador');
session_start();
require_once("./conect.php");
require_once("../../funcoes/util.php");
require_once("../../include/nocache.php");

$ano=$_GET["cmbAno"];
$mes=$_GET["cmbMes"];
if($mes<10){ $mes="0".$mes; }
$codcadastro=$_GET["cmbEmpresaCliente"];
$hoje=date("Y-m-d");
$sql=mysql_query("SELECT codigo, valorisstotal, geracao, periodo, vencimento FROM livro WHERE codcadastro='$codcadastro' AND SUBSTRING(periodo,1,4)='$ano' AND SUBSTRING(periodo,6,2)='$mes' AND valoriss >= 0 AND codcadastro='$codcadastro' AND estado='N'") or die(mysql_error());

if(mysql_num_rows($sql)>0){ ?>
<script>
function GeraGuia($codguia){
	var guia = document.getElementById('hdLivro').value;
	if (confirm('Deseja criar a guia de pagamento para esta periodo?')) {
		document.getElementById('hdLivro').value = guia;
		document.getElementById('frmGuia').submit();
	} else
		return false;
}
</script>

<form method="post" id="frmGuia">	
    <input type="hidden" name="btBuscar" value="Buscar" />
    <input type="hidden" name="cmbAno" id="cmbAno" value="<?php echo $ano; ?>" />
    <input type="hidden" name="cmbMes" id="cmbMes" value="<?php echo $mes; ?>" />
    <input type="hidden" name="txtEmissor" value="<?php echo $codcadastro;?>" />
			<table border="0" width="100%">
				<tr bgcolor="#999999">
					<td align="center">Data Declara&ccedil;&atilde;o</td>
					<td align="center">Compet&ecirc;cia</td>
                    <td align="center">Vencimento</td>
                    <td align="center">Multa</td>
					<td align="center">Valor</td>															
					<td align="center" width="100">A&ccedil;&otilde;es</td>
			    </tr>
			    <?php
				while(list($codigo,$total,$data,$periodo,$vencimento)=mysql_fetch_array($sql)){
				
				$dataInicio=DataPt($vencimento);
				$dataFim=DataPt($hoje);
				
				$dias = diasDecorridos($dataInicio, $dataFim);
				
				$multa = calculaMultaDes($dias, $total);				
					?>
                    	<input type="hidden" name="hdLivro" id="hdLivro" value="<?php echo $codigo; ?>" />
						<tr bgcolor="#FFFFEA">
							<td align="center"><?php echo DataPt($data); ?></td>
							<td align="center"><?php echo DataPt($periodo); ?></td>
                            <td align="center"><?php echo DataPt($vencimento); ?></td>
                            <td align="center"><?php if(!$multa){ $multa = 0; } echo DecToMoeda($multa); ?></td>
							<td align="center"><?php echo DecToMoeda($total); ?></td>
							<td align="center"><input type="hidden" class="texto" name="txtMultaJuros<?php echo $codigo ?>" id="txtMultaJuros<?php echo $codigo ?>" value="0" readonly="readonly" >
                                <input type="submit" class="botao" value="Gerar Boleto" name="btBoleto" id="btBoleto" onClick="return GeraGuia(<?php echo $codigo; ?>);"/>
                            </td>
						</tr>
					<?php
				}//fim while
				?>
			</table>
		</form>	
		</td>
	</tr>
	<tr>
		<td colspan="3" height="1" bgcolor="#CCCCCC"></td>
	</tr>    
</table>
<?php

}else{
	echo "Nenhum Resultado Encontrado!";
} ?>