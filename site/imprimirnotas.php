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
	include("../include/conect.php");
	include("../funcoes/util.php");
	
	$notas = $_POST['hdNota'];
?>
<center>	
<input name="btImprimir" id="btImprimir" type="button" class="botao" value="Imprimir" onClick="document.getElementById('btImprimir').style.display = 'none';print();document.getElementById('btImprimir').style.display = 'block';">	
</center>	
<?php
// variaveis globais vindas do conect.php
// $CODPREF,$PREFEITURA,$USUARIO,$SENHA,$BANCO,$TOPO,$FUNDO,$SECRETARIA,$LEI,$DECRETO,$CREDITO,$UF	

// descriptografa o codigo
$CODIGO = base64_decode($_GET['cod']);

// sql feito na nota
for($c=0;$c<$notas;$c++){
	if($_POST['ckbNota'.$c]){
		$impnota[] = $_POST['ckbNota'.$c];
		$codigo = $_POST['ckbNota'.$c];
		$sql = mysql_query("
		SELECT
		  `notas`.`aliq_percentual`, 
		  `notas`.`cofins`, 
		  `notas`.`contribuicaosocial`,
		  `notas`.`codigo`, 
		  `notas`.`numero`, 
		  `notas`.`codverificacao`,
		  `notas`.`datahoraemissao`, 
		  `notas`.`rps_numero`,
		  `notas`.`rps_data`, 
		  `notas`.`tomador_nome`, 
		  `notas`.`tomador_cnpjcpf`,
		  `notas`.`tomador_inscrmunicipal`,
		  `notas`.`tomador_inscrestadual`, 
		  `notas`.`tomador_endereco`,
		  `notas`.`tomador_logradouro`,
		  `notas`.`tomador_numero`,
		  `notas`.`tomador_complemento`,
		  `notas`.`tomador_cep`, 
		  `notas`.`tomador_municipio`, 
		  `notas`.`tomador_uf`,
		  `notas`.`tomador_email`, 
		  `notas`.`discriminacao`, 
		  `notas`.`valortotal`,
		  `notas`.`estado`, 
		  `notas`.`credito`,
		  `notas`.`pispasep`,
		  `notas`.`valordeducoes`,
		  `notas`.`valoracrescimos`,
		  `notas`.`basecalculo`, 
		  `notas`.`valoriss`,
		  `notas`.`valorinss`,
		  `notas`.`aliqinss`,
		  `notas`.`valorirrf`,
		  `notas`.`aliqirrf`,
		  `notas`.`deducao_irrf`,
		  `notas`.`total_retencao`,
		  `cadastro`.`razaosocial`, 
		  `cadastro`.`nome`, 
		  `cadastro`.`cnpj`,
		  `cadastro`.`cpf`,
		  `cadastro`.`inscrmunicipal`, 
		  `cadastro`.`inscrestadual`,
		  `cadastro`.`logradouro`,
		  `cadastro`.`numero`,
		  `cadastro`.`municipio`, 
		  `cadastro`.`uf`, 
		  `cadastro`.`logo`,
		  `notas`.`issretido`, 
		  `cadastro`.`codtipo`,
		  `cadastro`.`pispasep`,
		  `cadastro`.`codtipodeclaracao`,
		  `notas`.`observacao`,
		  `notas`.`motivo_cancelamento`
		FROM
		  `notas` 
		INNER JOIN
		  `cadastro` ON `notas`.`codemissor` = `cadastro`.`codigo`
		WHERE
		  `notas`.`codigo` = '$codigo'
		");
		list($aliquotapercentual,$cofins,$contribuicaosocial, $codigo, $numero, $codverificacao, $datahoraemissao, $rps_numero, $rps_data,
				$tomador_nome, $tomador_cnpjcpf, $tomador_inscrmunicipal, $tomador_inscrestadual, $tomador_endereco,
				$tomador_logradouro, $tomador_numero, $tomador_complemento, $tomador_cep,
				$tomador_municipio, $tomador_uf, $tomador_email, $discriminacao, $valortotal,
				$estado, $credito, $pispasep,$valordeducoes, $valoracrescimos, $basecalculo,
				$valoriss,$valorinss,$aliqinss,$valorirrf,$aliqirrf, $deducao_irrf, $total_retencao,
				$empresa_razaosocial, $empresa_nome, $empresa_cnpj, $empresa_cpf, $empresa_inscrmunicipal,
				$empresa_inscrestadual,	$empresa_endereco, $empresa_numero, $empresa_municipio, $empresa_uf, $empresa_logo ,$issretido,
				$codtipo,$cadastropispasep,$codtipodec,$observacao,$motivoCanc) = mysql_fetch_array($sql);
		
		$empresa_cnpjcpf = $empresa_cnpj.$empresa_cpf;
		
		if(!empty($tomador_logradouro)) $tomador_endereco = $tomador_logradouro;
		if(!empty($tomador_numero) and $tomador_numero != '0') $tomador_endereco .= ", ".$tomador_numero;
		if(!empty($tomador_complemento)) $tomador_endereco .= ", ".$tomador_complemento;
		
		if(!empty($empresa_endereco)) $empresa_endereco = $empresa_endereco;
		if(!empty($empresa_numero) and $empresa_numero != '0') $empresa_endereco .= ", ".$empresa_numero;

		//nao tem soh endereco agora tem logradouro e numero com complemento
		//$tomador_endereco="$tomador_logradouro, $tomador_numero";
		//se tiver complemento, adiciona para a string de endereço
		//if($tomador_complemento){
			//$tomador_endereco.=", $tomador_complemento";
		//}
		//verifica o codtipo do simples nacional
		$codtipoSN = coddeclaracao('Simples Nacional');
		
		//Verifica na tabela configuracoes se os creditos estao ativos
		$sql_verifica_creditos = mysql_query("SELECT ativar_creditos FROM configuracoes");
		list($ativar_creditos) = mysql_fetch_array($sql_verifica_creditos);
		
		if($ativar_creditos == "n"){
			$display = "display:none";
			$colspan = "colspan=\"2\"";
			
		}else{
			$display = "display:block";
			$colspan = "";
		}
		
		$sql_leidecreto = mysql_query("SELECT lei, decreto FROM configuracoes");
		list($lei,$decreto) = mysql_fetch_array($sql_leidecreto);
		?>
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>e-Nota [Imprimir Nota]</title>
		<style type="text/css" >
		table.gridview {
			width:100%;
			font-size:10px; 
			font-family:Verdana, Arial, Helvetica, sans-serif; 
			border-bottom-width:thick;
			border-collapse:collapse;
		}
		table.gridview tr td {
			border:1px solid #000000;
		}
		table.gridview tr th {
			background-color:#CCCCCC;
			border:1px solid #000000;
		}
		</style>
		</head>
		
		<body>
		<center>
		
		<table width="800" border="0" cellspacing="0" cellpadding="2" style="border:#000000 1px solid;border-collapse:collapse">
		  <tr>
			<td colspan="4" rowspan="3" width="75%" style="border:#000000 1px solid" align="center">
		<!-- tabela prefeitura inicio -->	
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
		  <tr>
			<td rowspan="4" width="20%" align="center" valign="top">
				<?php if ($CONF_BRASAO && file_exists(dirname(__FILE__)."/../img/brasoes/{$CONF_BRASAO}") ) { ?>
				<img src="../img/brasoes/<?php echo rawurlencode($CONF_BRASAO);?>" width="100" height="100" />
				<?php }//fim if para mostrar a imagem somente se existir ?>
				<br />
			</td>
			<td width="80%" class="cab01"><?php print "Prefeitura Municipal de ".strtoupper($CONF_CIDADE); ?></td>
		  </tr>
		  <tr>
			<td class="cab03"><?php print strtoupper($CONF_SECRETARIA); ?></td>
		  </tr>
		  <tr>
			<td class="cab02">NOTA FISCAL ELETR&Ocirc;NICA DE SERVI&Ccedil;OS - NF-e</td>
		  </tr>
		  <?php if($rps_numero){ ?>
		  <tr>
			<td>RPS N&ordm; <?php print $rps_numero; ?>, emitido em <?php print (substr($rps_data,8,2)."/".substr($rps_data,5,2)."/".substr($rps_data,0,4)); ?>.</td>
		  </tr>
		  <?php }// fim if se tem rps ?>
		</table>
		
		<!-- tabela prefeitura fim -->	</td>
			<td width="25%" colspan="2" align="left" style="border:#000000 1px solid">Número da Nota<br /><div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="3"><strong><?php print $numero; ?></strong></font></div></td>
		  </tr>
		  <tr>
			<td align="left" colspan="2" style="border:#000000 1px solid">Data e Hora de Emissão<br /><div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="3"><strong><?php print (substr($datahoraemissao,8,2)."/".substr($datahoraemissao,5,2)."/".substr($datahoraemissao,0,4)." ".substr($datahoraemissao,11,2).":".substr($datahoraemissao,14,2)); ?></strong></font></div></td>
		  </tr>
		  <tr>
			<td align="left" colspan="2" style="border:#000000 1px solid">Código de Verificação<br /><div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="3"><strong><?php print $codverificacao; ?></strong></font></div></td>
		  </tr>
		  <tr>
			<td colspan="6" align="center" style="border:#000000 1px solid">
			
		<!-- tabela prestador -->	
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
		  <tr>
			<td colspan="3" class="cab03" align="center">PRESTADOR DE SERVI&Ccedil;OS</td>
			</tr>
		  <tr>
			<td rowspan="6">
			<?php
			// verifica o logo
			if ($empresa_logo != "") {
				echo "<img src=\"../img/logos/$empresa_logo\" width=\"100\" height=\"100\" >";
			}	
			?>	
			</td>
			<td align="left">CNPJ/CPF: <strong><?php print $empresa_cnpjcpf; ?></strong></td>
			<td align="left">Inscri&ccedil;&atilde;o Estadual: <strong><?php print verificaCampo($empresa_inscrestadual); ?></strong></td>
		  </tr>
		  <tr>
			<td align="left">Nome: <strong><?php echo $empresa_nome; ?></strong></td>
			<td align="left">Inscri&ccedil;&atilde;o Municipal: <strong><?php print verificaCampo($empresa_inscrmunicipal); ?></strong></td>
		  </tr>
		  <tr>
			<td align="left">Raz&atilde;o Social: <strong><?php print $empresa_razaosocial; ?></strong></td>
            <td align="left">PIS/PASEP: <?php echo verificaCampo($cadastropispasep); ?></td>
		  </tr>
		  <tr>
			<td colspan="2" align="left">Endere&ccedil;o: <strong><?php print $empresa_endereco; ?></strong></td>
		  </tr>
		  <tr>
			<td align="left">Munic&iacute;pio: <strong><?php print $empresa_municipio; ?></strong></td>
			<td align="left">UF: <strong><?php print $empresa_uf; ?></strong></td>
		  </tr>
		</table>
			
			
		<!-- tabela prestador -->	</td>
			</tr>
		  <tr>
			<td colspan="6" align="center" style="border:#000000 1px solid">
		<!-- tabela tomador inicio -->	
		
		<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
		  <tr>
			<td colspan="3" class="cab03" align="center">TOMADOR DE SERVI&Ccedil;OS</td>
			</tr>
		  <tr>
			<td colspan="3" align="left">&nbsp;&nbsp;Nome/Raz&atilde;o Social: <strong><?php print strtoupper(verificaCampo($tomador_nome)); ?></strong></td>
			</tr>
		  <tr>
			<td align="left" width="450">&nbsp;&nbsp;CPF/CNPJ: <strong><?php print strtoupper(verificaCampo($tomador_cnpjcpf)); ?></strong></td>
			<td colspan="2" align="left">&nbsp;&nbsp;Inscri&ccedil;&atilde;o Estadual: <strong><?php print strtoupper(verificaCampo($tomador_inscrestadual)); ?></strong></td>
			</tr>
		  <tr>
			<td align="left">&nbsp;&nbsp;Endere&ccedil;o: <strong><?php print strtoupper(verificaCampo($tomador_endereco));?></strong></td>
			<td colspan="2" align="left">&nbsp;&nbsp;Inscri&ccedil;&atilde;o Municipal: <strong><?php print strtoupper(verificaCampo($tomador_inscrmunicipal)); ?></strong></td>
		  </tr>
		  <tr>
			<td align="left">&nbsp;&nbsp;Munic&iacute;pio: <strong><?php print strtoupper(verificaCampo($tomador_municipio)); ?></strong></td>
			<td align="left">&nbsp;&nbsp;CEP: <strong><?php print strtoupper(verificaCampo($tomador_cep));?></strong></td>
		  </tr>
		  <tr>
			<td align="left">&nbsp;&nbsp;E-mail: <strong><?php print strtoupper(verificaCampo($tomador_email)); ?></strong></td>
            <td align="left">UF: <strong><?php print strtoupper(verificaCampo($tomador_uf)); ?></strong></td>
		  </tr>
		</table>
				
		<!-- tabela tomador fim -->	</td>
			</tr>
		  <tr>
			<td colspan="6" align="center" style="border:#000000 1px solid">
			
		<!-- tabela discrimacao dos servicos -->	
			
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
		  <tr>
			<td class="cab03" align="center">DISCRIMINA&Ccedil;&Atilde;O DE SERVI&Ccedil;OS E DEDU&Ccedil;&Otilde;ES</td>
		  </tr>
		  <tr>
			<td height="400" align="left" valign="top">
				<br />
				<?php
				//sql para listar os servicos da nota atual
				$servicos_sql = mysql_query("
					SELECT 
						s.codservico,
						s.descricao,
						ns.basecalculo, 
						ns.iss,
						ns.issretido,
						s.aliquotair,
						s.aliquota,
						ns.discriminacao
					FROM 
						notas_servicos as ns
					INNER JOIN
						servicos as s ON ns.codservico = s.codigo
					WHERE 
						codnota = '$codigo'
				");
				?>
				<table class="gridview" align="center">
					<tr>
						<th align="center">C&oacute;digo</th>
						<th align="center">Servi&ccedil;o</th>
						<th align="center">Al&iacute;quota (%) </th>
						<th align="center">Base de Calculo (R$)</th>
						<th align="center">Iss retido (R$)</th>
						<th align="center">Iss (R$)</th>
					</tr>
					<?php
					$totalALiquota = 0;
					while ($servicos_dados = mysql_fetch_assoc($servicos_sql)) {
					?>
					<tr>
						<td align="center" <?php if(!$servicos_dados['codservico']){ echo "title='Não possui codigo de serviço'"; }?>>
							<?php if($servicos_dados['codservico']){ echo $servicos_dados['codservico']; }else{ echo "N/P"; }?>
						</td>
						<td align="left"><?php echo $servicos_dados['descricao']; ?></td>
						<td align="right"><?php if($aliquotapercentual){echo DecToMoeda($aliquotapercentual);}else{echo DecToMoeda($servicos_dados['aliquota']); }?></td>
						<td align="right"><?php echo DecToMoeda($servicos_dados['basecalculo']); ?></td>
						<td align="right"><?php echo DecToMoeda($servicos_dados['issretido']); ?></td>
						<td align="right"><?php echo DecToMoeda($servicos_dados['iss']); ?></td>
					</tr>
					<?php
					?>
					<tr>
						<th colspan="6" align="left"><strong>Discrimina&ccedil;&atilde;o</strong></th>
					</tr>
					<tr>
						<td height="30" colspan="6">
							<?php 
								if($servicos_dados['discriminacao']){
									echo $servicos_dados['discriminacao'];
								}else{
									echo "Não foi informado";
								}
							?>
						</td>
					</tr>
					<?php
						$totalALiquota += $servicos_dados['aliquota'];
					}//fim while
					?>
				</table>
				<br />
				<?php	
				// verifica o estado da nfe
				if($estado == "C") {
					echo "<div align=center><font size=7 color=#FF0000><b>
						ATEN&Ccedil;&Atilde;O!!<br />NFE CANCELADA</font> <br /><font size=5 color=#FF0000>
						Motivo do cancelamento:<br /> $motivoCanc</B></font></div>";
				} // fim if
				
				?>
			</table>
			
			
		<!-- tabela discrimacao dos servicos -->	
				</td>
			</tr>
			<?php 
				if($discriminacao){
					$discriminacao = nl2br($discriminacao); 
			?>
			<tr>
				<td colspan="6" align="center" style="border:#000000 1px solid">
					<table width="100%">
						<tr>
							<td class="cab03" align="center">DISCRIMINA&Ccedil;&Atilde;O DA NOTA</td>
						</tr>	
						<tr>
							<td align="left">
								<?php
									echo $discriminacao ; 
								?>
							</td>
						</tr>
					</table>		
				</td>
			</tr>
			<?php
				}
			?>
		
			<?php
			if($observacao){
			?>
			<tr>
				<td colspan="6" align="center" style="border:#000000 1px solid">
					<table width="100%">
						<tr>
							<td class="cab03" align="center">OBSERVA&Ccedil;&Otilde;ES DA NOTA</td>
						</tr>	
						<tr>
							<td align="left">
								<?php
									echo $observacao ; 
								?>
							</td>
						</tr>
					</table>		
				</td>
			</tr>
			<?php
			}
			?>
		
			
		
		  <tr>
			<td colspan="6" class="cab03" align="center" style="border:#000000 1px solid">VALOR TOTAL DA NOTA = R$ <?php print DecToMoeda($valortotal); ?></td>
			</tr>
		  <!--<tr>
			<td colspan="6" align="left" style="border:#000000 1px solid">Código do Serviço<br /><strong><?php print $servico_codservico." - ". $servico_descricao; ?></strong></td>
			</tr>-->
		  <tr>
			<?php
				if($valoracrescimos > 0){
					
			?>
			<td style="border:#000000 1px solid">Dedu&ccedil;&otilde;es (R$)<br /><div align="right"><strong><?php print DecToMoeda($valordeducoes); ?></strong></div></td>
			<td style="border:#000000 1px solid">Acr&eacute;scimos (R$)<br /><div align="right"><strong><?php print DecToMoeda($valoracrescimos); ?></strong></div></td>
			<?php
				}else{
					if($ativar_creditos == "n"){
						$colspan = "colspan=\"3\"";
					}
			?>
			<td style="border:#000000 1px solid">Valor Total das Dedu&ccedil;&otilde;es (R$)<br /><div align="right"><strong><?php print DecToMoeda($valordeducoes); ?></strong></div></td>
			<?php
				}
			?>
			<td style="border:#000000 1px solid" colspan="2">Base de C&aacute;lculo (R$)<br /><div align="right"><strong><?php print DecToMoeda($basecalculo); ?></strong></div></td>
			<td style="border:#000000 1px solid; display:none">
			 Al&iacute;quota (%)
			 <br />
			 <div align="right">
			  <strong>
			   <?php
			   /*if ($codtipodec == $codtipoSN)
			   {
				echo "----";
			   }
			   else
			   {*/
				print DecToMoeda($totalALiquota)." %";
			   /*} */ ?>
			  </strong>
			 </div>
			</td>
			<td style="border:#000000 1px solid" <?php echo $colspan;?> align="center">
			 Valor do ISS (R$)
			 <br />
			 <div align="right">
			  <strong>
			   <?php 
				/*if ($codtipodec == $codtipoSN)
				{
				  echo "----";	  
				} 
				else
				{ */
				 print DecToMoeda($valoriss); 
				/*}*/  ?>
			  </strong>
			 </div>
			</td>  
		
			<td style="border:#000000 1px solid; <?php echo $display;?>">
			 Cr&eacute;dito 
			 <br />
			 <div align="right">
			 <strong>
			  <?php /*
			   if ($codtipodec == $codtipoSN)
				{
				  echo "----";	  
				} 
				else
				{	  */ 
				 print DecToMoeda($credito); 
				/*} */ ?>
			 </strong></div>
			</td>
		  </tr>
		  <tr>
			<td colspan="6" style="border:#000000 1px solid" class="cab03">OUTRAS INFORMA&Ccedil;&Otilde;ES</td>
		  </tr>
		  
		  <tr>
			<td colspan="6" style="border:#000000 1px solid" align="left">
			- Esta NF-e foi emitida com respaldo na Lei n&ordm; <?php print $lei; ?> e no Decreto n&ordm; <?php print $decreto; ?><br />
			<?php /*
			if ($codtipodec == $codtipoSN)
			{
			  echo "- Esta NF-e não gera créditos, pois a empresa prestadora de serviços é optante pelo Simples Nacional<br> ";
			} */
			if($issretido != 0)
			{
			  echo "- Esta NF-e possui retenção de ISS no valor de R$ ".DecToMoeda($issretido)."<br> ";
			
			}
			
			if($pispasep > 0){
				echo "- Esta NF-e possui PIS/PASEP no valor de R$ ".DecToMoeda($pispasep)."<br />";
			}
			
			
			// verifica o estado do tomador
			/*
			if(($CONF_CIDADE != $tomador_municipio) && ($codtipodec != $codtipoSN)) {
				if($ativar_creditos == "s"){
					echo "- Esta NF-e não gera crédito, pois o Tomador de Serviços está localizado fora do município de $CONF_CIDADE<br>";
				}
			} // fim if	*/
			if($rps_numero){
			?>
			- Esta NF-e substitui o RPS N&ordm; <?php print $rps_numero; ?>, emitido em <?php print (substr($rps_data,8,2)."/".substr($rps_data,5,2)."/".substr($rps_data,0,4)); ?><br />
			<?php
			}//fim if rps
			//$valorinss,$aliqinss,$valorirrf,$aliqinss

			if($valorinss > 0){ //soh mostra se tiver valor

				if($aliqinss > 0){
					echo "- Retenção de INSS ".DecToMoeda($aliqinss)."% com valor de R$ ".DecToMoeda($valorinss)." <br>";
				}else{
					echo "- Retenção de INSS com valor de R$ ".DecToMoeda($valorinss)." <br>";
				}
			}
			if($valorirrf > 0){ //soh mostra se tiver valor
				if($aliqirrf > 0){
					echo "- Retenção de IRRF ".DecToMoeda($aliqirrf)."% com valor de R$ ".DecToMoeda($valorirrf).""; if($deducao_irrf > 0){ echo ". Dedução de R$ ".DecToMoeda($deducao_irrf); }
					echo "<br>";
				}else{
					echo "- Retenção de IRRF com valor de R$ ".DecToMoeda($valorirrf).""; if($deducao_irrf > 0){ echo ". Dedução de R$ ".DecToMoeda($deducao_irrf); }
					echo "<br>";
				}
			} 
			if($cofins > 0){
				echo "- Confins R$ ".DecToMoeda($cofins)." <br>";
			}

			if($contribuicaosocial > 0){
				echo "- Contribuição Social R$ ".DecToMoeda($contribuicaosocial)." <br>";
			}

			
			if($total_retencao > 0){
				echo "- Total de retenções da nota R$ ".DecToMoeda($total_retencao)." <br>";
			}			
			?>
			</td>
		  </tr>  
          
		</table>
		<br /><br />
			<?php

	}
}//fim while	
	?>

</center>
</body>
</html>