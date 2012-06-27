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
session_name("emissor");
session_start(); 
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>e-Nota</title>
<link href="../css/imprimir_emissor.css" rel="stylesheet" type="text/css" />
</head>

<body>
<?php
if(!(isset($_SESSION["empresa"]))) {   
	echo "
		<script>
			alert('Acesso Negado!');
			window.location='login.php';
		</script>
	";
} // fim if
else {   
	//conecta a base de dados e pega as variaveis globais
	include("../include/conect.php");   
	include("../funcoes/util.php");
	//verifica se foi inserido o XML para UPLOAD
	if($import != "") {
		$arq = $_FILES["import"]['name'];
		$arq_tmp = $_FILES['import']['tmp_name'];   
		$extensao = substr($arq,-3);// pega a extensão do arquivo 
  		//$randomico = rand(00000,99999);
		$arq = $CODIGO_DA_EMPRESA.$arq;
		if(($extensao =="xml")||($extensao =="XML")) {
   
			move_uploaded_file($arq_tmp,"importar/".$arq);
    		//verifica se o upload funcionou   
    		if(file_exists('importar/'.$arq)) {    
	 			$sql=mysql_query("SELECT ultimanota FROM cadastro WHERE codigo = '$CODIGO_DA_EMPRESA'");
	 			list($UltimaNota)=mysql_fetch_array($sql);
				/*if(!validaXmlImportacao("./importar/$arq")){
					die("<p align=\"center\"><strong>O arquivo de importa&ccedil;&atilde;o de RPS &eacute; incompat&iacute;vel com o modelo.</strong></p>");
				}else{
					$xml = simplexml_load_file("importar/$arq"); // lê o arquivo XML 
				}*/
				$xml = simplexml_load_file("importar/$arq"); // lê o arquivo XML 
     			$cont =0; 
	 			$erro =0; 
				$contServicos = 0;
				$rps_invalidos = "";
	 			
				//Verifica se os creditos estao ativos
				$sql_creditos_ativos = mysql_query("SELECT ativar_creditos FROM configuracoes");
				list($situacaoCreditos) = mysql_fetch_array($sql_creditos_ativos);
				
				$sql = mysql_query("SELECT ultimanota, codtipo FROM cadastro WHERE codigo = '$CODIGO_DA_EMPRESA'");
				list($notaNumero,$codtipo) = mysql_fetch_array($sql);
				$notaNumero++;
				$codsimples = codtipo('simples');
				$sql = mysql_query("SELECT cidade FROM configuracoes");
				list($cidade) = mysql_fetch_array($sql);
				$cidade = utf8_encode($cidade);

				//busca os dados do arquivo XML 
    			foreach($xml->children() as $elemento => $valor) { 
					$sql_verifica_servico = mysql_query("SELECT aliquota FROM servicos WHERE codigo = '".$xml->nota[$cont]->codservico."'");  
					if(mysql_num_rows($sql_verifica_servico) != 1){
						die("<center><b>N&atilde;o existe nenhum servi&ccedil;o com o c&oacute;digo ".$xml->nota[$cont]->codservico."</b></center>");
					}else{
						list($aliq) = mysql_fetch_array($sql_verifica_servico);
						if($codtipo == $codsimples){
							$aliqeditavel = true;
						}elseif($xml->nota[$cont]->tomador_municipio != $cidade){
							$aliqeditavel = true;
						}else{
							$aliqeditavel = false;
						}
						if($aliq != $xml->nota[$cont]->aliqpercentual && !$aliqeditavel){
							die("<center><b>Al&iacute;quota incorreta no RPS n&uacute;mero ".$xml->nota[$cont]->rps_numero."</b></center>");
						}
					}
					$rps_data = $xml->nota[$cont]->rps_data;
					$rpsnum	  = $xml->nota[$cont]->rps_numero;
					$sql_verifica_rps = mysql_query("SELECT COUNT(codigo) FROM notas WHERE rps_numero = '$rpsnum' AND codemissor = '".$_SESSION['codempresa']."'");
					list($verifica_rps) = mysql_fetch_array($sql_verifica_rps);
					if($verifica_rps > 0){
						die("<p align=\"center\"><strong>J&aacute; existe um RPS com este n&uacute;mero</strong></p>");
					}
					$sql_verifica_rps = mysql_query("SELECT COUNT(codigo) AS qtd, limite FROM rps_controle WHERE codcadastro = '".$_SESSION['codempresa']."'");					
					$verifica_rps = mysql_fetch_array($sql_verifica_rps);
					if($verifica_rps['qtd'] == 0){
						die("<p align=\"center\"><strong>Prestador n&atilde;o autorizado para emiss&atilde;o de RPS</strong></p>");
					}elseif($rpsnum > $verifica_rps['limite']){
						die("<p align=\"center\"><strong>Seu limite de RPS é: ".$verifica_rps['limite']."</strong></p>");
					}
					
					$tomador_cnpjcpf = $xml->nota[$cont]->tomador_cnpjcpf;
					$sql_verifica_tomador = mysql_query("
						SELECT 
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
					}else{
						$tomador_inscrmunicipal =  utf8_decode($xml->nota[$cont]->tomador_inscrmunicipal);
						$tomador_nome           =  utf8_decode($xml->nota[$cont]->tomador_nome);
						$tomador_logradouro     =  utf8_decode($xml->nota[$cont]->tomador_logradouro);
						$tomador_numero         = $xml->nota[$cont]->tomador_numero;
						$tomador_complemento    =  utf8_decode($xml->nota[$cont]->tomador_complemento);
						$tomador_bairro         =  utf8_decode($xml->nota[$cont]->tomador_bairro);						
						$tomador_cep            = $xml->nota[$cont]->tomador_cep;
						$tomador_municipio      =  utf8_decode($xml->nota[$cont]->tomador_municipio);
						$tomador_uf             = $xml->nota[$cont]->tomador_uf;
						$tomador_email          = $xml->nota[$cont]->tomador_email;
					}
					$deducoes = $xml->nota[$cont]->deducoes;
					$estado   = $xml->nota[$cont]->estado;
					
					//Verifica a validação do XML
					include("inc/importar_erros.php") ;
					$sql_verifica_rps = mysql_query("SELECT codigo FROM notas WHERE rps_numero = '$rps_numero' AND codemissor = '$CODIGO_DA_EMPRESA'");
					if(mysql_num_rows($sql_verifica_rps)){
						echo "<center><b>A nota com o número de RPS $rps_numero, já foi emitida!</b></center>";
						exit;
					}
					$cont++;
				}
				
				//Verifica se o prestador pode declarar todas as notas que estao no arquivo xml
				$sql_verifica_ultimanota = mysql_query("SELECT ultimanota, notalimite, nome, razaosocial FROM cadastro WHERE codigo = '$CODIGO_DA_EMPRESA'");
				list($ultimaNota,$limite,$nomePrestador,$razaoPrestador) = mysql_fetch_array($sql_verifica_ultimanota);
				if(($limite != 0) && ($limite)){
					$proximoUltimanota = $ultimaNota + $cont;
					if($proximoUltimanota > $limite){
						$erro = 8;
						
						if(!$razaoPrestador){
							$razaoPrestador = $nomePrestador;
						}
					}
				}
				
				//Verifica se o RPS das notas do xml estao ok
				$sql_verifica_ultimorps = mysql_query("SELECT ultimorps, limite FROM rps_controle WHERE codcadastro = '$CODIGO_DA_EMPRESA'");
				list($ultimoRPS,$limite) = mysql_fetch_array($sql_verifica_ultimorps);
				if($limite > 0){
					$proximoUltimoRPS = $ultimoRPS + $cont;
					if($proximoUltimoRPS > $limite){
						$erro = 9;
					}
				}else{
					$erro = 10;
				}
				
				if($erro > 0){
					unlink("importar/$arq");
				}
				// verifica a formatação do arquivo XML
	 			if($erro ==1){
					print ("<center><b>Arquivo contém dados inconsistentes fora do padrão</b></center>");
				}	
	 			elseif($erro ==2){
	  				print ("<center><b>Arquivo contém código de servico inválido </b></center>");
	 			} // fim elseif
				elseif($erro ==3){
	  				print ("<center><b>Arquivo contém um código de serviço que a empresa não pode emitir nota</b></center>");
				}
	 			elseif($erro ==4){
	  				print ("<center><b>CPF/CNPJ não contém uma formatação válida </b></center>");
	 			} 
	 			elseif($erro ==5){
					print ("<center><b>Data do RPS não contém uma formatação válida </b></center>");
	 			} 
	 			elseif($erro ==6){
					print ("<center><b>CEP do tomador não contém uma formatação válida </b></center>");
	 			}elseif($erro == 7){
					echo "<center><b>A nota com o número de RPS $rps_numero, já foi emitida!</b></center>";
				}elseif($erro == 8){
					echo "<center><b>O prestador <b>$razaoPrestador</b> já emitiu $ultimaNota nota(s), o xml contém $cont nota(s) e seu limite de AIDFe é de $limite nota(s)! Por favor solicite um limite de AIDFe maior.</b></center>";
				}elseif($erro == 9){
					echo "<center><b>O prestador já emitiu $ultimoRPS RPS(s), o xml contém $cont RPS(s) e seu limite de RPS é de $limite RPS(s)! 
					Por favor solicite um limite de RPS maior.</b></center>";
				}elseif($erro == 10){
					echo "<center><b>É necessário solicitar um limite de RPS para poder declarar o xml.</b></center>";
				}else {
	  				$cont =0; 
      				//tabela que mostra os dados que vieram no XML 	 
      ?>
<table border="0" style="border:1px solid #999;" align="left" cellpadding="2" cellspacing="2">
	<tr>
		<td>
			<table width="100%"> 
				<tr>
					<td colspan="20" class="cab01">
						Verificação de dados do  arquivo XML da  empresa  <?php echo $NOME; ?>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
<?php	
	//pega os dados do XML	 
	foreach($xml->children() as $elemento => $valor){   
		$rps_data	     = $xml->nota[$cont]->rps_data;
		$rpsnum			= $xml->nota[$cont]->rps_numero;
		$tomador_cnpjcpf = $xml->nota[$cont]->tomador_cnpjcpf;
		
		$sql_verifica_tomador = mysql_query("
			SELECT 
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
		if(mysql_num_rows($sql_verifica_tomador) > 0){	
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
		}else{
			$tomador_inscrmunicipal =  utf8_decode($xml->nota[$cont]->tomador_inscrmunicipal);
			$tomador_nome           =  utf8_decode($xml->nota[$cont]->tomador_nome);
			$tomador_logradouro     =  utf8_decode($xml->nota[$cont]->tomador_logradouro);
			$tomador_numero         =  $xml->nota[$cont]->tomador_numero;
			$tomador_complemento    =  utf8_decode($xml->nota[$cont]->tomador_complemento);
			$tomador_bairro         =  utf8_decode($xml->nota[$cont]->tomador_bairro);						
			$tomador_cep            =  $xml->nota[$cont]->tomador_cep;
			$tomador_municipio      =  utf8_decode($xml->nota[$cont]->tomador_municipio);
			$tomador_uf             =  $xml->nota[$cont]->tomador_uf;
			$tomador_email          =  $xml->nota[$cont]->tomador_email;
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
		
		$tomador_inscrmunicipal = empty($dadosTomador['inscrmunicipal']) ?
		$xml->nota[$cont]->tomador_inscrmunicipal :
		$dadosTomador['inscrmunicipal'];
		
		switch(strtoupper($estado)){
			case "N":
				$estado = "Normal";
			  break;
			case "E":
				$estado = "Escriturado";
			  break;
			case "C":
				$estado = "Cancelado";
			  break;
			case "B":
				$estado = "Boleto";
			  break;
		}
			 
		$string = "";
		
		//---Complementa o endereco-----------
		if($tomador_numero){
			$string = ", $tomador_numero";
		}
		
		if($tomador_bairro){
			$string .= ", $tomador_bairro";
		}
		
		if($tomador_complemento){
			$string .= ", $tomador_complemento";
		}
		//------------------------------------
		 ?>
		<table width="100%" class="cab06" cellspacing="0"> 
			<tr>
				<td class="cab01" align="left" colspan="4"><?php echo $cont+1;?>&deg; Nota</td>
			</tr>
			<tr class="cab04">
				<td align="center">N&uacute;mero da nota:</td>
				<td align="center">RPS</td>
				<td align="center">Data RPS</td>
				<td align="center">Estado</td>
			</tr>
			<tr>
				<td align="center"><?php echo $notaNumero;?></td>
				<td align="center"><?php echo $rpsnum;?></td>
				<td align="center"><?php echo DataPt($rps_data);?></td>
				<td align="center"><?php echo $estado;?></td>
			</tr>
			
			<tr>
				<td colspan="4" align="center" class="cab01">Dados do tomador</td>
			</tr>
			<tr>
				<td align="left">Nome: </td>
				<td align="left"><?php echo $tomador_nome;?></td>
			</tr>
			<tr>
				<td align="left">CNPJ/CPF: </td>
				<td align="left"><?php echo $tomador_cnpjcpf;?></td>
			</tr>
			<tr>
				<td align="left">Insrc. Munic.: </td>
				<td align="left"><?php echo $tomador_inscrmunicipal;?></td>
			</tr>
			<tr>
				<td align="left">Endere&ccedil;o: </td>
				<td align="left"><?php echo $tomador_logradouro.$string;?></td>
			</tr>
			<tr>
				<td align="left">Estado: </td>
				<td align="left"><?php echo $tomador_uf;?></td>
				<td align="left">Munic&iacute;pio: </td>
				<td align="left"><?php echo strtoupper($tomador_municipio);?></td>
			</tr>
			<tr>
				<td align="left">Email:</td>
				<td align="left"><?php echo $tomador_email;?></td>
			</tr>
		</table>
		<br />
			<?php
				$sql_descricao = mysql_query("SELECT descricao FROM servicos WHERE codservico = '$codservico'");
				list($descricao) = mysql_fetch_array($sql_descricao);
			?>
			<table width="100%" style="border:1px solid #000" cellspacing="0">
				<tr>
					<td colspan="6" align="center" class="cab01">Serviço(s)</td>
				</tr>
				<tr class="cab04">
					<td align="center">Descrição</td>
					<td align="center">Al&iacute;quota</td>
					<td align="center">Base de C&aacute;lc.</td>
					<td align="center">ISS</td>
					<td align="center">ISS Retido</td>
				</tr>
				<tr>
					<td align="center" title="<?php echo $descricao; ?>">
						<?php
							$display = strlen($descricao) > 20
							? $display = substr($descricao,0,20)."..."
							: $display = $descricao;
							echo $display;
						?>
					</td>
					<td align="center"><?php echo DecToMoeda($aliqpercentual); ?>%</td>
					<td align="center"><?php echo DecToMoeda($basecalc); ?></td>
					<td align="center"><?php echo DecToMoeda($iss); ?></td>
					<td align="center"><?php echo DecToMoeda($issretido); ?></td>
				</tr>
			</table>
			<br />
			<table width="100%" class="cab06">
				<tr><td align="center" class="cab01" colspan="6">Dados da nota</td></tr>
				<tr><td colspan="8">Discriminação:</td></tr>
				<tr><td colspan="8" align="left" class="cab05"><?php echo nl2br($discriminacao);?></td></tr>
				<tr><td colspan="8">Observações:</td></tr>
				<tr><td colspan="8" align="left" class="cab05"><?php echo nl2br($observacoes);?></td></tr>
				<?php
					if($estado == "Cancelado"){
						?>
							<tr><td colspan="8">Motivo do Cancelamento:</td></tr>
							<tr><td colspan="8" align="left" class="cab05"><?php echo nl2br($motivocancel);?></td></tr>
						<?php
					}
				?>
				<tr><td height="5">&nbsp;</td></tr>
				<tr>
					<td>Base de c&aacute;lculo:</td>
					<td>R$ <?php echo DecToMoeda($basecalc); ?></td>
					<td>Deduções da nota:</td>
					<td>R$ <?php echo DecToMoeda($deducoes);?></td>
				</tr>
				<tr>
					<td>ISS:</td>
					<td>R$ <?php echo DecToMoeda($iss); ?></td>
					<td>ISS Retido:</td>
					<td>R$ <?php echo DecToMoeda($issretido);?></td>
				</tr>
				<tr>
					<td>INSS:</td>
					<td align="left">R$ <?php echo DecToMoeda($inss);?></td>
					<td>IRRF:</td>
					<td align="left">R$ <?php echo DecToMoeda($irrf);?></td>
				</tr>
				<tr>
					<td>Cofins:</td>
					<td align="left">R$ <?php echo DecToMoeda($cofins);?></td>
					<td>PIS/PASEP:</td>
					<td align="left">R$ <?php echo DecToMoeda($pispasep);?></td>
				</tr>
				<tr>
					<td>Acr&eacute;scimos:</td>
					<td>R$ <?php echo DecToMoeda($acrescimo);?></td>
					<td>Retenções:</td>
					<td>R$ <?php echo DecToMoeda($totalretencoes);?></td>
				</tr>
				<tr>
					<td>Contribui&ccedil;&atilde;o Social:</td>
					<td>R$ <?php echo DecToMoeda($csocial);?></td>
					<td>Valor Total:</td>
					<td>R$ <?php echo DecToMoeda($valortotal);?></td>
				</tr>
			</table>	
			  <?php 
				$notaNumero++;
				$cont++;	
			} //fim foreach lista dados 
				
		}// If se não deu erro
		?>
			<br />
			<table width="100%">
				<tr>
					<td colspan="20" align="left">
						<form action="importar_inserir.php" method="post">
							<input type="hidden" value="<?php print $arq;?>" name="txtArquivoNome" />
							<input type="submit" name="btImportarXML" value="Importar Arquivo" class="botao" onclick="return confirm('Deseja gerar esta(s) nota(s)?')"/>
						</form>
					</td>
				</tr>
			  </table> 
		<?php		
	}// end if exists    
	else{
		print("<center><b>Falha ao tentar abrir o arquivo XML</b></center>");     
	}
	}// if entensão do arquivo
	else{
		print("<center><b>O arquivo Importado não tem a extensão XML</b></center>");    
	}   
	}// end if campo text import
	else {
		print("<center><b>Insira o arquivo para a importação</b></center>");
	}
}  

?>

</body>
</html>