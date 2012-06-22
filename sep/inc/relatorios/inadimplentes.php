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
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
  <tr>
    <td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
    <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Relat&oacute;rios - Movimentação </td>
    <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
  </tr>
  <tr>
    <td width="18" background="img/form/lateralesq.jpg"></td>
    <td align="center">

<form id="frmDevedores" method="post" target="_blank" action="inc/relatorios/imprimir_inadimplentes.php">
<fieldset>
    <legend><strong>Pesquisa de Prestadores com D&eacute;bitos Atrasados</strong></legend>

</fieldset>

<fieldset style="vertical-align:middle; text-align:left">
    <?php
        $meses = array(
            1  => "Janeiro",
            2  => "Fevereiro",
            3  => "Março",
            4  => "Abril",
            5  => "Maio",
            6  => "Junho",
            7  => "Julho",
            8  => "Agosto",
            9  => "Setembro",
            10 => "Outubro",
            11 => "Novembro",
            12 => "Dezembro",
        );

        $sql = mysql_query("
            SELECT
                MAX(DATE_FORMAT(datahoraemissao, '%Y')) AS fim,
                MIN(DATE_FORMAT(datahoraemissao, '%Y')) AS ini
            FROM notas
        ");
        $anos = mysql_fetch_object($sql);
    ?>
    <table width="40%">
        <tr>
            <td>
                Per&iacute;odo:
            </td>
            <td>
                <select name="cmbAno" id="cmbAno">
                    <option></option>
                    <?php
                        if($anos->ini != $anos->fim){
                            for($i = $anos->ini; $i <= $anos->fim; $i++){
                                echo "<option='$i'>$i</option>";
                            }
                        }else{
                            echo "<option value='{$anos->ini}'>{$anos->ini}</option>";
                        }
                    ?>
                </select>
                &nbsp;
                <select name="cmbMes" id="cmbMes">
                    <option></option>
                    <?php
                        foreach($meses as $key => $ano){
                            if($key < 10){
                                $key = "0".$key;
                            }
                            echo "<option value='$key'>$ano</option>";
                        }
                    ?>
                </select>
            </td>
        </tr>
        <tr>
            <td>Prestador:</td>
            <td>
                <select name="cmbPrestador" id="cmbPrestadores">
                    <option></option>
                    <?php
                        $sql = mysql_query("
                            SELECT codigo,
                            razaosocial,
                            if(cnpj<>'',cnpj,cpf) AS numdoc
                            FROM cadastro
                            WHERE codtipo <> 11
                        ");

                        while($prestadores = mysql_fetch_object($sql)){
                            echo "
                                <option value=\"{$prestadores->codigo}\">
                                    {$prestadores->numdoc} - {$prestadores->razaosocial}
                                </option>
                            ";
                        }
                    ?>
                </select>
            </td>
        </tr>
    </table>
    <input name="btPesquisar" type="submit" id="button1" class="botao" value="Buscar"   />
    <label >
    <input type="reset" name="btLimpar" id="button2" value="Limpar Campos" class="botao" />
    </label>
</fieldset>
<div id="divRelatPrestadores"></div>
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