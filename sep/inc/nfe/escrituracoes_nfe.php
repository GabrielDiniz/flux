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
<table border="0" cellspacing="0" cellpadding="0" >

	<tr>
		
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
							<td><input class="botao" value="Confirmar" name="btConfirmar" type="submit" onclick="return ValidaFormulario('txtNossoNumero|txtValorBoleto','Digite o Nosso Número e o Valor')"></td>
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
							<td align="center"><input name="btLer" type="submit" class="botao" value="Ler Arquivo"></td>
							<td align="right"></td>
						</tr>
					</table>
				</fieldset>
			</form>			
		</td>
		
	</tr>
	
</table>
