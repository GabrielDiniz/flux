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
    <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Relat&oacute;rios - Valores </td>  
    <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
  </tr>
  <tr>
    <td width="18" background="img/form/lateralesq.jpg"></td>
    <td align="center">

<form id="frmRelatorios" method="post" target="_blank" action="inc/relatorios/imprimir_valor.php">
<fieldset>
<legend><strong>Pesquisa de Valores Arrecadados</strong></legend>
<table align="left" width="100">
<tbody>
<tr>
<tr>
<td height="24" align="left">Nome:&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td colspan="4" align="left">
 <input class="texto" type="text" maxlength="100" size="60" name="txtNomeValor"> </td>
</tr>
            <td>
            Escolha o Período: 
            </td>
        <td>    
			<?php
  		  	//array de meses comencando em 1 ate 12
    		$meses=array("1"=>"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro");
    		$mes = date("n");
    		$ano = date("Y");						
    		?>
				<select name="cmbMes" id="_mes">
          <option value=""></option>
          <?php
          
		  for($ind=1;$ind<=12;$ind++){
            echo "<option value='$ind'";
			echo ">{$meses[$ind]}</option>";
          }
          ?>
      
      	  </select>
      
      <select name="cmbAno" id="_ano">
          <option value=""> </option>
            <?php
                $year=date("Y");
                for($h=0; $h<5; $h++){
                    $y=$year-$h;
                    echo "<option value=\"$y\"";
					echo ">$y</option>";
                }
            ?>
      </select>
					</div>				
                 </td>
			</tr>
            <tr>
			  <td align="left" colspan="5">
               <!--     <input type="checkbox" id="nfe" name="nfe" value="S"/> <label for="nfe"> Emitentes de NFe</label><br /> -->
                    <input type="checkbox" id="nfeCancelada" name="nfeCancelada" value="C"/> <label for="nfeCancelada"> NFe Canceladas</label>
              </td>
			</tr>
</tbody>
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

