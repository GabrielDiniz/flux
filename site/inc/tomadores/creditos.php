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
<script type="text/javascript">
function RetornaImovel(str,cod)
{
if (str.length==0)
  {
  document.getElementById("spanRetorno").innerHTML="";
  return;
  }
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("spanRetorno").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","inc/tomadores/creditos_imoveis.ajax.php?q="+str+"&cod="+cod,true);
xmlhttp.send();
}
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
<form method="post" id="frmCreditos">
<input type="hidden" value="<?php echo $_POST['txtMenu'];?>" name="txtMenu">
	<table width="580" border="0" cellpadding="0" cellspacing="1">
        <tr>
			
              <legend>Consulta Cr&eacute;ditos</legend><br><br><br>
	     
		</tr>
		<tr>
			<td height="60" colspan="3" >
                <table width="99%" border="0" align="center" cellpadding="5" cellspacing="0">
                    <tr>
                        <td width="30%" align="left">Tomador CPF/CNPJ<font color="#FF0000">*</font></td>
                        <td width="70%"  align="left"><input type="text" name="txtTomCpfCnpj" id="txtTomCpfCnpj" size="20" class="texto"  onkeydown="stopMsk( event );" onkeypress="return NumbersOnly( event );" onkeyup="CNPJCPFMsk( this );"/></td> 
                    </tr>
                    <tr>
                        <td align="center">&nbsp;</td>
                        <td align="left"><font color="#FF0000">*</font> Dados obrigat&oacute;rios</td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2"><input type="button" onclick="acessoAjax('inc/tomadores/creditos.ajax.php','frmCreditos','divUsarCreditos');" name="btConsultarCreditos" id="btConsultarCreditos" value="Consultar" class="botao" /></td>
                    </tr>
                </table>
		        <tr>
            <td height="1" colspan="3" ></td>
        </tr>
	</table>
    <table width="580" border="0" cellpadding="0" cellspacing="1">
    	<tr>
    		<td ><div id="divUsarCreditos"></div></td>
        </tr>
    </table>
</form>
<?php
if($_POST['btConfirma']){
	//Array ( [txtMenu] => [txtTomCpfCnpj] => 05.005.501/0001-84 [txtImovel] => 57 [btConfirma] => Confirmar ) 
	$cnpj = $_POST['txtTomCpfCnpj'];
	$imovel = $_POST['txtImovel'];
	if($imovel!=""){
		$cod = $_POST['hdCod'];
		$vercredito = mysql_query("SELECT credito FROM cadastro WHERE codigo = '$cod'");
		list($credito)=mysql_fetch_array($vercredito);
		if($credito>0){
			$procura = mysql_query("SELECT * FROM creditos_imoveis WHERE codcadastro = '$cod' AND estado = 'A'");
			if(mysql_num_rows($procura)>0){
				Mensagem("Esse CNPJ já fez solicita&ccedil;&atilde;o e aguarda libera&ccedil;&atilde;o da prefeitura.");
			}else{
				if(mysql_query("INSERT INTO creditos_imoveis (codcadastro, codimovel) VALUES ('$cod','$imovel')")){
					Mensagem('Solicita&ccedil;&atilde;o enviada &agrave; prefeitura');	
				}else{
					Mensagem('Erro ao fazer solicita&ccedil;&atilde;o');	
				}
			}
		}else{
			Mensagem("Esse CNPJ n&atilde;o possui cr&eacute;ditos");	
		}
	}else{
		Mensagem("Nenhum im&oacute;vel selecionado");	
	}
	//$sql = mysql_query("SELECT * FROM cadastro");
}
?>