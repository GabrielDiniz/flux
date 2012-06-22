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
session_name("contador");
session_start();
//echo "<pre>"; print_r($_POST); die('</pre>');
if(!(isset($_SESSION["codempresa"]))){   
	echo "
		<script>
		alert('Acesso Negado!');
		window.location='login.php';
		</script>
	";
}else{
	$botao = $_POST['btImportarXML'];  
	$arquivo_xml = $_POST['txtArquivoNome'];
	if($botao == "Importar Arquivo"){
		include("../include/conect.php");
		include("../funcoes/util.php");
		include("inc/funcao_logs.php");
		$sql=mysql_query("SELECT ultimanota FROM cadastro WHERE codigo = '".$_POST['hdCodEmpresa']."'");
		list($UltimaNota)=mysql_fetch_array($sql);  
		
		$sql=mysql_query("SELECT codigo FROM cadastro WHERE codigo = '".$_POST['hdCodEmpresa']."'"); 
		list($codigoEmpresa)=mysql_fetch_array($sql);  
		
		$xml = simplexml_load_file("importar/$arquivo_xml"); // lê o arquivo XML 
		$cont = 0; 
		$inserir_tomador = "N";
		foreach($xml->children() as $elemento => $valor){   
					
			$tomador_cnpjcpf = $xml->nota[$cont]->tomador_cnpjcpf;
			$sql_verifica_tomador = mysql_query("
				SELECT
					codtipo,
					cpf,
					cnpj, 
					nome,
					inscrmunicipal,
					logradouro,
					numero,
					complemento,
					bairro,
					cep,
					municipio,
					uf,
					email
				FROM 
					cadastro 
				WHERE 
					(cpf = '$tomador_cnpjcpf' OR cnpj = '$tomador_cnpjcpf')
			");
			if(mysql_num_rows($sql_verifica_tomador)){
				$dadosTomador = mysql_fetch_array($sql_verifica_tomador);
				$tomador_inscrmunicipal =  $dadosTomador['inscrmunicipal'] == utf8_decode($xml->nota[$cont]->tomador_inscrmunicipal)
					? $dadosTomador['inscrimunicipal']
					: utf8_decode($xml->nota[$cont]->tomador_inscrmunicipal);
					
				$tomador_nome           =  $dadosTomador['nome'] == utf8_decode($xml->nota[$cont]->tomador_nome)
					? $dadosTomador['nome']
					: utf8_decode($xml->nota[$cont]->tomador_nome);
					
				$tomador_logradouro     =  $dadosTomador['logradouro'] == utf8_decode($xml->nota[$cont]->tomador_logradouro)
					? $dadosTomador['logradouro']
					: utf8_decode($xml->nota[$cont]->tomador_logradouro);
					
				$tomador_numero         =  $dadosTomador['numero'] == $xml->nota[$cont]->tomador_numero
					? $dadosTomador['numero']
					: $xml->nota[$cont]->tomador_numero;
					
				$tomador_complemento    =  $dadosTomador['complemento'] == utf8_decode($xml->nota[$cont]->tomador_complemento)
					? $dadosTomador['complemento']
					: utf8_decode($xml->nota[$cont]->tomador_complemento);
					
				$tomador_bairro         =  $dadosTomador['bairro'] == utf8_decode($xml->nota[$cont]->tomador_bairro)
					? $dadosTomador['bairro']
					: utf8_decode($xml->nota[$cont]->tomador_bairro);
					
				$tomador_cep            =  $dadosTomador['cep'] == $xml->nota[$cont]->tomador_cep
					? $dadosTomador['cep']
					: $xml->nota[$cont]->tomador_cep;
					
				$tomador_municipio      =  $dadosTomador['municipio'] == utf8_decode($xml->nota[$cont]->tomador_municipio)
					? $dadosTomador['municipio']
					: utf8_decode($xml->nota[$cont]->tomador_municipio);
					
				$tomador_uf             =  $dadosTomador['uf'] == $xml->nota[$cont]->tomador_uf
					? $dadosTomador['uf']
					: $xml->nota[$cont]->tomador_uf;
					
				$tomador_email          =  $dadosTomador['email'] == $xml->nota[$cont]->tomador_email
					? $dadosTomador['email']
					: $xml->nota[$cont]->tomador_email;
				$inserir_tomador        = "N";
			}else{
				$tomador_inscrmunicipal = utf8_decode($xml->nota[$cont]->tomador_inscrmunicipal);
				$tomador_nome           = utf8_decode($xml->nota[$cont]->tomador_nome);
				$tomador_logradouro		= utf8_decode($xml->nota[$cont]->tomador_logradouro);
				$tomador_numero         = trim($xml->nota[$cont]->tomador_numero);
				$tomador_bairro			= utf8_decode($xml->nota[$cont]->tomador_bairro);
				$tomador_complemento    = utf8_decode($xml->nota[$cont]->tomador_complemento);					
				$tomador_cep            = $xml->nota[$cont]->tomador_cep;
				$tomador_municipio      = utf8_decode($xml->nota[$cont]->tomador_municipio);
				$tomador_uf             = $xml->nota[$cont]->tomador_uf;
				$tomador_email          = $xml->nota[$cont]->tomador_email;
				$inserir_tomador        = "S";
			}
		$discriminacao  =  utf8_decode($xml->nota[$cont]->discriminacao);
		$observacoes    =  utf8_decode($xml->nota[$cont]->observacoes);
		$deducoes  		= $xml->nota[$cont]->deducoes;
		$estado         = $xml->nota[$cont]->estado;
		$cofins		    = $xml->nota[$cont]->cofins;
		$pispasep	    = $xml->nota[$cont]->pispasep;
		$csocial	    = $xml->nota[$cont]->contribuicaosocial;
		$valortotal     = $xml->nota[$cont]->valortotal;
		$inss		    = $xml->nota[$cont]->inss;
		$irrf	    	= $xml->nota[$cont]->irrf;
		$basecalc	    = $xml->nota[$cont]->basecalculo;
		$iss		    = $xml->nota[$cont]->valoriss;
		$issretido	    = $xml->nota[$cont]->issretido;
		$observacao	    = $xml->nota[$cont]->observacao;
		$codservico     = $xml->nota[$cont]->codservico;
		$aliqpercentual = $xml->nota[$cont]->aliqpercentual;
		$totalretencoes = $xml->nota[$cont]->totalretencoes;
		$acrescimo		= $xml->nota[$cont]->acrescimo;
		$motivocancel	= utf8_decode($xml->nota[$cont]->motivocancelamento);
		$rps_numero		= $xml->nota[$cont]->rps_numero;
		$rps_data		= $xml->nota[$cont]->rps_data;
		$credito		= $xml->nota[$cont]->credito;
			
			$sql_verifica_rps = mysql_query("SELECT codigo FROM notas WHERE rps_numero = '$rps_numero' AND codemissor = '".$_POST['hdCodEmpresa']."'");
			if(mysql_num_rows($sql_verifica_rps)){
				Mensagem("A nota com o número de RPS $rps_numero, já foi emitida!");
				exit;
			}
			
			switch(strtolower($estado)){
				case "normal":
					$estado = "N";
				  break;
				case "escriturado":
					$estado = "E";
				  break;
				case "cancelado":
					$estado = "C";
				  break;
				case "boleto":
					$estado = "B";
				  break;
			}
			
			//GERA O CÓDIGO DE VERIFICAÇÃO
			$CaracteresAceitos = 'ABCDEFGHIJKLMNOPQRXTUVWXYZ';	
			$max = strlen($CaracteresAceitos)-1;
			$password = null;
			for($i=0; $i < 8; $i++){
				$password .= $CaracteresAceitos{mt_rand(0, $max)}; 
				$carac = strlen($password); 
				if($carac ==4){ 
					$password .= "-";
				} 
			}
			
			$campo = tipoPessoa($tomador_cnpjcpf);
			$codTipoTomador = codtipo('tomador');
			$codTipoDec = coddeclaracao('DES Consolidada');
			if($inserir_tomador == "S"){				
				$datainicio = date("Y-m-d");
				mysql_query("
					INSERT INTO
						cadastro
					SET
						nome              = '$tomador_nome',
						codtipo           = '$codTipoTomador',
						codtipodeclaracao = '$codTipoDec',
						razaosocial       = '$tomador_nome',
						$campo            = '$tomador_cnpjcpf',
						inscrmunicipal    = '$tomador_inscrmunicipal',
						logradouro        = '$tomador_logradouro',
						numero            = '$tomador_numero',
						bairro			  = '$tomador_bairro',
						complemento       = '$tomador_complemento',
						cep               = '$tomador_cep',
						uf                = '$tomador_uf',
						email             = '$tomador_email',
						municipio         = '$tomador_municipio',
						estado            = 'A',
						datainicio        = '$datainicio'
				")or die(mysql_error());
			}else{
				if($dadosTomador['codtipo'] == $codTipoTomador){
					mysql_query("
						UPDATE 
							cadastro
						SET
							nome              = '$tomador_nome',
							codtipo           = '$codTipoTomador',
							codtipodeclaracao = '$codTipoDec',
							razaosocial       = '$tomador_nome',
							inscrmunicipal    = '$tomador_inscrmunicipal',
							logradouro        = '$tomador_logradouro',
							numero            = '$tomador_numero',
							bairro			  = '$tomador_bairro',
							complemento       = '$tomador_complemento',
							cep               = '$tomador_cep',
							uf                = '$tomador_uf',
							email             = '$tomador_email',
							municipio         = '$tomador_municipio',
							estado            = 'A'
						WHERE 
							$campo = '$tomador_cnpjcpf'	
					")or die(mysql_error());
				}	
			}
			//Pega a data e a hora da emissao
			$dataAtual = date("Y-m-d");
			$horaAtual = date("H:i:s");
			
			//Pega o numero da ultima nota
			$sql_numero = mysql_query("SELECT ultimanota FROM cadastro WHERE codigo = '".$_POST['hdCodEmpresa']."'");
			list($max_numero) = mysql_fetch_array($sql_numero);
			$max_numero++;
			
			//Insere os dados no banco
			mysql_query("
				INSERT INTO 
					notas 
				SET 
					numero = '$max_numero', 
					codverificacao = '$password', 
					codemissor = '".$_POST['hdCodEmpresa']."', 
					rps_numero = '$rps_numero', 
					rps_data = '$rps_data',
					tomador_nome = '$tomador_nome', 
					tomador_cnpjcpf = '$tomador_cnpjcpf',
					tomador_inscrmunicipal = '$tomador_inscrmunicipal',		
					tomador_logradouro = '$tomador_logradouro',
					tomador_numero = '$tomador_numero',
					tomador_bairro = '$tomador_bairro',
					tomador_complemento = '$tomador_complemento', 
					tomador_cep = '$tomador_cep', 
					tomador_municipio = '$tomador_municipio',
					tomador_uf = '$tomador_uf',
					tomador_email = '$tomador_email', 
					discriminacao = '$discriminacao',
					valortotal = '$valortotal', 
					valordeducoes = '$valordeducoes', 
					basecalculo = '$basecalc',
					valoriss = '$iss',  
					estado = '$estado',
					datahoraemissao = '$dataAtual $horaAtual', 
					issretido = '$issretido', 
					valorinss = '$inss', 
					valorirrf = '$irrf', 
					observacao = '$observacoes',
					tipoemissao = 'importada',
					pispasep = '$pispasep',
					cofins = '$cofins',
					contribuicaosocial = '$csocial',
					aliq_percentual = '$aliqpercentual',
					motivo_cancelamento = '$motivocancel',
					total_retencao = '$totalretencoes',
					valoracrescimos = '$acrescimo'
			")or die(mysql_error());
			//Pega o codigo da ultima nota inserida no banco
			$codUltimaNota = mysql_insert_id();
			
			$sqlIsento = mysql_query("SELECT isentoiss FROM cadastro WHERE codigo = '".$_POST['hdCodEmpresa']."'");
			list($isento) = mysql_fetch_array($sqlIsento);
			if($isento == 'S'){
				$iss       = 0;
				$issretido = 0;
			}

			mysql_query("
				INSERT INTO
					notas_servicos
				SET
					codnota       = '$codUltimaNota',
					codservico    = '$codservico',
					basecalculo   = '$basecalculo',
					issretido     = '$issretido',
					iss           = '$iss',
					discriminacao = '$discriminacao'
			")or die(mysql_error());
					
			//Testa em quais modalidades de credito o tomador se encaixa
			if (strlen($tomador_cnpjcpf) == 14){
				if($totalISSRetido > 0){
					$tipo_pessoa = "PF";
					$iss_retido = "S";
				}
				else{
					$tipo_pessoa = "PF";
					$iss_retido = "N";
				} // fim else
			} // fim if
			elseif(strlen($tomador_cnpjcpf) == 18){
				if($totalISSRetido > 0){
					$tipo_pessoa = "PJ";
					$iss_retido = "S";
				}
				else{
					$tipo_pessoa = "PJ";
					$iss_retido = "N";
				}
			} // fim else if

			if($iss > 0){
				$value = $iss;
			}elseif($issretido > 0){
				$value = $issretido;
			}
			$sql_credito = mysql_query("
				SELECT 
					credito 
				FROM 
					nfe_creditos 
				WHERE 
					estado = 'A' AND 
					tipopessoa LIKE '%$tipo_pessoa%' AND 
					issretido = '$iss_retido' AND
					valor <= '$value'
			");
			if(mysql_num_rows($sql_credito) > 0){
				list($creditoPercent) = mysql_fetch_array($sql_credito);
				if($iss > 0){
					$credito = $iss*$creditoPercent/100;
				}elseif($issretido > 0){
					$credito = $issretido*creditoPercent/100;
				}
				$credito = number_format($credito,2,'.','');
				mysql_query("UPDATE notas SET credito = '$credito' WHERE codigo = '$codUltimaNota'") or die(mysql_error());
			}
			
			//Atualiza a ultima nota
			$sql = mysql_query("SELECT ultimanota FROM cadastro WHERE codigo = '".$_POST['hdCodEmpresa']."'");
			list($ultimaNota) = mysql_fetch_array($sql);
			$notificacao = notificaTomador($_POST['hdCodEmpresa'],$ultimaNota);
			
			$ultimaNota += 1;
			
			$sql = mysql_query("UPDATE cadastro SET ultimanota = '$ultimaNota' WHERE codigo = '".$_POST['hdCodEmpresa']."'")or die(mysql_error());
			
			mysql_query("UPDATE rps_controle SET ultimorps = '$rps_numero' WHERE codcadastro = '".$_POST['hdCodEmpresa']."'")or die(mysql_error());
			
			$cont++;
		}// foreach
		unlink("importar/$arquivo_xml");
		add_logs('Importou Arquivo');
		print("<script language=JavaScript>alert('Importação efetuada com sucesso !');window.close();</script>");
	}else{
		print("Acesso Negado!!");
	}	
}?>