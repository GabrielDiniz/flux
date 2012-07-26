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
if($_GET['d']){
	include 'regras_credito.php';
	exit;
}
if($_POST["btBoleto"] == "Boleto"){
	include 'inc/utilitarios/boleto.php';
}else{
	if($_POST["btAtualizar"] == "Atualizar"){
		include("inc/utilitarios/configuracoes_editar.php");
	}//fim if
	//pega as configuracoes da tabela
	$sql_configuracoes = mysql_query("SELECT codigo, endereco, cidade, estado, cnpj, email, secretaria, secretario, chefetributos, lei, decreto, topo_nfe, logo_nfe, brasao_nfe, codlayout, taxacorrecao, taxamulta, taxajuros, data_tributacao, declaracoes_atrazadas, gerar_guia_site FROM configuracoes");
	list($codigo,$endereco,$cidade,$estado,$cnpj,$email,$secretaria,$secretario,$chefetributos,$lei,$decreto,$topo,$logo,$brasao,$layout,$taxacorrecao,$taxamulta,$taxajuros,$data_tributacao,$declaracoes_atrazadas,$gerar_guia_site) = mysql_fetch_array($sql_configuracoes);
?>
<table border="0" cellspacing="0" cellpadding="0">
 
  <tr>
   
    <td align="center">
		<form method="post" id="frmConfiguracoes" enctype="multipart/form-data">
			<input name="include" id="include" type="hidden" value="<?php echo $_POST["include"];?>" />
			<fieldset><legend>Configurações</legend>
				<table width="100%">
					<tr align="left">
						<td align="left"><label for="txtEndereco">Endereço:</label></td>
						<td><input name="txtEndereco" id="txtEndereco" type="text" class="texto" value="<?php echo $endereco;?>" ></td>
						<td><label for="txtCidade">Cidade: </label></td>
						<td colspan="2">
							<div  id="divInsMunicipioEmpresa">
								<select name="txtInsMunicipioEmpresa" id="txtInsMunicipioEmpresa" class="combo">
									<?php
										$sql_municipio = mysql_query("SELECT codigo, nome FROM municipios WHERE uf = '$estado' ORDER BY nome");
										while(list($codMunicipio_bd,$nome_municipio) = mysql_fetch_array($sql_municipio)){
											echo "<option value=\"$nome_municipio\"";if( (strtolower($nome_municipio) == strtolower($cidade)) ){ echo "selected=selected";} echo ">$nome_municipio</option>";
										}//fim while
									?>
								</select>
							</div>
						</td>
					</tr>
					<tr align="left">
						<td><label for="txtUF">UF:</label></td>
						<td>
							<select name="txtInsUfEmpresa" id="txtInsUfEmpresa" onchange="buscaCidadesConfiguracao(this,'divInsMunicipioEmpresa')">
								<?php
									$sql=mysql_query("SELECT uf FROM municipios GROUP BY uf ORDER BY uf");
									while(list($uf_busca)=mysql_fetch_array($sql)){
										echo "<option value=\"$uf_busca\"";if($uf_busca == $estado){ echo "selected=selected"; }echo ">$uf_busca</option>";
									}
								?>
							</select>
						</td>
						<td><label for="txtChefe">Chefe de tributos:</label></td>
						<td colspan="2"><input name="txtChefe" id="txtChefe" type="text" class="texto" value="<?php echo $chefetributos;?>" ></td>
					</tr>
					<tr align="left">
						<td><label for="txtCNPJ">CNPJ: </label></td>
						<td><input name="txtCNPJ" id="txtCNPJ" type="text" class="texto" value="<?php echo $cnpj;?>" ></td>
						<td><label for="txtEmail">E-mail:</label></td>
						<td colspan="2"><input name="txtEmail" id="txtEmail" type="text" class="texto" value="<?php echo $email;?>" ></td>
					</tr>
					<tr align="left">
						<td><label for="txtLei">Lei:</label></td>
						<td><input name="txtLei" id="txtLei" type="text" class="texto" value="<?php echo $lei;?>" ></td>
						<td><label for="txtDecreto">Decreto:</label></td>
						<td colspan="2"><input name="txtDecreto" id="txtDecreto" size="10" type="text" class="texto" value="<?php echo $decreto;?>" ></td>
					</tr>
					<tr align="left">
						<td><label for="txtSecretaria">Secretaria:</label></td>
						<td><input name="txtSecretaria" id="txtSecretaria" type="text" class="texto" value="<?php echo $secretaria;?>" ></td>
						<td><label for="txtSecretario">Secretário:</label></td>
						<td colspan="2"><input name="txtSecretario" id="txtSecretario" type="text" class="texto" value="<?php echo $secretario;?>" ></td>
					</tr>
					
					<tr align="left">
						
						<td><label for="txtData">Dia tributação:</label></td>
						<td colspan="4">
							<input name="txtData" id="txtData" maxlength="2" size="3" type="text"  class="texto" value="<?php echo $data_tributacao;?>" />
							<label><input name="ckbData" type="checkbox" id="ckbData" onclick="DesabilitarDataTributo()" />Último dia do mês</label>
						</td>
					</tr>
					<tr align="left">
						<td><label for="flBrasao">Brasão</label></td>
						<td><input name="flBrasao" id="flBrasao" type="file" class="texto" ></td>
						<td>
							<label>Gerar guia para declarações pelo site</label>
						</td>
						<td>
							<label><input type="radio" name="rbGuias" id="rbGuiasS" value="t" <?php if($gerar_guia_site=='t'){echo 'checked="checked"';}?> /> Todas</label>
							<label><input type="radio" name="rbGuias" id="rbGuiasN" value="i" <?php if($gerar_guia_site=='i'){echo 'checked="checked"';}?> /> Individual</label>
						</td>
					</tr>
					<tr align="left">
						<td></td>
						<td></td>
						<td><label>Permitir Declarações atrasadas pelo site:</label></td>
						<td width="151">
							<label><input type="radio" name="rbDec" id="rbDecS" value="s" <?php if($declaracoes_atrazadas=='s'){echo 'checked="checked"';}?> /> Sim</label>
							<label><input type="radio" name="rbDec" id="rbDecN" value="n" <?php if($declaracoes_atrazadas=='n'){echo 'checked="checked"';}?> /> N&atilde;o</label>
						</td>
					</tr>
					<!--
					<tr>
						<td style="visibility:hidden">Tipo de serviço: </td>
						<td style="visibility:hidden"><label><input name="rbTipoServico" value="CNAE" type="radio" /> CNAE</label></td>
						<td width="139" style="visibility:hidden">
							<label><input name="rbTipoServico" value="LC 116" type="radio" /> LC 116</label>
						</td>
					</tr>
					-->
					<tr>
						<td colspan="4" align="left"><strong>Brasão atual: </strong>
					</td>
					<tr>
						<td align="left" colspan="4">
							<?php
							if($brasao){
							?>
								<img src="img/brasoes/<?php echo $brasao;?>" width="100" height="100" />
							<?php
							}else{
								echo "<font color=\"#FF0000\"><strong>A prefeitura não possui brasão</strong></font>";
							}
							?>
						</td>
					</tr>
					<tr align="left">
						<td colspan="5">
							<input name="btAtualizar" type="submit" class="botao" value="Atualizar">
							<input name="btBoleto" type="submit" class="botao" value="Boleto" />
						</td>
					</tr>
				</table>
				<div id="teste"></div>
			</fieldset>
		</form>
		</td>
	
  </tr>
  
</table>
<?php 
}
?>

