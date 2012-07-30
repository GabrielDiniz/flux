<table border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
		<td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Nfe - Relat&oacute;rio de Escritura&ccedil;&otilde;es</td>
		<td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
	</tr>
	<tr>
		<td width="18" background="img/form/lateralesq.jpg"></td>
		<td align="left">
		
			<form method="post" name="frmRelEscrituracoes" id="frmRelEscrituracoes" onSubmit="return false">
			<fieldset><legend>Filtro</legend>
			<table width="100%">
				<tr>
					<td width="22%" align="left">Nome do Arquivo: </td>
					<td width="78%" align="left"><input name="txtNomeArquivo" type="text" class="texto" /></td>
				</tr>
				<tr>
					<td align="left">Periodo: </td>
					<td align="left">
						<select name="cmbAno">
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
						<select name="cmbMes">
							<option value="">Selecione</option>
							<?php
								$meses = array("1"=>"Janeiro","Fevereiro","Mar&ccedil;o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro");
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
					<td align="left" colspan="2">
						<input name="btPesquisar" id="btPesquisar" type="submit" value="Pesquisar" class="botao" 
						onclick="acessoAjax('inc/guia/relatorio_escrituracoes_pesquisar.ajax.php','frmRelEscrituracoes','divResultado')">
						<input value="Limpar" type="reset" class="botao" />
					</td>
				</tr>
			</table>
			</fieldset>
			<div id="divResultado"></div>
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
