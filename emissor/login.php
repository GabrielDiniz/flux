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
// inicia a sess�o verificando se jah esta com o usuario logado, se estiver entra na p�gina admin


session_name("emissor");
session_start();
$_SESSION['autenticacao'] = rand(10000,99999);

if(!(isset($_SESSION["empresa"])))
{  
	?>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
	<? include ("../include/site-head.php"); ?>
 	<script src=""></script>
</head>
<body>
 <?php include("../include/topo.php"); ?> 
 
<!-- formulario de login --> 
<form action="inc/verifica.php" method="post" onsubmit="return verificaCnpjCpfCodigo();ValidaLogin('txtSenha|codseguranca');">

	  <!-- content -->
<section>
<div class=" container_12">
	<div class="wrapper">
		<div class="grid_6 prefix_3">
			<div class="box3">
				
				<h4>CPF/CNPJ</h4>
				<p>
					<input type="text" name="txtLogin" id="txtLogin" size="30" class="texto" onkeyup="CNPJCPFMsk( this )"  onkeydown="return NumbersOnly(event); "/>
				</p>
				ou
				<h4> Código</h4>
				<p>
					<input type="text" name="txtCodigo" id="txtCodigo" size="30" class="texto" onkeydown="return NumbersOnly(event);" />
				</p>
				<br/>
				<h4> Senha</h4>
				<p>
					<input type="text" name="txtCodigo" id="txtCodigo" size="30" class="texto" onkeydown="return NumbersOnly(event);" />
				</p>
			</div>
		</div>
	</div>
</div>
</section>
<!-- 
	    
	  
	  <td>	   	   
	   
	  </td>
	 </tr>
     <tr> 
	  <td align="left" colspan="2">
	    ou
	  </td>
	 </tr>
     <tr> 
	  <td align="left">
	   
	  </td>
	  <td>	   	   
	   
	  </td>
	 </tr>
	 <tr> 
	  <td align="left">
	    Senha
	  </td>
	  <td>	 
	   <input type="password" name="txtSenha" id="txtSenha" size="30" class="texto" />
	  </td>
	 </tr>
	 <tr valign="baseline"> 
	  <td style="font-size:9px">
	    C&oacute;d. Verifica&ccedil;&atilde;o
	  </td>
	  <td align="left" >	 
	   <input type="text" name="codseguranca" id="codseguranca" size="6" class="texto" />  &nbsp;
	   <img style="cursor: pointer;" onclick="mostrar_teclado();" src="../img/botoes/num_key.jpg" title="Teclado Virtual" /> &nbsp;
	   <?php include("inc/cod_verificacao.php"); ?></td>
	 </tr>
	 <tr>	 
	  <td align="center" colspan="2">
	   <input type="submit" name="btEntrar" size="30" value="Entrar" class="botao" />
	  </td>
	 </tr>
     <tr>
      <td align="center" colspan="2"><a href="../site/recuperarsenha.php">Recuperar Senha</a></td>
     </tr>
	</table>			
		</td>
	</tr>
	<tr>
    	<td height="1" colspan="3" bgcolor="#CCCCCC"></td>
	</tr>
</table>    
-->
</form>  


<?php include("../include/rodape.php"); ?>

</body>
</html>

<?php 

}else {

print("<script language=JavaScript>parent.location='aplic.php';</script>");
 
} 

?>  
