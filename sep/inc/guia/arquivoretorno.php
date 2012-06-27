<?php
class ArquivoRetorno {
	function codigoGuiaPeloNossonumero($nossonumero){
		$sql = mysql_query("SELECT codigo FROM guia_pagamento WHERE nossonumero = '$nossonumero' AND pago <> 'S'");
		if (mysql_num_rows($sql) == 0) {
			return false;
		}
		list($cod_guia) = mysql_fetch_array($sql);
		return $cod_guia;
	}
	
	function registrarPagamentoGuia($codguia){
		mysql_query("UPDATE guia_pagamento SET pago = 'S' WHERE codigo = '$codguia'");
				
		$sql_codguia = mysql_query("
			SELECT 
				n.codnota 
			FROM 
				guia_pagamento as gp 
			INNER JOIN 
			    livro as l ON gp.codlivro=l.codigo
			INNER JOIN livro_notas as n on n.codlivro=l.codigo		
			WHERE 
				gp.codigo = '$codguia' 
		");
		
		while (list($cod_nota) = mysql_fetch_array($sql_codguia) ){
			//echo "$codguia - $cod_nota<br>";
			mysql_query("UPDATE notas SET estado = 'E' WHERE codigo = '$cod_nota'");
			$sqlcredito = mysql_query("SELECT codtomador,credito FROM notas WHERE codigo='$cod_nota'");
			$dadoscred= mysql_fetch_object($sqlcredito);
			mysql_query("UPDATE cadastro SET credito = credito+{$dadoscred->credito} WHERE codigo = '$dadoscred->codtomador'");
			
			
			
		}
		return mysql_num_rows($sql_codguia);
	}
	
	function registrarPagamentoManual($nossonumero, $valor){
		$valor = MoedaToDec($valor);
		$sql = mysql_query("SELECT codigo FROM guia_pagamento WHERE nossonumero = '$nossonumero' AND valor = $valor");
		if (mysql_num_rows($sql) == 0) {
			return false;
		} else {
			list($cod_guia) = mysql_fetch_array($sql);
			return self::registrarPagamentoGuia($cod_guia);
		}
	}
	
	function lerTxtRetorno($arquivo_txt_upload){
		$arquivo_txt = $_FILES[$arquivo_txt_upload];
		//pega o endereco da pasta para guardar o aruivo de retorno
		$target_path = dirname(__FILE__)."/arquivosretorno/";
		
		if (!is_dir($target_path)) {
			mkdir($target_path);
		}
		
		//monta o endereco onde vai ficar os arquivos de retorno
		$target_path = $target_path . basename( $arquivo_txt['name']); 
		$arquivo = $target_path;
		
		if (move_uploaded_file($arquivo_txt['tmp_name'], $target_path)) {
			//echo "The file ".  basename( $arquivo_txt['name']). " has been uploaded";
			//echo "Sucesso!";
		} else {
			echo "Ocorreu um erro durante o upload, favor tentar novamente!";
			//se ocorrer um erro para o script
			return;
		}
		
		//le o arquivo em forma de array
		$arq_array = file($target_path);
		
		//tira a primeira linha que é a identificacao do banco
		$dados_banco = array_shift($arq_array);
		
		//tira a ultima que nao sei para que serve
		$dados_foot = array_pop($arq_array);
		
		$total_guias = count($arq_array);
		
		$cont_guias = 0;
		
		$cont_notas = 0;
		
		foreach ($arq_array as $lin) if ($lin) {
			//o nosso numero esta na posisao 56 e tem 25 caracteres de tamanho
			$nossonumero = substr($lin,56,25);
			$cod_guia = self::codigoGuiaPeloNossonumero($nossonumero);
			
			//conta as guias atualizadas com sucesso
			$reg_guias = self::registrarPagamentoGuia($cod_guia);
			
			if ($reg_guias > 0) {
				$cont_guias++;
			}
			
			$cont_notas += $reg_guias;
		
		}
		//echo "<br>{$cont_guias}/{$total_guias} guias pagas <br>{$cont_notas} notas escrituradas";
		
		//retorna um resumo da operacao de leitura do arquivo
		return array(
			'guias' 		=> $cont_guias,
			'total_guias'	=> $total_guias,
			'notas'		=> $cont_notas
		);
	}
	
	/**
	* Funcao para leitura de arquivo de retorno do banco referente ao simples nacional
	*/
	function lerTxtRetornoDAF607($arquivo_txt_upload, $periodo){
		$arquivo_txt = $_FILES[$arquivo_txt_upload];
		//pega o endereco da pasta para guardar o aruivo de retorno
		$target_path = dirname(__FILE__)."/arquivosretornoSN/";
		
		if (!is_dir($target_path)) {
			mkdir($target_path);
		}
		
		//monta o endereco onde vai ficar os arquivos de retorno
		$target_path = $target_path . basename( $arquivo_txt['name']); 
		$arquivo = $target_path;
		
		if(!move_uploaded_file($arquivo_txt['tmp_name'], $target_path)){
			echo "Ocorreu um erro durante o upload, favor tentar novamente!";
			return;
		}
		
		//le o arquivo em forma de array
		$arq_array = file($target_path);
		
		//remove a linha HEADER
		$dados_banco = array_shift($arq_array);
		
		//remove a linha TRAILER
		$dados_foot = array_pop($arq_array);
		
		$total_guias = count($arq_array);
		
		$cont_guias = 0;
		
		$cont_notas = 0;
		
		//Registra o diretorio do arquivo no banco de dados
		$cod_arquivo = self::registraArquivo(basename( $arquivo_txt['name']), NULL);
		
		foreach ($arq_array as $lin) if ($lin) {
			//Busca no arquivo os dados para a escrituracao
			$cnpj = substr($lin,74,14);
			$competencia = substr($lin,100,6);
			$reais = substr($lin,107,14);
			$moeda = substr($lin,121,2);
			$valor = (int) $reais.".".$moeda;
			
			if($periodo == $competencia){
				$cod_livro = self::retornaCodGuiaDAF607($cnpj, $competencia, $valor);
				
				//conta as guias atualizadas com sucesso
				$reg_guias = self::registrarPagamentoDAF607($cod_livro);
				
				if ($reg_guias > 0) {
					self::registraLivroArquivo($cod_livro,$cod_arquivo);
					$cont_guias++;
				}
				
				$cont_notas += $reg_guias;
			}else{
				Mensagem_onload("O per&iacute;odo selecionado n&atilde;o confere com o per&iacute;odo das guias no arquivo DAF607!");
				return;
			}
		
		}
		
		//Atualiza o registro do arquivo no banco
		self::registraArquivo(basename($arquivo_txt['name']), $competencia);
		
		
			//retorna um resumo da operacao de leitura do arquivo
		return array(
			'guias' 		=> $cont_guias,
			'total_guias'	=> $total_guias,
			'notas'		=> $cont_notas
		);
		
	}
	
	function retornaCodGuiaDAF607($cnpj,$competencia, $valor){
		//Busca o codigo do contribuinte
		$cnpj_tratado = mascaraCpf($cnpj);
		$data_tratada = mascaraCompetencia($competencia);
		$sql_cadastro = mysql_query("SELECT codigo FROM cadastro WHERE cnpj = '$cnpj_tratado'");
		list($cod_cadastro) = mysql_fetch_array($sql_cadastro);
		
		//Busca o codigo do livro pelo codigo do contribuinte e competencia
		$sql_livro = mysql_query("SELECT codigo FROM livro WHERE codcadastro = '$cod_cadastro' AND periodo = '$data_tratada' AND valoriss = '$valor'");
		if (mysql_num_rows($sql_livro) == 0) {
			return false;
		}
		list($cod_livro) = mysql_fetch_array($sql_livro);
		
		//Busca o codigo da guia referente ao codigo do livro
		/*$sql_guia = mysql_query("SELECT codigo FROM guia_pagamento WHERE codlivro = '$cod_livro'");
		list($cod_guia) = mysql_fetch_array($sql_livro);*/
		
		return $cod_livro;
	}
	
	function registrarPagamentoDAF607($cod_livro){
		//mysql_query("UPDATE guia_pagamento SET pago = 'S' WHERE codigo = '$codguia'");

		$sql_notas = mysql_query("
			SELECT 
				codnota 
			FROM 
				livro_notas	
			INNER JOIN
				notas ON livro_notas.codnota = notas.codigo
			WHERE 
				codlivro = '$cod_livro' AND notas.estado <> 'E'
		");
		
		while (list($cod_nota) = mysql_fetch_array($sql_notas) ){
			//echo "$codguia - $cod_nota<br>";
			mysql_query("UPDATE notas SET estado = 'E' WHERE codigo = '$cod_nota'");
			$sqlcredito = mysql_query("SELECT codtomador, credito FROM notas WHERE codigo = '$cod_nota'");
			$dadoscred = mysql_fetch_object($sqlcredito);
			mysql_query("UPDATE cadastro SET credito = credito+{$dadoscred->credito} WHERE codigo = '$dadoscred->codtomador'");
		}
		return mysql_num_rows($sql_notas); 
	}
	
	//Funcao que registra o arquivo no banco
	function registraArquivo($endereco_arquivo, $competencia = NULL){
		if($competencia){
			$competencia = mascaraCompetencia($competencia);
		}
		$sql_arquivo_busca = ("SELECT codigo FROM notas_arquivos WHERE arquivo = '$endereco_arquivo'");
		$query = mysql_query($sql_arquivo_busca);

		if(mysql_num_rows($query) > 0){
			list($cod_arquivo) = mysql_fetch_array($query);
			$sql_arquivo_atualizar = ("UPDATE notas_arquivos SET arquivo = '$endereco_arquivo', competencia = '$competencia' WHERE codigo = '$cod_arquivo'");
			mysql_query($sql_arquivo_atualizar);
		}else{
			$sql_arquivo_inserir = ("INSERT INTO notas_arquivos SET arquivo = '$endereco_arquivo', competencia = '$competencia'");
			mysql_query($sql_arquivo_inserir);
			$cod_arquivo = mysql_insert_id();
		}
		
		return $cod_arquivo;
	}
	
	//Funcao que registra o relacionamento entre os livros escriturados e o arquivo upado
	function registraLivroArquivo($cod_livro, $cod_arquivo){
		$sql_busca_arquivo_livro = mysql_query("SELECT codigo FROM notas_arquivo_livro WHERE codarquivo = '$cod_arquivo' AND codlivro = '$cod_livro'");
		if(!mysql_num_rows($sql_busca_arquivo_livro)){
			$sql_arquivo_livro = mysql_query("INSERT INTO notas_arquivo_livro SET codarquivo = '$cod_arquivo', codlivro = '$cod_livro'");
		}
	}
}
?>