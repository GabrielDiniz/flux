<?php
/*
LICENÃ‡A PÃšBLICA GERAL GNU
Versão 3, 29 de junho de 2007
    Copyright (C) <2010>  <PORTAL PÃšBLICO INFORMÁTICA LTDA>

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



<fieldset style="width:800px"><legend>Resultado da Pesquisa</legend>
<?php
require_once("../conect.php");
require_once("../nocache.php");
require_once("../../funcoes/util.php");

$nome_arquivo = $_GET['txtNomeArquivo'];
$mes = $_GET['cmbMes'];
$ano = $_GET['cmbAno'];


$string = "";
if(($mes) && ($ano)){
	if(strlen($mes) == 1){
		$mes = "0".$mes;
	}
	$competencia = $ano."-".$mes;
	$string .= " AND competencia = '$competencia'";
}elseif($mes){
	if(strlen($mes) == 1){
		$mes = "0".$mes;
	}
	$string .= " AND SUBSTRING(competencia,6,2) = '$mes'";
}elseif($ano){
	$string .= " AND SUBSTRING(competencia,1,4) = '$ano'";
}

$query = ("SELECT codigo, arquivo, competencia FROM notas_arquivos WHERE arquivo LIKE '%$nome_arquivo%' $string ORDER BY codigo DESC");
$sql = Paginacao($query,'frmRelEscrituracoes','divResultado');
?>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<?php 
	if(mysql_num_rows($sql)>0){ ?>
		<tr >
			<td width="78" align="center"><strong>Cod. Arquivo</strong></td>
			<td width="486" align="center"><strong>Nome do Arquivo</strong></td>
			<td width="134" align="center"><strong>Compet&ecirc;ncia</strong></td>
			<td width="76" align="center">&nbsp;</td>
	</tr>
		<tr>
			<td colspan="7" height="1" ></td>
		</tr>
	<?php
	while(list($codigo, $arquivo, $competencia) = mysql_fetch_array($sql)) {
	?>    
		<tr bgcolor="#FFFFFF">
			<td align="center"><?php echo $codigo; ?></td>
			<td align="left"><?php echo $arquivo;  ?></td>	
			<td align="center"><?php echo DataPt($competencia); ?></td>
			<td align="center">
				<input type="button" value="Ver" title="Ver Notas escrituradas" class="botao"
				onclick="acessoAjax('inc/guia/relatorio_escrituracoes_arquivos.ajax.php?codarquivo=<?php echo $codigo;?>&a=a&','frmRelEscrituracoes','divResultado')" />
			</td>
		</tr>
	  <?php
		} // fim while  
	}else{//fim if se tem resultados
	?>
		<tr>
			<td colspan="5"><strong><center>Nenhum resultado encontrado.</center></strong></td>
		</tr>
	<?php
	}//else se nao tem resultados da busca
  ?> 
</table>
</fieldset>
