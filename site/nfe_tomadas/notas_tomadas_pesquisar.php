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
	if($_POST['btCancelar'] == "Cancelar"){
		$codNotaTomada = $_POST['hdCodNotaTomada'];
		$mensagem      = $_POST['txtMotivoCancelar'];
		mysql_query("UPDATE notas_tomadas SET estado = 'C', motivo_cancelamento = '$mensagem' WHERE codigo = '$codNotaTomada'");
		Mensagem_onload("Nota cancelada");
	}
	
	
	$codLogado = $CODIGO_DA_EMPRESA;
	$sql_dados_logado = mysql_query("SELECT codtipo, razaosocial, cnpj, cpf FROM cadastro WHERE codigo = '$codLogado'");
	$logado = mysql_fetch_object($sql_dados_logado);
	$cnpjcpf = $logado->cnpj.$logado->cpf;
	$codTipoContador = codtipo('contador');
?>
<form action="notas_tomadas.php" id="frmPesquisaNotaTomada" method="post">
	<input type="hidden" name="hdCodLogado" id="hdCodLogado" value="<?php echo $codLogado;?>" />
	<input type="hidden" name="btPesquisar" value="<?php echo $_POST['btPesquisar'];?>" />
	<table border="0" align="center" cellpadding="0" cellspacing="1">
		<tr>
			<td width="10" height="10" bgcolor="#FFFFFF"></td>
			<td width="160" align="center" bgcolor="#FFFFFF" rowspan="3">Pesquisar Nota Tomada</td>
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
			<td height="60" colspan="3" bgcolor="#CCCCCC">

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
						<td width="14%" align="left">CNPJ: </td>
						<td align="left" colspan="3"><input name="txtCNPJ" type="text" class="texto" size="20" /></td>
					</tr>
					<tr>
						<td align="left">N° da Nota: </td>
						<td width="24%" align="left"><input name="txtNumeroNota" type="text" class="texto" size="10" /></td>
						<td width="19%" align="left">Cód. Verificação: </td>
						<td width="43%" align="left"><input name="txtCodVerificacao" type="text" class="texto" size="10" /></td>
					</tr>
					<tr>
						<td align="left">Data Inicial: </td>
						<td align="left"><input name="txtDataIni" type="text" class="texto" size="12" /></td>
						<td align="left">Data Final: </td>
						<td align="left"><input name="txtDataFim" type="text" class="texto" size="12" /></td>
					</tr>
					<tr>
						<td align="left" colspan="4">
							<input name="btBuscar" type="button" class="botao" value="Buscar" 
							onClick="acessoAjax('../site/nfe_tomadas/notas_tomadas_lista.ajax.php','frmPesquisaNotaTomada','divPesquisaNotaTomada')" />
							&nbsp;
							<input type="reset" value="Limpar" class="botao" />
						</td>
					</tr>
				</table>

			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="#CCCCCC"></td>
		</tr>
	</table>
	<div id="divPesquisaNotaTomada"></div>
</form>
