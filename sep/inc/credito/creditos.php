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
if($_POST['btConfirma']=="Confirmar"){
	require_once("../../../middleware/pmfeliz/autoload.php");
	/*[include] => inc/credito/creditos.php [cmbTomador] => [hdPagina] => 1 [hdPrimeiro] => [hdValorMaximo] => 7800 [hdCodCadastro] => 71000184 [hdCodImovel] => 57 [btVer] => [btConfirma] => Confirmar [txtCredito] => 7.800,00*/
	$x = ($_POST['hdX']);
	if($_POST['txtAbatimento'.$x]!=""){
		$valorcredito = MoedaToDec($_POST['txtAbatimento'.$x]);
	}else{
		$valorcredito = $_POST['hdCredito'.$x];
	}
	if($_POST['hdCodimoveis'.$x]!=""){
		$codigoimoveis = $_POST['hdCodimoveis'.$x];	
	}
	if($_POST['hdCodCadastro'.$x]!=""){
		$codcadastro = $_POST['hdCodCadastro'.$x];	
	}
	if($_POST['hdCredito'.$x]!=""){
		$creditocadastro = MoedaToDec($_POST['hdCredito'.$x]);	
	}
	if($_POST['hdCodImovel'.$x]!=""){
		$codimovel = $_POST['hdCodImovel'.$x];	
	}
	$imoveis = new Postgre_Smabas01();
	$imoveis->setNumCad($codimovel);
	$imoveis->CarregaNumCad();
	$imoveis->setVlrDesc($imoveis->getVlrDesc()+$valorcredito);
	$imoveis->AtualizaValor();
	$creditonovo = $creditocadastro - $valorcredito;
	mysql_query("UPDATE cadastro SET credito='$creditonovo' WHERE codigo = '$codcadastro'");
	$hoje = date("Y-m-d H:i:s");
	mysql_query("INSERT INTO creditos_imoveis_usado (codcadastro, creditousado, creditoanterior, creditoatual, data) VALUES ('$codcadastro','$valorcredito','$creditocadastro','$creditonovo','$hoje')");
	mysql_query("UPDATE creditos_imoveis SET estado = 'U' WHERE codigo='$codigoimoveis'");
	Mensagem("Cr&eacute;ditos usados");
}
?>
<script>
function atualizacreditos(valormaximo,valortotal){
	var credito = MoedaToDec(document.getElementById('txtCredito').value);
	if(credito>valormaximo){
		credito=valormaximo;
		document.getElementById('txtCredito').value = DecToMoeda(valormaximo);
	}
	var valordesconto = (valortotal - credito);
	document.getElementById('txtValorDesconto').value = DecToMoeda(valordesconto);	
}
</script>
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
  <tr>
    <td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
    <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Relat&oacute;rios - cr&eacute;ditos gerados </td>
    <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
  </tr>
  <tr>
    <td width="18" background="img/form/lateralesq.jpg"></td>
    <td align="center">

<form id="frmCreditos" name="frmCreditos" method="post">
<input name="include" id="include" type="hidden" value="<?php echo $_POST["include"];?>" />
<fieldset>
<legend><strong>Solicita&ccedil;&otilde;es</strong></legend>
<table align="left" width="50%">
<tbody>
    <tr>
        <td>
            <select style="width: 350px" name="cmbTomador" id="cmbTomador">
                <option value="">Selecione o tomador com créditos</option>
                    <?php
                        $sql_categoria=mysql_query("
                            SELECT
                                cadastro.nome,
                                IF(
                                    cadastro.cnpj<>'',
                                    cadastro.cnpj,
                                    cadastro.cpf
                                ) AS doc
                            FROM cadastro WHERE credito > 0
                        ");
                        while(list($nome,$doc)=mysql_fetch_array($sql_categoria)){
                            print("<option value=\"$doc\">$nome</option>");
                        }
                    ?>
            </select>
         </td>
    </tr>
    <tr>
    	<td colspan="5"><input type="submit" name="btnBuscar" id="btnBuscar" value="Buscar" class="botao" onclick="btnBuscarCred_click(); return false;" /></td>
    </tr>
    <tr>
    	<td colspan="5"><label><input name="ckUsados" type="checkbox" value="S" /> Listar cr&eacute;ditos usados.</label></td>
    </tr>
</tbody>
</table>

</fieldset>
<div id="divCreditos"></div>
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
<script type="text/javascript">
	function btnBuscarCred_click() {
		acessoAjax('inc/credito/creditos.ajax.php','frmCreditos','divCreditos');
	}
</script>
