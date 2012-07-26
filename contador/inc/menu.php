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
	$codDaSessao = $_SESSION['codempresa'];
	if(!empty($_POST['cmbCliente'])){
		$codCliente = $_POST['cmbCliente'];
		$_SESSION['codCliente'] = $_POST['cmbCliente'];
	}else{
		$codCliente = null;
		$_SESSION['codCliente'] = null;
	}
	$sql_tipo_declaracao = mysql_query("SELECT codtipodeclaracao, isentoiss FROM cadastro WHERE codigo = '$codDaSessao'");
	list($codtipodeclaracao,$isentoiss) = mysql_fetch_array($sql_tipo_declaracao);
	$codtipodec = coddeclaracao('Simples Nacional');
	
	if($codtipodeclaracao == $codtipodec && is_null($codCliente)){
		//array dos menus com seus respectivos links
		$menus=array(
			"Cadastro" 			=> "empresas.php",
			"AIDF Eletr&ocirc;nico" 	=> "aidf.php",
			"Notas Eletr&ocirc; nicas" => "notas.php",
			/*"NF-e Tomadas"      => "notas_tomadas.php",*/
			"Livro Digital"     => "livro.php",
			"RPS" 				=> "importar.php",
			"Exportar Notas" 	=> "exportar.php",
			"Contador Simples"  => "contador_simples.php",
			"Sair" 				=> "logout.php"
		);
	
	}elseif($codtipodeclaracao == $codtipodec && !is_null($codCliente)){
		$menus=array(
			"Cadastro" 			=> "empresas.php",
			"AIDF Eletr&ocirc;nico" 	=> "aidf.php",
			"Notas Eletr&ocirc;nicas" => "notas.php",
			/*"NF-e Tomadas"      => "notas_tomadas.php",*/
			"Livro Digital"     => "livro.php",
			"Guia de Pagamento" => "pagamento.php",
			"RPS" 				=> "importar.php",
			"Exportar Notas" 	=> "exportar.php",
			"Contador Simples"  => "contador_simples.php",
			"Sair" 				=> "logout.php"
		);
	}else{
		//array dos menus com seus respectivos links
		$menus=array(
			"Cadastro" 			=> "empresas.php",
			"AIDF Eletr&ocirc;nico" 	=> "aidf.php",
			"Notas Eletr&ocirc;nicas" => "notas.php",
			"Livro Digital"     => "livro.php",
			"Guia de Pagamento" => "pagamento.php",
			"RPS"		 		=> "importar.php",
			"Exportar Notas" 	=> "exportar.php",
			"Sair" 				=> "logout.php"
		);
	}
	?>
<div class="grid_3 suffix_1">
	<h2></h2>
	<ul class="list1">
		<?php
	// lista itens de menu
	foreach($menus as $menu => $link){
		print("<li> <a  href='$link' target='_parent'>&nbsp;$menu</a></li>"); 
	}
	?>
</ul>
</div>