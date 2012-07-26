<?php
include 'inc/conect.php';

if($_POST["btInserirNota"] == "Emitir"){
	include("nota_avulsa_nova.php");//arquivo que executa o script de insercao no banco de dados
}
?>
<div id="DivAbas"></div>    
<table border="0" cellspacing="0" cellpadding="0">
 
  <tr>
   <legend>Nota Avulsa</legend>
    <td align="center">    
		<br />
		<form method="post" id="frmNota">
			<input type="hidden" name="include" id="include" value="<?php echo $_POST["include"];?>" />
			<fieldset>
			<table align="left">
				<tr>
					<td>CNPJ/CPF Prestador</td>
					<td><input type="text" name="txtCnpjPrestador" class="texto" /></td>
				</tr>
				<tr>
					<td>
						<input type="submit" name="btnBuscar" id="btnBuscar" value="Buscar" class="botao" onclick="btnBuscar_click(); return false;" />
						<input type="submit" name="btnBuscarNotas" id="btnBuscarNotas" value="Ver Notas" class="botao" onclick="btnBuscarNotas_click(); return false;" />
					</td>
				</tr>
			</table>
			</fieldset>
			<div id="dvResultadoNota"></div>
		</form>
        
    </td>
	
  </tr>
 
</table>
<script type="text/javascript">
	function btnBuscar_click() {
		acessoAjax('inc/nfe/nota_avulsa.ajax.php','frmNota','dvResultadoNota');
	}
	function btnBuscarNotas_click() {
		acessoAjax('inc/nfe/nota_avulsa_ver.ajax.php','frmNota','dvResultadoNota');
	}
	function btnBuscar2_click() {
		acessoAjax('inc/nfe/nota_avulsa_ver.ajax.php','frmNota','divVerNotas');
	}

</script>