<table border="0" cellspacing="0" cellpadding="0" >
    <tr>
        <td width="18" align="left" background="img/form/cabecalho_fundo.jpg"><img src="img/form/cabecalho_icone.jpg" /></td>
        <td width="700" background="img/form/cabecalho_fundo.jpg" align="left" class="formCabecalho">&nbsp;Débitos</td>
        <td width="19" align="right" valign="top" background="img/form/cabecalho_fundo.jpg"><a href=""><img src="img/form/cabecalho_btfechar.jpg" width="19" height="21" border="0" /></a></td>
    </tr>
    <tr>
        <td width="18" background="img/form/lateralesq.jpg"></td>
        <td align="center" width="700">
            <?php include("./inc/imposto/debitosForm.php"); ?>
        </td>
        <td width="19" background="img/form/lateraldir.jpg"></td>
    </tr>
    <tr>
        <td align="left" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantoesq.jpg" /></td>
        <td background="img/form/rodape_fundo.jpg"></td>
        <td align="right" background="img/form/rodape_fundo.jpg"><img src="img/form/rodape_cantodir.jpg" /></td>
    </tr>
</table>
<form id="frmDebitos" method="post">
    <input type="hidden" name="include" id="include" value="<?php echo  $_POST['include'];?>" />
</form>