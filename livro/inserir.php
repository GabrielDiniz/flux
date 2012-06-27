<?php
    if($_POST['codempresa']){
        $codcadastro = $_POST['codempresa'];
    }else{
        $codcadastro = $_SESSION['codempresa'];
    }
	$cnpjcpf=$_POST['txtCnpjLivro'];
	$mes= $_POST['cmbMes'];
	$ano= $_POST['cmbAno'];
	if ($mes==date("m") && $ano==date("Y")){
                Mensagem("O livro s&oacute; pode ser gerado ao m&eacute;s anterior do atual!");
        }else{
            $dataemissao    = date("Y-m-d");
            $data           = explode("-",$dataemissao);
			
			
			$sql_diaTributacao = mysql_query("SELECT data_tributacao FROM configuracoes");
			list($data_tributacao) = mysql_fetch_array($sql_diaTributacao);
			
			if($data_tributacao == 0){
            	$vencimento = UltDiaUtil($mes,$ano);
			}else{
				$vencimento = proximoDiaVencimento($mes,$ano,$data_tributacao);
			}
			
			
            $obs = $_POST['txtObs'];
            $mes <=9 ? $mes='0'.$mes:NULL;
            $periodo= $ano.'-'.$mes;
            $periodomysql=$ano."-".$mes;

            $basecalculo=0;
            $reducaobc=0;
            $valoriss=0;
            $valorissretido=0;
            $valorisstotal=0;

            $sql=mysql_query("SELECT * FROM livro WHERE codcadastro='$codcadastro' AND periodo='$periodo' AND estado <> 'C'");
            if(mysql_num_rows($sql)==0)
            {

            $sql_notas = mysql_query("SELECT codigo,tomador_cnpjcpf,basecalculo,valoriss,issretido,estado FROM notas WHERE (codemissor='$codcadastro') AND datahoraemissao LIKE '$periodomysql%'");
                    $sql_notas_tomadas=mysql_query("SELECT codigo,total,iss,issretido,estado FROM notas_tomadas WHERE (codtomador='$codcadastro') AND data LIKE '$periodomysql%'");

                    if(mysql_num_rows($sql_notas)>0){

                    mysql_query("INSERT INTO livro (codcadastro,periodo,vencimento,geracao,obs) VALUES('$codcadastro','$periodo','$vencimento',NOW(),'$obs')");

                    $sql=mysql_query("SELECT MAX(codigo) as codigo FROM livro WHERE codcadastro='$codcadastro'");

                    $livro=mysql_fetch_object($sql);


                    while($nota=mysql_fetch_object($sql_notas)){

                            if($nota->estado!='C')
                            {
                                    $basecalculo+=$nota->basecalculo;
                                    $valoriss+=$nota->valoriss;
                                    $valorisstotal+=$nota->valoriss;
                                    $valorissretido+=$nota->issretido;
                                    mysql_query("INSERT INTO livro_notas (codnota,codlivro,tipo,nfe) VALUES('{$nota->codigo}','{$livro->codigo}','E','S')");
                            }
                    }
                    while($nota_tomada=mysql_fetch_object($sql_notas_tomadas)){

                            if($nota_tomada->estado!='C')
                            {
                                    $basecalculo+=$nota_tomada->total;
                                    $valoriss+=$nota_tomada->iss;
                                    $valorissretido+=$nota_tomada->issretido;
                                    $valorisstotal+=$nota_tomada->issretido;
                                    mysql_query("INSERT INTO livro_notas (codnota,codlivro,tipo,nfe) VALUES('{$nota_tomada->codigo}','{$livro->codigo}','T','S')");
                            }
                    }
                    //$valorisstotal=$valoriss;
                    $basecalculo-=$valorissretido;
                    // {$livro->codigo}
                    mysql_query("UPDATE livro SET basecalculo='$basecalculo' , valoriss='$valoriss',  valorissretido='$valorissretido' ,valorisstotal='$valorisstotal'
                    WHERE codigo={$livro->codigo}");
                    $codlivro=base64_encode($livro->codigo);
                    Mensagem("Livro gerado com sucesso!");

                    NovaJanela("../livro/imprimirlivrogeral.php?livro=$codlivro");
                    }else{
                    	Mensagem("Para gerar o livro, &eacute; preciso ter notas tomadas ou emitidas. A compet&ecirc;ncia selecionada nao possui nenhuma nota.");
                    }
            }else{
				Mensagem("Livro deste contribuinte neste período já foi gerado anteriormente. Informe outro contribuinte ou outro período");
            }
        }
?>