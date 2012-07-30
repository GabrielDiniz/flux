<fieldset>
<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	
	$cnpj = $_GET['txtCNPJ'];
	$numero = $_GET['txtNumero'];
	$estado = $_GET['cmbEstado'];
	
	$queryWhere = "";
	
	if($cnpj){
		$queryWhere .= " AND (cadastro.cnpj = '$cnpj' OR cadastro.cpf = '$cnpj')";
	}
	
	if($numero){
		$queryWhere .= " AND rps_solicitacoes.codigo = '$numero'";
	}
	
	$query = ("
		SELECT 
			cadastro.nome,
			cadastro.razaosocial,
			cadastro.cnpj,
			cadastro.cpf,
			rps_solicitacoes.codigo,
			rps_solicitacoes.data, 
			rps_solicitacoes.estado,
			rps_solicitacoes.comunicado
		FROM 
			rps_solicitacoes
		INNER JOIN
			cadastro ON rps_solicitacoes.codcadastro = cadastro.codigo
		WHERE 
			rps_solicitacoes.estado LIKE '%$estado%' ".$queryWhere." AND rps_solicitacoes.comunicado = 'N' 
		ORDER BY
			rps_solicitacoes.codigo
		DESC
	");
	
	$sql_lista_rps = Paginacao($query,"frmRPS","divLista",10);
	if(mysql_num_rows($sql_lista_rps)){
?>
	<style>
		#divDetalhesRPS{
			top:20%;
			left:25%;
			position:absolute;
			display:none;
		}
	</style>
	<div id="divDetalhesRPS"></div>
	<table width="100%">
		<tr >
			<td width="4%" align="center">N&deg;</td>
			<td width="44%" align="center">Emissor</td>
			<td width="12%" align="center">CNPJ</td>
			<td width="10%" align="center">Data</td>
			<td width="9%" align="center">Estado</td>
			<td width="21%"></td>
		</tr>
		<?php
			while(list($nome,$razaosocial,$cnpj,$cpf,$codRPS,$dataRPS,$estadoRPS,$comunicado) = mysql_fetch_array($sql_lista_rps)){
				$cnpjcpf = $cnpj.$cpf;
				if(!$razaosocial){
					$razaosocial = $nome;
				}
				
				$razaosocial_curta = ResumeString($razaosocial,36);
				
				switch($estadoRPS){
					case "A":
						$str_estado = "Aguardando";
					  break;
					case "L":
						$str_estado = "Liberado";
					  break;
					case "R":
						$str_estado = "Recusado";
					  break;
				}
		?>
		<tr bgcolor="#FFFFFF">
			<td align="center"><?php echo $codRPS;?></td>
			<td align="left" title="<?php echo $razaosocial;?>"><?php echo $razaosocial_curta;?></td>
			<td align="center"><?php echo $cnpjcpf;?></td>
			<td align="center"><?php echo DataPt($dataRPS);?></td>
			<td align="center"><?php echo $str_estado;?></td>
			<td align="center">
				<?php
				if($estadoRPS == "A"){
				?>
					<input name="btLiberar" type="button" class="botao" value="Liberar" 
					onclick="mostraDetalhesRPS('inc/nfe/rps_detalhes.ajax.php?codRPS=<?php echo $codRPS;?>','divDetalhesRPS')" />
					&nbsp;
					<input name="btRecusar" type="button" class="botao" value="Recusar" 
					onclick="recusaRPS('inc/nfe/rps_liberar_recusar.ajax.php?tipo=R&codigo=<?php echo $codRPS;?>')" />
				<?php
				}else{
				?>
					<span id="spanComunicar">
						<input name="btComunicarPartes" type="button" class="botao" value="Comunicar Partes" 
						onclick="comunicarPartesRPS('inc/nfe/rps_comunicarpartes.ajax.php?codRPS=<?php echo $codRPS;?>','<?php echo $comunicado;?>')" />
					</span>
				<?php
				}
				?>
			</td>
		</tr>
		<?php
			}
		?>
	</table>
<?php
	}else{
		echo "<center><strong>Não há solicitações de RPS</strong></center>";
	}
?>
</fieldset>