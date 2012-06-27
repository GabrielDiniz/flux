	<?php
 	include("funcoes.php");
	include("../../include/conect.php");
	$sql = mysql_query("SELECT agencia, contacorrente, convenio, contrato, carteira FROM boleto");
	list($agencia,$contacorrente,$convenio,$contrato,$carteira) = mysql_fetch_array($sql);
    $codigoboleto = base64_decode($_GET['COD']);   
    //$codigoboleto=589;
	if($codigoboleto) 
	{
		$sqlguiapagamento = mysql_query("SELECT codlivro, codnota FROM guia_pagamento WHERE guia_pagamento.codigo = '$codigoboleto'");
		$dados=mysql_fetch_array($sqlguiapagamento);
		if($dados['codlivro']!=NULL){
			$sql_tipo_guia=mysql_query("
			SELECT
				cadastro.codigo,
				cadastro.codtipo,
				cadastro.cnpj,
				cadastro.cpf,
				cadastro.razaosocial,
				cadastro.logradouro,
				cadastro.numero,
				livro.codcadastro, 
				livro.periodo,
				livro.basecalculo,
				DATE_FORMAT(guia_pagamento.dataemissao,'%d/%m/%Y'), 
				guia_pagamento.valor, 
				guia_pagamento.valormulta, 
				guia_pagamento.nossonumero, 
				DATE_FORMAT(guia_pagamento.datavencimento,'%d/%m/%Y')
			FROM 
				guia_pagamento 
			INNER JOIN 
				livro ON livro.codigo = guia_pagamento.codlivro
			INNER JOIN
				cadastro ON cadastro.codigo = livro.codcadastro
			WHERE 
				guia_pagamento.codigo = '$codigoboleto'
			");
		}else{
			$sql_tipo_guia=mysql_query("
			SELECT
				cadastro.codigo,
				cadastro.codtipo,
				cadastro.cnpj,
				cadastro.cpf,
				cadastro.razaosocial,
				cadastro.logradouro,
				cadastro.numero,
				notas.codemissor, 
				DATE_FORMAT(notas.datahoraemissao, '%Y-%m'),
				notas.valortotal,
				DATE_FORMAT(guia_pagamento.dataemissao,'%d/%m/%Y'), 
				guia_pagamento.valor, 
				guia_pagamento.valormulta, 
				guia_pagamento.nossonumero, 
				DATE_FORMAT(guia_pagamento.datavencimento,'%d/%m/%Y')
			FROM 
				guia_pagamento 
			INNER JOIN 
				notas ON notas.codigo = guia_pagamento.codnota
			INNER JOIN
				cadastro ON cadastro.codigo = notas.codemissor
			WHERE 
				guia_pagamento.codigo = '$codigoboleto'
			");
		}
	    
		
		list($CodigoEmpresa,$CodTipo,$Cnpj,$cpf,$RazaoSocial,$EndSacado,$Numero,$codrel,$Competencia,$Receita,$emissao,$valorbl,$valormulta,$nossonumero,$vencimento) = mysql_fetch_array($sql_tipo_guia);
		 
	if($dados['codlivro']!=NULL){
		
		$queryatividades = mysql_query("SELECT servicos.descricao FROM cadastro_servicos INNER JOIN servicos ON cadastro_servicos.codservico=servicos.codigo WHERE cadastro_servicos.codemissor = '$CodigoEmpresa'");
	}else{
		$codigotipo = codtipo('tomador');
		if($codigotipo==$CodTipo){
			$nometomador = mysql_query("SELECT tomador_nome, issretido FROM notas WHERE codigo = '{$dados['codnota']}'");
			list($TomadorNome, $IssRetido)=mysql_fetch_array($nometomador);
			$RazaoSocial = $TomadorNome;
			$valorbl = $IssRetido;
			$valormulta=0;
		}
		$queryatividades = mysql_query("SELECT servicos.descricao FROM servicos INNER JOIN notas_servicos ON notas_servicos.codservico = servicos.codigo WHERE notas_servicos.codnota = '{$dados['codnota']}'");
	}
		
	$taxa_boleto =0;	
	
	//DEFINE OS 3 PRIMEIROS CARACTERES DA LINHA DIGITAVEL
	$tipoProduto="8"; // para definir como arrecadação
	$tipoSegmento="1"; //para definir como prefeitura
	$tipoValor="6"; // Define o modulo de geração do digito verificador
		
	
	//$CONF_CNPJ
	//$CONF_ENDERECO
	//$CONF_CIDADE
	//$CONF_ESTADO
	
	
	//FORMATA O VALOR DO BOLETO
    $valorbl = $valorbl+$valormulta;
	$valor= $valorbl; //variavel do banco;	
	$valor = str_replace(",", ".",$valor);	
	$valor_boleto=number_format($valor+$taxa_boleto, 2, ',', '');
	$valor = formata_numero($valor_boleto,11,0,"valor");
	
	// FORMATA O CNPJ DEIXANDO-O SOMENTE COM NUMEROS
	$sqlfebraban=mysql_query("SELECT codfebraban FROM boleto");
	$febraban=mysql_fetch_object($sqlfebraban);
	$identificacao=$febraban->codfebraban;
			
	
	
	//$nossonumero=$nossonumero; // convenio + zeros + codguia	
	
	//GERA O DIGITO VERIFICADOR 
	$dv= modulo_10($tipoProduto.$tipoSegmento.$tipoValor.$valor.$identificacao.$nossonumero);	
	
	//echo '----- '.$dv.' -----';
	//MONTA A LINHA DIGITAVEL
	$linha = $tipoProduto.$tipoSegmento.$tipoValor.$dv.$valor.$identificacao.$nossonumero;	
	
	//print($linha);
	
	
	//MOSTRA O CODIGO DE BARRAS
	$linha01= substr($linha,0,11);
		$dv01=modulo_10($linha01);
		
	$linha02= substr($linha,11,11);
		$dv02=modulo_10($linha02);

	$linha03= substr($linha,22,11);		
		$dv03=modulo_10($linha03);

		
	$linha04= substr($linha,33,11);
		$dv04=modulo_10($linha04);
		
	$linhad = $linha01.'-'.$dv01.' '.$linha02.'-'.$dv02.' '.$linha03.'-'.$dv03.' '.$linha04.'-'.$dv04."<br>";
	
	//echo$nossonumero."<br>";
	//echo strlen($nossonumero)."<br>";
	//geraCodigoDeBarras($linha);
	$sql_instrucoes_boleto = mysql_query("SELECT instrucoes FROM boleto");
	list($Instrucoes_boleto) = mysql_fetch_array($sql_instrucoes_boleto);
	
	// INCLUDE DO LAYOUT	
	include("layout.php");
	}
?>	



		 