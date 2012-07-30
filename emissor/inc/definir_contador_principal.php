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
	$login = $_SESSION['login'];
	$campo = tipoPessoa($login);	
	if($_POST['btRemover']){
		mysql_query("UPDATE cadastro SET codcontador = NULL WHERE $campo = '$login'");
		add_logs('Removeu contador');
	}
	if($btAtualizar=="Atualizar"){
		$cod = $_POST['txtCod'];
		mysql_query("UPDATE cadastro SET 
				contadornfe ='{$_POST['txtNfe']}',
				contadorlivro ='{$_POST['txtLivro']}',
				contadorguia='{$_POST['txtGuia']}',
				contadorrps='{$_POST['txtRps']}' WHERE codigo = '$cod'");	
					
				echo "<script>alert('Dados atualizados com sucesso!!')</script>";
		}
	
	if($btDefinirContador!="")
		{
			$sql = mysql_query("UPDATE cadastro SET codcontador = '$cmbContador' WHERE $campo = '$login'");
			Mensagem_onload('Contador definido com sucesso!');
			add_logs('Definido contador');
		}	
	$sql = mysql_query("SELECT codigo,contadornfe,contadorlivro,contadorguia,contadorrps FROM cadastro WHERE $campo = '$login'");
	list($codempresa, $contnfe, $contlivro,$contguia, $contrps)=mysql_fetch_array($sql);
	
		

	$sql = mysql_query("SELECT codcontador FROM cadastro WHERE $campo = '$login'");
	list($codcontador)=mysql_fetch_array($sql);
	$sql = mysql_query("SELECT razaosocial FROM cadastro WHERE codigo = '$codcontador'");
	list($nomecontador)=mysql_fetch_array($sql);
	if($nomecontador==""){
		$mensagem = "Voc&eacute; ainda n&atilde;o possui contador autorizado";
	}else {
		$mensagem="Seu contador atual &eacute; <font color=\"#FF0000\"><b>".$nomecontador."</b></font>";
	}

?>
<form method="post" name="frmBusca">
<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Definir Novo Contador</td>
      <td width="400" bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
	  <td height="1" ></td>
      <td ></td>
	</tr>
	<tr>
	  <td height="10" bgcolor="#FFFFFF"></td>
      <td bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td colspan="3" height="1" ></td>
	</tr>
	<tr>
		<td height="60" colspan="3" >

<table width="100%" border="0" cellpadding="2" cellspacing="2">
	
    <tr>
        <td align="left" width="100">Nome</td>
        <td align="left"><input type="text" name="txtNome" class="texto" /></td>
		</tr>
    <tr>
        <td align="left">CNPJ/CPF</td>
        <td align="left"><input type="text" name="txtCNPJ" class="texto" onkeydown="stopMsk( event );return NumbersOnly( event );" onkeyup="CNPJCPFMsk( this );" /></td>
		</tr>
    <tr>
        <td colspan="2" align="left">
        	<input type="submit" name="btBuscar" class="botao" value="Pesquisar" />
        	       </td>
    </tr>
</table>
    <?php
		if($btBuscar!=""){
		
			include("definir_contador_final.php");
		}
	?>	

		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>    
</table>
<table border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
      <td width="10" height="10" bgcolor="#FFFFFF"></td>
	  <td width="170" align="center" bgcolor="#FFFFFF" rowspan="3">Permiss&otilde;es do Contador</td>
      <td width="400" bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
	  <td height="1" ></td>
      <td ></td>
	</tr>
	<tr>
	  <td height="10" bgcolor="#FFFFFF"></td>
      <td bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td colspan="3" height="1" ></td>
	</tr>
	<tr>
		<td height="60" colspan="3" >

<table width="100%" border="0" cellpadding="2" cellspacing="2">
	<tr>
    	<td colspan="2"><em>Contador: <?php echo $mensagem; ?></em><br /></td>
	</tr>
    <tr>
	   	<td>
			 <input type="submit" value="Excluir" name="btRemover"  class="botao" />
		</td>
	</tr>
    <tr>
		<td> 
			NFE: &nbsp;</td>
        
        <td>Sim
		
          <input type="radio" name="txtNfe"  value="S" id="txtNfe" <?php if($contnfe == 'S'){ echo "checked=checked"; } ?> />
N&atilde;o
			<input type="radio" name="txtNfe"  value="N" id="txtNfe" <?php if($contnfe == 'N'){ echo "checked=checked"; } ?> /></td>
    </tr>
    <tr>
		<td>Livro: &nbsp;</td>
        <td>Sim		
          <input type="radio" name="txtLivro" value="S"  id="txtLivro" <?php if($contlivro == 'S'){ echo "checked=checked"; } ?> />
N&atilde;o
<input type="radio" name="txtLivro" value="N"  id="txtLivro" <?php if($contlivro == 'N'){ echo "checked=checked"; } ?> /></td>
    </tr>
    	<tr>
			<td>Guia: &nbsp;</td>
		    <td>Sim
			 <input type="radio" name="txtGuia" value="S" id="txtGuia" <?php if($contguia == 'S'){ echo "checked=checked"; } ?> />
N&atilde;o
<input type="radio" name="txtGuia" value="N" id="txtGuia" <?php if($contguia == 'N'){ echo "checked=checked"; } ?> /></td>
    	</tr>
		<tr>
			<td>RPS: &nbsp;</td>
		    <td>Sim
		      <input type="radio" name="txtRps" value="S" id="txtRps" <?php if($contrps == 'S'){ echo "checked=checked"; } ?> />
N&atilde;o
			<input type="radio" name="txtRps" value="N" id="txtRps" <?php if($contrps == 'N'){ echo "checked=checked"; } ?> /></td>
		</tr>
    <tr>
        <td colspan="2" align="left">
			<input type="hidden" name="txtCod" value="<?php echo $codempresa;?>">
        	<input name="btAtualizar" type="submit" class="botao" id="btAtualizar" value="Atualizar" />
			
		</td>
    </tr>
</table>
    <?php
		/*if($btAtualizar!=""){
			include("definir_contador_final.php");
		}*/
	?>	

		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" ></td>
	</tr>    
</table> 
</form>
