<?php
include('../../inc/conect.php');
include('../../funcoes/util.php');
require_once("../../../../../middleware/pmfeliz/autoload.php");
?>
<fieldset>
    <table width="100%">
        <tr>
            <td>
            	<?php
                $cnpj = $_GET['cmbTomador'];
				if($cnpj!=""){
					$sql_where = array();
					if ($cnpj) {
						$AND = " AND (c.cpf = '$cnpj' OR c.cnpj = '$cnpj')";
					}
				}
				$check= $_GET["ckUsados"];
				if($check){ $str= " WHERE creditos_imoveis.estado = 'U'";}else{ $str= " WHERE creditos_imoveis.estado = 'E'"; }
				$query=("
					SELECT
						creditos_imoveis.codimovel, creditos_imoveis.codigo as codimoveis, c.cnpj, c.cpf, c.credito, c.codigo, creditos_imoveis.estado
					FROM
						cadastro as c
					INNER JOIN
						creditos_imoveis
					ON creditos_imoveis.codcadastro = c.codigo
					$str $AND
					ORDER BY
						c.codigo
				");
				$sql=Paginacao($query,'frmCreditos','divCreditos',10);
				if(mysql_num_rows($sql)>0){
					?>
                    <input type="hidden" name="hdX<?php echo $x; ?>" id="hdX<?php echo $x; ?>" value="<?php echo $x; ?>" />
                    <table width="100%" cellpadding="0" cellspacing="0">
                     <tr bgcolor="#666666">
					  <td align="center">Cod. Im&oacute;vel</td>
                      <td align="center">CPF/CNPJ</td>
                      <td align="center">Cr&eacute;dito</td>
                      <td align="center">Abatimento</td>
                      <td align="center">A&ccedil;&otilde;es</td>
                     </tr>
                    <?php
					$x=1;
					while($dados = mysql_fetch_object($sql)){
						?>
                        <input type="hidden" name="hdCredito<?php echo $x; ?>" id="hdCredito<?php echo $x; ?>" value="<?php echo $dados->credito; ?>" />
                        <input type="hidden" name="hdCodimoveis<?php echo $x; ?>" id="hdCodimoveis<?php echo $x; ?>" value="<?php echo $dados->codimoveis; ?>" />
                        <input type="hidden" name="hdCodCadastro<?php echo $x; ?>" id="hdCodCadastro<?php echo $x; ?>" value="<?php echo $dados->codigo; ?>" />
                        <input type="hidden" name="hdCodImovel<?php echo $x; ?>" id="hdCodImovel<?php echo $x; ?>" value="<?php echo $dados->codimovel; ?>" />
                        <tr bgcolor="#FFFFFF">
                         <td align="center"><?php echo $dados->codimovel; ?>&nbsp;
                         </td>
                         <td align="center"><?php echo $dados->cnpj.$dados->cpf; ?></td>
                         <td align="center"><?php echo "R$ ".DecToMoeda($dados->credito); ?></td>
                         <?php if($dados->estado=="U"){ 
                         $abatanterior = mysql_query("SELECT creditousado FROM creditos_imoveis_usado WHERE codcredito = '".$dados->codimoveis."' "); 
						 list($creditousado)=mysql_fetch_array($abatanterior);
						 ?>
                         <td align="center"><?php echo DecToMoeda($creditousado); ?></td>
                         <?php }else{ ?>
                         <td align="center"><input onkeyup="MaskMoeda(this);return NumbersOnly(event);" type="text" onkeydown="return NumbersOnly(event);" name="txtAbatimento<?php echo $x; ?>" id="txtAbatimento<?php echo $x; ?>" value="<?php echo DecToMoeda($dados->credito); ?>" class="texto" size="20" /></td>
                         <?php } ?>
                         <td align="center">
                         	<input type="button" class="botao" value="Informa&ccedil;&otilde;es" title="Ver Conte&uacute;do completo" 
            	onclick="VisualizarNovaLinha('<?php echo $dados->codimovel;?>','tdcredito<?php echo $x;?>',this,'inc/credito/creditos_imoveis.ajax.php?cod=<?php echo $dados->codigo ?>');" />					<?php if($dados->estado!="U"){ ?>
                            <input name="btConfirma" value="Confirmar" class="botao" type="submit" onClick="document.getElementById('hdX').value=<?php echo $x; ?>;return ValidaFormulario('txtAbatimento<?php echo $x; ?>','Os campos devem estar preenchidos')" />
                            <?php } ?>
                         </td>
                        </tr>
                        <tr>
                         <td id="tdcredito<?php echo $x;?>" colspan="5"></td>
                        </tr>
                        <?php
						$x++;
					}
				}else{
				echo "Nenhuma solicita&ccedil;&atilde;o";	
				}?>
                </table>
            </td>
        </tr>
    </table>
</fieldset>