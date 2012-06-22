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

include("../../inc/conect.php");
include("../../funcoes/util.php");
// variaveis vindas do conect.php
// $CODPREF,$PREFEITURA,$USUARIO,$SENHA,$BANCO,$TOPO,$FUNDO,$SECRETARIA,$LEI,$DECRETO,$CREDITO,$UF	



$sql_brasao = mysql_query("SELECT brasao_nfe FROM configuracoes");
//preenche a variavel com os valores vindos do banco
list($BRASAO) = mysql_fetch_array($sql_brasao);



?>

<title>Imprimir Relat&oacute;rio</title>


<style type="text/css">
<!--
.style1 {font-family: Georgia, "Times New Roman", Times, serif}

.tabela {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	border-collapse:collapse;
	border: 1px solid #000000;
}
.tabelameio {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	border-collapse:collapse;
	border: 1px solid #000000;
}
.tabela tr td{
	border: 1px solid #000000;
}
.fonte{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
-->
</style>
</head>

<body>

<div id="DivImprimir">
<input type="button" onClick="print();this.style.display = 'none';" value="Imprimir" /></div>
<center>

<table width="700px" height="120" border="2" cellspacing="0" class="tabela">
  <tr>
    <td width="106"><center><img src="../../img/brasoes/<?php print $BRASAO; ?>" width="96" height="105"   />
    </center></td>
    <td width="584" height="33" colspan="2"><span class="style1">
      <center>
             <p>RELAT&Oacute;RIO DE PRESTADORES </p>
             <p>PREFEITURA MUNICIPAL DE <?php print strtoupper($CONF_CIDADE); ?> </p>
             <p><?php print strtoupper($CONF_SECRETARIA); ?> </p>
      </center>
    
    
    </span></td>
  </tr>
  </table>
<br>



<table width="700px" border="1" cellspacing="0" class="tabelameio"  > 

<tr>
  
		<td width="32%" >
<table>
							<?php
							//Comando sql que selecionara do banco os tipos de prestadores e a quantidade de cada e o total geral

							$sql_tipo = mysql_query("
								SELECT 
									tipo.nome, 
									COUNT(cadastro.codigo) 
								FROM 
									cadastro 
								INNER JOIN 
									tipo ON tipo.codigo = cadastro.codtipo 
								WHERE
									(tipo = 'prestador' OR tipo = 'tomador' OR tipo = 'contador')
								GROUP BY 
									tipo.nome
							");
							echo "<b><center><font class=\"fonte\">Tipos de Prestadores</center></b> <br>";
							
							$qtdtotal=0;
							while(list($nome,$qtd)=mysql_fetch_array($sql_tipo)){
								echo"<tr><td align=\"center\"><font class=\"fonte\">$nome:</font></td><td align=\"center\"><font class=\"fonte\">$qtd</font></td></tr>";
								$qtdtotal=$qtdtotal+$qtd;
								}
							?>
							<tr>
								<td align="center"><font class="fonte"> Total:</font></td><td><?php echo "<font class=\"fonte\"> $qtdtotal<font>"; ?></td>
					 		</tr>
		  </table>
	  	
		<td width="34%" valign="top">
		  <table  border="0" > 
        
       <tr >
<?php

//Comando sql que selecionará do banco a quantidade de prestadores por estado
$sql = mysql_query ("
	SELECT 
		uf , 
		COUNT(*) 
	FROM 
		cadastro 
	INNER JOIN
		tipo ON cadastro.codtipo = tipo.codigo
	WHERE 
		uf != '' AND codtipo > 0  AND (tipo = 'prestador' OR tipo = 'tomador' OR tipo = 'contador')
	GROUP BY 
		uf
");

echo "<b><center>Qnt. de Prestadores por Estado (UF)</center></b> <br>";

$qtdtotal=0;
$cont = 0;
while(list($uf,$qtd)=mysql_fetch_array($sql)){
if($cont == '5'){
echo "</tr><tr>";

$cont = 0;  
}
echo"<td align=\"center\" ><font class=\"fonte\">$uf:</td><td align=\"center\"><font class=\"fonte\">$qtd</font></td>";
$qtdtotal=$qtdtotal+$qtd;

$cont++;
}
								
?>

<?php
$ano=mysql_query("SELECT year (datahoraemissao from notas");
?>
</tr>
    <tr>
        <td align="left"><font class="fonte">Total:</font></td><td><?php echo "<font class=\"fonte\">$qtdtotal</font>"; ?></td>
    </tr>
      </table>
      </td>
		<td width="34%" valign="top">
			<table>
            <?php 
			//Comando sql que selecionará do banco os tipos de declaracoes e quantidade de cada
			$sql_tipodec = mysql_query("SELECT declaracoes.declaracao, COUNT(*)
										FROM
										  declaracoes 
										INNER JOIN
										  cadastro ON cadastro.codtipodeclaracao = declaracoes.codigo
										INNER JOIN 
										  tipo ON cadastro.codtipo = tipo.codigo
										WHERE 
										  (tipo = 'prestador' OR tipo = 'tomador' OR tipo = 'contador')
										GROUP BY
										  declaracoes.declaracao");
			
			echo "<b><center>Tipos de Declarações</center></b> <br>";  
										  
			$qtdtotal=0;							  
			while(list($declaracoes,$qtd)=mysql_fetch_array ($sql_tipodec)){
			echo"<tr><td align=\"center\"><font class=\"fonte\">$declaracoes:</td><td align=\"center\"><font class=\"fonte\">$qtd</td></tr>";
			$qtdtotal=$qtdtotal+$qtd;
			}
			?>  
                <tr>
                    <td align="left"><font class="fonte">Total:</font></td><td><?php echo "<font class=\"fonte\"> $qtdtotal</font>"; ?></td>
                </tr> 
   			</table>
	  </td>
	</tr>	
<?php
	
	
	//Recebe as variaveis enviadas pelo form por post

	$nome        = trataString($_POST['txtNomeValor']);
	$ano 		 = $_POST["cmbAno"];
	$mes 		 = $_POST["cmbMes"];
	$nfe 	 	 = $_POST['nfe'];
	$nfe_canc	 = $_POST['nfeCancelada'];
	$str_innerjoin	= "";
	$str_where   = "";

		
	//verifica quais campos foram preenchidos e concatena na variavel str_where

	if($ano){
		$str_where .= " AND year (notas.datahoraemissao) ='$ano'";
	}
	if($mes){
		$str_where .= " AND month (notas.datahoraemissao) ='$mes'";
	}
	if ($ano!=""|| $nfe_canc!=""|| $mes!="") {
		$str_innerjoin= " INNER JOIN notas on notas.codemissor = cadastro.codigo";
	}
	if($mes){
		$str_where .= " AND month (notas.datahoraemissao) ='$mes'";
	}
	if ($nfe_canc=="C"){
		$str_where .= " AND notas.estado = '$nfe_canc'";
	}
	if($nfe=="S"){
		$str_where .= " AND cadastro.nfe = '$nfe'";
	}
	
//Sql buscando as informações que o usuario pediu e com o limit estipulado pela função
	if ($nome=="" && $ano=="" && $mes=="")
	{
		$query = ("
			SELECT 
				notas.valortotal, notas.valoriss, notas.valordeducoes, notas.valorinss, notas.total_retencao, cadastro.nome
			FROM notas
			INNER JOIN
				cadastro on cadastro.codigo = notas.codemissor
				$str_where
			ORDER BY
				cadastro.nome
			");
	}
	else
	{
		$query = ("
			SELECT 
				notas.valortotal, notas.valoriss, notas.valordeducoes, notas.valorinss, notas.total_retencao, cadastro.nome
			FROM notas
			INNER JOIN
				cadastro on cadastro.codigo = notas.codemissor
			WHERE
				cadastro.nome LIKE '%$nome%'
				$str_where
			ORDER BY
				cadastro.nome
				");
	}
	$sql_pesquisa = mysql_query ($query);
	$result = mysql_num_rows($sql_pesquisa);
	
	
if(mysql_num_rows($sql_pesquisa)){

?>


<table width="700px" class="tabela">
	<tr style="background-color:#999999">
    <?php
	if($result <= 1)
	{
		echo "<b>Foi encontrado $result  Resultado</b>";
	}
	else
	{
		echo "<b>Foram encontrados $result  Resultados</b>";
	}
	?>
      <td width="30%" align="center"><strong>Nome</strong></td>
      <td width="20%" align="center"><strong>Valor arrecadado</strong></td>
      <td width="15%" align="center"><strong>Deduções</strong></td>
      <td width="12%" align="center"><strong>ISS</strong></td>
      <td width="20%" align="center"><strong>Total retenção</strong></td>

  </tr>
  <?php
  		
		$x = 0;
		$tipos_extenso = array(
			"prestador"              => "Prestador",
			"empreiteira"            => "Empreiteira",
			"instituicao_financeira" => "Instituição Financeira",
			"cartorio"               => "Cartório",
			"operadora_credito"      => "Operadora de Crédito",
			"grafica"                => "Gráfica",
			"contador"               => "Contador",
			"tomador"                => "Tomador",
			"orgao_publico"          => "Orgão Público",
			"simples"                => "Simples"
		);
		$conta=0;
		$guardanome="";
		while($dados_pesquisa = mysql_fetch_array($sql_pesquisa)){
			if ($guardanome!=$dados_pesquisa['nome'])
			{
				$guardanome = $dados_pesquisa['nome'];
				$conta=0;
			}
			$valor = $dados_pesquisa['notas'];
			$conta++;
		//print_array($dados_pesquisa);
 ?>
<input type="hidden" name="txtCodigoGuia<?php echo $x;?>" id="txtCodigoGuia<?php echo $x;?>" value="<?php echo $dados_pesquisa['tipo'];?>" />

    <tr id="trDecc<?php echo $x;?>">
        <td bgcolor="white" align="left"><?php
		//if($conta==1){
			echo $guardanome;
		//}
		?></td>
     	<td bgcolor="white" align="center"><?php echo "R$ ".$dados_pesquisa['valortotal'];?></td>
        <td bgcolor="white" align="center"><?php echo "R$ ".$dados_pesquisa['valordeducoes'];?></td>
        <td bgcolor="white"  align="center"><?php echo "R$ ".$dados_pesquisa['valoriss'];?></td>
        <td bgcolor="white" align="center"><?php echo "R$ ".$dados_pesquisa['total_retencao'];?></td>

  </tr>
      
 
  <?php
			$x++;
		}//fim while
	?>
</table>
<table width="700px" class="tabela">
<?php
}else{
 //caso não encontre resultados, a mensagem 'Não há resultados!' será mostrada na tela
	echo "<tr style=\"background-color:#999999\"><td colspan=\"3\"><center><b><font class=\"fonte\">Não há resultados!</font></center></td></b></tr>";
}
?>
</table>
</body>
</html>

