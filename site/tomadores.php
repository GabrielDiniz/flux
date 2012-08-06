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
  
  // arquivo de conexï¿½o com o banco
  include("../include/conect.php"); 
  
  // arquivo com funcoes uteis
  include("../funcoes/util.php");
  //print("<a href=index.php target=_parent><img src=../img/topos/$TOPO></a>");
  
?>

<script type="text/javascript">
	function buscaGuiasIssRetido(cnpj,cmbMes,cmbAno,retorno){
		var mes = document.getElementById(cmbMes).value;
		var ano = document.getElementById(cmbAno).value;
		
		ajax({
			url:'inc/tomadores/issretido_dec.ajax.php?cnpj='+cnpj+'&cmbAno='+ano+'&cmbMes='+mes+'&a=a',
			espera: function(){
				document.getElementById(retorno).innerHTML = 'Verificando...';
			},
			sucesso: function(){
				document.getElementById(retorno).innerHTML = respostaAjax;		
			}
		});
	}	

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<? include '../include/site-head.php'; ?>
</head>

<body>
	<?php include("../include/topo.php"); ?>
    <div class=" container_12">
    <div class="wrapper">
    
<!-- box de conteudos -->
  	<?php  include("inc/tomadores/links.php"); ?>
		<div class="boxbase">
			<div class="grid_8 padRT2">
				<h2 class="padbot"></h2>
				
					<?php
						if(!$_GET["cred"]){
							if($_POST["txtMenu"])
								{
									include("inc/tomadores/".$_POST["txtMenu"].".php");
								}else {
									echo("<p class='textoInicial'> Olá seja bem vindo ao sistema digital de emissão de notas fiscais de serviços. Neste ambiente você, tomador, poderá fazer consultas a RPS (recibo provisório de serviço), poderá também consultar a autenticidade das notas a você emitidas e ainda gerar guias de declarações com ISS retido agregando ao seu trabalho modernidade, comodidade,  agilidade e segurança.</p>");
									
								}
						}else{
							include("inc/tomadores/creditos.php");
						}
					 ?>    
					 
			</div>
		</div>
	</div>
</div>
 <?php include("../include/rodape.php"); ?>

</body>
</html>
