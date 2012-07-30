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
<table border="0" cellspacing="0" cellpadding="0" >
  
  <tr>
    
    <td align="center">

<form id="frmMovimentacao" method="post" target="_blank" action="inc/relatorios/imprimir_estimativa_issqn.php">
<fieldset>
<legend><strong>Pesquisa de Estimativa de ISSQN</strong></legend>
<table align="left" width="50%">
<tbody>
    <tr>
        <td>
            Escolha o Período
        </td>
        <td>
			<?php
  		  	//array de meses comencando em 1 ate 12
    		$meses=array("1"=>"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro");
    		$mes = date("n");
    		$ano = date("Y");
    		?>
            <select name="cmbMes" id="_mes">
                 <?php
                     for($ind=1;$ind<=12;$ind++){
                 ?>
                 		<option value="<?php echo $ind; ?>" <?php if($ind == $mes) echo 'selected="selected"'; ?>><?php echo $meses[$ind]; ?></option>
                 <?php	} ?>
            </select>
            <select name="cmbAno" id="_ano">
                  <?php
                      $year=date("Y");
                      for($h=0; $h<5; $h++){
                          $y=$year-$h;
                  ?>
                  		<option value="<?php echo $y; ?>"><?php echo $y; ?></option>
                  <?php } ?>
            </select>
         </td>
    </tr>
</tbody>
</table>
</fieldset>

<fieldset style="vertical-align:middle; text-align:left">
<input name="btPesquisar" type="submit" id="button1" class="botao" value="Buscar"   />
<label >
<!--<input type="reset" name="btLimpar" id="button2" value="Limpar Campos" class="botao" />-->
<input type="hidden" name="hdContador" value="<?php echo $contservico; ?>"/>
</label>
</fieldset>
<div id="divRelatPrestadores"></div>
</form>
		</td>
		
  </tr>
  
</table>

