<?php
/*
LICENÃ‡A PÃšBLICA GERAL GNU
Versão 3, 29 de junho de 2007
    Copyright (C) <2010>  <PORTAL PÃšBLICO INFORMÃ?TICA LTDA>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Este programa é software livre: você pode redistribuÃ­-lo e / ou modificar sob os termos da GNU General Public License como publicado pela Free Software Foundation, tanto a versão 3 da Licença, ouÂ (por sua opção) qualquer versão posterior.

Este programa é distribuÃ­do na esperança que possa ser útil, mas SEM QUALQUER GARANTIA, sem mesmo a garantia implÃ­cita de COMERCIALIZAÃ‡ÃƒO ou ADEQUAÃ‡ÃƒO A UM DETERMINADO PROPÓSITO. Veja a GNU General Public License para mais detalhes.

Você deve ter recebido uma cópia da GNU General Public LicenseÂ Â junto com este programa. Se não, veja <http://www.gnu.org/licenses/>.


This is an unofficial translation of the GNU General Public License into Portuguese. It was not published by the Free Software Foundation, and does not legally state the distribution terms for software that uses the GNU GPL â€” only the original English text of the GNU GPL does that. However, we hope that this translation will help Portuguese speakers understand the GNU GPL better.

Esta é uma tradução não oficial em português da Licença Pública Geral GNU (da sigla em inglês GNU GPL). Ela não é publicada pela Free Software Foundation e não declara legalmente os termos de distribuição para softwares que a utilizam â€” somente o texto original da licença, escrita em inglês, faz isto. Entretanto, acreditamos que esta tradução ajudará aos falantes do português a entendê-la melhor.


// Originado do Projeto ISS Digital â€“ Portal Público que tiveram colaborações de VinÃ­cius Kampff, 
// Rafael Romeu, Lucas dos Santos, Guilherme Flores, Maikon Farias, Jean Farias e Daniel Bohn
// Acesse o site do Projeto www.portalpublico.com.br             |
// Equipe Coordenação Projeto ISS Digital: <informatica@portalpublico.com.br>   |

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
	<?php include("inc/relatorios/busca.php"); ?>
</div>
<?php 
	if(isset($_POST['CODEMISSOR'])){
		$sql_cad = "SELECT * FROM cadastro WHERE codigo = ".$_POST['CODEMISSOR'];
		$sql_res_cad = mysql_query($sql_cad);
		$prestador = mysql_fetch_array($sql_res_cad);
		$cod_prestador = $prestador['codigo'];
		if($prestador['cpf'] != '')$cpfcnpj = $prestador['cpf'];
		else $cpfcnpj = $prestador['cnpj'];
		
		if($prestador['nome'] != '')$nome_prestador = $prestador['nome'];
		else $nome_prestador = $prestador['razaosocial'];
	}
?>
<table border="0" cellspacing="0" cellpadding="0" >
  
  <tr>
    
    <td align="center">
		<form method="post" name="frmRelatorio" id="frmRelatorio" action="inc/relatorios/imprimir_notas_escrituradas.php" target="_blank">
		<input type="hidden" name="include" value="<?php echo $_POST['include']; ?>" />
		<fieldset>
			<legend>Relat&oacute;rio de notas escrituradas</legend>
			<table align="left">
				<tr>
					<td>Data Inicial</td>
                    <td>
                        <input type="text" name="txtDataInicial" id="txtDataInicial" class="texto" size="10" readonly="readonly" />
                    </td>
				</tr>
				<tr>
					<td>Data Final</td>
                    <td>
                        <input type="text" name="txtDataFinal" id="txtDataFinal" class="texto" size="10" readonly="readonly" />
                    </td>
				</tr>
				<tr>
					<td>Prestador</td>
					<td>
                    <input type="hidden" value="<?php echo $cpfcnpj ?>" name="txtCnpjPrestador" />
                    <input type="text" value="<?php echo $nome_prestador ?>" name="nomePrestador" id="nomePrestador" readonly="readonly" size="50" />
                    <input type="button" value="Pesquisar" name="btPesquisar" class="botao" onclick="document.getElementById('divBusca').style.visibility='visible'" />
                    </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" name="btnBuscar" value="Buscar" class="botao" onclick="btnBuscar_click(); return false;" />
						<input type="submit" name="btnImprimir" value="Imprimir" class="botao" onclick="btnBuscar_click();" />
                        <input type="button" name="btLimpar" id="button2" value="Limpar Campos" class="botao" onclick="document.getElementById('nomePrestador').value = '';document.getElementById('txtDataInicial').value = '';document.getElementById('txtDataFinal').value = ''" />
					</td>
				</tr>
			</table>
		</fieldset>
		<div id="dvResultdoRelatorio"></div>
		</form>
	</td>
	
  </tr>
  
</table>
<script type="text/javascript">
	function btnBuscar_click(){
		acessoAjax('inc/relatorios/escrituradas_resultado.ajax.php','frmRelatorio','dvResultdoRelatorio');
	}
</script>
