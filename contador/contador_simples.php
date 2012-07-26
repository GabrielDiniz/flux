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
			alert('Acesso Negado!');
			window.location='login.php';
		</script>
	";
}else{?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>e-Nota</title><script src="../scripts/padrao.js" language="javascript" type="text/javascript"></script>
<link href="../css/padrao_emissor.css" rel="stylesheet" type="text/css" />
<? include '../include/site-head.php'; ?>
</head>

<body>
	<?php include("../include/topo.php"); ?>
	<section> 
	<div class=" container_12">
    	<div class="wrapper">
			<?php include("inc/menu.php"); ?>
			<div class="boxbase">
			

				<!-- frame central lateral direita inicio -->	
				<div style="margin: 15px;">
				    <b>Contador Simples Nacional, escolha um de seus clientes para emitar seu Livro Digital e Guia de Pagamento.</b>
				    <br /><br />
				    <form method="post">
				        <?php
				            $sql = mysql_query("SELECT codigo FROM tipo WHERE nome LIKE '%Simples Nacional%'");
				            list($codSimples) = mysql_fetch_array($sql);
				            $sqlCliente = mysql_query("
				                SELECT
				                    codigo,
				                    nome,
				                    IF(cpf<>'',cpf,cnpj) AS doc
				                FROM cadastro
				                WHERE codcontador = '{$_SESSION['codempresa']}'
				                AND codtipodeclaracao <> '$codSimples'
				            ");
				        ?>
				        Escolha seu cliente &nbsp;
				        <select name="cmbCliente" id="cmbCliente">
				            <?php
				                while($cliente = mysql_fetch_object($sqlCliente)){
				                    echo "<option value='{$cliente->codigo}'>";
				                    echo $cliente->nome." - ".$cliente->doc;
				                    echo "</option>";
				                }
				            ?>
				        </select>
				        &nbsp;
				        <input type="submit" class="botao" name="btEscolher" value="Escolher" />
				    </form>
				    <?php
				        if($_POST['btEscolher']){
				            Mensagem("Menus Liberados");
				        }
				    ?>
				</div>
			</div>
		</div>
	</div>	
	</section>	
	<?php include("../include/rodape.php"); ?>
</body>
</html>
<?php }?>