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
    $login = $_SESSION['codempresa']; //$publicarBtn = array("s" => "Não Publicar", "n" => "Publicar");

    $sql = mysql_query("
        SELECT codigo FROM cadastro
       WHERE codigo='".$login."'
    ");
    list($codcontador) = mysql_fetch_array($sql);

    $sqlSimples = mysql_query("
        SELECT COUNT(cadastro.codigo) FROM cadastro
        INNER JOIN tipo ON cadastro.codtipodeclaracao = tipo.codigo
        WHERE cadastro.codtipo = 10 AND tipo.nome LIKE '%simples nacional%'
        AND cadastro.codigo = $codcontador
    ");

    list($simples) = mysql_fetch_array($sqlSimples);

    $sqlEmpresaCliente = mysql_query("
        SELECT codigo,
        if(cnpj<>'',cnpj, cpf) AS documento,
        nome
        FROM cadastro
        WHERE codcontador = $codcontador AND contadorlivro = 'S' AND codtipodeclaracao != '3'
    ");
?>
	<form method="post">
		<table width="100%">
			<tr>
				<td align="center">
                    Empresa&nbsp;
                      <select name="cmbEmpresaCliente" id="cmbEmpresaCliente">
                          <?php if($simples < 1){ ?>
                          <option value="<?php echo $codcontador; ?>"><?php echo "Pr&oacute;pria - ".$_SESSION['codempresa']; ?></option>
                          <?php } ?>
                          <?php
                            while($empresaCliente = mysql_fetch_object($sqlEmpresaCliente)){
                                if($empresaCliente->codigo == $_POST['cmbEmpresaCliente'] || $empresaCliente->codigo == $_POST['cmbCliente']){
                                    $selected = "selected='selected'";
                                }else{
                                    $selected = "";
                                }
                                echo "
                                    <option $selected value='".$empresaCliente->codigo."'>
                                    ".$empresaCliente->nome." - ".$empresaCliente->documento."
                                    </option>
                                ";
                            }
                          ?>
                      </select>
                    <br /><br />
                    <input type="submit" class="botao" name="btOp" value="Gerar Guia">
                    &nbsp;
                    <input type="submit" name="btOp" class="botao" value="Guias Emitidas">
                </td>
			</tr>
		</table>
	</form>
	
	
 	<?php
	if($_POST['btOp'] == "Gerar Guia")
	{
	  include("guia_pagamento.php");
	}
	
	elseif($_POST['btOp'] == "Guias Emitidas")
	{
	  include("pagamento_emitidas.php");
	
	}
	
	
	//codigo para impressao do boleto
    if($btEnviaBoleto =="Boleto")
    {
      include("pagamento_boleto.php");
    } 

	?>