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
  include("../../include/conect.php");
  include("../../funcoes/util.php");  
/*
  $cep =$_GET['cep'];
  $cepexplode=explode('-',$cep);
	if($cepexplode[0]!="" && $cepexplode[1]!=""){
		$query=mysql_query("SELECT cep_uf FROM cep_log_index WHERE cep5='".$cepexplode[0]."'");
		$dados=mysql_fetch_object($query);
		$querycep=mysql_query("SELECT cidade, bairro, tp_logradouro, logradouro FROM cep_".$dados->cep_uf." WHERE cep = '".$cep."'");
		$resultado=mysql_fetch_array($querycep);
		
		$bairro = htmlentities($resultado['bairro']);
		$cidade = htmlentities($resultado['cidade']);
		$tplogradouro = htmlentities($resultado['tp_logradouro']);
		$logradouro = htmlentities($resultado['logradouro']);
		
		$resultadoCEP = array(
			"resultado"  => '1',
			"resultado_txt" => 'sucesso',
			"uf"  => strtoupper($dados->cep_uf),
			"cidade"  => $cidade,
			"bairro"  => $bairro,
			"tipo_logradouro"  => $tplogradouro,
			"logradouro" => $logradouro
		);

		echo html_entity_decode(utf8_decode(json_encode($resultadoCEP)));
	}


*/
$cep = $_GET['cep'];
  $cepexplode=explode('-',$cep);
  $retorno = "";
	if($cepexplode[0]!="" && $cepexplode[1]!=""){
		$query=mysql_query("SELECT cep_uf FROM cep_log_index WHERE cep5='".$cepexplode[0]."'");
		$dados=mysql_fetch_object($query);
		$querycep=mysql_query("SELECT cidade, bairro, tp_logradouro, logradouro FROM cep_".$dados->cep_uf." WHERE cep = '".$cep."'");
		$resultado=mysql_fetch_array($querycep);
		if(mysql_num_rows($query)>0){
			if(mysql_num_rows($querycep)>0){
				$bairro = htmlentities($resultado['bairro']);
				$cidade = htmlentities($resultado['cidade']);
				$tplogradouro = htmlentities($resultado['tp_logradouro']);
				$logradouro = htmlentities($resultado['logradouro']);
				
				$retorno.="1|";
				$retorno.=strtoupper($dados->cep_uf)."|";
				$retorno.=$cidade."|";
				$retorno.=$bairro."|";
				$retorno.=$tplogradouro."|";
				$retorno.=$logradouro;
				
			}else{
				$retorno = "0|";	
			}
		}else{
			$retorno = "0|";	
		}
	}
	
	echo html_entity_decode(utf8_decode($retorno));
	
?>