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
    <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Relat&oacute;rios - Prestadores </td>  
    <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
  </tr>
  <tr>
    <td width="18" background="img/form/lateralesq.jpg"></td>
    <td align="center">

<form id="frmRelatorios" method="post" target="_blank" action="inc/relatorios/imprimir.php">
    <fieldset>
        <legend><strong>Pesquisa de Prestadores</strong></legend>
        <table align="left" width="100">
            <tr>
                <td align="left" style="text-indent:5px">UF</td>
                <td colspan="6" align="left">
                    <!--ESTE SELECT ESTA COM A NOMENCLATTURA DE UM TEXT PARA MANTER A COMPATIBILIDADE DO ARQUIVO INSERIR.PHP COM TODOS OS ARQUIVOS DE CADASTRO DE EMPRESAS-->
                    <?php
                        $sql_uf = mysql_query("SELECT estado, cidade FROM configuracoes");
                        list($UF,$MUNICIPIO) = mysql_fetch_array($sql_uf);
                    ?>
                    <select name="cmbEstado" id="txtInsUfEmpresa" onchange="buscaCidades(this,'txtInsMunicipioEmpresa')">
                        <option></option>
                        <?php
                            $sql=mysql_query("SELECT uf FROM municipios GROUP BY uf ORDER BY uf");
                            while(list($uf_busca)=mysql_fetch_array($sql)){
                                echo "<option value=\"$uf_busca\"";if($uf_busca == $UF){ echo "selected=selected"; }echo ">$uf_busca</option>";
                            }
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left" style="text-indent:5px">Munic&iacute;pio</td>
                <td colspan="6" align="left">
                    <div  id="txtInsMunicipioEmpresa">
                        <select name="txtInsMunicipioEmpresa" id="txtInsMunicipioEmpresa" class="combo" style="width:150px">
                            <option></option>
                            <?php
                                $sql_municipio = mysql_query("SELECT nome FROM municipios WHERE uf = '$UF'");
                                while(list($nome) = mysql_fetch_array($sql_municipio)){
                                    echo "<option value=\"$nome\"";if(strtolower($nome) == strtolower($MUNICIPIO)){ echo "selected=selected";} echo ">$nome</option>";
                                }//fim while
                            ?>
                        </select>
                    </div>
                 </td>
            </tr>
            <tr>
                <td align="left" style="text-indent:5px">Categoria</td>
                <td colspan="6" align="left">
                    <select name="cmbCategoria" id="cmbCategoria" style="width:500px">
                        <option></option>
                        <?php
                            $sqlCategoria = mysql_query("SELECT codigo, nome FROM servicos_categorias");
                            while($categoria = mysql_fetch_object($sqlCategoria)){
                                echo "<option value='".$categoria->codigo."'>".$categoria->nome."</option>";
                            }
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left" style="text-indent:5px">Estado</td>
                <td colspan="6" align="left">
                    <input type="radio" name="rgpEstado" value="A" />Ativo
                    &nbsp;
                    <input type="radio" name="rgpEstado" value="I" />Inativo
                    &nbsp;
                    <input type="radio" name="rgpEstado" value="NL" />N&atilde;o Liberado
                </td>
            </tr>
        </table>
    </fieldset>

    <fieldset style="vertical-align:middle; text-align:left">
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