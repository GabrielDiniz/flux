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
$sessioncnpj = $_SESSION['login'];
if($sessioncnpj==$_POST['txtTomadorCNPJ']){
	Mensagem('O tomador nao pode ser o próprio prestador');
}else{
	//Variaveis com os valores preenchidos da nota
	$tomadorCnpj             = $_POST['txtTomadorCNPJ'];
	$tomadorNome             = $_POST['txtTomadorNome'];
	$tomadorInscMunic        = $_POST['txtTomadorIM'];
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
	$notaDiscriminacao       = trataString($_POST['txtNotaDiscriminacao']);
	$notaObservacao          = trataString($_POST['txtObsNota']);
	$notaValorDeducoes       = MoedaToDec($_POST['txtValorDeducoes']);
	$notaValorAcrescimos     = MoedaToDec($_POST['txtValorAcrescimos']);
	$notaTotalBasedeCalculo  = MoedaToDec($_POST['txtBaseCalculo']);
	$notaPISPASEP            = MoedaToDec($_POST['txtPISPASEP']);
	//$notaAliquota            = MoedaToDec($_POST['txtAliquota']);
	$notaTotalValorISS       = MoedaToDec($_POST['txtISS']);
	$notaTotalValorISSRetido = MoedaToDec($_POST['txtIssRetido']);
	$notaAliquotaINSS        = $_POST['txtAliquotaINSS'];
	$notaValorINSS           = MoedaToDec($_POST['txtValorINSS']);
	$notaAliquotaIRRF        = $_POST['txtIRRF'];
	$notaDeducaoIRRF         = MoedaToDec($_POST['txtDeducIRRF']);
	$notaValorIRRF           = MoedaToDec($_POST['txtValorFinalIRRF']);
	$notaValorTotalRetencoes = MoedaToDec($_POST['txtValTotalRetencao']);
	$notaCredito             = MoedaToDec($_POST['txtCredito']);
	$notaValorTotal          = MoedaToDec($_POST['txtValTotal']);
	$notaCkbRPS              = $_POST['ckbHabilita'];
    $contribuicaoSocial      = $_POST['txtContribuicaoSocial'];
    $cofins                  = $_POST['txtCofins'];
    $codServico              = explode('|',$_POST['cmbCodServico']);
    $dataehora               = date("Y-m-d H:i:s");

    //Seleciona a ultima nota inserida pela empresa
	$sql = mysql_query("SELECT ultimanota FROM cadastro WHERE codigo = '$CODIGO_DA_EMPRESA'");
	list($ultimanota)=mysql_fetch_array($sql);
	$ultimanota ++;
	
	//busca o limite de notas desse emissor
	$sql=mysql_query("SELECT notalimite FROM cadastro WHERE codigo = $CODIGO_DA_EMPRESA");
	list($notalimite)=mysql_fetch_array($sql);
	
	//testa se o numero de notas limites ja foi ultrapassado se ja tiver ultrapassado avisa-o
	if(($ultimanota>$notalimite)&&($notalimite!=0)) {
	
		Mensagem('Voce nao pode emitir NFe por que ultrapassou seu limite estabelecido pelo AIDF. Entre em contato com a prefeitura.');
		Redireciona('notas.php');
		
	}elseif(($ultimanota<=$notalimite)||($notalimite==0)){  
		if(($tomadorNome !="") && ($tomadorCnpj !="") && ($notaTotalBasedeCalculo !="")){  
			
			$aux = explode(" ", $notaDataHoraEmissao);
			$notaEmissaoData = DataMysql($aux[0]);
			$notaEmissaoHora = $aux[1].":00";
			
	
			//Faz uma busca pelo tomador
			$sql = mysql_query("SELECT codigo FROM cadastro WHERE cnpj='$tomadorCnpj' or cpf='$tomadorCnpj'");
			//Testa se o tomador o pessoa fisica ou pessoa juridica
			$campo = tipoPessoa($tomadorCnpj);
						
			//Testa se o tomador existe caso nao exista cria-o no banco
			if(mysql_num_rows($sql)<=0){
				$codtipo = codtipo('tomador');
				$codtipodec = coddeclaracao('DES Simplificada');
				$diaatual = date("Y-m-d");
				mysql_query("
					INSERT INTO 
						cadastro
					SET 
						nome = '$tomadorNome',
						$campo = '$tomadorCnpj',
						inscrmunicipal = '$tomadorInscMunic',
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
				");
				$codtomador = mysql_insert_id();
		
			}else{
                mysql_query("
					UPDATE
						cadastro
					SET
						nome = '$tomadorNome',
						$campo = '$tomadorCnpj',
						inscrmunicipal = '$tomadorInscMunic',
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

				list($codtomador) = mysql_fetch_array($sql);
			}
		
            //Sql que insere os dados da nota emitida no banco
			$sql = mysql_query("
                INSERT INTO
                    notas
                SET
                    `numero`='$ultimanota',
                    `codverificacao`='$notaCodigoVerificacao',
                    `codemissor`='$CODIGO_DA_EMPRESA',
                    `rps_numero`='$txtRpsNum',
                    `rps_data`='$data',
                    `codtomador`='$codtomador',
                    `discriminacao`='$notaDiscriminacao',
                    `valortotal`='$notaValorTotal',
                    `valordeducoes`='$notaValorDeducoes',
                    `basecalculo`='$notaTotalBasedeCalculo',
                    `valoriss`='$notaTotalValorISS',
                    `credito`='$txtCredito',
                    `estado`='N',
                    `codservico`='{$codServico[1]}',
                    `datahoraemissao`='$dataehora',
                     issretido='$notaTotalValorISSRetido',
                     valorinss='$notaValorINSS',
                     aliqinss='$notaAliquotaINSS',
                     valorirrf='$notaValorIRRF',
                     aliqirrf='$notaAliquotaIRRF',
                     deducao_irrf = '$notaDeducaoIRRF',
                     total_retencao = '$notaValorTotalRetencoes'
            ");
			
			if($notaCkbRPS == "T"){
				//$notaRpsNumero = $_POST['txtRpsNum'];
				$notaRpsData   = DataMysql($_POST['txtDataRps']);
			
				//Pega o ultimo rps emitido
				$sql_rps_ultimo = mysql_query("SELECT ultimorps FROM rps_controle WHERE codcadastro = '$CODIGO_DA_EMPRESA'");
				list($ultimoRPS) = mysql_fetch_array($sql_rps_ultimo);
				
				$notaRpsNumero = $ultimoRPS + 1;
				
				mysql_query("UPDATE notas SET rps_numero = '$notaRpsNumero', rps_data = '$notaRpsData' WHERE codemissor = '$CODIGO_DA_EMPRESA' AND codigo = '$codigoUltimaNota'");
				mysql_query("UPDATE rps_controle SET ultimorps = '$notaRpsNumero' WHERE codcadastro = '$CODIGO_DA_EMPRESA'");
			
			}

			
			$sql = mysql_query("UPDATE cadastro SET ultimanota= '$ultimanota' WHERE codigo = '$CODIGO_DA_EMPRESA'");
			add_logs('Emitiu nota fiscal');
			
			//Envia o email informando o tomador que foi inserida uma nfe
			if($tomadorEmail){
			
				$email_enviado = "";				
				//Chama a funcao que envia o email para o tomador
				$email_enviado = notificaTomador($CODIGO_DA_EMPRESA,$ultimanota);
			
			}
			//------------------------------------------------------------
			
			if($email_enviado){
				print("<script language=JavaScript>alert('Nota Emitida com sucesso e tomador notificado!!')</script>");
			}else{
				print("<script language=JavaScript>alert('Nota Emitida com sucesso!!')</script>");
			}
		}else{
			print("<script language=JavaScript>alert('Favor preencher campos obrigatórios')</script>");
		}
	}
}
?>