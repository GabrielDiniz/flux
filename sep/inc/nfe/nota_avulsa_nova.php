<?php
/*COPYRIGHT 2008 - 2010 DO PORTAL PUBLICO INFORMATICA LTDA
Arquivo e parte do programa E-ISS / SEP-ISS

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
$cnpjcpf=$_POST['txtCnpjLivro'];
$mes= $_POST['cmbMes'];
$ano= $_POST['cmbAno'];
$dia= $_POST['txtDia'];
$mes <=9 ? $mes='0'.$mes:NULL;
$periodo= $ano.'-'.$mes;
$periodomysql=$ano."-".$mes;


if($ano==NULL || $mes==NULL){
	Mensagem("Escolha Ano e Mês para gerar a Nota Avulsa.");
}else{
	$sessioncnpj = $_POST['txtCnpjPrestador'];
	if($sessioncnpj==$_POST['txtTomadorCNPJ']){
		Mensagem('O tomador nao pode ser o próprio prestador');
	}else{
		//Variaveis com os valores preenchidos da nota
		$tomadorCnpj             = $_POST['txtTomadorCNPJ'];
		$tomadorNome             = $_POST['txtTomadorNome'];
		$tomadorInscMunic        = $_POST['txtTomadorIM'];
		$tomadorInscEstadual     = $_POST['txtTomadorIE'];
		$tomadorLogradouro       = $_POST['txtTomadorLogradouro'];
		$tomadorNumero           = $_POST['txtTomadorNumero'];
		$tomadorComplemento      = $_POST['txtTomadorComplemento'];
		$tomadorBairro           = $_POST['txtTomadorBairro'];
		$tomadorCep              = $_POST['txtTomadorCEP'];
		if(!empty($_POST['txtTomadorMunicipio'])){
			$tomadorMunicipio = $_POST['txtTomadorMunicipio'];
		}elseif(!empty($_POST['txtInsMunicipioEmpresa'])){
			$tomadorMunicipio = $_POST['txtInsMunicipioEmpresa'];
		}
		$tomadorUF               = $_POST['txtTomadorUF'];
		$tomadorEmail            = $_POST['txtTomadorEmail'];
		$notaNumero              = $_POST['txtNotaNumero'];
		$notaDataHoraEmissao     = $_POST['txtNotaDataHoraEmissao'];
		$notaCodigoVerificacao   = $_POST['txtNotaCodigoVerificacao'];
		$notaDiscriminacao       = $_POST['txtNotaDiscriminacao'];
		$notaObservacao          = $_POST['txtObsNota'];
		$notaValorDeducoes       = MoedaToDec($_POST['txtValorDeducoes']);
		$notaValorAcrescimos     = MoedaToDec($_POST['txtValorAcrescimos']);
		$notaTotalBasedeCalculo  = MoedaToDec($_POST['txtBaseCalculo']);
		$notaPISPASEP            = MoedaToDec($_POST['txtPISPASEP']);
		//$notaAliquota            = MoedaToDec($_POST['txtAliquota']);
		$notaTotalValorISS       = MoedaToDec($_POST['txtISS']);
		$notaTotalValorISSRetido = MoedaToDec($_POST['txtIssRetido']);
		$notaAliquotaINSS        = MoedaToDec($_POST['txtAliquotaINSS']);
		$notaValorINSS           = MoedaToDec($_POST['txtValorINSS']);
		$notaAliquotaIRRF        = MoedaToDec($_POST['txtIRRF']);
		$notaDeducaoIRRF         = MoedaToDec($_POST['txtDeducIRRF']);
		$notaValorIRRF           = MoedaToDec($_POST['txtValorFinalIRRF']);
		$notaValorTotalRetencoes = MoedaToDec($_POST['txtValTotalRetencao']);
		$notaCredito             = MoedaToDec($_POST['txtCredito']);
		$notaValorTotal          = MoedaToDec($_POST['txtValTotal']);
		$notaCkbRPS              = $_POST['ckbHabilita'];
		$contribuicaoSocial      = MoedaToDec($_POST['txtContribuicaoSocial']);
		$cofins                  = MoedaToDec($_POST['txtCofins']);
		$aliquotapercentual      = MoedaToDec($_POST['txtAliqServico1']);
			
			//Seleciona a ultima nota inserida pela empresa
			$sql = mysql_query("SELECT ultimanota FROM cadastro WHERE codigo = '$_POST[codempresa]'");
			list($ultimanota)=mysql_fetch_array($sql);
			$ultimanota ++;
			
			//busca o limite de notas desse emissor
			$sql=mysql_query("SELECT notalimite FROM cadastro WHERE codigo = '$_POST[codempresa]'");
			list($notalimite)=mysql_fetch_array($sql);
			
			//testa se o numero de notas limites ja foi ultrapassado se ja tiver ultrapassado avisa-o
			
				if($notaTotalBasedeCalculo !=""){  
					
					$aux = explode(" ", $notaDataHoraEmissao);
					$notaEmissaoData = $ano."-".$mes."-".$dia;
					$notaEmissaoHora = $aux[1].":00";
					
			
					//Faz uma busca pelo tomador
					$sql = mysql_query("SELECT * FROM cadastro WHERE cnpj='$tomadorCnpj' or cpf='$tomadorCnpj'");
					//Testa se o tomador o pessoa fisica ou pessoa juridica
					$campo = tipoPessoa($tomadorCnpj);
					$codtipo = codtipo('tomador');
					$codtipodec = coddeclaracao('DES Simplificada');
					$diaatual = date("Y-m-d");		
					//Testa se o tomador existe caso nao exista cria-o no banco
					if(mysql_num_rows($sql)<=0){
					
						mysql_query("
							INSERT INTO 
								cadastro
							SET 
								nome = '$tomadorNome',
								$campo = '$tomadorCnpj',
								inscrmunicipal = '$tomadorInscMunic',
								inscrestadual = '$tomadorInscEstadual',
								codtipo = '$codtipo', 
								codtipodeclaracao = '$codtipodec', 
								logradouro = '$tomadorLogradouro',
								numero = '$tomadorNumero',
								complemento = '$tomadorComplemento',
								bairro = '$tomadorBairro',
								cep = '$tomadorCep',
								municipio = '$tomadorMunicipio',
								uf = '$tomadorUF',
								email = '$tomadorEmail',
								estado = 'A',
								datainicio = '$diaatual'
						");
						
						$codtomador = mysql_insert_id();
				
					}else{
						if($tomadorCnpj!=""){
							mysql_query("
								UPDATE
									cadastro
								SET
									nome = '$tomadorNome',
									$campo = '$tomadorCnpj',
									inscrmunicipal = '$tomadorInscMunic',
									inscrestadual = '$tomadorInscEstadual',
									codtipo = '$codtipo',
									codtipodeclaracao = '$codtipodec',
									logradouro = '$tomadorLogradouro',
									numero = '$tomadorNumero',
									complemento = '$tomadorComplemento',
									bairro = '$tomadorBairro',
									cep = '$tomadorCep',
									municipio = '$tomadorMunicipio',
									uf = '$tomadorUF',
									email = '$tomadorEmail',
									estado = 'A'
								WHERE
								   $campo = '$tomadorCnpj'
							");
						}
		
						list($codtomador) = mysql_fetch_array($sql);
					}
				
					//verifica a isenção do prestador
					$sqlIsento = mysql_query("SELECT isentoiss FROM cadastro WHERE codigo='$_POST[codempresa]'");
					list($issIsento) = mysql_fetch_array($sqlIsento);
					if($issIsento == 'S'){
						$notaTotalValorISS = 0;
						$notaTotalValorISSRetido = 0;
					}
		
					//Sql que insere os dados da nota emitida no banco
					$sql = mysql_query("
						INSERT INTO 
							notas 
						SET 
							numero = '$ultimanota', 
							codverificacao = '$notaCodigoVerificacao', 
							codemissor = '$_POST[codempresa]', 
							codtomador= '$codtomador',
							tomador_nome = '$tomadorNome', 
							tomador_cnpjcpf = '$tomadorCnpj',
							tomador_inscrmunicipal = '$tomadorInscMunic',	
							tomador_inscrestadual = '$tomadorInscEstadual',	
							tomador_logradouro = '$tomadorLogradouro',
							tomador_numero = '$tomadorNumero',
							tomador_complemento = '$tomadorComplemento',
							tomador_bairro = '$tomadorBairro',
							tomador_cep = '$tomadorCep',
							tomador_municipio = '$tomadorMunicipio',
							tomador_uf = '$tomadorUF',
							tomador_email = '$tomadorEmail',
							discriminacao = '$notaDiscriminacao',
							valortotal = '$notaValorTotal',
							valordeducoes = '$notaValorDeducoes',
							valoracrescimos = '$notaValorAcrescimos',
							basecalculo = '$notaTotalBasedeCalculo',
							valoriss = '$notaTotalValorISS',
							credito = '$notaCredito',
							pispasep = '$notaPISPASEP',
							estado = 'N',
							datahoraemissao = '$notaEmissaoData $notaEmissaoHora', 
							issretido = '$notaTotalValorISSRetido', 
							valorinss = '$notaValorINSS', 
							aliqinss = '$notaAliquotaINSS',
							valorirrf = '$notaValorIRRF', 
							aliqirrf = '$notaAliquotaIRRF', 
							deducao_irrf = '$notaDeducaoIRRF', 
							total_retencao = '$notaValorTotalRetencoes',
							observacao = '$notaObservacao',
							cofins = '$cofins',
							contribuicaosocial = '$contribuicaoSocial'
					");		
					
					//Variaveis com relecao aos servicos da nota
					$quantidadeInputs = $_POST['hdInputs']; //numero de inputs de servicos
					$codigoUltimaNota = mysql_insert_id();  //ultimo codigo que foi inserido no mysql
					$cont = 1;
						$aux = explode("|",$_POST['cmbCodServico'.$cont]);
						$servicoCodigo    = $aux[1];
						$servicoBaseCalc  = MoedaToDec($_POST['txtBaseCalcServico'.$cont]);
						$servicoValorISS  = MoedaToDec($_POST['txtValorIssServico'.$cont]);
						$servicoISSRetido = MoedaToDec($_POST['txtISSRetidoManual'.$cont]);
						$servicoDiscr     = htmlentities($_POST['txtDiscriminacaoServico'.$cont]);
						
						if($servicoDiscr == htmlentities("Discriminação do serviço")){
							$servicoDiscr = "";
						}
		
						if($issIsento == 'S'){
							$servicoValorISS = 0;
							$servicoISSRetido = 0;
						}
		
						$sql_servicos_notas = mysql_query("
							INSERT INTO 
								notas_servicos
							SET
								codnota = '$codigoUltimaNota',
								codservico = '$servicoCodigo',
								basecalculo = '$servicoBaseCalc',
								iss = '$servicoValorISS',
								issretido = '$servicoISSRetido',
								discriminacao = '$servicoDiscr'
						");
						
					if($notaCkbRPS == "T"){
						//$notaRpsNumero = $_POST['txtRpsNum'];
						$notaRpsData   = DataMysql($_POST['txtDataRps']);
					
						//Pega o ultimo rps emitido
						$sql_rps_ultimo = mysql_query("SELECT ultimorps FROM rps_controle WHERE codcadastro = '$_POST[codempresa]'");
						list($ultimoRPS) = mysql_fetch_array($sql_rps_ultimo);
						
						$notaRpsNumero = $ultimoRPS + 1;
						
						mysql_query("UPDATE notas SET rps_numero = '$notaRpsNumero', rps_data = '$notaRpsData' WHERE codemissor = '$_POST[codempresa]' AND codigo = '$codigoUltimaNota'");
						mysql_query("UPDATE rps_controle SET ultimorps = '$notaRpsNumero' WHERE codcadastro = '$_POST[codempresa]'");
					
					}
		
					
					$sql = mysql_query("UPDATE cadastro SET ultimanota= '$ultimanota' WHERE codigo = '$_POST[codempresa]'");
					add_logs('Emitiu nota fiscal');
					
					//Envia o email informando o tomador que foi inserida uma nfe
					if($tomadorEmail){
					
						$email_enviado = "";				
						//Chama a funcao que envia o email para o tomador
						$email_enviado = notificaTomador($_POST['codempresa'],$ultimanota);
					
					}
					
					imprimirNota($codigoUltimaNota);
					
					//------------------------------------------------------------
				
					//INICIO DA GUIA
					
					$codigoguia		= $codigoUltimaNota;
					$codemissor		= $_POST['codempresa'];
					$sql_guia		= mysql_query("SELECT * FROM notas WHERE codigo = '$codigoguia'");
					$dados_guia		= mysql_fetch_array($sql_guia);
					$hoje           = date("Y-m-d");
					$dataem         = explode("-",$hoje);
					
					$datavencimento = strtotime("$hoje +7 day");
					$vencimentodia = date("Y-m-d",$datavencimento);
					$dataInicio=DataPt(date("Y-m-d", time() + (7 * 86400)));
					$dataFim=DataPt($hoje);
					
					$dias = diasDecorridos($dataInicio, $dataFim);
				
					$multa = calculaMultaDes($dias, $dados_guia['valoriss']);
				
					$sql_banco=mysql_query("SELECT bancos.codigo, bancos.boleto FROM bancos INNER JOIN boleto ON bancos.codigo=boleto.codbanco");
					list($codbanco,$boleto)=mysql_fetch_array($sql_banco);
				
					if($DIRETORIOINTEGRACAO){
						chdir('../');
						$x = getcwd();
						$x = explode('/',$x);
						$x = end($x);
						if($x=='trunk'){
							$diretorio=('../../middleware/'.$DIRETORIOINTEGRACAO);			
						}else{
							$diretorio=('../middleware/'.$DIRETORIOINTEGRACAO);
						}
						
						$ACAO = "insere_guia_nfe";
						require "$diretorio/index.php";
						
					}else{	
						$insere_guia = ("
							INSERT INTO guia_pagamento
							SET	valor='{$dados_guia['valoriss']}',
							valormulta='$multa',
							dataemissao='$hoje',
							datavencimento='$vencimentodia',
							pago='N', estado='N',
							codnota='$codigoguia'
						");
			
			
						if(mysql_query($insere_guia)){
							$sqlguia=mysql_query("SELECT MAX(codigo) FROM guia_pagamento");
							list($codguiapag)=mysql_fetch_array($sqlguia);
							
							$nossonumero = gerar_nossonumero($dados_guia['codigo'],date("Y-m-d", time() + (7 * 86400)));
							$chavecontroledoc = gerar_chavecontrole($dados_guia["codigo"],$codguiapag);
							
							mysql_query("UPDATE guia_pagamento SET nossonumero='$nossonumero', chavecontroledoc='$chavecontroledoc' WHERE codigo='$codguiapag'");
							
							$sql_boleto=mysql_query("SELECT MAX(codigo) FROM guia_pagamento");
							list($codigoboleto)=mysql_fetch_array($sql_boleto);	
					
								$atualiza_livro = ("UPDATE notas SET estado='B' WHERE codigo='$codigoguia'");
								
								if(mysql_query($atualiza_livro)){
									Mensagem("Nota Avulsa emitida e boleto gerado com sucesso");
									imprimirGuia($codigoboleto);
									Redireciona("principal.php");
								}else{
									Mensagem("Erro ao gerar guia. Contate a prefeitura");
								}
							
						}else{
							Mensagem("Erro ao inserir guia de pagamento. Contate a prefeitura");	
						}	
					}
				
					}else{
						print("<script language=JavaScript>alert('Favor preencher campos obrigatórios')</script>");
				}
	}
}
?>