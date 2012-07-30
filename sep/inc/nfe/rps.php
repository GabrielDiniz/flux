<table border="0" cellspacing="0" cellpadding="0" >
	
	<tr>
		
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
		
	</tr>
	
</table>
