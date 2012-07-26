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
<style type="text/css">
#divBusca {
	position:absolute;
	left:30%;
	top:20%;
	width:298px;
	height:276px;
	z-index:1;
 visibility:<?php if(isset($btBuscarCliente)) { echo"visible"; }else{ echo"hidden"; }?>
}
</style>
<div id="divBusca"  >
	<?php include("inc/relatorios/busca_tomadores.php"); ?>
</div>
<?php 
	if(isset($_POST['CODEMISSOR'])){
		$sql_cad = "SELECT * FROM cadastro WHERE codigo = ".$_POST['CODEMISSOR'];
		$sql_res_cad = mysql_query($sql_cad);
		$tomador = mysql_fetch_array($sql_res_cad);
		$cod_tomador = $tomador['codigo'];
		if($prestador['cpf'] != '')$cpfcnpj = $prestador['cpf'];
		else $cpfcnpj = $prestador['cnpj'];
		
		if($tomador['nome'] != '')$nome_tomador = $tomador['nome'];
		else $nome_tomador = $tomador['razaosocial'];
	}
?>
<table border="0" cellspacing="0" cellpadding="0" >
 
  <tr>
    
    <td align="center">

<form id="frmMovimentacao" method="post" target="_blank" action="inc/relatorios/imprimir_movimentacao_tomadores.php">
<fieldset>
<legend><strong>Pesquisa de Movimento</strong></legend>
<table align="left" width="60%">
<tbody>
    <tr>
        <td>
            Escolha o Período
        </td>
        <td>
			<?php
  		  	//array de meses comencando em 1 ate 12
    		$meses=array(
                "1"=>"Janeiro",
                "Fevereiro",
                "Março",
                "Abril",
                "Maio",
                "Junho",
                "Julho",
                "Agosto",
                "Setembro",
                "Outubro",
                "Novembro",
                "Dezembro"
             );
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
         </td>
    </tr>
    <tr>
        <td>
            Escolha o Tomador
        </td>
        <td align="left" colspan="5">
            <!--<select style="width: 150px" name="cmbTomador" id="cmbTomador">
                <option value="">Selecione o tomador</option>
                    <?php
                        $sql_categoria=mysql_query("
                            SELECT
                                cadastro.nome,
                                IF(
                                    cadastro.cnpj<>'',
                                    cadastro.cnpj,
                                    cadastro.cpf
                                ) AS doc
                            FROM cadastro
                            INNER JOIN notas ON(
                               cadastro.cpf = notas.tomador_cnpjcpf OR
                               cadastro.cnpj = notas.tomador_cnpjcpf
                            )
                            GROUP BY cadastro.nome
                            ORDER BY cadastro.nome
                        ");
                        while(list($nome,$doc)=mysql_fetch_array($sql_categoria)){
                            print("<option value=\"$doc\">$nome</option>");
                        }
                    ?>
            </select>-->
            <input type="hidden" value="<?php echo $cod_tomador ?>" name="cmbTomador" />
            <input type="text" value="<?php echo $nome_tomador ?>" name="nomePrestador" id="nomePrestador" readonly="readonly" size="50" />
            <input type="button" value="Pesquisar" name="btPesquisar" class="botao" onclick="document.getElementById('divBusca').style.visibility='visible'" />
        </td>
    </tr>
</tbody>
</table>
</fieldset>

<fieldset style="vertical-align:middle; text-align:left">
<input name="btPesquisar" type="submit" id="button1" class="botao" value="Buscar"   />
<label >
<input type="button" name="btLimpar" id="button2" value="Limpar Campos" class="botao" onclick="document.getElementById('nomePrestador').value = '';document.getElementById('_mes').value = '';document.getElementById('_ano').value = ''" />
<input type="hidden" name="hdContador" value="<?php echo $contservico; ?>"/>
</label>
</fieldset>
<div id="divRelatPrestadores"></div>
</form>
		</td>
		
  </tr>
  
</table>