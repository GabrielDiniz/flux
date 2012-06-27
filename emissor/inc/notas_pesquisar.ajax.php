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
include("conect.php");
include("../../funcoes/util.php");	
	$CODIGO_DA_EMPRESA=$_GET['hdcodempresa'];	
	$numero = $_GET['txtNumeroNota'];
	$codverificacao = $_GET['txtCodigoVerificacao'];
	$tomador_cnpjcpf = $_GET['txtTomadorCPF'];
	$tomador_nome = $_GET['txtTomadorNome'];

	if($numero){
		$string = " AND `notas`.`numero` = '$numero' ";
	}
	if($tomador_cnpjcpf){
		$string .= " AND `notas`.`tomador_cnpjcpf` = '$tomador_cnpjcpf' ";
	}
	if($tomador_nome){
		$string .= " AND `notas`.`tomador_nome` LIKE '%$tomador_nome%' ";
	}
	$query=("
SELECT
  `notas`.`codigo`, `notas`.`numero`, `notas`.`codverificacao`,
  `notas`.`datahoraemissao`, `notas`.`codemissor`, `notas`.`tomador_nome`,
  `notas`.`tomador_cnpjcpf`, `notas`.`estado`, notas.codtomador
FROM
  `notas`
WHERE
  `notas`.`codemissor` = '$CODIGO_DA_EMPRESA' AND
   `notas`.`codverificacao` LIKE '$codverificacao%'  
   $string
   ORDER BY notas.codigo DESC
	"); // fim sql
	
	
?>

<table border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
		<td width="10" height="10" bgcolor="#FFFFFF"></td>
		<td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Resultado de Pesquisa</td>
		<td width="400" bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#CCCCCC"></td>
		<td bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
		<td height="10" bgcolor="#FFFFFF"></td>
		<td bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td colspan="3" height="1" bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
		<td height="60" colspan="3" bgcolor="#CCCCCC">
			<?php $sql = Paginacao($query,'frmPesquisar','Container',10);?>
			<table width="100%" border="0" cellspacing="2" cellpadding="2">
				<?php
					if(mysql_num_rows($sql)>0){
				?>
				<tr>
					<td width="5%" align="center">N&ordm;</td>
					<td width="13%" align="center">C&oacute;d Verif</td>
					<td width="19%" align="center">D/H Emiss&atilde;o</td>
					<td width="36%" align="center">Tomador Nome </td>
					<td width="10%" align="center">Estado</td>
					<td width="10%" align="center">
                    	<input type="button" name="btImprimir" id="btImprimir" class="botao" value="Imprimir seleção" onclick="document.getElementById('frmPesquisar').action='../site/imprimirnotas.php';document.getElementById('frmPesquisar').target='_blank';submit();" />
                    </td>
				</tr>
				<tr>
					<td colspan="7" height="1" bgcolor="#999999"></td>
				</tr>
				<?php	
					$x = 0;
					while(list($codigo, $numero, $codverificacao, $datahoraemissao, $codempresa, $tomador_nome, $tomador_cnpjcpf, $estado, $codtomador) = mysql_fetch_array($sql)) {
					
					if($codtomador){
						$sql_tomador = mysql_query("SELECT nome, razaosocial FROM cadastro WHERE codigo = '$codtomador'");
						list($tomador_nome,$tomador_razaosocial) = mysql_fetch_array($sql_tomador);
						if(!$tomador_nome){
							$tomador_nome = $tomador_razaosocial;
						}
					}
					// mascara o codigo com cripto base64 
					$crypto = base64_encode($codigo);
					 
					if($estado == "C"){
						$bgcolor = "#FFB895";
					}else{
						$bgcolor = "#FFFFFF";
					}
				?>
				<tr>
					<td align="center" bgcolor="<?php echo $bgcolor;?>"><?php echo $numero; ?></td>
					<td align="center" bgcolor="<?php echo $bgcolor;?>"><?php echo $codverificacao;  ?></td>
					<td align="center" bgcolor="<?php echo $bgcolor;?>"><?php echo substr($datahoraemissao,8,2)."/".substr($datahoraemissao,5,2)."/".substr($datahoraemissao,0,4); ?></td>
					<td bgcolor="<?php echo $bgcolor;?>"><?php echo $tomador_nome; ?></td>
					<td bgcolor="<?php echo $bgcolor;?>">
					<?php 
						switch ($estado) { 
							case "C": echo "Cancelado"; break;
							case "N": echo "Normal"; break;
							case "B": echo "Boleto Gerado"; break;
							case "E": echo "Escriturada"; break;
						} 
					?>
					</td>
					<td bgcolor="#FFFFFF" colspan="2">
						<input type="checkbox" name="ckbNota<?php echo $x; ?>" id="cbkNota<?php echo $x; ?>" value="<?php echo $codigo;?>" />
						<input type="button" class="botao" value="" id="btEnviarEmail" 
							onclick="document.getElementById('txtNotaEmail').value='<?php echo $codigo; ?>';
							document.getElementById('frmEnviarEmail').submit();"
							alt="Notificar tomador por e-mail" title="Notificar tomador por e-mail" /> 
						
						<?php
						
						$dtemissao = substr($datahoraemissao,0,10);
						$dtatual = date("Y-m-d");					
						
						$res = diasDecorridos($dtemissao,$dtatual,'=D');
						
						

						
						if (($estado != "C")&&($res<=7)){
						?>
							<input name="btCanc" type="button" class="botao" value="" id="btX" 
							onclick="VisualizarNovaLinha('<?php echo $codigo;?>','<?php echo"tdnfe".$x;?>',this,'inc/notas_motivo_cancelar.php')" title="Cancelar nota"/>
						<?php 
						}
						?>
					</td>
				</tr>
				<tr>
					<td colspan="7" id="<?php echo"tdnfe".$x; ?>" height="1" bgcolor="#999999"></td>
				</tr>
				<?php
					$x++;
				} // fim while 
			}else{
				echo "
						<tr>
							<td>N&atilde;o h&aacute; nenhuma nota!</td>
						</tr>
					";
			}
		?>
        	<input type="hidden" id="hdNota" name="hdNota" value="<?php echo $x; ?>">
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="#CCCCCC"></td>
	</tr>
</table>
