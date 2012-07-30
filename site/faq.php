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
  
  // arquivo de conexão com o banco
  include("../include/conect.php"); 
  
  // arquivo com funcoes uteis
  include("../funcoes/util.php");
  //print("<a href=index.php target=_parent><img src=../img/topos/$TOPO></a>");
  
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>e-Nota</title>

<script src="../scripts/java_site.js" language="javascript" type="text/javascript"></script>

<script type="text/javascript" src="../scripts/lightbox/prototype.js"></script>
<script type="text/javascript" src="../scripts/lightbox/scriptaculous.js?load=effects,builder"></script>
<script type="text/javascript" src="../scripts/lightbox/lightbox.js"></script>
<link rel="stylesheet" href="../css/lightbox.css" type="text/css" media="screen" />

<link href="../css/padrao_site.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
#apDiv1 {
	position:absolute;
	left:40%;
	top:45%;
	width:400px;
	height:160px;
	z-index:1;
	background-image: url(../img/index/indicativos.jpg);
}
.style1 {
	font-size: 12pt;
	color: #FF0000;
	font-weight: bold;
}
.style2 {	font-size: 10pt;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<div id="apDiv1" style="visibility:hidden" onclick="javascript:changeProp('apDiv1','','visibility','hidden','DIV')"><br />
  <br />
  <br />
  <br />
  <br />
  <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<?php
$sql = mysql_query("SELECT COUNT(codigo) FROM emissores WHERE estado = 'A'");
list($empresas_ativas) = mysql_fetch_array($sql);
echo "<font color=#FF0000 size=4><strong>$empresas_ativas</strong></font>";
	
?>
<br />
<br />
<br />

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<?php
$sql = mysql_query("SELECT COUNT(codigo) FROM notas");
list($notas_emitidas) = mysql_fetch_array($sql);
echo "<font color=#FF0000 size=4><strong>$notas_emitidas</strong></font>";
	
	?>
</div>
<table width="760" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><?php include("inc/topo.php"); ?></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" height="400" valign="top" align="center">
	
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="170" rowspan="2" align="left" valign="top" background="../img/menus/menu_fundo.jpg"><?php include("inc/menu.php"); ?></td>
    <td align="right" valign="top" width="590"><img src="../img/cabecalhos/faq.jpg" width="590" height="100" /></td>
  </tr>
  <tr>
    <td align="center" valign="top">
    
    
<table width="100%" border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td align="center" valign="top">
    <!-- quadro da esquerda acima -->
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="3" ></td>
      </tr>
      <tr>
        <td height="10" ></td>
      </tr>
      <tr>
        <td height="1"></td>
      </tr>
      <tr>
        <td height="5" align="left" bgcolor="#859CAD"></td>
      </tr>
    </table>    
	
	<!-- Quadro do meio acima -->
	
	<!-- quadro direita acima --></td>
    </tr>
  <tr>
    <td align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="3" ></td>
      </tr>
      <tr>
        <td height="10" ></td>
      </tr>
      <tr>
        <td height="120" align="left" valign="top"  style="padding:5px;"><table width="500" border="0" cellspacing="0" cellpadding="5">
          <tr>
            <td align="left" background="img/index_oquee_fundo.jpg"><p>01 &ndash; CONCEITOS</p>
              <p><strong>1.01. O que &eacute; Nota Fiscal Eletr&ocirc;nica de Servi&ccedil;os (NFS-e)?</strong><br />
                Nota Fiscal Eletr&ocirc;nica  de Servi&ccedil;os (NFS-e) &eacute; o documento emitido e armazenado eletronicamente em  sistema pr&oacute;prio da Prefeitura Municipal, com o objetivo de registrar as  opera&ccedil;&otilde;es relativas &agrave; presta&ccedil;&atilde;o de servi&ccedil;os. A NFS-e n&atilde;o deve ser confundida  com a Nota Fiscal de ICMS, de responsabilidade do Governo Estadual, que  registra opera&ccedil;&otilde;es relativas &agrave; circula&ccedil;&atilde;o de mercadorias: supermercados, lojas,  restaurantes etc.</p>
              <p><strong>1.02. O que &eacute; Nota Fiscal Convencional?</strong><br />
  &Eacute; qualquer uma das notas  fiscais de servi&ccedil;os emitidas na conformidade do que disp&otilde;em as leis j&aacute; envigor.  A nota fiscal convencional s&oacute; poder&aacute; ser emitida por prestadores de servi&ccedil;os  desobrigados a emiss&atilde;o de NFS-e at&eacute; o dia 31 de dezembro de 2011. Veja no item  3.01 quais s&atilde;o os prestadores obrigados a emitir NFS-e.</p>
              <p><strong>1.03. O que &eacute; Recibo Provis&oacute;rio de Servi&ccedil;os (RPS)?</strong><br />
  &Eacute; o documento que dever&aacute; ser usado por emitentes da NFS-e no eventual  impedimento da emiss&atilde;o &ldquo;on-line&rdquo; da Nota. Nesse caso, o prestador emitir&aacute; o RPS para cada transa&ccedil;&atilde;o e  providenciar&aacute; sua convers&atilde;o em NFS-e at&eacute; o dia 20 do m&ecirc;s seguinte a sua  emiss&atilde;o.</p>
              <p>02 - RECIBO PROVIS&Oacute;RIO  DE SERVI&Ccedil;OS (RPS)</p>
              <p><strong>2.01. Como gerar o RPS?</strong><br />
                H&aacute; modelo padr&atilde;o para o  RPS, ele dever&aacute; ser confeccionado ou impresso de acordo com o modelo disposto  no perfil do prestador de servi&ccedil;o.</p>
              <p><strong>2.02. O RPS deve ser confeccionado por gr&aacute;fica credenciada pela  Prefeitura? </strong><br />
                N&atilde;o h&aacute; essa necessidade.  O RPS poder&aacute; ser&nbsp; impresso no Sistema da  NFS-e, sem a necessidade de solicita&ccedil;&atilde;o da Autoriza&ccedil;&atilde;o de Impress&atilde;o de  Documento Fiscal (AIDF). Por&eacute;m, caso o contribuinte, opte pela impress&atilde;o do RPS  num estabelecimento gr&aacute;fico, dever&aacute; solicitar AIDF.<br />
  <br />
  <strong>2.03. O RPS deve ter numera&ccedil;&atilde;o  seq&uuml;encial espec&iacute;fica?</strong><br />
                Sim. O RPS deve ser  numerado obrigatoriamente em ordem crescente seq&uuml;encial, a partir do n&uacute;mero 1  (um). Para quem j&aacute; &eacute; emitente de nota fiscal convencional, o RPS dever&aacute; manter  a seq&uuml;&ecirc;ncia num&eacute;rica do &uacute;ltimo documento fiscal emitido. <br />
  <br />
  <strong>2.04. O que fazer com as notas fiscais  convencionais j&aacute; confeccionadas?</strong> <br />
                As notas fiscais convencionais j&aacute; confeccionadas poder&atilde;o ser utilizadas at&eacute; o  dia 31 de dezembro de 2011. Ap&oacute;s esta data os talon&aacute;rios utilizados durante o  exerc&iacute;cio de 2011 e os n&atilde;o utilizados dever&atilde;o ser apresentados no Setor de Fiscaliza&ccedil;&atilde;o  de Tributos, da Secretaria Municipal de Planejamento e Finan&ccedil;as, que  inutilizar&aacute; as notas fiscais convencionais n&atilde;o utilizadas. Leia tamb&eacute;m o item 2.07. Se a op&ccedil;&atilde;o for pela emiss&atilde;o  &ldquo;on-line&rdquo; de NFS-e, <br />
  <br />
  <strong>2.05. Em quantas vias deve-se emitir o  RPS?</strong><br />
                O RPS deve ser emitido em duas vias. A 1&ordf; ser&aacute; entregue ao tomador de servi&ccedil;os,  ficando a 2&ordf; em poder do prestador dos servi&ccedil;os. Os RPS convertidos, n&atilde;o  convertidos ou cancelados devem ser guardados por cinco anos contados do dia 1&ordm;  de janeiro do ano seguinte ao da emiss&atilde;o. <br />
  <br />
  <strong>2.06. &Eacute; necess&aacute;rio converter o RPS ou a  nota fiscal convencional por NFS-e?</strong> <br />
                Sim. Os RPS ou as notas fiscais convencionais emitidas perder&atilde;o a validade,  para todos os fins de direito, depois de transcorrido o prazo de convers&atilde;o em NFS-e. <br />
  <br />
  <strong>2.07. Qual o prazo para converter o RPS  ou a nota fiscal convencional por NFS-e?</strong><br />
                Os RPS ou as notas fiscais convencionais dever&atilde;o ser convertidas em&nbsp; NFS-e at&eacute; o dia 20 do m&ecirc;s subseq&uuml;ente ao de  sua emiss&atilde;o.<br />
  <br />
  <strong>2.08. O que acontece no caso de n&atilde;o convers&atilde;o  do RPS ou da nota fiscal convencional em NFS-e?<br />
  </strong>A n&atilde;o-convers&atilde;o do RPS ou da nota fiscal convencional em NFS-e equipara-se  a n&atilde;o-emiss&atilde;o de documento fiscal e sujeitar&aacute; o prestador de servi&ccedil;os &agrave;s  penalidades previstas na legisla&ccedil;&atilde;o. <br />
  <br />
  <strong>2.09. O que acontece no caso de convers&atilde;o fora do prazo do RPS ou da  nota fiscal convencional em NFS-e?</strong> <br />
                A convers&atilde;o fora do prazo do RPS ou da nota fiscal convencional em NFS-e  sujeitar&aacute; o prestador de servi&ccedil;os &agrave;s penalidades previstas na legisla&ccedil;&atilde;o.<br />
  <br />
  <strong>2.10. &Eacute; permitido o uso de notas fiscais convencionais conjugadas  (mercadorias e servi&ccedil;os) no lugar do RPS?</strong> <br />
                N&atilde;o <br />
  <br />
  <strong>2.11. &Eacute; permitido o uso de cupons fiscais no lugar do RPS? </strong><br />
                N&atilde;o.<br />
  <br />
  <strong>2.12. Qual o procedimento a ser adotado no caso de cancelamento de RPS  antes da convers&atilde;o em NFS-e? </strong><br />
                O contribuinte poder&aacute;: <br />
                1) Converter o RPS cancelado e cancelar a respectiva NFS-e; ou <br />
                2) Optar pela n&atilde;o convers&atilde;o do RPS cancelado. Nesse caso, dever&aacute; manter em  arquivo, por cinco anos, todas as vias do RPS com a indica&ccedil;&atilde;o de &ldquo;cancelado&rdquo;.  Caso contr&aacute;rio, seu cancelamento n&atilde;o ser&aacute; considerado. O sistema da NFS-e  controla a seq&uuml;&ecirc;ncia num&eacute;rica dos RPS convertidos. <br />
  <strong><br />
    2.13. Como proceder no caso do prestador n&atilde;o converter o RPS em NFS-e?</strong><br />
                Se o seu prestador n&atilde;o efetuar a convers&atilde;o do Recibo Provis&oacute;rio de Servi&ccedil;os  (RPS) em NFS-e informe o fato &agrave; Prefeitura Municipal da Cidade no campo  &quot;Reclama&ccedil;&otilde;es&quot; dispon&iacute;vel no website da NFe da Cidade. <br />
  <br />
                03 - OBRIGATORIEDADE DE EMISS&Atilde;O DE NFS-e <br />
  <br />
  <strong>3.01. Quem est&aacute; obrigado &agrave; emiss&atilde;o da NFS-e? </strong><br />
                I- <strong>a contar do dia 1&ordm; de outubro de 2011:</strong>&nbsp;&nbsp;&nbsp; <br />
                a) as empresas enquadradas na categoria  geral, ou que n&atilde;o s&atilde;o optantes pelo Simples Nacional; <br />
                b) as empresas mesmo que optantes do  simples nacional que desenvolvam servi&ccedil;os dos itens da Lista de servi&ccedil;os:<br />
                1- no item 1 - Servi&ccedil;os de inform&aacute;tica e  cong&ecirc;neres;<br />
                2- no item 2 - Servi&ccedil;os de Pesquisa e  Desenvolvimento de Qualquer Natureza; - <br />
                3- no item 17 - Servi&ccedil;o de apoio t&eacute;cnico, administrativo, jur&iacute;dico, cont&aacute;bil,  comercial e cong&ecirc;neres;<br />
  &nbsp;<br />
  <strong>II - a contar do dia 1&ordm; de janeiro de 2012, para os demais prestadores de  servi&ccedil;os.</strong><br />
                III - O prestadores desobrigados  tamb&eacute;m podem optar pela utiliza&ccedil;&atilde;o de NFS-e. Leia o item 3.09. <strong></strong><br />
  <br />
  <strong>3.02. A partir de quando a emiss&atilde;o de NFS-e &eacute; obrigat&oacute;ria? </strong><br />
                Todos os contribuintes dever&atilde;o obrigatoriamente emitir A NFS-e ou o RPS a  partir de 1&ordm; de janeiro de 2012. <br />
  <br />
  <strong>3.03. Como devo apurar meu faturamento para saber se devo emitir a  NFS-e?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz<br />
  <br />
  <strong>3.04. Quem iniciou a atividade de presta&ccedil;&atilde;o de servi&ccedil;os durante um  determinado exerc&iacute;cio (a partir de 2005) est&aacute; obrigado &agrave; emiss&atilde;o de NFS-e no  exerc&iacute;cio seguinte?<br />
  </strong>N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz<br />
  <br />
  <strong>3.05. Como fica a obrigatoriedade de emiss&atilde;o de NFS-e, considerando a  data de in&iacute;cio de atividade de presta&ccedil;&atilde;o de servi&ccedil;o?</strong><br />
  <em>N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</em><br />
  <em><br />
  </em><strong>3.06. Se o prestador de servi&ccedil;os obrigado &agrave; emiss&atilde;o de NFS-e  auferir, em determinado exerc&iacute;cio, receita bruta de servi&ccedil;os inferior ao valor  deteminado poder&aacute; voltar a emitir nota fiscal convencional?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz<br />
  <br />
  <strong>3.07. O contribuinte enquadrado em mais de um c&oacute;digo de presta&ccedil;&atilde;o de  servi&ccedil;os dever&aacute; emitir NFS-e para todos os servi&ccedil;os? </strong><br />
  <br />
                Sim. O contribuinte que emitir NFS-e dever&aacute; faz&ecirc;-lo para todos os servi&ccedil;os  prestados. <br />
  <strong><br />
    3.08. O contribuinte enquadrado em mais de um c&oacute;digo de presta&ccedil;&atilde;o de servi&ccedil;os  dever&aacute; obedecer ao cronograma de emiss&atilde;o de NFS-e para cada c&oacute;digo de servi&ccedil;o?</strong><br />
                N&atilde;o. Na hip&oacute;tese do contribuinte se enquadrar em mais de um c&oacute;digo de presta&ccedil;&atilde;o  de servi&ccedil;os, dever&aacute; adotar, para todos os c&oacute;digos, a mesma data de in&iacute;cio da  NFS-e<br />
  <br />
  <strong>3.09. Somente quem est&aacute; obrigado poder&aacute; emitir NFS-e? </strong><br />
                N&atilde;o. Todos os prestadores de servi&ccedil;os inscritos no Cadastro de Emissor da  NFS-e, desobrigados da emiss&atilde;o de NFS-e, poder&atilde;o optar por sua emiss&atilde;o. <br />
  <br />
  <strong>3.10. A op&ccedil;&atilde;o pela emiss&atilde;o de NFS-e depende de requerimento do  interessado?</strong><br />
                Sim. A autoriza&ccedil;&atilde;o para emiss&atilde;o de NFS-e deve ser solicitada atrav&eacute;s de  requerimento conforme modelo estabelecido no Decreto de Regulamenta&ccedil;&atilde;o da  NFS-e. A Secretaria Municipal de Planejamento e Finan&ccedil;as comunicar&aacute; aos  interessados, por &ldquo;e-mail&rdquo;, a delibera&ccedil;&atilde;o do pedido de autoriza&ccedil;&atilde;o. <br />
  <br />
  <strong>3.11. A op&ccedil;&atilde;o pela emiss&atilde;o de NFS-e, uma vez deferida, vigora a partir  de quando?</strong><br />
                Os prestadores de servi&ccedil;os que optarem pela NFS-e iniciar&atilde;o sua emiss&atilde;o no dia  seguinte ao do deferimento da autoriza&ccedil;&atilde;o, devendo converter em NFS-e&nbsp; todas as notas fiscais convencionais emitidas  no respectivo m&ecirc;s. <br />
  <br />
  <strong>3.12. A partir de quando uma empresa rec&eacute;m-aberta, que opte pela  utiliza&ccedil;&atilde;o de NFS-e, pode emitir RPS ou utilizar NFS-e? </strong><br />
                Uma empresa rec&eacute;m-aberta, que n&atilde;o disponha de blocos de notas fiscais  convencionais, s&oacute; poder&aacute; prestar servi&ccedil;os depois de obter a autoriza&ccedil;&atilde;o para  utiliza&ccedil;&atilde;o de NFS-e. N&atilde;o &eacute; poss&iacute;vel a emiss&atilde;o de NFS-e, ou a substitui&ccedil;&atilde;o de  RPS por NFS-e, com data anterior &agrave; data de autoriza&ccedil;&atilde;o para utilizar NFS-e. <br />
  <br />
  <strong>3.13. O prestador de servi&ccedil;os, desobrigado da emiss&atilde;o de NFS-e, que  optar pela NFS-e, poder&aacute; voltar a emitir nota fiscal convencional?</strong><br />
                N&atilde;o. A op&ccedil;&atilde;o pela emiss&atilde;o de NFS-e, uma vez deferida, &eacute; irretrat&aacute;vel. <br />
  <br />
  <strong>3.14. Uma vez deferida a autoriza&ccedil;&atilde;o para emiss&atilde;o de NFS-e, qual o  prazo para substituir as notas fiscais convencionais emitidas at&eacute; a data do  deferimento da autoriza&ccedil;&atilde;o?</strong><br />
                As notas fiscais convencionais, emitidas a partir do primeiro dia do m&ecirc;s da  autoriza&ccedil;&atilde;o para utiliza&ccedil;&atilde;o de NFS-e at&eacute; a data do deferimento dessa  autoriza&ccedil;&atilde;o, devem ser substitu&iacute;das at&eacute; o dia 20 do m&ecirc;s subseq&uuml;ente ao  deferimento. Consulte, tamb&eacute;m, o item 3.11. <br />
  <br />
  <strong>3.15. As entidades imunes ao ISS est&atilde;o obrigadas &agrave; emiss&atilde;o da NFS-e?</strong><br />
                As entidades imunes ao ISS, enumeradas pelo art. 150, VI, da Constitui&ccedil;&atilde;o  Federal, est&atilde;o dispensadas da emiss&atilde;o de documento fiscal. No entanto, se  optarem pela emiss&atilde;o de documento fiscal e se enquadrarem nas disposi&ccedil;&otilde;es lei,  dever&atilde;o se adequar &agrave;s exig&ecirc;ncias da NFS-e. O sistema da NFS-e permite a sele&ccedil;&atilde;o  do tipo de tributa&ccedil;&atilde;o do servi&ccedil;o, que, no caso em quest&atilde;o, seria &ldquo;imune&rdquo;. Nesse  caso, n&atilde;o ser&aacute; gerado cr&eacute;dito para o tomador dos servi&ccedil;os. <br />
  <br />
  <strong>3.16. As entidades isentas do ISS est&atilde;o obrigadas &agrave; emiss&atilde;o da NFS-e?</strong><br />
                As entidades isentas do ISS est&atilde;o obrigadas &agrave; emiss&atilde;o de documento fiscal.  Portanto, caso se enquadrem nas disposi&ccedil;&otilde;es da Lei, dever&atilde;o se adequar &agrave;s  exig&ecirc;ncias da NFS-e. O sistema da NFS-e permite a sele&ccedil;&atilde;o do tipo de tributa&ccedil;&atilde;o  do servi&ccedil;o, que, no caso, seria &ldquo;isento&rdquo;. <br />
  <br />
                04 - BENEF&Iacute;CIOS <br />
  <br />
  <strong>4.01. Quais os benef&iacute;cios para quem emite NFS-e?</strong><br />
                Redu&ccedil;&atilde;o de custos de impress&atilde;o e de armazenagem de documentos fiscais (a NFS-e  &eacute; um documento emitido e armazenado eletronicamente em sistema pr&oacute;prio da  Prefeitura); Dispensa de Autoriza&ccedil;&atilde;o para Impress&atilde;o de Documentos Fiscais  (AIDF) para a NFS-e; Emiss&atilde;o de NFS-e por meio da internet; Gera&ccedil;&atilde;o autom&aacute;tica  da guia de recolhimento por meio da internet; Possibilidade de envio de NFS-e  por e-mail; Maior efici&ecirc;ncia no controle gerencial de emiss&atilde;o de NFS-e;  Dispensa de lan&ccedil;amento das NFS-e na Declara&ccedil;&atilde;o Eletr&ocirc;nica de Servi&ccedil;os (DES). <br />
  <br />
  <strong>4.02. Quais os benef&iacute;cios para quem recebe NFS-e? <br />
  </strong>1. Gera&ccedil;&atilde;o autom&aacute;tica da guia de recolhimento por meio da internet, no  caso de respons&aacute;vel tribut&aacute;rio; <br />
                2. Possibilidade de recebimento de NFS-e por e-mail; <br />
                3. Maior efici&ecirc;ncia no controle gerencial de recebimento de NFS-e; <br />
                4. Dispensa de lan&ccedil;amento das NFS-e na Declara&ccedil;&atilde;o Eletr&ocirc;nica de Servi&ccedil;os (DES). </p>
              <p>05 - EMISS&Atilde;O, CANCELAMENTO E RETIFICA&Ccedil;&Atilde;O DE NFS-e <br />
                  <strong><br />
                    5.01. Como deve ser emitida a NFS-e?</strong><br />
                A NFS-e deve ser emitida &ldquo;on-line&rdquo;, por meio da internet, no endere&ccedil;o  eletr&ocirc;nico da Prefeitura Municipal, somente pelos prestadores de servi&ccedil;os  estabelecidos no munic&iacute;pio, ou prestadores com sede em outros munic&iacute;pios que  devam recolher ISSQN em Vera   Cruz, mediante a utiliza&ccedil;&atilde;o de senha. <br />
  <br />
  <strong>5.02. O que fazer em caso de eventual impedimento da emiss&atilde;o &ldquo;on line&rdquo;  da NFS-e?</strong><br />
                No caso de eventual impedimento da emiss&atilde;o &ldquo;on-line&rdquo; da NFS-e, o prestador de  servi&ccedil;os emitir&aacute; RPS, registrando todos os dados que permitam sua substitui&ccedil;&atilde;o  por NFS-e. <br />
  <br />
  <strong>5.03. &Eacute; obrigat&oacute;ria a emiss&atilde;o de NFS-e &ldquo;on line&rdquo;? </strong><br />
                N&atilde;o. Desde que o prestador n&atilde;o tenha equipamento ou acesso a internet. Assim, o  prestador de servi&ccedil;os poder&aacute; emitir RPS a cada presta&ccedil;&atilde;o de servi&ccedil;os, devendo,  nesse caso, efetuar a sua convers&atilde;o em NFS-e.<br />
  <br />
  <strong>5.04. Em quantas vias deve-se imprimir a NFS-e?</strong><br />
                A NFS-e dever&aacute; ser impressa por ocasi&atilde;o da presta&ccedil;&atilde;o de servi&ccedil;os em via &uacute;nica.  Sua impress&atilde;o poder&aacute; ser dispensada na hip&oacute;tese do tomador solicitar seu envio  por &ldquo;e-mail&rdquo;. <br />
  <br />
  <strong>5.05. Pode-se enviar a NFS-e por e-mail para o tomador de servi&ccedil;os? </strong><br />
                Sim. A NFS-e poder&aacute; ser enviada por &ldquo;e-mail&rdquo; ao tomador de servi&ccedil;os, desde que  por sua solicita&ccedil;&atilde;o. Nesse caso, o tomador pode dispensar a emiss&atilde;o da NFS-e. O  prestador de servi&ccedil;os poder&aacute;, inclusive, adicionar coment&aacute;rios ao e-mail. <br />
  <br />
  <strong>5.06. A NFS-e poder&aacute; ser impressa em modelo diverso do estabelecido em  regulamento? </strong><br />
                N&atilde;o.<br />
  <br />
  <strong>5.07. A NFS-e ter&aacute; numera&ccedil;&atilde;o seq&uuml;encial espec&iacute;fica? </strong><br />
                Sim. O n&uacute;mero da NFS-e ser&aacute; gerado pelo sistema, em ordem seq&uuml;encial, sendo  &uacute;nico para cada estabelecimento da empresa prestadora de servi&ccedil;os. </p>
              <p><strong>5.08. At&eacute; quando &eacute; poss&iacute;vel consultar a NFS-e,  ap&oacute;s sua emiss&atilde;o? </strong><br />
                As NFS-e emitidas poder&atilde;o ser consultadas e impressas &quot;on-line&quot; por 5  anos. Depois de transcorrido tal prazo, a consulta &agrave;s NFS-e emitidas somente  poder&aacute; ser realizada mediante a solicita&ccedil;&atilde;o de envio de arquivo em meio  magn&eacute;tico. </p>
              <p><strong>5.09. Pode-se utilizar uma NFS-e para  registrar mais de um tipo de servi&ccedil;o prestado? </strong><br />
                N&atilde;o. Para cada tipo de servi&ccedil;o prestado (c&oacute;digo de servi&ccedil;o) dever&aacute; ser emitida  uma NFS-e. Ou seja, uma NFS-e registra apenas um tipo de servi&ccedil;o. </p>
              <p><strong>5.10. Pode-se cancelar uma NFS-e emitida? Em  quais situa&ccedil;&otilde;es? </strong><br />
                A NFS-e poder&aacute; ser cancelada pelo emitente, at&eacute; o dia 5 do m&ecirc;s seguinte a sua  emiss&atilde;o, por meio do sistema, nas seguintes situa&ccedil;&otilde;es:<br />
                1. Cancelamento da NFS-e quando o ISS ainda n&atilde;o foi recolhido:<br />
                1.1. Cancelamento de NFS-e por n&atilde;o ter sido prestado o servi&ccedil;o Lembramos que o  fato gerador do ISS &eacute; a presta&ccedil;&atilde;o do servi&ccedil;o. Dessa forma, n&atilde;o havendo  presta&ccedil;&atilde;o de servi&ccedil;o, n&atilde;o h&aacute; ISS a recolher e a NFS-e pode ser cancelada.  Entretanto, caso tenha havido presta&ccedil;&atilde;o de servi&ccedil;o, o ISS correspondente deve  ser recolhido independentemente de ter ou n&atilde;o sido efetuado o pagamento pelo  servi&ccedil;o prestado. Nesse caso a NFS-e n&atilde;o poder&aacute; ser cancelada. <br />
                1.2. Cancelamento de NFS-e emitida com dados incorretos. Dados incorretos do  tomador dos servi&ccedil;os, quando este for pessoa jur&iacute;dica estabelecida no  munic&iacute;pio, n&atilde;o podem ser retificados pelo prestador dos servi&ccedil;os. Para corrigir  dados da NFS-e, inclusive os dados de tomador pessoa f&iacute;sica ou pessoa jur&iacute;dica  n&atilde;o estabelecida no munic&iacute;pio, o prestador de servi&ccedil;os dever&aacute; cancelar a NFS-e  e emitir outra, via RPS, em substitui&ccedil;&atilde;o &agrave; NFS-e incorreta, conforme instru&ccedil;&otilde;es  a seguir. Observar que a data de emiss&atilde;o do RPS dever&aacute; observar a data da  ocorr&ecirc;ncia do fato gerador, ou seja, a data da efetiva presta&ccedil;&atilde;o do servi&ccedil;o.  NFS-e com data retroativa: Caso t&iacute;pico: uma NFS-e foi emitida no dia 20/09. No  dia 04/10, constatou-se que essa NFS-e foi emitida incorretamente, sendo  necess&aacute;rio o seu cancelamento e posterior substitui&ccedil;&atilde;o por outra NFS-e. O  contribuinte, nesse caso, dever&aacute;: <br />
                a) Verificar se a NFS-e emitida incorretamente consta de guia de recolhimento  e, se for o caso, cancelar essa guia; <br />
                b) Cancelar a NFS-e; <br />
                c) Emitir um RPS com a data de 20/09, com os dados corretos; <br />
                d) Efetuar a substitui&ccedil;&atilde;o do RPS com os dados corretos em NFS-e. No formul&aacute;rio da  NFS-e, preencha o campo &quot;n&ordm; do RPS&quot;, &quot;S&eacute;rie do RPS&quot; e  &quot;Data de Emiss&atilde;o do RPS&quot; com os dados desse RPS. <br />
                e) Emitir uma nova guia de recolhimento, se for o caso. <br />
                Observa&ccedil;&otilde;es:<br />
                - Para mais informa&ccedil;&otilde;es sobre o cancelamento de NFS-e, consulte o manual de  acesso ao sistema da NFS-e (vers&atilde;o para download); <br />
                - Se a NFS-e j&aacute; tiver sido inclu&iacute;da em uma guia de recolhimento emitida, o  status da NFS-e aparecer&aacute; como &ldquo;Normal&rdquo;. Nesse caso, efetue o cancelamento da  referida guia para que seja poss&iacute;vel o cancelamento da NFS-e. <br />
                2. Cancelamento de NFS-e com ISS j&aacute; recolhido: Ap&oacute;s o recolhimento do imposto,  a NFS-e somente poder&aacute; ser cancelada por meio de processo administrativo. <br />
                2.1. Cancelamento de NFS-e por n&atilde;o ter sido prestado o servi&ccedil;o Lembramos que o  fato gerador do ISS &eacute; a presta&ccedil;&atilde;o do servi&ccedil;o. Dessa forma, n&atilde;o havendo  presta&ccedil;&atilde;o de servi&ccedil;o, n&atilde;o h&aacute; ISS a recolher e a NFS-e pode ser cancelada.  Entretanto, caso tenha havido presta&ccedil;&atilde;o de servi&ccedil;o, o ISS correspondente deve  ser recolhido independentemente de ter ou n&atilde;o sido efetuado o pagamento pelo  servi&ccedil;o prestado. Nesse caso, a NFS-e n&atilde;o poder&aacute; ser cancelada. A NFS-e dever&aacute;  ser cancelada e o ISS recolhido restitu&iacute;do mediante processo administrativo, ao  qual dever&atilde;o ser juntados os seguintes documentos: <br />
                - requerimento do interessado, em que conste o nome ou raz&atilde;o social, n&uacute;mero de  inscri&ccedil;&atilde;o no CCM, n&uacute;mero de inscri&ccedil;&atilde;o no CNPJ ou CPF, endere&ccedil;o completo,  telefone para contato, exposi&ccedil;&atilde;o clara do pedido e todos os elementos  necess&aacute;rios &agrave; sua prova; <br />
                - contrato social; <br />
                - RG e CPF do signat&aacute;rio; <br />
                - identifica&ccedil;&atilde;o da NFS-e a ser cancelada. <br />
                2.2. Cancelamento de NFS-e emitida com dados incorretos. Dados incorretos do  tomador dos servi&ccedil;os, quando este for pessoa jur&iacute;dica estabelecida no  munic&iacute;pio, n&atilde;o podem ser retificados pelo prestador dos servi&ccedil;os. Nesse caso,  antes de emitir NFS-e em substitui&ccedil;&atilde;o &agrave; cancelada, o prestador deve solicitar  ao tomador dos servi&ccedil;os que verifique seus dados. O prestador de servi&ccedil;os  dever&aacute; emitir outra NFS-e, via RPS, em substitui&ccedil;&atilde;o &agrave; cancelada. Note-se que a  data de emiss&atilde;o do RPS dever&aacute; ser a data da ocorr&ecirc;ncia do fato gerador, ou  seja, a data da efetiva presta&ccedil;&atilde;o do servi&ccedil;o. A NFS-e dever&aacute; ser cancelada  mediante processo administrativo, ao qual dever&atilde;o ser juntados os seguintes  documentos: <br />
                - requerimento do interessado, constando o nome ou raz&atilde;o social, n&uacute;mero de  inscri&ccedil;&atilde;o no CNPJ ou CPF, endere&ccedil;o completo, telefone para contato, exposi&ccedil;&atilde;o  clara do pedido e todos os elementos necess&aacute;rios &agrave; sua prova; <br />
                - contrato social; <br />
                - RG e CPF do signat&aacute;rio; <br />
                - identifica&ccedil;&atilde;o da NFS-e a ser cancelada bem como da NFS-e que a substituiu. <br />
                O prestador de servi&ccedil;os poder&aacute; solicitar que o pagamento do ISS da NFS-e  cancelada seja realocado para o da NFS-e que a substituiu ou solicitar a  restitui&ccedil;&atilde;o do valor recolhido. <br />
                Observa&ccedil;&atilde;o: o prestador dos servi&ccedil;os que solicitar restitui&ccedil;&atilde;o de ISS que tenha  sido recolhido pelo tomador dos servi&ccedil;os, dever&aacute; obter deste a autoriza&ccedil;&atilde;o para  receb&ecirc;-la e juntar essa autoriza&ccedil;&atilde;o ao requerimento. <strong>Verificar com a  Prefeitura Municipal o local de entrega do requerimento bem como hor&aacute;rios</strong>. <br />
                Observa&ccedil;&otilde;es: <br />
                - a NFS-e que foi cancelada aparecer&aacute; com situa&ccedil;&atilde;o <em>&ldquo;cancelada&rdquo;</em> tanto  para o prestador quanto para o tomador dos servi&ccedil;os; <br />
                - o tomador dos servi&ccedil;os, desde que tenha cadastrado seu &quot;e-mail&quot;  para recebimento da NFS-e, receber&aacute; um aviso informando que a NFS-e foi cancelada. </p>
              <p><strong>5.11. Ap&oacute;s a emiss&atilde;o da NFS-e, pode-se  alter&aacute;-la? </strong><br />
                N&atilde;o. Se houver necessidade de retificar dados incorretos da NFS-e, leia o item  5.10. </p>
              <p><strong>5.12. A emiss&atilde;o de NFS-e permite o registro de  opera&ccedil;&otilde;es conjugadas (mercadorias e servi&ccedil;os)?</strong><br />
                N&atilde;o. A NFS-e destina-se exclusivamente ao registro de presta&ccedil;&atilde;o de servi&ccedil;os.  Consulte, tamb&eacute;m, o item 2.11. </p>
              <p><strong>5.13. A emiss&atilde;o de NFS-e permite o registro  dos dados referentes aos tributos federais?</strong><br />
                Sim. O campo destinado &agrave; discrimina&ccedil;&atilde;o dos servi&ccedil;os &eacute; de livre preenchimento e  pode ser utilizado para o registro de impostos e contribui&ccedil;&otilde;es federais.  Lembramos que a base de c&aacute;lculo do ISS &eacute; o pre&ccedil;o do servi&ccedil;o, que inclui os  impostos e contribui&ccedil;&otilde;es federais. Dessa forma, tais impostos e contribui&ccedil;&otilde;es  n&atilde;o podem ser considerados como redu&ccedil;&atilde;o da base de c&aacute;lculo do ISS. </p>
              <p><strong>5.14. Considerado o cronograma constante em  lei, quem estiver obrigado &agrave; utiliza&ccedil;&atilde;o de NFS-e dever&aacute; requerer autoriza&ccedil;&atilde;o  para sua emiss&atilde;o? </strong><br />
                Sim. Tanto as empresas obrigadas como as que optem pela utiliza&ccedil;&atilde;o de NFS-e  devem solicitar a correspondente autoriza&ccedil;&atilde;o. </p>
              <p><strong>5.15. Como obter a autoriza&ccedil;&atilde;o para emiss&atilde;o de  NFS-e?</strong><br />
                No Portal da Prefeitura utilize o link &quot;Prestadores&quot; para solicitar  uma senha que permite o acesso a &aacute;reas restritas desse &ldquo;site&rdquo;. </p>
              <p><strong>5.16. A NFS-e  poder&aacute; ser emitida englobando v&aacute;rios tipos de servi&ccedil;os? </strong><br />
                N&atilde;o. O prestador de servi&ccedil;os dever&aacute; emitir uma NFS-e para cada servi&ccedil;o  prestado, sendo vedada a emiss&atilde;o de uma mesma NFS-e que englobe servi&ccedil;os  enquadrados em mais de um c&oacute;digo de servi&ccedil;o. </p>
              <p><strong>5.17. Como alterar  a data de emiss&atilde;o da NFS-e quando esta for emitida em data posterior a da  presta&ccedil;&atilde;o dos servi&ccedil;os?</strong><br />
                De acordo com a legisla&ccedil;&atilde;o, por ocasi&atilde;o da presta&ccedil;&atilde;o de cada servi&ccedil;o (fato  gerador) dever&aacute; ser emitida Nota Fiscal, Nota Fiscal-Fatura de Servi&ccedil;os, Cupom Fiscal  ou outro documento exigido pela Administra&ccedil;&atilde;o. Portanto, n&atilde;o deve ocorrer  emiss&atilde;o de NFS-e em data posterior a da ocorr&ecirc;ncia do fato gerador do ISS.  Mesmo no caso de convers&atilde;o de RPS em NFS-e, embora a NFS-e possa ser emitida em  data posterior, o sistema considera a data de emiss&atilde;o do RPS como a data do  fato gerador para efeito de c&aacute;lculo do imposto. </p>
              <p><strong>5.18. Como  emitir NFS-e para tomador de servi&ccedil;os (PJ) estabelecido em outro pa&iacute;s? <br />
                </strong>No caso de exporta&ccedil;&atilde;o de servi&ccedil;os, ou seja, servi&ccedil;os cujos resultados  se verifiquem no exterior: <br />
                - N&atilde;o informe o n&ordm; do CNPJ, Inscri&ccedil;&atilde;o Municipal, CEP e UF; <br />
                - No campo Endere&ccedil;os dever&atilde;o ser colocados os dados referentes ao Estado e no  campo Munic&iacute;pio o Pa&iacute;s; <br />
                - Nos demais campos dever&atilde;o ser preenchidos normalmente. No caso de os  resultados dos servi&ccedil;os se verificarem no Brasil, mesmo que o pagamento seja  feito no exterior, os servi&ccedil;os ser&atilde;o tributados no nosso munic&iacute;pio </p>
              <p><strong>5.19. Emiti uma  NFS-e com dados incorretos. Posso corrigi-la por meio de carta de corre&ccedil;&atilde;o? </strong><br />
                N&atilde;o &eacute; permitida a utiliza&ccedil;&atilde;o de carta de corre&ccedil;&atilde;o para retificar a  &ldquo;Discrimina&ccedil;&atilde;o dos Servi&ccedil;os&rdquo;. Para mais informa&ccedil;&otilde;es, consulte o manual de  acesso ao sistema da NFS-e para pessoas jur&iacute;dicas.</p>
              <p><strong>5.20. Onde pode  ser inclu&iacute;do o campo de aceite dos servi&ccedil;os na NFS-e? </strong><br />
                O &quot;canhoto&quot; para aceite dos servi&ccedil;os prestados n&atilde;o &eacute; previsto nos  documentos fiscais emitidos &quot;on-line&quot;. Caso a formalidade de aceite  seja necess&aacute;ria, redija os termos do &ldquo;aceite&rdquo; no campo &quot;Discrimina&ccedil;&atilde;o de  Servi&ccedil;os&quot;, depois da descri&ccedil;&atilde;o dos servi&ccedil;os prestados. Impressa a NFS-e, o  tomador dos servi&ccedil;os poder&aacute; aceit&aacute;-los apondo sua assinatura no local indicado  no corpo da nota fiscal. </p>
              <p><strong>5.21. Estou  enquadrado no Simples Nacional, institu&iacute;do pela Lei Complementar n&ordm; 123/2006.  Por que minhas NFS-e n&atilde;o apresentam al&iacute;quota e valor do ISS? </strong><br />
                Para contribuinte enquadrado no Simples Nacional, quando a responsabilidade  pelo recolhimento do ISS &eacute; do prestador dos servi&ccedil;os, os campos referentes &agrave;  base de c&aacute;lculo, al&iacute;quota e valor do ISS n&atilde;o s&atilde;o utilizados na NFS-e. Nessa situa&ccedil;&atilde;o,  o recolhimento dos tributos dever&aacute; ser feito mensalmente, mediante Documento de  Arrecada&ccedil;&atilde;o do Simples Nacional (DAS), conforme orienta&ccedil;&atilde;o dispon&iacute;vel em  http://www.receita.fazenda.gov.br/SimplesNacional. </p>
              <p><strong>5.22. Estou  enquadrado no Simples Nacional e emito Nota Fiscal Eletr&ocirc;nica (NFS-e). Como  ser&aacute; a emiss&atilde;o das NFS-e, quando o tomador dos servi&ccedil;os for respons&aacute;vel pelo  recolhimento do ISS? </strong><br />
                Quando o tomador dos servi&ccedil;os for respons&aacute;vel pelo recolhimento do ISS, a nota  fiscal ser&aacute; emitida com tributa&ccedil;&atilde;o normal e o tomador dever&aacute; emitir a guia de  recolhimento pelo sistema da NFS-e</p>
              <p><strong>5.23. Estou  enquadrado em regime de tributa&ccedil;&atilde;o diferente do que consta no sistema da NFS-e  (Simples Nacional ou tributa&ccedil;&atilde;o normal), e quero corrigir a situa&ccedil;&atilde;o para as  pr&oacute;ximas NFS-e e para as existentes. O que devo fazer?</strong> <br />
                As NFS-e emitidas com regime de tributa&ccedil;&atilde;o incorreto n&atilde;o poder&atilde;o ser  retificadas. Por&eacute;m as pr&oacute;ximas NFS-e emitidas poder&atilde;o ser corrigidas mediante  contado com a Prefeitura Municipal e solicitando altera&ccedil;&atilde;o do cadastro da  empresa emissora de NFS-e </p>
              <p>06 - EMISS&Atilde;O DE GUIA DE RECOLHIMENTO</p>
              <p><strong>6.01. Existe uma  guia de recolhimento de ISS espec&iacute;fica para a NFS-e?</strong><br />
                Sim. O recolhimento do ISS, referente &agrave;s NFS-e, dever&aacute; ser feito exclusivamente  por meio de documento de arrecada&ccedil;&atilde;o emitido pelo aplicativo da NFS-e no menu  &quot;Guia de Pagamento&quot; para os prestadores de servi&ccedil;os. <br />
                Os tomadores de servi&ccedil;os n&atilde;o emitentes de NFS-e devem acessar o menu  &quot;Tomadores&quot;, item &quot;Guia de Pagamento&quot; no sistema para poder  emitir guia de recolhimento quando o ISS deve ser retido e recolhido pelo  tomador. </p>
              <p><strong>6.02. Quando a  guia de recolhimento de ISS fica dispon&iacute;vel para emiss&atilde;o?</strong><br />
                A partir da emiss&atilde;o da primeira NFS-e dentro do m&ecirc;s.</p>
              <p><strong>6.03. Quem fica  dispensado da emiss&atilde;o da guia de recolhimento pelo sistema da NFS-e? </strong><br />
                1) Os &oacute;rg&atilde;os da administra&ccedil;&atilde;o p&uacute;blica direta da Uni&atilde;o, dos Estados e do  Munic&iacute;pio, bem como suas autarquias, funda&ccedil;&otilde;es, empresas p&uacute;blicas, sociedades  de economia mista e demais entidades controladas direta ou indiretamente pela  Uni&atilde;o, pelos Estados ou pelo Munic&iacute;pio, que recolherem o ISS retido na fonte  por meio dos sistemas or&ccedil;ament&aacute;rio e financeiro dos governos federal, estadual  e municipal. <br />
                2) As empresas estabelecidas no Munic&iacute;pio e enquadradas no Simples Nacional, os  aut&ocirc;nomos e os que recolhem o ISS por quota fixa mensal.</p>
              <p><strong>6.04. Qual &eacute; a  data de vencimento do ISS referente &agrave;s NFS-e?</strong><br />
                O ISS vence no &uacute;ltimo dia &uacute;til do m&ecirc;s subsequente. A guia dever&aacute; ser impressa a  partir do dia 21 de cada m&ecirc;s. </p>
              <p><strong>6.05. &Eacute; poss&iacute;vel  emitir a guia de recolhimento ap&oacute;s o vencimento do ISS?</strong><br />
                Sim. Cancele a guia vencida e emita nova guia com valor e vencimento  atualizados. A nova guia ser&aacute; emitida com os acr&eacute;scimos legais. </p>
              <p><strong>6.06. &Eacute; poss&iacute;vel  cancelar guia de recolhimento emitida?</strong><br />
                Sim, desde que o ISS n&atilde;o tenha sido recolhido. </p>
              <p><strong>6.07. Os  contribuintes sujeitos ao regime de recolhimento do ISS por estimativa dever&atilde;o  emitir a guia de recolhimento no aplicativo da NFS-e?</strong><br />
                N&atilde;o.</p>
              <p><strong>6.08. Os  contribuintes que possuem regime especial de recolhimento do ISS, individual ou  coletivo, dever&atilde;o emitir a guia de recolhimento no aplicativo da NFS-e? </strong><br />
                N&atilde;o.</p>
              <p><strong>6.09. As  empresas estabelecidas no Munic&iacute;pio, n&atilde;o enquadradas no Simples Nacional,  dever&atilde;o emitir a guia de recolhimento no aplicativo da NFS-e?</strong><br />
                Sim. As empresas estabelecidas no Munic&iacute;pio, n&atilde;o enquadradas no Simples  Nacional, que optarem pela emiss&atilde;o de NFS-e dever&atilde;o emitir a guia de  recolhimento no aplicativo da NFS-e</p>
              <p><strong>6.10. As  empresas enquadradas no Simples Nacional dever&atilde;o emitir a guia de recolhimento  no aplicativo da NFS-e? </strong><br />
                N&atilde;o. As empresas enquadradas no Simples Nacional dever&atilde;o recolher tributos  utilizando o Documento de Arrecada&ccedil;&atilde;o do Simples Nacional (DAS), conforme  orienta&ccedil;&atilde;o dispon&iacute;vel em: http://www.receita.fazenda.gov.br/SimplesNacional. </p>
              <p>07 - GERA&Ccedil;&Atilde;O DE CR&Eacute;DITO</p>
              <p><strong>7.01. Quem far&aacute;  jus ao cr&eacute;dito gerado pela NFS-e?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>7.02. Quanto &eacute;  gerado de cr&eacute;dito por NFS-e? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>7.03. Como o tomador de servi&ccedil;os ser&aacute;  informado sobre os cr&eacute;ditos gerados?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>7.04. Quando o  cr&eacute;dito fica dispon&iacute;vel para utiliza&ccedil;&atilde;o? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>7.05. Quem n&atilde;o  far&aacute; jus ao cr&eacute;dito gerado?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>7.06. Quais os  procedimentos para se obter o cr&eacute;dito? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>7.07. Emito Nota  Fiscal Eletr&ocirc;nica (NFS-e) e estou enquadrado no Simples Nacional. NFS-e  emitidas por mim dar&atilde;o ao tomador do servi&ccedil;o direito a cr&eacute;dito de parcela do  ISS?<br />
              </strong>N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p>08 - UTILIZA&Ccedil;&Atilde;O DE  CR&Eacute;DITO</p>
              <p><strong>8.01. Quando o  tomador de servi&ccedil;os dever&aacute; indicar os im&oacute;veis que aproveitar&atilde;o os cr&eacute;ditos  gerados? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.02. Pode-se  indicar im&oacute;vel em nome de terceiros?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.03. Pode-se  indicar im&oacute;vel com d&eacute;bito de IPTU? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.04. Como o  cr&eacute;dito gerado poder&aacute; ser utilizado? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.05. Como &eacute;  calculado o valor do abatimento do IPTU? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.06. Ap&oacute;s a  utiliza&ccedil;&atilde;o do cr&eacute;dito, como ser&aacute; pago o saldo do IPTU?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.07. O que  acontece no caso de n&atilde;o pagamento do saldo restante do IPTU?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.08. Qual &eacute; a  validade dos cr&eacute;ditos?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.09. Quem n&atilde;o  poder&aacute; utilizar o cr&eacute;dito gerado?</strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p><strong>8.10. O tomador  de servi&ccedil;os que estiver com pend&ecirc;ncias quanto ao imposto junto &agrave; Prefeitura  Municipal perder&aacute; os cr&eacute;ditos gerados? </strong><br />
                N&atilde;o se aplica ao munic&iacute;pio de Vera Cruz</p>
              <p>09 - ASPECTOS GERAIS</p>
              <p><strong>9.01. Qual a  garantia de que a NFS-e recebida &eacute; aut&ecirc;ntica?</strong><br />
                Na op&ccedil;&atilde;o &ldquo;Verifique a Autenticidade&rdquo;, dentro do menu &quot;Tomadores&quot;,  dispon&iacute;vel no site da NFS-e, basta digitar o n&uacute;mero da NFS-e, o n&uacute;mero da  inscri&ccedil;&atilde;o no CNPJ do emitente e o c&oacute;digo de verifica&ccedil;&atilde;o existente na NFS-e. Se  a NFS-e for aut&ecirc;ntica, sua imagem ser&aacute; visualizada na tela do computador,  podendo, inclusive, ser imprimida. </p>
              <p><strong>9.02. O programa  da NFS-e permite a importa&ccedil;&atilde;o de arquivo?</strong><br />
                Consulte o item 10.2. </p>
              <p><strong>9.03. O programa  da NFS-e permite a exporta&ccedil;&atilde;o de arquivo?</strong> <br />
                Consulte o item 10.4.</p>
              <p><strong>9.04. O  prestador de servi&ccedil;os poder&aacute; cadastrar o contador para acessar o aplicativo  NFS-e?</strong><br />
                Sim. O prestador de servi&ccedil;os poder&aacute; informar no link &ldquo;Contador&rdquo; o n&ordm; do CPF ou  do CNPJ do contador. Ao informar o n&ordm; do CPF ou do CNPJ do contador, o sistema  preencher&aacute; automaticamente o nome ou raz&atilde;o social, se este possuir inscri&ccedil;&atilde;o  junto &agrave; Prefeitura Municipal. Caso contr&aacute;rio, o campo ficar&aacute; em branco e o  contador dever&aacute; preencher a ficha de cadastro para acesso ao sistema no menu  &quot;Contadores&quot;.</p>
              <p><strong>9.05. O contador  poder&aacute; acessar o aplicativo NFS-e de seus clientes? </strong><br />
                Sim, o contador poder&aacute; acessar os dados de todos os contribuintes que o  cadastraram como contador respons&aacute;vel, desde que autorizado pelo cliente,  atrav&eacute;s do Sistema NFS-e.</p>
              <p>10 - SISTEMA DA NFS-e</p>
              <p><strong>10.01. Quem ter&aacute;  acesso ao sistema NFS-e?</strong><br />
                Pessoa Jur&iacute;dica/F&iacute;sica inscrita poder&aacute; acessar todas as funcionalidades do  sistema, depois de obter autoriza&ccedil;&atilde;o para utilizar NFS-e. Pessoa  Jur&iacute;dica/F&iacute;sica n&atilde;o inscrita (estabelecida em outro Munic&iacute;pio)  poder&aacute; consultar as NFS-e recebidas. Contador (PF ou PJ) poder&aacute; acessar  informa&ccedil;&otilde;es de todos os contribuintes que o cadastraram como contador  respons&aacute;vel. </p>
              <p><strong>10.02. O programa da NFS-e permite a  importa&ccedil;&atilde;o de arquivo?</strong> <br />
                Sim. A NFS-e possui um layout padr&atilde;o de arquivo que poder&aacute; ser gerado pelo  sistema do contribuinte e importado no sistema NFS-e, convertendo os dados do  arquivo em   Notas Fiscais Eletr&ocirc;nicas. O pr&oacute;prio sistema NFS-e valida o  arquivo. Ap&oacute;s a valida&ccedil;&atilde;o, o sistema solicita a confirma&ccedil;&atilde;o da grava&ccedil;&atilde;o. </p>
              <p><strong>10.03. Quem n&atilde;o possui autoriza&ccedil;&atilde;o para  emiss&atilde;o de NFS-e poder&aacute; testar a valida&ccedil;&atilde;o do arquivo?</strong> <br />
                N&atilde;o. Nesse caso, o sistema n&atilde;o permitir&aacute; acesso a funcionalidade sem  cadastramento de usu&aacute;rio. Para testar o arquivo &eacute; necess&aacute;rio acessar o sistema  com um n&ordm; de CNPJ de empresa estabelecida e com permiss&atilde;o de acesso pelo  Munic&iacute;pio. </p>
              <p><strong>10.04. O programa da NFS-e permite a  exporta&ccedil;&atilde;o de arquivo?</strong> <br />
                Sim. A NFS-e possui um layout padr&atilde;o de arquivo que poder&aacute; ser gerado pelo  sistema, permitindo a transfer&ecirc;ncia eletr&ocirc;nica das informa&ccedil;&otilde;es referentes &agrave;  NFS-e da base de dados da Prefeitura da Cidade para o contribuinte. </p>
              <p><strong>10.05. Onde posso obter um documento contendo  as instru&ccedil;&otilde;es e os layouts de importa&ccedil;&atilde;o e exporta&ccedil;&atilde;o de arquivos?</strong><br />
                Nos menu &quot;Manuais de Ajuda&quot;, nos arquivos &quot;<strong>Layout de  arquivo para convers&atilde;o de RPS em NFS-e</strong>&quot; e &quot;<strong>Layout de  arquivo de exporta&ccedil;&atilde;o de NFS-e</strong>&quot;.</p>
              <p><strong>10.06. Existe um programa espec&iacute;fico para  transmiss&atilde;o do arquivo?</strong><br />
                N&atilde;o h&aacute; um programa espec&iacute;fico para transmiss&atilde;o dos lotes. O arquivo gerado pelo  contribuinte poder&aacute; ser transmitido diretamente pelo sistema da NFS-e.</p>
              <p><strong>10.07. Ap&oacute;s a transmiss&atilde;o do arquivo ser&aacute;  gerado algum relat&oacute;rio?</strong> <br />
                Sim. Ap&oacute;s o envio e valida&ccedil;&atilde;o do arquivo contendo todos os RPS emitidos, ser&aacute;  apresentado um relat&oacute;rio resumindo o processo. Se n&atilde;o houver erros no arquivo,  este poder&aacute; ser gravado e todos os RPS ser&atilde;o convertidos em NFS-e imediatamente  ap&oacute;s a grava&ccedil;&atilde;o. </p>
              <p><strong>10.08. Ap&oacute;s a transmiss&atilde;o do arquivo ser&aacute;  disponibilizado algum arquivo de retorno? Neste arquivo posso obter os n&uacute;meros  das NFS-e geradas? </strong><br />
                Sim. Ap&oacute;s o envio, valida&ccedil;&atilde;o e grava&ccedil;&atilde;o do arquivo contendo todos os RPS  emitidos, basta acessar o menu &quot;Importar RPS&quot;, escolher a op&ccedil;&atilde;o  &quot;NFS-e emitidas&quot; e informar o per&iacute;odo desejado. Em seguida, o sistema  ir&aacute; gerar um relat&oacute;rio. Esse relat&oacute;rio relaciona o n&uacute;mero da NFS-e gerada com o  n&uacute;mero do RPS enviado. Poder&aacute; ser gerado a qualquer momento, acessando o menu &quot;Importar  RPS&quot; e escolhendo o per&iacute;odo desejado e a op&ccedil;&atilde;o &quot;NFS-e Emitidas&quot;. </p>
              <p><strong>10.09. O que ocorre no caso de transmiss&atilde;o de  arquivo contendo RPS j&aacute; transmitido anteriormente? </strong><br />
                Caso um RPS j&aacute; convertido em NFS-e seja novamente transmitido em arquivo, o  sistema ir&aacute; comparar o RPS convertido com o atual. Se n&atilde;o houver altera&ccedil;&atilde;o, o  RPS atual ser&aacute; ignorado e n&atilde;o ser&aacute; processado. Caso contr&aacute;rio, a NFS-e anterior  ser&aacute; cancelada automaticamente e o RPS atual ser&aacute; processado e convertido em  uma nova NFS-e. </p>
              <p><strong>10.10. O que ocorre no caso de transmiss&atilde;o de  arquivo contendo RPS j&aacute; convertido &ldquo;on line&rdquo; em NFS-e? </strong><br />
                Caso um RPS j&aacute; convertido &ldquo;on line&rdquo; em NFS-e seja  enviado em arquivo, o RPS enviado ser&aacute; ignorado e n&atilde;o ser&aacute; processado. </p>
              <p><strong>10.11. O que ocorre no caso de convers&atilde;o &ldquo;on  line&rdquo; de RPS j&aacute; convertido em NFS-e por meio de transmiss&atilde;o de arquivo?</strong><br />
                Neste caso, a convers&atilde;o &ldquo;on line&rdquo; do RPS s&oacute; ser&aacute; poss&iacute;vel ap&oacute;s o cancelamento  da NFS-e correspondente ao RPS convertido.</p>
              <p><strong>10.12. Qual o nome do arquivo de transmiss&atilde;o  dos RPS? </strong><br />
                O arquivo contendo os RPS enviados para convers&atilde;o em NFS-e poder&aacute; ser  &quot;batizado&quot; com qualquer nome. </p>
              <p><strong>10.13. O que fazer em caso de erro no arquivo  de transmiss&atilde;o dos RPS?</strong><br />
                Em caso de erro na valida&ccedil;&atilde;o do arquivo, o usu&aacute;rio dever&aacute; verificar o relat&oacute;rio  gerado e ap&oacute;s corre&ccedil;&atilde;o gerar novo arquivo. </p>
              <p><strong>10.14. Ap&oacute;s o envio do arquivo, em quanto  tempo o RPS ser&aacute; convertido em NFS-e?</strong><br />
                A gera&ccedil;&atilde;o de NFS-e, ap&oacute;s a importa&ccedil;&atilde;o do arquivo de RPS, &eacute; imediata. </p>
              <p><strong>10.15. &Eacute; poss&iacute;vel a integra&ccedil;&atilde;o em tempo real  do sistema de faturamento da empresa com o sistema da NFS-e?</strong><br />
                Atualmente, n&atilde;o. Somente ap&oacute;s a implanta&ccedil;&atilde;o do aplicativo  Web Service, que est&aacute; em desenvolvimento, ser&aacute; poss&iacute;vel integrar em tempo real  o sistema de faturamento da empresa com a NFS-e, sem a necessidade de envio de  lote.</p></td>
          </tr>
        </table>
          <br />
          <br /></td>
      </tr>
      <tr>
        <td height="1"></td>
      </tr>
      <tr>
        <td height="5" align="left" bgcolor="#859CAD"></td>
      </tr>
    </table></td>
    </tr>   
    </table>    
    
    
    
    
    
    
    
    </td>
  </tr>
</table>



	</td>
  </tr>
</table>
<?php include("inc/rodape.php"); ?>

</body>
</html>
