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

$query = ("SELECT 
				guia.codigo AS codguia,
				guia.dataemissao,
				guia.datavencimento,
				guia.valor,
				guia.valormulta,
				guia.nossonumero,
				guia.chavecontroledoc,
				guia.pago AS pago,
				guia.estado,
				guia.estado,
				guia.motivo_cancelamento,
				guia.codlivro,
				guia.codnota AS codnota
		  FROM guia_pagamento 
		  INNER JOIN notas AS nota ON nota.codigo = codguia
		  WHERE pago = 'N'");
		 
if (mysql_num_rows($sql) == 0) {
	?><strong><center>Nenhum resultado encontrado.</center></strong><?php
} else {
?>

<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
	<tr>
    	<td width="19" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
        <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Relat&oacute;rios - Devedores </td>
        <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg">
            <a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a>
        </td>
    </tr>
    <tr>
        <td width="18" background="img/form/lateralesq.jpg"></td>
        <td align="left">
            <form>
                <fieldset style="margin-left:10px; margin-right:10px;">
                <legend>Maiores Devedores do ISSQN</legend>
                	<table width="100%" border="0" cellspacing="2" cellpadding="2">
                        <tr>
                            <td width="70%" bgcolor="#999999" align="center">Nome</td>
                            <td width="15%" bgcolor="#999999" align="center">Total</td>
                            <td width="15%" bgcolor="#999999" align="center">N&deg; Meses</td></tr>
                    </table>
                </fieldset>
            </form>
        </td>
    </tr>
</table>
<?php
	}
?>