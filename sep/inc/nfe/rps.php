<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
	<tr>
		<td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
		<td width="750" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;NFe - RPS</td>
		<td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg">
			<a href="">
				<img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" />
			</a>
		</td>
	</tr>
	<tr>
		<td width="18" background="img/form/lateralesq.jpg"></td>
		<td align="left">
			
			<form method="post" id="frmRPS" onSubmit="return false">
				<fieldset><legend>Filtro</legend>
					<table width="100%">
						<tr>
							<td width="11%" align="right">CNPJ: </td>
							<td width="89%" align="left"><input name="txtCNPJ" type="text" class="texto" /></td>
						</tr>
						<tr>
							<td align="right">Número: </td>
							<td align="left"><input name="txtNumero" type="text" class="texto" /></td>
						</tr>
						<tr>
							<td align="right">Estado: </td>
							<td align="left">
								<select name="cmbEstado">
									<option value="">Todos</option>
									<option value="A">Aguardando</option>
									<option value="L">Liberado</option>
									<option value="R">Recusado</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="left" colspan="2">
								<input name="btBuscar" id="btBuscar" type="submit" class="botao" value="Buscar" 
								onClick="acessoAjax('inc/nfe/rps_lista.ajax.php','frmRPS','divLista')" />
								&nbsp;
								<input type="reset" class="botao" value="Limpar" />
							</td>
						</tr>
					</table>
				</fieldset>
				<div id="divLista"></div>
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
