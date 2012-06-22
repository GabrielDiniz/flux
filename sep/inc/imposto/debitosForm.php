<fieldset>
    <legend>Débitos</legend>
    <form method="post" id="formDebitos" name="formDebitos" action="./inc/imposto/debitosImprimir.php" target="_blank">
        <table align="left" width="100%">
            <tr>
                <td width="1%">Ano:</td>
                <td>
                    <select name="cmbAnoDebito" id="cmbAnoDebito">
                        <option></option>
                        <?php
                            $sql = mysql_query("
                                SELECT DATE_FORMAT(datahoraemissao,'%Y') AS ano
                                FROM notas GROUP BY ano
                            ");
                            while(list($ano) = mysql_fetch_array($sql)){
                                echo "<option value='$ano'>$ano</option>";
                            }
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Mês</td>
                <td>
                    <select name="cmbMesDebito" id="cmbMesDebiro">
                        <option></option>
                        <option value="01">Janeiro</option>
                        <option value="02">Fevereiro</option>
                        <option value="03">Março</option>
                        <option value="04">Abril</option>
                        <option value="05">Maio</option>
                        <option value="06">Junho</option>
                        <option value="07">Julho</option>
                        <option value="08">Agosto</option>
                        <option value="09">Setembro</option>
                        <option value="10">Outubro</option>
                        <option value="11">Novembro</option>
                        <option value="12">Dezembro</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Emissor:</td>
                <td>
                    <select id="cmbEmissorDebito" name="cmbEmissorDebito" style="width: 150px">
                        <option></option>
                        <?php
                            $sql = mysql_query("SELECT razaosocial, codigo FROM cadastro WHERE nfe='S' AND estado='A'");
                            while($emissor = mysql_fetch_object($sql)){
                                echo "<option value='".$emissor->codigo."'>".$emissor->razaosocial."</option>";
                            }
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Estado:</td>
                <td>
                    <select id="cmbEstadoDebito" name="cmbEstadoDebito">
                        <option></option>
                        <option value="P">Pago</option>
                        <option value="A">Aberto</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button" value="Buscar" class="botao" 
                    onclick="acessoAjax('./inc/imposto/debitos.ajax.php','formDebitos','divRetorno');" />
                </td>
                <td>
                    <input type="reset" value="Limpar" class="botao" />
                    <input type="submit" value="Imprimir" id="btImprimir" class="botao" />
                </td>
            </tr>
            <tr>
                <td colspan="2" id="divRetorno"></td>
            </tr>
        </table>
    </form>
</fieldset>