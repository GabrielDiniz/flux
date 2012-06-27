<?php
// busca livro
$sql_livro = mysql_query("
			SELECT 
				cad.nome,
				cad.inscrmunicipal, 
				cad.logo,
				if(!cad.cnpj, cad.cpf, cad.cnpj) as cnpj, 
				livro.codcadastro,
				livro.periodo,
				DATE_FORMAT(livro.vencimento,'%d/%m/%Y') as vencimento,
				DATE_FORMAT(livro.geracao,'%d/%m/%Y') as geracao,
				livro.basecalculo,
				livro.reducaobc,
				livro.valoriss, 
				livro.valorissretido,
				livro.valorisstotal,
				livro.obs 				
				FROM livro
				INNER JOIN cadastro as cad ON cad.codigo=livro.codcadastro				
				WHERE livro.codigo = $livro");

$livro = mysql_fetch_object($sql_livro);
		
?>
<style type="text/css">
<!--
#divPrincipalArrec{	
	margin-top:5px;
	margin-bottom:100px;	
}

#divCabecalhoArrec{
	text-align:center;	
	margin-bottom:2px;
}
-->
</style>

<div id="divPrincipalArrec">
	<div id="divCabecalhoArrec">
<table border="0" cellpadding="5" cellspacing="0" style="margin: 0 auto;">
  <tr>
    <td width="150" rowspan="4" align="center"><?php if($livro->logo == NULL) { echo 'sem imagem'; } else { echo "<img src=../img/logos/$livro->logo width=\"120\" height=\"120\" />"; }; ?></td>
    <td width="800" colspan="4" align="center" class="titulo1">REGISTRO E APURA&Ccedil;&Atilde;O DO ISS </td>
    <td width="150" rowspan="4" align="center"><?php if($CONF_BRASAO == NULL) {echo 'sem imagem';} else { echo "<img src=../img/brasoes/$CONF_BRASAO width=\"120\" height=\"120\" />";};?></td>
  </tr>
  <tr>
    <td width="150" class="field1">Contribuinte:</td>
    <td colspan="3" class="field1"><?php echo $livro->nome; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">CNPJ/CPF:</td>
    <td width="250"><?php echo $livro->cnpj; ?>&nbsp;</td>
    <td width="150" class="field1">Per&iacute;odo:</td>
    <td width="250"><?php 
						  $periodof = substr($livro->periodo,5,2);
						  $periodof = $periodof."/".substr($livro->periodo,0,4);
						  echo $periodof; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">Inscr. Municipal: </td>
    <td colspan="3" ><?php echo $livro->inscrmunicipal; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">Observa&ccedil;&otilde;es:</td>
    <td colspan="5"><?php echo $livro->obs; ?>&nbsp;</td>
    </tr>
  <tr>
    <td class="field1">Data da Gera&ccedil;&atilde;o: </td>
    <td colspan="5"><?php echo $livro->geracao; ?>&nbsp;</td>
    </tr>
</table>
	
	
	
	</div>
	<div class="titulo1" id="divCabecalhoArrec">CONTROLE DE ARRECADA&Ccedil;&Atilde;O DE ISS </div>
	<div id="divIssArrec">
<table width="400" border="0" cellpadding="5" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td colspan="2" align="center" class="titulo1">ISSQN</td>
    </tr>
  <tr>
    <td colspan="2" align="center" class="field2">Imposto pr&oacute;prio a pagar </td>
    </tr>
  <tr>
    <td width="50%">Vencimento</td>
    <td width="50%"><?php echo $livro->vencimento; ?>&nbsp;</td>
  </tr>
  <tr>
    <td>Base de C&aacute;lculo </td>
    <td><?php echo "R$ ".DecToMoeda($livro->basecalculo); ?>&nbsp;</td>
  </tr>
  <tr>
    <td>Redu&ccedil;&atilde;o da Base de C&aacute;lculo </td>
    <td><?php echo  "R$ ".DecToMoeda($livro->reducaobc); ?>&nbsp;</td>
  </tr>
  <tr>
    <td>Valor do ISS </td>
    <td><?php echo "R$ ".DecToMoeda($livro->valoriss); ?>&nbsp;</td>
  </tr>
  <tr>
    <td>Valor do ISS Retido </td>
    <td><?php echo "R$ ".DecToMoeda($livro->valorissretido); ?>&nbsp;</td>
  </tr>
  <tr>
    <td>Total</td>
    <td><?php echo "R$ ".DecToMoeda($livro->valorisstotal); ?>&nbsp;</td>
  </tr>
</table>
	
	</div>
	

</div>


