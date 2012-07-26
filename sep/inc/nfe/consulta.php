<?php
/*
LICENÇA PÚBLICA GERAL GNU
Versão 3, 29 de junho de 2007
    Copyright (C) <2010>  <PORTAL PÚBLICO INFORMÁTICA LTDA>

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

Este programa é software livre: você pode redistribuí-lo e / ou modificar sob os termos da GNU General Public License como publicado pela Free Software Foundation, tanto a versão 3 da Licença, ou (por sua opção) qualquer versão posterior.

Este programa é distribuído na esperança que possa ser útil, mas SEM QUALQUER GARANTIA, sem mesmo a garantia implícita de COMERCIALIZAÇÃO ou ADEQUAÇÃO A UM DETERMINADO PROPÓSITO. Veja a GNU General Public License para mais detalhes.

Você deve ter recebido uma cópia da GNU General Public License  junto com este programa. Se não, veja <http://www.gnu.org/licenses/>.


This is an unofficial translation of the GNU General Public License into Portuguese. It was not published by the Free Software Foundation, and does not legally state the distribution terms for software that uses the GNU GPL — only the original English text of the GNU GPL does that. However, we hope that this translation will help Portuguese speakers understand the GNU GPL better.

Esta é uma tradução não oficial em português da Licença Pública Geral GNU (da sigla em inglês GNU GPL). Ela não é publicada pela Free Software Foundation e não declara legalmente os termos de distribuição para softwares que a utilizam — somente o texto original da licença, escrita em inglês, faz isto. Entretanto, acreditamos que esta tradução ajudará aos falantes do português a entendê-la melhor.


// Originado do Projeto ISS Digital – Portal Público que tiveram colaborações de Vinícius Kampff, 
// Rafael Romeu, Lucas dos Santos, Guilherme Flores, Maikon Farias, Jean Farias e Daniel Bohn
// Acesse o site do Projeto www.portalpublico.com.br             |
// Equipe Coordenação Projeto ISS Digital: <informatica@portalpublico.com.br>   |

*/
?>
<!-- Formulario de insercao de empresa  -->
<style type="text/css">
<!--
#divBusca {
	position:absolute;
	left:30%;
	top:20%;
	width:298px;
	height:276px;
	z-index:1;
 visibility:<?php if(isset($btBuscarCliente)) { echo"visible"; }else{ echo"hidden"; }?>
}
input[type*="text"]{
	text-transform:uppercase;
}
-->
</style>
<div id="divBusca"  >
	<?php include("inc/nfe/busca_prestador.php"); ?>
</div>
<?php 
	if(($_POST['codprestador'])){		   
		$codigo=$_POST['codprestador'];	
		$sql=mysql_query("SELECT IF(cnpj <> '',cnpj,cpf) AS cnpjcpf FROM cadastro WHERE codigo='$codigo'");
		$cpfcnpj = mysql_fetch_object($sql);
	}
?>
<script>
  function CancelaNota(codnota,msg)
  {	
	if(confirm(msg)){
		document.getElementById('hdPrimeiro').value=1; //mantem a paginacao na mesma pagina
		document.getElementById('txtCodigoCancela').value=codnota;
		var motivo = '';
		do{
			motivo = window.prompt("Informe o motivo do cancelamento");
			if(motivo == null){
				motivo = '';
			}else{
				document.getElementById('txtMotivoCancela').value = motivo;
			}
		}while(motivo == '');
		acessoAjax('inc/nfe/pesquisar_resultado.ajax.php','frmNfe','divResultado');
		alert('Nota cancelada!');
	}
  }			
</script>

<table border="0" cellspacing="0" cellpadding="0" >
	
	<tr>
	
		<td align="center">
			<form method="post" name="frmNfe" id="frmNfe" onsubmit="return false">
				<input type="hidden" name="include" id="include" value="<?php echo $_POST["include"]; ?>" />
				<fieldset style="width:800px">
				<legend>Pesquisar Nota</legend>
				<table width="100%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td align="left" width="22%">Número da Nota</td>
						<td align="left" width="78%">
							<input name="txtNumeroNota" type="text" size="10" class="texto" />
						</td>
					</tr>
					<tr>
						<td align="left">Código de Verificação</td>
						<td align="left">
							<input name="txtCodigoVerificacao" type="text" size="10" class="texto" style="text-transform:uppercase;" />
						</td>
					</tr>
					<tr>
						<td align="left">Prestador - CNPJ/CPF</td>
						<td align="left">
							<input name="txtCNPJPrestador" id="txtCNPJPrestador" maxlength="18" type="text" size="20" class="texto" value="<?php echo $cpfcnpj->cnpjcpf;?>" />
                            <input name="btPesquisar" type="submit" value="Pesquisar" class="botao" onclick="document.getElementById('divBusca').style.visibility='visible'" />
						</td>
					</tr>
                    <tr>
						<td align="left">Prestador - Nome</td>
						<td align="left">
							<input name="txtNomeEmissor" id="txtNomeEmissor" maxlength="30" type="text" size="20" class="texto" />
						</td>
					</tr>
                  <!--  <tr>
						<td align="left">Prestador - CNPJ</td>
						<td align="left">
							<input name="txtCnpjEmissor" id="txtCnpjEmissor" maxlength="30" type="text" size="20" class="texto" />
						</td>
					</tr>
                    -->
					<tr>
						<td align="left">Tomador - CNPJ/CPF</td>
						<td align="left">
							<input name="txtCNPJ" id="txtCNPJ" type="text" size="20" class="texto" maxlength="18" />
						</td>
					</tr>					<tr>
						<td align="left">Data Inicial: </td>
						<td align="left">
							<input name="txtDataInicial" type="text" id="txtDataInicial" size="20" value="<?php echo DataPt($dataInicial);?>" class="texto" />
						</td>
					</tr>					<tr>
						<td align="left">Data Final: </td>
						<td align="left">
							<input name="txtDataFinal" type="text" id="txtDataFinal" size="20" value="<?php echo DataPt($dataFinal);?>" class="texto" />
						</td>
					</tr>
                    <tr>
                    	<td align="left">Tipo: </td>
                        <td align="left">
                        	<label><input type="radio" value="T" name="rdTipo" checked="checked" /> <strong>Todas</strong></label>
                            <label><input type="radio" value="A" name="rdTipo" /> <strong>Avulsas</strong></label>
                            <label><input type="radio" value="N" name="rdTipo" /> <strong>Normais</strong></label>
                        </td>
                    </tr>
					<tr>
						<td align="left" colspan="2">
							<input name="btPesquisar" type="submit" value="Pesquisar" class="botao" onclick="
							acessoAjax('inc/nfe/pesquisar_resultado.ajax.php','frmNfe','divResultado')">
						</td>
					</tr>
				</table>
				</fieldset>
				<div id="divResultado"></div>
			</form>
		</td>

	</tr>
	
</table>