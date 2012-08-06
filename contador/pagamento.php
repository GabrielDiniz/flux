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
session_name("contador");
session_start();
if(!(isset($_SESSION["empresa"])))
{   
  echo "
	  <script>
		  alert('Acesso Negado!!');
		  window.location='login.php';
	  </script>
  ";
}else{?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>e-Nota</title>
<script language="javascript" src="../scripts/java_contador.js" type="text/javascript"></script>
<?php // include("scripts/java.php")?>
<link href="../css/padrao_contador.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../scripts/java_site.js" ></script>
<script language="javascript" src="../scripts/padrao.js" ></script>
<? include '../include/site-head.php'; ?>
</head>

<body>
	<?php include("../include/topo.php"); ?>
	<section> 
	<div class=" container_12">
    	<div class="wrapper">
			<?php include("inc/menu.php"); ?>
			<div class="boxbase">
				<?php include("inc/pagamento_principal.php"); ?>
			</div>
		</div>
	</div>	
	</section>	
	<?php include("../include/rodape.php"); ?>
</body>
</html>

<?php }

if($_POST["btBoleto"]){			
		$codigolivro		= $_POST["hdLivro"];
		$codemissor		= $_POST["txtEmissor"];
		$sql_livro		= mysql_query("SELECT * FROM livro WHERE codigo = '$codigolivro'");
		$dados_livro		= mysql_fetch_array($sql_livro);
		$hoje=date("Y-m-d");
		$dataem     = explode("-",$hoje);
	
		$dataInicio=DataPt($dados_livro["vencimento"]);
		$dataFim=DataPt($hoje);
	
		$dias = diasDecorridos($dataInicio, $dataFim);
	
		$multa = calculaMultaDes($dias, $dados_livro['valorisstotal']);
	
		$sql_banco=mysql_query("SELECT bancos.codigo, bancos.boleto FROM bancos INNER JOIN boleto ON bancos.codigo=boleto.codbanco");
		list($codbanco,$boleto)=mysql_fetch_array($sql_banco);
	
		if($DIRETORIOINTEGRACAO){
			chdir('../');
			$x = getcwd();
			$x = explode('/',$x);
			$x = end($x);
			if($x=='trunk'){
				$diretorio=('../../middleware/'.$DIRETORIOINTEGRACAO);			
			}else{
				$diretorio=('../middleware/'.$DIRETORIOINTEGRACAO);
			}
			
			$ACAO = "insere_guia_nfe";
			require "$diretorio/index.php";
			
		}else{	
			$vencimento 	= explode("-",$dados_livro['vencimento']);
			$vencimentoguia = UltDiaUtil($vencimento[1],$vencimento[0],true);
			
			$insere_guia = ("
                INSERT INTO guia_pagamento
                SET	valor='{$dados_livro['valorisstotal']}',
                valormulta='$multa',
                dataemissao='$hoje',
                datavencimento='$vencimentoguia',
                pago='N', estado='N',
                codlivro='$codigolivro'
            ");


			if(mysql_query($insere_guia)){
				$sqlguia=mysql_query("SELECT MAX(codigo) FROM guia_pagamento");
				list($codguiapag)=mysql_fetch_array($sqlguia);
				
				$nossonumero = gerar_nossonumero($codguiapag,$dados_livro['vencimento']);
				$chavecontroledoc = gerar_chavecontrole($dados_livro["codigo"],$codguiapag);
				
				mysql_query("UPDATE guia_pagamento SET nossonumero='$nossonumero', chavecontroledoc='$chavecontroledoc' WHERE codigo='$codguiapag'");
				
				$sql_boleto=mysql_query("SELECT MAX(codigo) FROM guia_pagamento");
				list($codigoboleto)=mysql_fetch_array($sql_boleto);	
		
					$atualiza_livro = ("UPDATE livro SET estado='B' WHERE codigo='$codigolivro'");
					
					if(mysql_query($atualiza_livro)){
						Mensagem("Boleto gerado com sucesso");
						imprimirGuia($codigoboleto);
						Redireciona("pagamento.php");	
					}else{
						Mensagem("Erro ao atualizar livro. Contate a prefeitura");
					}
				
			}else{
				Mensagem("Erro ao inserir guia de pagamento. Contate a prefeitura");	
			}	
		}
}
?>

