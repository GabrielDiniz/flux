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
require_once("../../inc/conect.php");
require_once("../../inc/nocache.php");
require_once("../../funcoes/util.php");

$cnpj = $_GET['txtCnpjPrestador'];
if($cnpj!=""){
$sql_where = array();

if ($cnpj) {
	$sql_where[] = "(c.cpf = '$cnpj' OR c.cnpj = '$cnpj')";
}

//testa se tem algum filtro do where
if ($sql_where) {
	$WHERE = 'WHERE ' . implode(' AND ', $sql_where);
} else {
	$WHERE = '';
}

$query = ("
	SELECT
		*
	FROM
		cadastro as c
	$WHERE
	ORDER BY
		c.codigo
	LIMIT 1
");

$sql = mysql_query($query);

if (mysql_num_rows($sql) == 0) {
	?><fieldset><strong><center>Nenhum resultado encontrado</center></strong></fieldset><?php
} else {
	$dados = mysql_fetch_array($sql);
	$dados['cnpj'] .= $dados['cpf'];
	if($dados['nfe']=="S"){
		?><fieldset><strong><center>Este contribuinte n&atilde;o pode gerar Nota Avulsa.</center></strong></fieldset><?php
	}else{
	$notas = mysql_query("SELECT * FROM notas WHERE codemissor = '$dados[codigo]'");
	
	$sql_servicos = mysql_query("
		SELECT 
			cadastro_servicos.codigo,
			servicos.codigo,
			servicos.codservico,
			servicos.descricao,
			servicos.aliquota, 
			servicos.aliquotair, 
			servicos.basecalculo
		FROM 
			servicos
		INNER JOIN 
			cadastro_servicos ON servicos.codigo = cadastro_servicos.codservico
		WHERE 
			cadastro_servicos.codemissor = '$dados[codigo]'
	");
	
	//SELECIONA A ULTIMA NOTA INSERIDA PELA EMPRESA
	$sql = mysql_query("SELECT ultimanota, codtipo, codtipodeclaracao FROM cadastro WHERE codigo = '$dados[codigo]'");
	list($ultimanota,$codtipo,$codtipodec)=mysql_fetch_array($sql);
	$ultimanota += 1;
	
	$sql = mysql_query("SELECT notalimite FROM cadastro WHERE codigo = '$dados[codigo]'");
	list($notalimite) = mysql_fetch_array($sql);
	if($notalimite == 0){
		$notalimite = "Liberado";
	}
	
	//GERA O C�DIGO DE VERIFICA��O
	$CaracteresAceitos = 'ABCDEFGHIJKLMNOPQRXTUVWXYZ';
	$max = strlen($CaracteresAceitos)-1;
	$password = null;
	 for($i=0; $i < 8; $i++) {
	 $password .= $CaracteresAceitos{mt_rand(0, $max)}; 
	 $carac = strlen($password); 
	 if($carac ==4)
	 { 
	 $password .= "-";
	 } 
	}

	
	$qtdservicos = mysql_num_rows($sql_servicos);
	
	$qtdnotas = mysql_num_rows($notas);
	
	$x=1;
	$quantidade=1;
	$diaatual=date("Y-m-d");
    if($dados['datainicio']==NULL || $dados['datainicio']==0000-00-00){ $dados['datainicio'] = $diaatual; }
    $anoatual=date("Y");
    $anoempresa=substr($dados['datainicio'],0,-6);
    $anofimempresa=substr($dados['datafim'],0,-6);
    if($dados['datafim']<$dados['datainicio']){ $dados['datafim']=NULL; } if($dados['datafim']>$dados['diaatual']){ $dados['datafim']=NULL; }

	if($qtdservicos>0){?>
    <!--<form name="frmInserir" method="post" id="frmInserir" onsubmit="return ValidarInserirNota()">-->
	
    
    
    <fieldset><legend><strong>Informa&ccedil;&otilde;es</strong></legend>
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
			<td  align="center">Nome</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['nome']; ?></td>
            <td  align="center">Cpf/Cnpj</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['cnpj']; ?></td>
        </tr>
        <tr>
			<td  align="center">Logradouro</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['logradouro']; ?></td>
            <td  align="center">Bairro</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['bairro']; ?></td>
		</tr>
        <tr>
			<td  align="center">Cep</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['cep']; ?></td>
            <td  align="center">Munic&iacute;pio/Estado</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['municipio']."/".$dados['uf']; ?></td>
		</tr>
        <tr>
			<td  align="center">Email</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['email']; ?></td>
            <td  align="center">Fone</td><td bgcolor="#FFFFFF" align="center"><?php echo $dados['fonecomercial']; ?></td>
		</tr>
	</table>
    <div id="divVerNotas"></div>
    </fieldset>
    
    
    
    <fieldset><legend><strong>Informa&ccedil;&otilde;es da Nota</strong></legend>
    <input name="hdInputs" id="hdInputs" type="hidden" value="0" />
        <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
        	<tr>    
        		<td  align="left" colspan="3"><font color="#FF0000" size="-2">OBS: N&atilde;o utilizar a tecla Enter para alternar entre os campos.</font>  </td>
        	</tr>
            <tr>
                <td align="center">N&uacute;mero</td>
                <td align="center">Data e Hora de Emiss&atilde;o</td>
                <td align="center">C&oacute;digo de Verifica&ccedil;&atilde;o</td>
            </tr>
            <tr>
                <td align="center"><input name="txtNotaNumero" style="text-align:center;" type="text" size="10" class="texto" readonly="yes" value="<?php print $ultimanota;?> "></td>
                <td align="center">
                <input name="txtNotaDataHoraEmissao" style="text-align:center;" type="text" size="20" class="texto" readonly="yes" 
                value="<?php print date('d/m/Y H:i'); ?>">
                </td>
	            <td align="center"><input name="txtNotaCodigoVerificacao" style="text-align:center;" type="text" size="20" class="texto" readonly="yes" value="<?php print $password;?>"></td>
            </tr> 
        </table>
        <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
            <tr>
                <td align="left" colspan="3"><strong>Per&iacute;odo</strong></td>
            </tr>
            <tr>    
                <td align="left" width="100">
                    <input type="hidden" name="codempresa" value="<?php echo $dados['codigo']; ?>" id="codempresa">
                        <select name="cmbAno" id="cmbAno" onchange="acessoAjax('listaperiodo.ajax.php?dia=d','frmNota','divSelect');" >
                            <option value="">Escolha o ano</option>
                                <?php
                                if($dados['datafim']==NULL){
                                    for($ano=$anoatual;$ano>=$anoempresa;$ano--){
                                        echo "<option value=\"$ano\">$ano</option>";
                                    }
                                }else{
                                    for($ano=$anoempresa;$ano<=$anofimempresa;$ano++){
                                        echo "<option value=\"$ano\">$ano</option>";
                                    }
                                }
                                ?>
                        </select>
                </td>
                <td id="divSelect" valign="top">
                <select name="cmbMes" id="cmbMes">
                	<option value=""></option>
                </select>
                </td>
            </tr>
        </table>
            
            <input name="hdInputs" id="hdInputs" type="hidden" value="0" />
            <input name="hdCodemissor" id="hdCodemissor" type="hidden" value="<?php echo $dados['codigo'];?>" />
            <input name="hdLimite" id="hdLimite" type="hidden" value="<?php echo mysql_num_rows($sql_servicos);?>"  /> 
            
            <table width="100%">
                <tr>
                    <td align="left">
                        <label><strong>Clique para informar o tomador<br /><br /></strong>
                        <input name="btTomador" type="button" value="Tomador" class="botao" 
                        onclick="mostraDivTomador();" /></label>
                        <div id="divTomadorNota" class="divTomadorNota">
                            <table border="0" cellspacing="0" cellpadding="0"  height="100%">
                                <tr>
                                    <td width="18" align="left" background="../img/form/cabecalho_fundo.jpg"></td>
                                    <td width="95%" background="../img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho"></td>  
                                    <td width="19" align="right" valign="top" background="../img/form/cabecalho_fundo.jpg">
                                        <a href="#" onclick="escondeMostraDiv('divTomadorNota');return false">
                                            <img src="../img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" />
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="18" background="../img/form/lateralesq.jpg"></td>
                                    <td align="left" width="100%" height="100%" valign="top">
                                       
                                        <table width="100%" border="0" cellspacing="2" cellpadding="2"> 
                                            <tr>
                                                <td colspan="2"><strong>Tomador de Servi&ccedil;os</strong></td>
                                            </tr>
                                            <tr>
                                                <td align="left" width="25%">CPF/CNPJ</td>
                                                <td align="left"><input name="txtTomadorCNPJ" type="text" size="20" class="texto" onkeydown="stopMsk( event );return NumbersOnly( event );" onkeyup="CNPJCPFMsk( this );"  maxlength="18" id="txtTomadorCNPJ" onblur="acessoAjax('../emissor/inc/tomador_nota.ajax.php','frmNota','divContainer',true);"></td>
                                            </tr>
                                        </table>   
                                        <div id="divContainer">
                                        <table width="100%" border="0" cellspacing="2" cellpadding="2"> 
                                            <tr>
                                                <td width="25%" align="left">Nome/Raz&atilde;o Social</td>
                                                <td width="75%" align="left"><input name="txtTomadorNome" id="txtTomadorNome" type="text" size="55" class="texto"></td>
                                            </tr>  
                                            <tr>
                                                <td align="left">Inscri&ccedil;&atilde;o Municipal</td>
                                                <td align="left"><input name="txtTomadorIM" type="text" onkeydown="return NumbersOnly(event);"  size="30" class="texto" ></td>
                                            </tr>
                                            <!--<tr>
                                            <td align="left">Inscri&ccedil;&atilde;o Estadual</td>
                                            <td align="left"><input name="txtTomadorIE" type="text" onkeydown="return NumbersOnly(event);"  size="30" class="texto" ></td>
                                            </tr>-->
                                            <tr>
                                                <td align="left">Logradouro</td>
                                                <td align="left"><input name="txtTomadorLogradouro" type="text" size="30" class="texto">
                                            &nbsp;&nbsp;N&uacute;mero <input name="txtTomadorNumero" type="text" onkeydown="return NumbersOnly( event );"  size="5" class="texto" maxlength="5"  /></td>
                                            </tr>  
                                            <tr>
                                                <td align="left">Complemento</td>
                                                <td align="left"><input name="txtTomadorComplemento" type="text" size="30" class="texto"></td>
                                            </tr>
                                            <tr>
                                                <td align="left">Bairro</td>
                                                <td align="left"><input name="txtTomadorBairro" type="text" size="30" class="texto"></td>
                                            </tr>
                                            <tr>
                                                <td align="left">CEP</td>
                                                <td align="left">
                                                <input name="txtTomadorCEP" type="text" size="15" class="texto" onkeydown="return NumbersOnly( event );"  maxlength="9"  onkeyup="MaskCEP(this);" ></td>
                                            </tr>
                                            <tr>
                                                <td align="left">UF<font color="#FF0000">*</font></td>
                                                <td align="left">
                                                    <!--ESTE SELECT ESTA COM A NOMENCLATTURA DE UM TEXT PARA MANTER A COMPATIBILIDADE DO ARQUIVO INSERIR.PHP COM TODOS OS ARQUIVOS DE CADASTRO DE EMPRESAS-->
                                                    <select name="txtTomadorUF" id="txtTomadorUF" onchange="buscaCidades(this,'txtTomadorMunicipio')">
                                                        <option value=""></option>
                                                        <?php
                                                            $sqlcidades=mysql_query("SELECT uf FROM municipios GROUP BY uf ORDER BY uf");
                                                            while(list($uf_busca)=mysql_fetch_array($sqlcidades)){
                                                                echo "<option value=\"$uf_busca\"";if($uf_busca == $UF_MUNICIPIO){ echo "selected=selected"; }echo ">$uf_busca</option>";
                                                            }
                                                        ?>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">Munic&iacute;pio<font color="#FF0000">*</font></td>
                                                <td align="left">
                                                <div  id="txtTomadorMunicipio">
                                                    <select name="txtTomadorMunicipio" id="txtTomadorMunicipio" class="combo">
                                                        <?php
                                                        $sql_municipio = mysql_query("SELECT nome FROM municipios WHERE uf = '$uf_busca'");
                                                        while(list($nome_municipio) = mysql_fetch_array($sql_municipio)){
                                                            echo "<option value=\"$nome_municipio\"";if(strtolower($nome_municipio) == strtolower($NOME_MUNICIPIO)){ echo "selected=selected";} echo ">$nome_municipio</option>";
                                                        }//fim while 
                                                        ?>
                                                    </select>
                                                </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">E-mail</td>
                                                <td align="left"><input name="txtTomadorEmail" type="text" size="30" class="email"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="8" align="right"><font color="#FF0000">**</font><i>Digite o e-mail do tomador para que o mesmo seja notificado sobre a emiss&atilde;o.</i></td>
                                            </tr>
                                            </table>
                                            </div>

                                        <div>
                                            <table>
                                                <tr>
                                                    <td width="93%" align="right">
                                                        <input name="btConfirmar" id="btConfirmar" type="button" class="botao" value="Confirmar" onclick="escondeMostraDiv('divTomadorNota');" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td width="19" background="../img/form/lateraldir.jpg"></td>
                                </tr>
                                <tr>
                                    <td align="left" background="../img/form/rodape_fundo.jpg"><img src="../img/form/rodape_cantoesq.jpg" /></td>
                                    <td background="../img/form/rodape_fundo.jpg"></td>
                                    <td align="right" background="../img/form/rodape_fundo.jpg"><img src="../img/form/rodape_cantodir.jpg" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
            
            
            
            
            <table width="100%" id="tblServicos" cellpadding="3">
                <tr>
                    <td align="left"><b>Observa&ccedil;&otilde;es da nota: </b></td>
                </tr>
                <tr>
                    <td align="center"><textarea name="txtObsNota" rows="0" cols="0" style="width:90%; height:60px;"></textarea></td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td align="left">
                        <label><strong>Clique para informar os servi&ccedil;os<br /><br /></strong>
                        <input name="btServico" type="button" value="Servi&ccedil;os" class="botao" 
                        onclick="mostraDivServicos();" /></label>
                        <div id="divServicosNota" class="divServicosNota">
                            <table border="0" cellspacing="0" cellpadding="0"  height="100%">
                                <tr>
                                    <td width="18" align="left" background="../img/form/cabecalho_fundo.jpg"></td>
                                    <td width="95%" background="../img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho"></td>  
                                    <td width="19" align="right" valign="top" background="../img/form/cabecalho_fundo.jpg">
                                        <a href="#" onclick="escondeMostraDiv('divServicosNota');return false">
                                            <img src="../img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" />
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="18" background="../img/form/lateralesq.jpg"></td>
                                    <td align="left" width="100%" height="100%" valign="top">
                                        <div style="overflow:auto; height:250px;">		
                                        <table id="retornoDivLinha" width="100%">
                                        </table>
                                        </div>
                                        <div>
                                            <table>
                                                <tr>
                                                    <td width="93%" align="right">
                                                    <input name="btAdicionar" id="btAdicionar" type="hidden" class="botao" value="Adicionar" 
                                            		onclick="addLinhaNota()" />
                                                        <input name="btConfirmar" id="btConfirmar" type="button" class="botao"
                                                        value="Confirmar" onclick="escondeMostraDiv('divServicosNota');" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td width="19" background="../img/form/lateraldir.jpg"></td>
                                </tr>
                                <tr>
                                    <td align="left" background="../img/form/rodape_fundo.jpg"><img src="../img/form/rodape_cantoesq.jpg" /></td>
                                    <td background="../img/form/rodape_fundo.jpg"></td>
                                    <td align="right" background="../img/form/rodape_fundo.jpg"><img src="../img/form/rodape_cantodir.jpg" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset><legend><strong>Dados da nota</strong></legend>
        <table width="100%">
	<!-- busca a relacao dos servicos por empresa -->
	<tr>
		<td align="left">Base de C&aacute;lculo</td>
		<td align="left">
			R$ <input name="txtBaseCalculo" type="text" size="10" class="texto" id="txtBaseCalculo" style="text-align:right;" 
			onkeyup="MaskMoeda(this);" onkeydown="return NumbersOnly(event);" onblur="ValorIss('<?php echo $regras_credito;?>')" readonly="readonly" value="0,00">
			<input name="txtBaseCalculoAux" type="hidden" id="txtBaseCalculoAux" />
			<input name="hdCalculos" id="hdCalculos" type="hidden" />
			<input name="hdValorInicial" id="hdValorInicial" type="hidden" />
            <input type="hidden" id="hdBkpBaseCalculo" value="a" />
		</td>
	</tr>
	<tr>
		<td width="21%" align="left">Dedu&ccedil;&otilde;es</td>
		<td width="26%" align="left">R$
			<input name="txtValorDeducoes" type="text" size="10" class="texto" id="txtValorDeducoes"  style="text-align:right;" value="0,00"
                   onkeydown="MaskMoeda(this); return NumbersOnly(event);" onblur="ValorIss('<?php echo $regras_credito;?>');" readonly="readonly" />
		</td>
		<td align="left">Acr&eacute;scimos</td>
		<td align="left">
			R$ 
			<input name="txtValorAcrescimos" type="text" size="10" class="texto" id="txtValorAcrescimos" style="text-align:right" value="0,00"
			onblur="document.getElementById('txtBaseCalculo').onblur()" readonly="readonly" />
		</td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td align="left"> ISS </td>
		<td align="left">R$
			<input name="txtISS" type="text" size="10" onblur="document.getElementById('txtBaseCalculo').onblur()" class="texto" readonly="yes" style="text-align:right;" id="txtISS" value="0,00" />
		</td>
		<td width="13%" align="left">ISS Retido </td>
		<td width="40%" align="left"> R$
			<input id="txtIssRetido" onblur="document.getElementById('txtBaseCalculo').onblur()" name="txtIssRetido" onkeyup="MaskMoeda(this);" onkeydown="return NumbersOnly(event);" type="text" size="10" 
			class="texto" readonly="yes" style="text-align:right;" value="0,00"/>
		</td>
	</tr>
	<tr>
		<td align="left">INSS </td>
		<td align="left"> R$
			<input id="txtValorINSS" name="txtValorINSS" type="text" size="10" class="texto" onkeyup="MaskMoeda(this);" 
			onkeydown="return NumbersOnly(event);" style="text-align:right;" onblur="document.getElementById('txtBaseCalculo').onblur()" value="0,00"/><!--onblur="document.getElementById('txtBaseCalculo').onblur()" -->
		</td>
		<td align="left">IRRF</td>
		<td align="left"> R$
			<input id="txtValorFinalIRRF" name="txtValorFinalIRRF" type="text" size="10" class="texto" onkeyup="MaskMoeda(this);" 
			onkeydown="return NumbersOnly(event);" onblur="
            descontaValor('txtValorINSS','txtValorFinalIRRF');document.getElementById('txtBaseCalculo').onblur();" style="text-align:right;" value="0,00"/>
		</td>
	</tr>
    <tr>
        <td width="21%" align="left">Cofins</td>
		<td width="26%" align="left">R$
            <input name="txtCofins" onblur="document.getElementById('txtBaseCalculo').onblur()" id="txtCofins" type="text" class="texto" size="10" value="0,00" onkeyup="MaskMoeda(this);"
			onkeydown="return NumbersOnly(event);" style="text-align:right" />
		</td>
        <td width="21%" align="left">Contribui&ccedil;&atilde;o Social</td>
		<td width="26%" align="left">R$
            <input name="txtContribuicaoSocial" id="txtContribuicaoSocial" onblur="document.getElementById('txtBaseCalculo').onblur()" type="text" class="texto" size="10" value="0,00" onkeyup="MaskMoeda(this);"
			onkeydown="return NumbersOnly(event);" style="text-align:right" />
		</td>
    </tr>
    <tr>
		<td width="21%" align="left">PIS/PASEP</td>
		<td width="26%" align="left">R$
			<input name="txtPISPASEP" type="text" onblur="document.getElementById('txtBaseCalculo').onblur()" class="texto" size="10" value="0,00" onkeyup="MaskMoeda(this);"
			onkeydown="return NumbersOnly(event);" style="text-align:right" />
		</td>
	</tr>
    <tr>
        <td width="150" align="left">Valor liquido</td>
        <td align="left">R$ <input name="txtValTotal" id="txtValTotal" type="text" onblur="document.getElementById('txtBaseCalculo').onblur()" size="10" class="texto" readonly="yes" style="text-align:right;" value="0,00">&nbsp;</td>
        <td width="13%" align="left">
			Reten&ccedil;&otilde;es		</td>
		<td width="40%" align="left">
			R$ 
				<input name="txtValTotalRetencao" id="txtValTotalRetencao" onblur="document.getElementById('txtBaseCalculo').onblur()" type="text" class="texto" size="10" readonly="readonly" style="text-align:right" value="0,00" />
		</td>
	</tr>
	<tr <?php echo $display;?>>
		<td align="left">Cr&eacute;dito</td>
		<td align="left">R$
			<input name="txtCredito" id="txtCredito" type="text" onblur="document.getElementById('txtBaseCalculo').onblur()" size="10" class="texto" readonly="yes" style="text-align:right" value="0,00" >
		</td>
    </tr>
    <tr>
        <td  align="left"><input name="btInserirNota" type="submit" value="Emitir" class="botao" onclick="return ValidaFormulario('txtBaseCalculo|txtTomadorMunicipio|txtTomadorUF|cmbAno|cmbMes|cmbDia')" ></td>
    </tr>
</table>
		</fieldset>
       <!-- </form>-->
    <?php }else{
		echo "<fieldset><legend>Gerar Nota Avulsa</legend>";
		echo "<br />Nenhum servi&ccedil;o cadastrado para esse CPF/CNPJ. Cadastre um servi&ccedil;o para gerar uma Nota Avulsa.<br /><br />";
		echo "</fieldset>";	
	}?>    
<?php
	}
}//fim else se tem resultado
}else{
	?><strong><center>Digite um CNPJ ou CPF.</center></strong><?php
}
?>
