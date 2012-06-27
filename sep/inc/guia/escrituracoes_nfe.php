<?php
include 'inc/conect.php';
include 'arquivoretorno.php';

if ($_POST['btLer']) {
	if ($_FILES['fileArquivoRetorno']['name']){
		$resposta_retorno = ArquivoRetorno::lerTxtRetorno('fileArquivoRetorno');
		$notas = $resposta_retorno['notas'];
		Mensagem_onload("{$notas} notas escrituradas");
	} else {
		Mensagem_onload("Selecione um arquivo para retorno");
	}
}

if($_POST['btLerArquivoDAF607']){
	if($_FILES['fileArquivoRetornoDAF607']['name']){
		$ano = $_POST['cmbAnoDAF607'];
		$mes = $_POST['cmbMesDAF607'];
		
		if($mes < 10){
			$mes = "0".$mes;
		}
		$periodo = $ano.$mes;
		$resposta_retorno = ArquivoRetorno::lerTxtRetornoDAF607('fileArquivoRetornoDAF607',$periodo);
		if($resposta_retorno){
			$notas = $resposta_retorno['notas'];
			if($notas == 0){
				Mensagem_onload("Nenhuma nota escriturada");
			}else{
				Mensagem_onload("{$notas} nota(s) escriturada(s)");
			}
			
		}
	}else{
		Mensagem_onload("Selecione um arquivo para retorno");
	}
}

if ($_POST['btConfirmar']) {
	if ($_POST['txtNossoNumero'] || $_POST['txtValorBoleto']) {
		$notas = ArquivoRetorno::registrarPagamentoManual($_POST['txtNossoNumero'],$_POST['txtValorBoleto']);
		if ($notas) {
			Mensagem_onload("{$notas} notas escrituradas");
		} else {
			Mensagem_onload("Verifique o Nosso Número e o Valor");
		}
	} else {
		Mensagem_onload("Digite o Nosso Número e o Valor");
	}
}
?>
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
	<tr>
		<td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
		<td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Nfe - Escritura&ccedil;&otilde;es</td>
		<td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
	</tr>
	<tr>
		<td width="18" background="img/form/lateralesq.jpg"></td>
		<td align="left">
		
			<form method="post" enctype="multipart/form-data">
				<input name="include" type="hidden" id="include" value="<?php echo $_POST['include'];?>">
				<fieldset><legend>Pagamento Manual</legend>
					<table width="100%">
						<tr>
							<td width="120">Nosso Número<font color="#FF0000">*</font></td>
							<td><input class="texto" size="30" name="txtNossoNumero" id="txtNossoNumero" type="text" /></td>
						</tr>
						<tr>	
							<td>Valor<font color="#FF0000">*</font></td>

							<td><input class="texto" onkeyup="MaskMoeda(this)" size="20" name="txtValorBoleto" id="txtValorBoleto" type="text" /></td>
						</tr>
						<tr>
							<td align="left"><input class="botao" value="Confirmar" name="btConfirmar" type="submit" onclick="return ValidaFormulario('txtNossoNumero|txtValorBoleto','Digite o Nosso Número e o Valor')"></td>
							<td align="right"><font color="#FF0000">*</font>Campos obrigatórios</td>
						</tr>
					</table>
				</fieldset>
				<fieldset><legend>Leitura do arquivo</legend>
					<table width="100%">
						<tr>
							<td align="left" width="120">Arquivo de retorno:</td>
							<td align="left"><input name="fileArquivoRetorno" type="file" class="botao"></td>
						</tr>
						<tr>
							<td align="left" colspan="2"><input name="btLer" type="submit" class="botao" value="Ler Arquivo"></td>
						</tr>
					</table>
				</fieldset>
				<fieldset><legend>Leitura do arquivo DAF607</legend>
					<table width="100%">
						<tr>
							<td align="left" width="120">Selecione o periodo:</td>
							<td align="left">
								<select name="cmbAnoDAF607" id="cmbAnoDAF607">
									<option value="">Selecione</option>
									<?php
										$anoAtual = date("Y");
										$cont = 0;
										while($cont < 5){
										?>
											<option value="<?php echo $anoAtual - $cont;?>"><?php echo $anoAtual - $cont;?></option>
										<?php
											$cont++;
										}
									?>
								</select>
								<select name="cmbMesDAF607" id="cmbMesDAF607">
									<option value="">Selecione</option>
									<?php
										$meses = array("1"=>"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro");
										$cont = 1;
										while($cont <= 12){
										?>
											<option value="<?php echo $cont;?>"><?php echo $meses[$cont];?></option>
										<?php
											$cont++;
										}
									?>
								</select>
							</td>
						</tr>
						<tr>
							<td align="left" width="120">Arquivo de retorno:</td>
							<td align="left"><input name="fileArquivoRetornoDAF607" id="fileArquivoRetornoDAF607" type="file" class="botao"></td>
						</tr>
						<tr>
							<td align="left" colspan="2">
								<input name="btLerArquivoDAF607" type="submit" class="botao" value="Ler Arquivo DAF607" 
								onclick="return ValidaFormulario('cmbAnoDAF607|cmbMesDAF607|fileArquivoRetornoDAF607','Selecione o periodo e arquivo a ser lido!')">
							</td>
						</tr>
					</table>
				</fieldset>
			</form>			
		</td>
		<td width="19" background="img/form/lateraldir.jpg"></td>
	</tr>
	<tr>
		<td align="left" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantoesq.jpg" /></td>
		<td background="img/form/rodape_fundo.jpg"></td>
		<td align="right" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantodir.jpg" /></td>
	</tr>
</table>
