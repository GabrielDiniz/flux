<?php
	require_once("../conect.php");
	require_once("../../funcoes/util.php");
	
	$tipo = $_GET['tipo'];
	$codSolicitacao = $_GET['codigo'];
	$novoLimite = $_GET['novoLimite'];
	
	if($tipo == "L"){
	
		$sql_busca_solicitante = mysql_query("
			SELECT 
				cadastro.codigo 
			FROM 
				cadastro
			INNER JOIN
				rps_solicitacoes ON rps_solicitacoes.codcadastro = cadastro.codigo
			WHERE 
				rps_solicitacoes.codigo = '$codSolicitacao'
		");
		list($codCadastro) = mysql_fetch_array($sql_busca_solicitante);	
		
		mysql_query("UPDATE rps_solicitacoes SET estado = 'L' WHERE codigo = '$codSolicitacao'");
		
		$sql_testa = mysql_query("SELECT codigo,limite FROM rps_controle WHERE codcadastro = '$codCadastro'");
		if(mysql_num_rows($sql_testa)){			
			$dadosrps=mysql_fetch_object($sql_testa);
			mysql_query("UPDATE rps_controle SET limite = '$novoLimite',ultimo_limite='{$dadosrps->limite}' WHERE codcadastro = '$codCadastro' ");
		}else{
			mysql_query("INSERT INTO rps_controle SET codcadastro = '$codCadastro', limite = '$novoLimite'");
		}
		
	}elseif($tipo == "R"){
	
		mysql_query("UPDATE rps_solicitacoes SET estado = 'R' WHERE codigo = '$codSolicitacao'");
		
	}
?>