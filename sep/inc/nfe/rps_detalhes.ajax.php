<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	$codRPS = $_GET['codRPS'];
?>
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
	<tr>
		<td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
		<td background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;NFe - RPS</td>
		<td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg" onclick="document.getElementById('divDetalhesRPS').style.display='none'">
			<img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" />
		</td>
	</tr>
	<tr>
		<td width="18" background="img/form/lateralesq.jpg"></td>
		<td align="left" style="border:1px solid #000000">
			
			<?php
			
			
			$sql_detalhes = mysql_query("
				SELECT 
					cadastro.codigo AS codCadastro,
					cadastro.nome,
					cadastro.razaosocial,
					cadastro.logradouro,
					cadastro.numero,
					cadastro.cnpj,
					cadastro.cpf,
					rps_solicitacoes.codigo AS codSolicitacao,
					rps_solicitacoes.data, 
					rps_solicitacoes.estado,
					rps_controle.ultimorps,
					rps_controle.limite
				FROM 
					rps_solicitacoes
				INNER JOIN
					cadastro ON rps_solicitacoes.codcadastro = cadastro.codigo
				LEFT JOIN
					rps_controle ON cadastro.codigo = rps_controle.codcadastro
				WHERE 
					rps_solicitacoes.codigo = '$codRPS'
			");
			$dados_RPS = mysql_fetch_object($sql_detalhes);
			$cnpjcpf = $dados_RPS->cnpj.$dados_RPS->cpf;
			
			if(!$dados_RPS->razaosocial){
				$dados_RPS->razaosocial = $dados_RPS->nome; 
			}
			
			if($dados_RPS->ultimorps < 1){
				$dados_RPS->ultimorps = 0;
			}
			
			if($dados_RPS->limite < 1){
				$dados_RPS->limite = 0;
			}
			?>
			<table width="100%" cellpadding="5">
				<tr bgcolor="#FFFFFF">
					<td align="right">Razão Social: </td>
					<td align="left" colspan="3"><?php echo $dados_RPS->razaosocial;?></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td align="right">CNPJ: </td>
					<td align="left" colspan="3"><?php echo $cnpjcpf;?></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td align="right">Logradouro: </td>
					<td align="left"><?php echo $dados_RPS->logradouro;?></td>
					<td align="right">Número: </td>
					<td align="left"><?php echo $dados_RPS->numero;?></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td align="right">Ultimo RPS: </td>
					<td align="left"><?php echo $dados_RPS->ultimorps;?></td>
					<td align="right">Limite: </td>
					<td align="left">
						<input name="txtLimite" id="txtLimite" type="text" class="texto" value="<?php echo $dados_RPS->limite;?>" size="4" maxlength="6" 
						title="Digite o novo limite de RPS" />
						<input type="hidden" name="hdLimite" id="hdLimite" value="<?php echo $dados_RPS->limite;?>" />
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td align="left" colspan="4">
						<input name="btLiberar" type="button" class="botao" value="Liberar" 
						onclick="liberaRPS('inc/nfe/rps_liberar_recusar.ajax.php?tipo=L&codigo=<?php echo $dados_RPS->codSolicitacao;?>','txtLimite','hdLimite','spanRetorno')" />
						&nbsp;
						<input name="btCancelar" type="button" class="botao" value="Cancelar" onclick="document.getElementById('divDetalhesRPS').style.display='none'"/>
						<span id="spanRetorno"></span>
					</td>
				</tr>		
			</table>
	
		</td>
		<td width="19" background="img/form/lateraldir.jpg"></td>
	</tr>
	<tr>
		<td align="left" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantoesq.jpg" /></td>
		<td background="img/form/rodape_fundo.jpg"></td>
		<td align="right" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantodir.jpg" /></td>
	</tr>
</table>
