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
	if($_POST['btDeclarar'] == "Declarar"){
		$numeroNota     = $_POST['txtNumero'];
		$codVerificacao = strtoupper($_POST['txtCodVerificacao']);
		$data           = DataMysql($_POST['txtData']);
		$cnpj           = $_POST['txtCNPJ'];
		$valorLiquido   = MoedaToDec($_POST['txtValorTotal']);
		$totalISS       = MoedaToDec($_POST['txtTotalISS']);
		$totalISSRetido = MoedaToDec($_POST['txtTotalISSRetido']);
		$sql_busca_codprestador = mysql_query("SELECT codigo FROM cadastro WHERE (cnpj = '$cnpj' OR cpf = '$cnpj')");
		list($codPrestador) = mysql_fetch_array($sql_busca_codprestador);
		if(isset($_POST['cmbEmpresa'])){
			$codTomador = $_POST['cmbEmpresa'];
		}else{
			$codTomador = $_POST['hdCodLogado'];
		}
					
		$sql_verifica_duplicidade = mysql_query("
			SELECT 
				codigo 
			FROM 
				notas_tomadas 
			WHERE 
				codtomador = '$codTomador' AND numero = '$numeroNota' AND codprestador = '$codPrestador' AND estado = 'N'
		");
		if(mysql_num_rows($sql_verifica_duplicidade)){
		
			Mensagem_onload("Esta nota tomada, já foi declarada. Para redeclarar cancele a anterior!");
			
		}else{
			
			mysql_query("
				INSERT INTO 
					notas_tomadas 
				SET 
					numero = '$numeroNota',
					codtomador = '$codTomador',
					codprestador = '$codPrestador', 
					data = '$data', 
					codverificacao = '$codVerificacao',
					total = '$valorLiquido',
					iss = '$totalISS',
					issretido = '$totalISSRetido',
					estado = 'N'
			");
			$ultimaNotaTomada = mysql_insert_id();
			
			$hdInputs = $_POST['hdInputs'];
			$cont = 0;
			while($cont < $hdInputs){
				$aux           = explode("|", $_POST['cmbCodServico'.$cont]);
				$servico       = $aux[1];
				$baseCalc      = MoedaToDec($_POST['txtBaseCalcServico'.$cont]);
				$iss           = MoedaToDec($_POST['txtValorIssServico'.$cont]);
				$issRetido     = MoedaToDec($_POST['txtISSRetidoManual'.$cont]);
				$discriminacao = $_POST['txtDiscriminacaoServico'.$cont];
				
				if(($baseCalc > 0) && ($servico > 0)){
					mysql_query("
						INSERT INTO 
							notas_tomadas_servicos 
						SET 
							codnota_tomada = '$ultimaNotaTomada',
							codservico = '$servico',
							basecalculo = '$baseCalc',
							iss = '$iss',
							issretido = '$issRetido',
							discriminacao = '$discriminacao'
					");
				}
				$cont++;
			}
			Mensagem_onload("Declaração de nota tomada realizada com sucesso!");
			
		}
	}
	
	$codLogado = $CODIGO_DA_EMPRESA;
	$sql_dados_logado = mysql_query("SELECT codtipo, razaosocial, cnpj, cpf FROM cadastro WHERE codigo = '$codLogado'");
	$logado = mysql_fetch_object($sql_dados_logado);
	$cnpjcpf = $logado->cnpj.$logado->cpf;
	$codTipoContador = codtipo('contador');
?>
<form action="notas_tomadas.php" method="post">
	<input type="hidden" name="btDeclararNotaTomada" value="<?php echo $_POST['btDeclararNotaTomada'];?>" />
	<input type="hidden" name="hdCodLogado" id="hdCodLogado" value="<?php echo $codLogado;?>" />
	<input type="hidden" name="hdCNPJ" id="hdCNPJ" value="">
	<table border="0" align="center" cellpadding="0" cellspacing="1">
		<tr>
			<td width="10" height="10" bgcolor="#FFFFFF"></td>
			<td width="160" align="center" bgcolor="#FFFFFF" rowspan="3">Declarar Notas Tomadas</td>
			<td width="450" bgcolor="#FFFFFF"></td>
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
			<td height="60" colspan="3" bgcolor="#CCCCCC" style="border:1px solid #666">
			
				<table width="100%">
					<?php
					if($codTipoContador == $logado->codtipo){
					?>
					<tr>
						<td align="left" colspan="4">Selecione o emissor: 
							<select name="cmbEmpresa" class="combo" style="width:270px;">
								<option value="<?php echo $codLogado;?>"><?php echo "(próprio)".$logado->razaosocial." - ".$cnpjcpf;?></option>
								<?php
								$sql_lista_empresas = mysql_query("SELECT codigo, razaosocial, cnpj, cpf FROM cadastro WHERE codcontador = '$codLogado'");
								while($listaEmpresa = mysql_fetch_object($sql_lista_empresas)){
									$cnpjcpf = $listaEmpresa->cnpj.$listaEmpresa->cpf;
									echo "<option value=\"{$listaEmpresa->codigo}\">{$listaEmpresa->razaosocial} - {$cnpjcpf}</option>";
								}
								?>
							</select>
						</td>
					</tr>
					<?php
					}
					?>
					<tr>
						<td width="13%" align="left">N&deg; da nota: </td>
						<td width="32%" align="left"><font color="#FF0000">*</font> <input name="txtNumero" id="txtNumero" type="text" class="texto" size="10" /></td>
						<td width="19%" align="left">C&oacute;d. Verifica&ccedil;&atilde;o: </td>
						<td width="36%" align="left"><font color="#FF0000">*</font> 
							<input name="txtCodVerificacao" id="txtCodVerificacao" type="text" class="texto" size="12" style="text-transform:uppercase" 
							maxlength="9" />
						</td>
					</tr>
					<tr>
						<td align="left">Data: </td>
						<td align="left" colspan="3"><font color="#FF0000">*</font> <input name="txtData" id="txtData" type="text" class="texto" size="12" /></td>
					</tr>
					<tr>
						<td align="left">CNPJ: </td>
						<td align="left" colspan="3"><font color="#FF0000">*</font>
							<input name="txtCNPJ" id="txtCNPJ" type="text" class="texto" size="20" onBlur="buscaInfoPrestador(this)" />&nbsp;<span id="erroPrestador"></span>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="left">
							<div id="divPrestador" style="width:100%;"></div>
						</td>
					</tr>
					<tr>
						<td align="left">
							<input name="btDeclarar" type="submit" class="botao" value="Declarar" 
							onClick="return (ValidaFormulario('txtNumero|txtCodVerificacao|txtData|hdCNPJ','Preencha os campos obrigátorios corretamente!') && confirm('Deseja declarar esta nota tomada?'))" />
						</td>
						<td align="right" colspan="3"><font color="#FF0000">*</font>Preencha os campos obrigátorios</td>
					</tr>
				</table>
			
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="#CCCCCC"></td>
		</tr>
	</table>
</form>
