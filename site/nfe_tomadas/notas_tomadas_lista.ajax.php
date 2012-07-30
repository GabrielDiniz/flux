<?php
/*
COPYRIGHT 2008 - 2010 DO PORTAL PUBLICO INFORMATICA LTDA

Este arquivo e parte do programa E-ISS / SEP-ISS

O E-ISS / SEP-ISS e um software livre; voce pode redistribui-lo e/ou modifica-lo
dentro dos termos da Licenca Publica Geral GNU como publicada pela Fundacao do
Software Livre - FSF; na versao 2 da Licenca

Este sistema e distribuido na esperanca de ser util, mas SEM NENHUMA GARANTIA,
sem uma garantia implicita de ADEQUACAO a qualquer MERCADO ou APLICACAO EM PARTICULAR
Veja a Licenca Publica Geral GNU/GPL em portugues para maiores detalhes

Voce deve ter recebido uma copia da Licenca Publica Geral GNU, sob o titulo LICENCA.txt,
junto com este sistema, se nao, acesse o Portal do Software Publico Brasileiro no endereco
www.softwarepublico.gov.br, ou escreva para a Fundacao do Software Livre Inc., 51 Franklin St,
Fith Floor, Boston, MA 02110-1301, USA
*/
?>
<?php
	require_once("../../include/conect.php");
	require_once("../../funcoes/util.php");
	require_once("../../include/nocache.php");
	
	$cnpj           = $_GET['txtCNPJ'];
	$numero         = $_GET['txtNumeroNota'];
	$codVerificacao = $_GET['txtCodVerificacao'];
	$dataIni        = DataMysql($_GET['txtDataIni']);
	$dataFim        = DataMysql($_GET['txtDataFim']);
	$string         = '';
	
	if(isset($_GET['cmbEmpresa'])){
		$codTomador = $_GET['cmbEmpresa'];
	}else{
		$codTomador = $_GET['hdCodLogado'];
	}
	
	if($cnpj){
		$sql_busca_codprestador = mysql_query("SELECT codigo FROM cadastro WHERE (cnpj = '$cnpj' OR cpf = '$cnpj')");
		list($codPrestador) = mysql_fetch_array($sql_busca_codprestador);
		$string .= " AND codprestador = '$codPrestador'";
	}
	
	if($numero){
		$string .= " AND numero = '$numero'";
	}
	
	if($dataIni){
		$string .= " AND data >= '$dataIni'";
	}
	
	if($dataFim){
		$string .= " AND data <= '$dataFim'";
	}
	
	$query = ("
		SELECT 
			codigo,
			numero, 
			codprestador, 
			data, 
			codverificacao,
			estado
		FROM 
			notas_tomadas 
		WHERE 
			codtomador = '$codTomador' AND codverificacao LIKE '%$codVerificacao%' $string
		ORDER BY
			codigo
		DESC
	");
	
?>
<table border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
		<td width="10" height="10" bgcolor="#FFFFFF"></td>
		<td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Resultado de Pesquisa</td>
		<td width="400" bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td height="1" ></td>
		<td ></td>
	</tr>
	<tr>
		<td height="10" bgcolor="#FFFFFF"></td>
		<td bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td colspan="3" height="1" ></td>
	</tr>
	<tr>
		<td height="60" colspan="3" >
			
			<?php
			$sql_lista = Paginacao($query,'frmPesquisaNotaTomada','divPesquisaNotaTomada',10);
			if(mysql_num_rows($sql_lista)){
			?>
			<table width="100%">
				<tr >
					<td width="12%" align="center"><strong>Número</strong></td>
					<td width="22%" align="center"><strong>Cód. Verificacao</strong></td>
					<td width="49%" align="center"><strong>CNPJ/CPF</strong></td>
					<td width="11%" align="center"><strong>Data</strong></td>
					<td width="6%" align="center"></td>
				</tr>
				<?php
				$cont=0;
				while($dados_lista = mysql_fetch_object($sql_lista)){
					if($dados_lista->estado == "C"){
						$bgcolor = "#FFB895";
					}else{
						$bgcolor = "#FFFFFF";
					}
					
					$busca_cnpj_prestador = mysql_query("SELECT cnpj, cpf FROM cadastro WHERE codigo = '{$dados_lista->codprestador}'");
					list($cnpj, $cpf) = mysql_fetch_array($busca_cnpj_prestador);
					$cnpjcpf = $cnpj.$cpf;
				?>
					<tr bgcolor="<?php echo $bgcolor;?>" height="30">
						<td align="center"><?php echo $dados_lista->numero;?></td>
						<td align="center"><?php echo $dados_lista->codverificacao;?></td>
						<td align="center"><?php echo $cnpjcpf;?></td>
						<td align="center"><?php echo DataPt($dados_lista->data);?></td>
						<td align="left" bgcolor="#FFFFFF">
							<?php
							if ($dados_lista->estado != "C") {
							?>
								<input name="btCancelar" type="button" class="botao" value="" id="btX" 
								onclick="VisualizarNovaLinha('<?php echo $dados_lista->codigo;?>','<?php echo"tdNFTomadas".$cont;?>',this,'../site/nfe_tomadas/notas_tomadas_motivo_cancelar.ajax.php')" title="Cancelar nota"/>
							<?php 
							}
							?>
						</td>
					</tr>
					<tr>
						<td colspan="6" id="<?php echo"tdNFTomadas".$cont; ?>" height="1" ></td>
					</tr>
				<?php
					$cont++;
				}
				?>				
			</table>
			<?php
			}else{
				echo "<center><strong>Não há nenhuma nota declarada!</strong></center>";
			}
			?>

		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" ></td>
	</tr>
</table>
