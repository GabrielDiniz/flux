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
require_once("../../../include/conect.php");
require_once("../../../funcoes/util.php"); 
/*
if($_POST){
	
	$cod_guia=base64_encode($_POST['hdCodigoGuia']);

	/*
	
	if($_POST['hdCnpjComTomador']!=""){//des com discriminacao de tomador
		include 'gerarguia_comtomador.php';
	}
	if($_POST['hdCNPJ']!=""){//des sem tomador e o cnpj do emissor nao cadastrado
		include 'gerarguia_semtom_cnpjnaocad.php';
	}
	if($_POST['hdCNPJsemTomador']!=""){//des sem tomador e emissor cadastrado
		include 'gerarguia_semtomador.php';
	}
	if($_POST['hdTotalInputs']!=""){//declaracao de iss retido
		include 'gerarguia_issretido.php';
	}
	
	//Mensagem("Serviço(s) declarado(s)!");
	//Redireciona("../../tomadores.php");
	Redireciona("../../../boleto/pagamento/boleto_bb.php?COD=$cod_guia");
}*/
$codnota		= $_POST["hdCodigoGuia"];
$codemissor		= $_POST["txtEmissor"];
$hoje           = date("Y-m-d");
$dataem         = explode("-",$hoje);

$sql = mysql_query("SELECT codemissor, issretido, DATE(datahoraemissao) AS data FROM notas WHERE codigo = '$codnota'");
$dados_notas = mysql_fetch_array($sql);

/*$dataem = explode("-", $dados_notas['data']);

if($dataem[1] < 12){
	$aux = $dataem[1]+1;
	if(($aux < 10) && (strlen($aux) < 2)){
		$aux = "0".$aux;
	}
}else{
	$aux = 01;
	$dataem[2] = $dataem[2] + 1;
}
$vencimento = $dataem[0]."-". $aux ."-".$dataem[2];
*/

$vencimento = UltDiaUtil($dataem[1],$dataem[0], true);
$dataInicio=DataPt($vencimento);
$dataFim=DataPt($hoje);
$dias = diasDecorridos($dataInicio, $dataFim);
if($dias < 0){
	$dias = 0;
}
$multa = calculaMultaDes($dias, $dados_notas['issretido']);

$sql_banco = mysql_query("SELECT bancos.codigo, bancos.boleto FROM bancos INNER JOIN boleto ON bancos.codigo = boleto.codbanco");
list($codbanco,$boleto)=mysql_fetch_array($sql_banco);

$insere_guia = ("
	INSERT INTO 
		guia_pagamento
	SET	
		valor = '{$dados_notas['issretido']}',
		valormulta = '$multa',
		dataemissao = '$hoje',
		datavencimento = '$vencimento',
		pago = 'N', 
		estado = 'N',
		codnota = '$codnota'
");


if(mysql_query($insere_guia)){
	$sqlguia=mysql_query("SELECT MAX(codigo) FROM guia_pagamento");
	list($codguiapag)=mysql_fetch_array($sqlguia);
	$nossonumero = gerar_nossonumero($dados_notas['codemissor'],$vencimento);
	$chavecontroledoc = gerar_chavecontrole($dados_notas["codemissor"],$codguiapag);
	mysql_query("UPDATE guia_pagamento SET nossonumero='$nossonumero', chavecontroledoc='$chavecontroledoc' WHERE codigo='$codguiapag'");
	
	$sql_boleto=mysql_query("SELECT MAX(codigo) FROM guia_pagamento");
	list($codigoboleto)=mysql_fetch_array($sql_boleto);	
	$crypto = base64_encode($codigoboleto);
	Mensagem("Boleto gerado com sucesso");
	//imprimirGuia($codigoboleto);
	print("<script>window.location = '../../../boleto/recebimento/index.php?COD=$crypto';</script>");
	//Redireciona("pagamento.php");	
			
}else{
	Mensagem("Erro ao inserir guia de pagamento. Contate a prefeitura");	
}	
?>