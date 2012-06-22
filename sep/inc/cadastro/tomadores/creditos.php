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
	//verifica se ha o valor de post do campo oculto do cadastro se houver atribui o valor do cnpjcpf
	if($_POST["hdCNPJCPF"]){
		$cnpjcpf = $_POST["hdCNPJCPF"];
	}//fim if
	if(!$cnpjcpf){
		$cnpjcpf = $_POST['txtCNPJCPF'];
	}
	
?>
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
  <tr>
    <td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
    <td width="800" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Tomadores - Cr&eacute;ditos</td>  
    <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
  </tr>
  <tr>
    <td width="18" background="img/form/lateralesq.jpg"></td>
    <td align="center">
			<fieldset><legend>Consulta de Cr&eacute;ditos</legend>
				<form method="post">	
					<input type="hidden" name="include" id="include" value="<?php echo  $_POST['include'];?>" />
					<table align="left" width="100%">
						<tr align="left">
							<td width="25%">CNPJ/CPF do Tomador<font color="#FF0000">*</font></td>
							<td><input type="text" class="texto" name="txtCNPJCPF" maxlength="18" onkeypress="return NumbersOnly( event );" onkeyup="CNPJCPFMsk( this );" value="<?php echo $cnpjcpf;?>" /></td>
						</tr>
						<tr align="left">
							<td width="25%"><input type="submit" class="botao" name="btConsultaCreditos" value="Consultar" /></td>
							<td>&nbsp;</td>
						</tr>
					</table>
				<?php
				//testa se o botao tem valor ou se veio um valor por post para a variavel cnpjcpf
				if(($_POST["btConsultaCreditos"] == "Consultar") || ($cnpjcpf != ""))
					{
						//testa se cnpjcpf continuar vazio recebe o valor do campo do form
						if($cnpjcpf == ""){
							$cnpjcpf = $_POST["txtCNPJCPF"];
						}//fim if
						$campo = tipoPessoa($cnpjcpf);
						//testa se o periodo estiver vazio pega o ano atual para teste
						if($periodo == ""){
							$periodo = date("Y");
						}//fim if
						//se o cnpjcpf continuar vazio mostra uma mensagem para o usuario pedindo que preencha o cnpjcpf
						if($cnpjcpf==""){
							Mensagem("Informe o CNPJ/CPF do tomador");
						}else{	
							//Soma os creditos do tomador sobre as nfe correspondente ao cnpjcpf informado
							$sql_credito_nfe = mysql_query("SELECT credito, nome FROM cadastro WHERE $campo='$cnpjcpf'");
							//verifica o nome deste mesmo tomador
							list($credito_nfe, $tomador) = mysql_fetch_array($sql_credito_nfe);
							if(mysql_num_rows($sql_credito_nfe)>0){?>
                                <table align="center" width="100%">
									<tr align="center" bgcolor="#999999">
										<td>CNPJ/CPF</td>
										<td>Nome do tomador</td>
										<td>Cr&eacute;dito</td>
									</tr>
									<tr align="center" bgcolor="#FFFFFF">
										<td width="180"><?php echo $cnpjcpf;?></td>
										<td><?php echo $tomador;?></td>
										<td width="125"><?php if($credito_nfe <= 0){ echo "Não possui cr&eacute;ditos"; }else{ echo "R$".DecToMoeda($credito_nfe); }?></td>
									</tr>
                                </table><?php 
							}else{
								//mensagem de erro ao tentar verificar um CNPJCPF que nao esteja cadastrado
								echo "<table width=\"100%\">
											<tr>
												<td align=\"center\">Este CNPJ/CPF n&atilde;o existe.</td>
											</tr>
										</table>
									";
							}//fim else
						}//fim else
					}//fim if
			?>
            </form>
		</fieldset>
	</td>
	<td width="19" background="img/form/lateraldir.jpg"></td>
  </tr>
  <tr>
    <td align="left" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantoesq.jpg" /></td>
    <td background="img/form/rodape_fundo.jpg"></td>
    <td align="right" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantodir.jpg" /></td>
  </tr>
</table>
