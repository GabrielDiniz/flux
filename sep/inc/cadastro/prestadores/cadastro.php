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
$sql_municipio=mysql_query("SELECT cidade, estado FROM configuracoes");
$dados_municipio=mysql_fetch_array($sql_municipio);

//Verifica se foi inserido alguma empresa nova, se for vai para o arquivo de inser��o
 if(($_POST['btCadastrar'] =="Salvar")&&($_POST['hdAtualizar'] ==''))
 {   
   include("inserir.php");
 }
 if(($_POST['btCadastrar'] =="Salvar")&&($_POST['hdAtualizar']=='sim'))
 { 
 	include("editar.php"); 
 }
 if($_POST['btGerar'] == "Gerar senha"){
 	include("gera_senha.php");
 }
 if($_POST["btExcluir"]){
 	$CODIGO = $_POST['CODEMISSOR'];
	mysql_query("UPDATE cadastro SET estado = 'I' WHERE codigo = '$CODIGO'");
	add_logs('Desativou um Prestador');
	Mensagem("Prestador desativado");
 }
?>
<script>
	function verificaRPA(obj,retorno){
		var nrocaracteres = obj.value.length;
		var elem = document.getElementById('cmbTipoDec');
		if(nrocaracteres == 14){
			document.getElementById('Simples Nacional').style.display = 'none';
			if(elem.options[elem.selectedIndex].value == "<?php echo codtipodeclaracao('Simples Nacional')?>"){
				elem.value = "";
			}
		}else{
			document.getElementById('Simples Nacional').style.display = 'block';
		}
	}
</script>
<!-- Formul�rio de inser��o de empresa  -->
<style type="text/css">
<!--
#divBusca {
	position:absolute;
	left:30%;
	top:20%;
	width:298px;
	height:276px;
	z-index:1;
 visibility:<?php if(isset($btBuscarCliente)) { echo"visible"; }else{ echo"hidden"; }?>
}

/*Faz com que todos os inputs de texto so mostrem letras maiusculas*/
input[type*="text"]{
	text-transform:uppercase;
}
-->
</style>
<div id="divBusca"  >
	<?php include("inc/cadastro/prestadores/busca.php"); ?>
</div>
<?php	
	if(($_POST['CODEMISSOR'])){		   
		$codigo=$_POST['CODEMISSOR'];	
		$sql=mysql_query("
						SELECT 
							codigo,
							codtipo,
							codtipodeclaracao,
							nome, 
							razaosocial,
							IF(cnpj <> '',cnpj,cpf) AS cnpjcpf,
							inscrmunicipal,
							inscrestadual,
							logradouro,
							numero, 
							complemento,
							bairro,
							fonecomercial,
							fonecelular,
							cep,
							municipio, 
							uf, 
							logo,
							email,
							ultimanota, 						
							notalimite,						
							estado, 
							codcontador,
							nfe,
							pispasep,
							datafim,
							datainicio,
                            isentoiss
						FROM 
							cadastro 					
						WHERE
							codigo='$codigo'
						");
		list($codigo,$codtipo,$codtipodec,$nome,$razaosocial,$cnpjcpf,$inscrmunicipal,$inscricaoestadual, $logradouro,$numero,$complemento,$bairro,$fone,$celular,$cep,$municipio,$uf,$logo,$email,$ultima,$notalimite,$estado,$codcontador,$nfe,$pispasep,$datafim,$datainicio,$isentoiss)= mysql_fetch_array($sql);
		
		// verifica se o prestador é simples nacional
		$simples = coddeclaracao("Simples Nacional");
		if($simples == $codtipodec){
			$simples = true;
		}else{
			$simples = false;
		}
		
		//Busca os dados adcionais da tabela
		$codcargo_gerente = codcargo('Gerente');
		$codcargo_diretor = codcargo('Diretor');
		$sql_resp = mysql_query("SELECT nome, cpf FROM cadastro_resp WHERE codemissor = '$codigo' AND 
		(codcargo = '$codcargo_gerente' OR codcargo = '$codcargo_diretor')");
		list($nome_responsavel,$cpf_responsavel) = mysql_fetch_array($sql_resp);
		
		
		//Busca as informa��es que s�o extra para cada tipo de prestador
		$sql_info_instituicoes = mysql_query("SELECT agencia, codbanco FROM inst_financeiras WHERE codcadastro = '$codigo'");
		list($agencia_inst,$codbanco_inst) = mysql_fetch_array($sql_info_instituicoes);
		
		$sql_info_operadoras = mysql_query("SELECT agencia, codbanco FROM operadoras_creditos WHERE codcadastro = '$codigo'");
		list($agencia_opr,$codbanco_opr) = mysql_fetch_array($sql_info_operadoras);
		
		$sql_info_cartorios = mysql_query("SELECT admpublica, nivel FROM cartorios WHERE codcadastro = '$codigo'");
		list($admpublica_cart,$nivel_cart) = mysql_fetch_array($sql_info_cartorios);
		
	}

?>
<table border="0" cellspacing="0" cellpadding="0" class="form">
	
	<tr>
	
	
	<td align="center">
	
	<form  method="post" name="frmCadastroEmpresa" id="frmCadastroEmpresa">
		<input type="hidden" name="include" id="include" value="<?php echo $_POST['include'];?>" />
		<input type="hidden" name="hdAtualizar" id="hdAtualizar" value="<?php if($_POST['CODEMISSOR']){echo 'sim';}?>" />
		<?php if($_POST['CODEMISSOR']){?>
		<input type="hidden" name="CODEMISSOR" id="CODEMISSOR" value="<?php echo $_POST['CODEMISSOR']?>" />
		<?php }?>
		<fieldset>
		<legend>Prestadores Inserir</legend>
		<input type="hidden" name="btCadastrarEmpresa" value="Cadastrar" />
		<table border="0" align="center" id="tblEmpresa">
        	<? if($codigo){ ?>
                <tr>
                    <td align="left"  style="text-indent:5px">C&oacute;d Cadastro<font color="#FF0000">*</font></td>
                    <td colspan="3">
					  <input type="text" size="15" style="background-color:#CCCCCC;" maxlength="100" name="txtInsCodCadastro" id="txtInsCodCadastro" readonly="readonly" class="texto" value="<?php echo $codigo; ?>">		
                    </td>
                </tr>
            <?php
            }
			?>	
			<tr>
				<td align="left"  style="text-indent:5px">Tipo<font color="#FF0000">*</font></td>
				<td colspan="3">
					<select name="cmbCodtipo" id="cmbCodtipo" class="combo" onchange="alternaCampos('cmbCodtipo')">
						<option value=""></option>
						<?php
							$sql_codtipo = mysql_query("SELECT codigo, tipo, nome FROM tipo WHERE (tipo = 'prestador' OR tipo = 'tomador' OR tipo = 'contador') ORDER BY nome");
							while(list($codigo_tipo,$tipo,$nome_tipo) = mysql_fetch_array($sql_codtipo)){
								echo "<option value=\"$codigo_tipo|$tipo\"";if($codigo_tipo == $codtipo){ echo "selected = selected";}echo ">$nome_tipo</option>";
							}
						?>
					</select>
				</td>
			</tr>            
			<tr>
				<td align="left" style="text-indent:5px"> Nome<font color="#FF0000">*</font> </td>
				<td colspan="3" align="left">
					<input type="text" size="70" maxlength="100" name="txtInsNomeEmpresa" id="txtInsNomeEmpresa" class="texto" value="<?php echo $nome; ?>"
					 >				</td>
			</tr>
			<tr>
                            <td align="left" style="text-indent:5px"> Raz&atilde;o Social<font color="#FF0000">*</font> </td>
				<td colspan="3" align="left">
					<input type="text" size="70" maxlength="100" name="txtInsRazaoSocial" id="txtInsRazaoSocial" class="texto" value="<?php if(isset($razaosocial)){echo $razaosocial;} ?>"
					>				</td>
			</tr>
            <tr>
                <td align="left" style="text-indent:5px"> Inscr. Estadual</td>
				<td colspan="3" align="left">
					<input type="text" size="70" maxlength="100" name="txtInsInscEstadualEmpresa" id="txtInsInscEstadualEmpresa" class="texto" value="<?php if(isset($inscricaoestadual)){echo $inscricaoestadual;} ?>"
					>				</td>
			</tr>
			<!-- alterna input cpf/cnpj-->
			<tr>
				<td align="left" width="95" style="text-indent:5px"> CNPJ/CPF<font color="#FF0000">*</font> </td>
				<td align="left" width="150">
					<input  id="txtInsCpfCnpjEmpresa" type="text" size="20"  name="txtInsCpfCnpjEmpresa" class="texto" onkeydown="return NumbersOnly( event );" onkeyup="CNPJCPFMsk( this );" 
					value="<?php if(isset($cnpjcpf)){echo $cnpjcpf;} ?>" onblur="verificaRPA(this,'tdTipoDec')" />				</td>
			    <td align="left" width="120">Insc. Municipal</td>
			    <td align="left" width="150">
					<input type="text" size="23" maxlength="30" name="txtInsInscMunicipalEmpresa" class="texto" value="<?php if(isset($inscrmunicipal)){echo $inscrmunicipal;} ?>" 
					/>				</td>
			</tr>
			<!-- alterna input cpf/cnpj FIM-->
			<tr>
				<td align="left" style="text-indent:5px"> Logradouro<font color="#FF0000">*</font> </td>
				<td colspan="3" align="left">
					<input type="text" size="70" maxlength="90" name="txtInsEnderecoEmpresa" id="txtInsEnderecoEmpresa" class="texto" 
					value="<?php if(isset($logradouro)){echo $logradouro;} ?>" />				</td>
			</tr>
			<tr>
				<td align="left" style="text-indent:5px"> Numero<font color="#FF0000">*</font> </td>
				<td align="left">
					<input type="text" size="20" maxlength="20" name="txtNumero" id="txtNumero" class="texto" value="<?php if(isset($numero)){echo $numero;} ?>" /></td>
				<td align="left">Complemento:</td>
                
                <td align="left">
                    <input type="text" size="23" maxlength="100" name="txtComplemento" id="txtComplemento" class="texto" 
                    value="<?php if(isset($complemento)){echo $complemento;} ?>" />				
                </td>
                
			</tr>
            <tr>
                <td align="left" style="text-indent:5px">Bairro:<font color="#FF0000">*</font></td>
                <td align="left">
					<input type="text" size="20" maxlength="100" name="txtBairro" id="txtBairro" class="texto" value="<?php if(isset($bairro)){echo $bairro;} ?>"
					  /></td>
                
                <td align="left">CEP:<font color="#FF0000">*
                </font></td>
                <td align="left"><font color="#FF0000">
                  <input type="text" size="23" maxlength="9" name="txtCEP" id="txtCEP" class="texto" value="<?php if(isset($cep)){echo $cep;} ?>" />
                </font></td>
                
            </tr>
            <tr>
                <td align="left" style="text-indent:5px">Telefone <br />&nbsp;Comercial<font color="#FF0000">*</font></td>
                <td align="left">
					<input type="text" class="texto" size="20" maxlength="15" name="txtFoneComercial" id="txtFoneComercial"
				     value="<?php if(isset($fone)){echo $fone;} ?>"/></td>
                 <td align="left">Telefone Celular</td>
                <td align="left"><input type="text" class="texto" size="23" maxlength="15" name="txtFoneCelular" id="txtFoneCelular" value="<?php if(isset($celular)){echo $celular;} ?>" /></td>
            </tr>
            <tr>
            <td align="left" style="text-indent:5px">Data inicio<font color="#FF0000">*</font> </td>
             
             <td align="left">
					<input type="text" class="texto"size="12" maxlength="10" name="txtDtInicio" id="txtDtInicio"  value="<?php if(isset($datainicio)){echo DataPt($datainicio);} ?>" onkeyup="MaskData(this)" /></td>

                <td align="left" style="text-indent:5px">Data de<br />&nbsp;Encerramento</td>
                <td align="left"><input type="text" class="texto" size="12" maxlength="10" name="txtDataFim" id="txtDataFim" value="<?php if(isset($datafim)){echo DataPt($datafim);} ?>" onkeyup="MaskData(this)" /></td>
                
               
            </tr>
			<tr>
				<td colspan="4">
					
					<!-- Tabela institui��o e operadoras -->
					
					<table width="100%" border="0" cellspacing="1" cellpadding="2" align="left" id="tbl_inst_opr" style="display:none; margin:0px">
						<?php
							include("inc/cadastro/prestadores/cadastro/cadastro_inst_opr.php");
						?>
					</table>
					
					<!-- Tabela C�rtorios -->
					
					<table width="100%" border="0" cellspacing="1" cellpadding="2" align="left" id="tbl_cart" style="display:none; margin:0px">
						<?php
							include("inc/cadastro/prestadores/cadastro/cadastro_cart.php");
						?>
					</table>				
					
				</td>
			</tr>			
			<tr>
				<td align="left" style="text-indent:5px">UF<font color="#FF0000">*</font></td>
				<td align="left">
					<!--ESTE SELECT ESTA COM A NOMENCLATTURA DE UM TEXT PARA MANTER A COMPATIBILIDADE DO ARQUIVO INSERIR.PHP COM TODOS OS ARQUIVOS DE CADASTRO DE EMPRESAS-->
					<?php
						if(!$uf){
							$uf_teste = $dados_municipio['estado'];
						}else{
							$uf_teste = $uf;
						}
					?>
					<select name="txtInsUfEmpresa" id="txtInsUfEmpresa" onchange="buscaCidades(this,'txtInsMunicipioEmpresa')">
						<option value=""></option>
						<?php
							$sql=mysql_query("SELECT uf FROM municipios GROUP BY uf ORDER BY uf");
							while(list($uf_busca)=mysql_fetch_array($sql)){
								echo "<option value=\"$uf_busca\"";if($uf_busca == $uf_teste){ echo "selected=selected"; }echo ">$uf_busca</option>";
							}
						?>
					</select>
				</td>
				<td>PIS/PASEP</td>
				<td colspan="2"><input name="txtPISPASEP" class="texto" type="text" maxlength="20" value="<?php echo $pispasep;?>" /></td>
			</tr>
			<tr>
                            <td align="left" style="text-indent:5px">Munic&iacute;pio<font color="#FF0000">*</font></td>
				<td colspan="3" align="left">
					<div  id="txtInsMunicipioEmpresa">
						<select name="txtInsMunicipioEmpresa" id="txtInsMunicipioEmpresa" class="combo">
							<?php
								$sql_municipio = mysql_query("SELECT nome FROM municipios WHERE uf = '$uf_teste'");
								if(!isset($municipio)){
									while(list($nome_municipio) = mysql_fetch_array($sql_municipio)){
										echo "<option value=\"$nome_municipio\"";if((strtolower($nome_municipio) == strtolower($dados_municipio['cidade'])) || (strtolower($nome_municipio) == strtolower($municipio))){ echo "selected=selected";} echo ">$nome_municipio</option>";
									}//fim while
								}else{
									while(list($nome_municipio) = mysql_fetch_array($sql_municipio)){
										echo "<option value=\"$nome_municipio\"";if( (strtolower($nome_municipio) == strtolower($municipio)) ){ echo "selected=selected";} echo ">$nome_municipio</option>";
									}//fim while
								}
							?>
						</select>
					</div>				</td>
			</tr>
			<tr>
				<td align="left" style="text-indent:5px"> Email<font color="#FF0000">*</font> </td>
				<td colspan="3" align="left">
					<input type="text" size="30" maxlength="100" name="txtInsEmailEmpresa" id="txtInsEmailEmpresa" class="texto" value="<?php if(isset($email)){echo $email;} ?>"
					 style="text-transform:none" />
					<em>Informar somente 01 (um) e-mail</em>
				</td>
			</tr>
			<?php if($_POST['CODEMISSOR']){?>
			<tr>
				<td align="left"></td>
				<td align="left" colspan="3">
					<input name="btGerar" value="Gerar senha" class="botao" type="submit" <?php if(!$email){ echo "disabled=\"disabled\"";}?> /><?php if(!$email){?><b>&Eacute; necessario ter um e-mail para gerar a senha</b><?php }?>
				</td>
			</tr>
			<?php }?>
			<tr>
                            <td align="left" style="text-indent:5px">Tipo de <br />&nbsp;declara&ccedil;&atilde;o<font color="#FF0000">*</font></td>
				<td align="left" id="tdTipoDec">
					<select name="cmbTipoDec" id="cmbTipoDec" class="combo">
						<option value=""></option>
						<?php
							$sql_tipodec = mysql_query("SELECT codigo, declaracao FROM declaracoes");
							while(list($codigo_dec,$declaracoes) = mysql_fetch_array($sql_tipodec)){
								echo "<option value=\"$codigo_dec\"";if($codigo_dec == $codtipodec){ echo "selected = selected";} echo " id=\"$declaracoes\">$declaracoes</option>";
							}
						?>
					</select>				
                </td>
                <td align="left">NFe N&uacute;mero</td>
                <td align="left">
                    <?php
                        $sqlValidaNumNota = mysql_query("SELECT COUNT(codigo) FROM notas WHERE codemissor = '$codigo'");
                        list($validaNumNota) = mysql_fetch_array($sqlValidaNumNota);
                        if($validaNumNota > 0){
                            $readOnly = "readonly='readonly'";
                        }else{
                            $readOnly = "";
                        }
                    ?>
                    <input type="text" class="texto" name="txtNfeNum" id="txtNfeNum" size="8" 
                    value="<?php echo ($ultima+1); ?>"S onkeydown="return NumbersOnly(event);" />
                </td>
			</tr>
			<tr>
				<td align="left" style="text-indent:5px">NFe</td>
				<td colspan="3" align="left">
                    <label for="txtNfe"><input type="checkbox" value="S"  name="txtNfe" id="txtNfe" <?php if(($nfe == 'S') || ($nfe == "s")){echo "checked=\"checked\"";} ?>/>
					<em>Esta empresa emite Nota Fiscal eletr&ocirc;nica</em></label>
                </td>
			</tr>
            <tr>
                <td align="left" style="text-indent:5px">Isento</td>
                <td colspan="3" align="left">
                    <label for="chkIsentoIss">
                        <input type="checkbox" value="S" name="chkIsentoIss" id="chkIsentoIss" <?php if(($isentoiss == 'S')||($isentoiss == 's')){echo "checked=\"checked\""; } ?> />
                        <i>Esta empresa &eacute; isenta de ISS</i>
                    </label>
                </td>
            </tr>
			<?php if($_POST['CODEMISSOR']){?>
			<tr>
				<td align="left" style="text-indent:5px">Estado</td>
				<td colspan="3" align="left">
					<input type="radio" name="rgEstado" value="A" id="rgEstado_0"  <?php if($estado =='A'){echo "checked=\"checked\"";} ?> />
					&nbsp;Ativo
					<input type="radio" name="rgEstado" value="I" id="rgEstado_1" <?php if($estado =='I'){echo "checked=\"checked\"";} ?>/>
					&nbsp;Inativo
                </td>
			</tr>
			<?php }?>
			<tr>
				<td colspan="4" align="left">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" align="left">
				</td>
			</tr>
		</table>
		<table id="bigtable" width="100%">
			<tr>
				<td>
					<table width="500" border="0" cellspacing="1" cellpadding="2" align="left">
						<?php
				if(($_POST['CODEMISSOR'])){
					$COD = $_POST['CODEMISSOR'];	   	
					$sql=mysql_query("SELECT codigo, nome, cpf FROM cadastro_resp WHERE codemissor = '$COD' AND codcargo <> '$codcargo_gerente' AND codcargo <> '$codcargo_diretor'");
					$contsocios = mysql_num_rows($sql);
					$cont_aux_socios = $contsocios;	  
					print("<tr>
							  <td colspan=4 align=left>
							   <b>Respons&aacute;vel/S&oacute;cio</b>
							  </td>
							 </tr>
							");
					while(list($CodigoSocio,$nomesocio,$cpfsocio)=mysql_fetch_array($sql))
					{
						print("	    
						<tr>
						   <td align=left colspan=4>
							<input type=hidden name=txtCodigoSocio$contsocios value=$CodigoSocio>
							Nome&nbsp; <input type=text name=txtnomesocio$contsocios value=\"$nomesocio\" size=40 maxlength=100 class=texto>&nbsp;
							CPF&nbsp;<input type=text name=txtcpfsocio$contsocios value=$cpfsocio size=14 maxlength=14 class=texto 
							onkeyup=\"CNPJCPFMsk( this );\">");
							print("<input type=checkbox name=checkExcluiSocio$contsocios value=$CodigoSocio>Excluir"); 				
						print("</td>		   
						</tr> ");
						$contsocios--;		  
				  } 
				}	?>
					</table>				</td>
			</tr>
			<tr>
				<td colspan="4" align="left">
					<!-- bot�o que chama a fun��o JS e mostra + um s�cio-->
					<input type="button" value="Adicionar Respons&aacute;vel/S&oacute;cio" name="btAddSocio" class="botao" onclick="incluirSocio()" />
					<font color="#FF0000">*</font></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<!--CAMPO S�CIOS --------------------------------------------------------------------------->
					<table width="100%" border="0" cellspacing="1" cellpadding="2">
						<?php include("socios.php")?>
					</table>
					<!-- CAMPO S�CIOS FIM -->				</td>
			</tr>
			<tr>
				<td colspan="4" align="left">
				<?php if($_POST['CODEMISSOR'])		
			{ ?>
				<table width="100%" border="0" cellspacing="1" cellpadding="2" id="tblServicos">
					<tr>
						<td align="left" colspan="4">
                                                    <b>Servi&ccedil;os</b> <br />						</td>					
						<td></td>
					</tr>
					<!---------------- LISTAGEM DOS SERVICOS A SEREM EDITADOS ------------------------------------------------------->
					<?php
					  $COD = $_POST['CODEMISSOR'];
					  $sql_servicos=mysql_query("
					  SELECT cadastro_servicos.codigo,servicos.codigo,servicos.codservico,servicos.descricao,servicos.aliquota, servicos.codcategoria 
					  FROM servicos
					  INNER JOIN cadastro_servicos ON servicos.codigo = cadastro_servicos.codservico
					  WHERE cadastro_servicos.codemissor = '$COD'");
					  
					 $contservicos = mysql_num_rows($sql_servicos);
					 $cont_aux_servicos = $contservicos;
					 $numservicos = $contservicos;
					 ?>
					<?php while(list($codigo_empresas_servicos,$codigo,$codservico,$descricao,$aliquota,$CodCateg)=mysql_fetch_array($sql_servicos))
					  {
						print("	 
						 <tr>	
						   <td align=left >
							 <input type=hidden value=$codigo_empresas_servicos name=servico$contservicos >	
							 <select name=cmbEditaServico$contservicos style=width:400px;>
							   <option value=$codigo>$codservico | $descricao | $aliquota</option>");	
							   	$sql_all_servicos=mysql_query("SELECT codigo,codservico,descricao,aliquota FROM servicos WHERE estado= 'A' AND codcategoria = '$CodCateg'");
							  while(list($CODigo,$CODservico,$Descricao,$Aliquota)=mysql_fetch_array($sql_all_servicos))			    
							  {
							   if ($codigo != $CODigo)
							   {
								print("<option value=$CODigo>$CODservico |$Descricao | $Aliquota</option>");
							   }
							  }	
						print("</select>&nbsp;");
							   print("<input type=checkbox name=checkExcluiServico$contservicos value=$codigo>Excluir");
					  print("</td>		  	  
						  </tr> ");
						$contservicos--;  
					  } ?>
				</table>
			<?php } ?>		</td></tr>
			
			<tr id="trBotao">
				<td colspan="4" align="left">
					<!-- bot�o que chama a fun��o JS e mostra + um servi�o-->
                                        <input type="button" value="Adicionar Servi&ccedil;os" name="btAddServicos" class="botao" onclick="incluirServico()" />
					<font color="#FF0000">*</font></td>
			</tr>
			<tr id="trCombos">
				<td colspan="4" align="center">
					<!--CAMPO SERVICOS -->
					<table width="100%" border="0" cellspacing="1" cellpadding="2">
						<?php include("servicos.php")?>
					</table>
					<!-- CAMPO SERVICOS FIM -->				</td>
			</tr>
            <tr>
                <td colspan="4" align="right"><strong><font color="#FF0000">*</font> Campos Obrigat&oacute;rios</strong></td>
         	</tr>
		</table>
		</fieldset>
		<fieldset style="vertical-align:middle; text-align:left">
		<?php
			//O valor das variaveis mudam conforme a situacao, se for insercao sera onclick 1 que verifica responsavel e servicos se nao onclick 2
			$string_onclick1 = "return  (ValidaFormulario('txtInsNomeEmpresa|txtInsRazaoSocial|txtInsCpfCnpjEmpresa|txtInsEnderecoEmpresa|txtNumero|txtBairro|txtCEP|txtFoneComercial|txtInsUfEmpresa|txtInsMunicipioEmpresa|txtInsEmailEmpresa|cmbTipoDec|cmbCodtipo|txtNomeSocio1|txtCpfSocio1|cmbCategoria1'));";
			$string_onclick2 = "return  (ValidaFormulario('txtInsNomeEmpresa|txtInsRazaoSocial|txtInsCpfCnpjEmpresa|txtInsEnderecoEmpresa|txtNumero|txtBairro|txtCEP|txtFoneComercial|txtInsUfEmpresa|txtInsMunicipioEmpresa|txtInsEmailEmpresa|cmbTipoDec|cmbCodtipo'));";		
		?>
		<input type="button" value="Novo" name="btNovo" class="botao" onclick="LimpaCampos('frmCadastroEmpresa')"  />
		<input type="button" value="Pesquisar" name="btPesquisar" class="botao" onclick="document.getElementById('divBusca').style.visibility='visible'" />
		<input type="submit" value="Excluir" name="btExcluir" class="botao" onclick="return confirm('Deseja desativar este prestador?');" />
		<input type="submit" value="Salvar" name="btCadastrar" class="botao" id="btCadastrar" 
		onclick="<?php if(($_POST['CODEMISSOR'])){ echo $string_onclick2; }else{ echo $string_onclick1; } ?>" />
		<?php if($_POST['CODEMISSOR']){?>
        <input type="submit" value="Imprimir" name="btImprimir" class="botao"
            onclick="cancelaAction(this.form.id,'inc/cadastro/prestadores/imprime_cadastro.php','_blank')" />
        
        <?php
			}
		?>
        <!--<input type="button" class="botao" name="btImprimir" id="btImprimir" value="Imprimir" onclick="window.open('inc/cadastro/prestadores/imprime_cadastro.php')" />-->
		</fieldset>
		<input type="hidden" name="hdTemporario" id="hdTemporario" />
		<input type="hidden" name="hdPadrao_onclick" id="hdPadrao_onclick" value="<?php echo $string_onclick2; ?>" />
	</form>	</td>

	</tr>
	
</table>
<!-- Formul�rio de inser��o de servi�os Fim-->
<script>
	if(document.getElementById('cmbCodtipo')){
		alternaCampos('cmbCodtipo');
	}	
</script>