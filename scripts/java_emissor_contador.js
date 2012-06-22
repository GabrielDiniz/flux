
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
function comprimentoSenha(comprimento,campos){
	campos = campos.split("|");
	for(var i = 0; i < campos.length; i++){
		senha = document.getElementById(campos[i]).value;
		if(senha.length < comprimento){
			alert("A senha deve ter pelo menos "+comprimento+" caracteres");
			return false;
		}
	}
	return true;
}

function validaMei(cont,mei,tipo){
	if(mei == tipo){
		document.getElementById('txtValorIssServico'+cont).value = '0,00';	
	}	
}

function validaSimples(cont,simples,tipo){
	var municipioPrefeitura = document.getElementById('hdMunicpio').value;
	var municipioTomador =  "";
	if(document.getElementById('txtInsMunicipioEmpresa')){
		municipioTomador = document.getElementById('txtInsMunicipioEmpresa').value;
	}else if(document.getElementById('txtTomadorMunicipio')){
		municipioTomador = document.getElementById('txtTomadorMunicipio').value;
	}
	if((municipioPrefeitura == municipioTomador) && (simples == tipo)){
		document.getElementById('txtAliqServico'+cont).readOnly = false;		
	}else{
		document.getElementById('txtAliqServico'+cont).readOnly = true;		
	}
}

function aliquotaEditavel(cont, simples, tipo){
	var municipioPrefeitura = document.getElementById('hdMunicpio').value;
	var issRetido = document.getElementById('ckISSRetidoManual'+cont).checked;
	var municipio = "";
	if(document.getElementById('txtInsMunicipioEmpresa')){
		municipio = document.getElementById('txtInsMunicipioEmpresa').value;
	}else if(document.getElementById('txtTomadorMunicipio')){
		municipio = document.getElementById('txtTomadorMunicipio').value;
	}
	if(simples == tipo){
		document.getElementById('txtAliqServico'+cont).readOnly = false;	
	}else{
		if((issRetido) && (municipio != municipioPrefeitura)){
			document.getElementById('txtAliqServico'+cont).readOnly = false;
		}else{
			document.getElementById('txtAliqServico'+cont).readOnly = true;	
		}
	}
}

function verificaISSRetidoNota(){ 
	if(document.getElementById('ckISSRetidoManual1').value=='n'){
       document.getElementById('txtISSRetidoManual1').value=document.getElementById('txtValorIssServico1').value;
	   document.getElementById('ckISSRetidoManual1').value='s';
	  // document.getElementById('txtValorIssServico1').value='0,00';
	}
    else{
		document.getElementById('txtValorIssServico1').value=document.getElementById('txtISSRetidoManual1').value;
		document.getElementById('txtISSRetidoManual1').value='0,00';
		document.getElementById('ckISSRetidoManual1').value='n'
	    
	};
	
	
}

function buscaInfoPrestador(obj){
	var spanErro = document.getElementById('erroPrestador');
	var divPrestador = document.getElementById('divPrestador');
	var hdCNPJ = document.getElementById('hdCNPJ');
	var prestadorLogado = document.getElementById('hdCodLogado');
	var retorno;
	
	if(obj.value){
		if((obj.value.length == 18) || (obj.value.length == 14)){
			
			ajax({
				url:"../site/nfe_tomadas/notas_tomadas_infos_prestador.ajax.php?cnpj="+obj.value+"&logado="+prestadorLogado.value,
				espera: function(){
					spanErro.innerHTML = 'Pesquisando...';
				},
				sucesso: function() {
					spanErro.innerHTML = '';
					retorno = respostaAjax.split("==>");
					divPrestador.innerHTML = retorno[0];
					if(retorno[1]){
						hdCNPJ.value = '';
					}else{
						hdCNPJ.value = obj.value;
					}
				}
			});
			
		}else{
			spanErro.innerHTML = "<strong>Formato de CNPJ/CPF inv&aacute;lido!</strong>";
			divPrestador.innerHTML = '';
			hdCNPJ.value = '';
		}
	}else{
		spanErro.innerHTML = "<strong>Voc&ecirc; deve digitar um CNPJ/CPF v&aacute;lido!</strong>";
		divPrestador.innerHTML = '';
		hdCNPJ.value = '';
	}
}

// Cecília espiando....
function calculaISSNfeTomadas(hidden, cont){
	var baseservico = MoedaToDec(document.getElementById('hdBaseServico'+cont).value);
	if(baseservico>0){
		var iss = (MoedaToDec(document.getElementById('hdBaseServico'+cont).value) * MoedaToDec(document.getElementById('txtAliqServico'+cont).value))/100;
		document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
	}else{
		var iss = (MoedaToDec(document.getElementById('txtBaseCalcServico'+cont).value) * MoedaToDec(document.getElementById('txtAliqServico'+cont).value))/100;
		document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
	}
	
	var hdInputs       = document.getElementById(hidden).value;
	var contServicos   = 0;
	var total          = 0;
	var totalISS       = 0;
	var totalISSRetido = 0;
    var totalLiquido   = 0;

	var issretido = document.getElementById('txtISSRetidoManual'+cont).value;
	var iss = document.getElementById('txtValorIssServico'+cont).value;
	var baseservico = document.getElementById('txtBaseCalcServico'+cont).value;

	if(MoedaToDec(issretido) > MoedaToDec(baseservico)){
		document.getElementById('txtISSRetidoManual'+cont).value = baseservico;
		document.getElementById('txtBaseCalcServico'+cont).value = DecToMoeda(baseservico);
		document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseservico-issretido);
	}

    totalLiquido += MoedaToDec(document.getElementById('txtBaseCalcServico'+cont).value);
    totalLiquido -= MoedaToDec(document.getElementById('txtISSRetidoManual'+cont).value);
    document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(totalLiquido);
	
	while(contServicos < hdInputs){
		total = total + MoedaToDec(document.getElementById('txtValorLiquido'+contServicos).value);
		totalISS = totalISS + MoedaToDec(document.getElementById('txtValorIssServico'+contServicos).value);
		totalISSRetido = totalISSRetido + MoedaToDec(document.getElementById('txtISSRetidoManual'+contServicos).value);
		contServicos++;
	}
	
	document.getElementById('txtValorTotal').value = DecToMoeda(total);
	document.getElementById('txtTotalISS').value = DecToMoeda(totalISS);
	document.getElementById('txtTotalISSRetido').value = DecToMoeda(totalISSRetido);
}

function MostraAliquotaNFTomada(obj,campoAliq, cont){
	var aux = obj.value.split("|");
	document.getElementById('hdBaseServico'+cont).value = aux[3];
	document.getElementById(campoAliq).value = aux[0];
}

function descontaValor(campo1, campo2, campo3){
    var valor1 = MoedaToDec(document.getElementById(campo1).value);
    var valor2 = MoedaToDec(document.getElementById(campo2).value);
	var valor3 = MoedaToDec(document.getElementById(campo3).value);
	

		var totalv1v2v3 = valor1+valor2+valor3;
        if(totalv1v2v3 == document.getElementById('txtValTotalRetencao').value){
			alert(totalv1v2v3);
			valor1 = DecToMoeda(valor1 - valor2);
			document.getElementById(campo1).value = valor1;
		}

}

function habilitaRPS(ckb, campoRps, campoDataRps, hdRPS, hdDataRPS, retorno){
	var RPS       = document.getElementById(campoRps);
	var dataRPS   = document.getElementById(campoDataRps);
	var ultimoRPS = document.getElementById(hdRPS);
	var limiteRPS = document.getElementById(hdDataRPS);
	var spanRPS   = document.getElementById(retorno);
	
	if(ckb.checked == true){
	
		if(parseInt(limiteRPS.value) > 0){
			if(parseInt(ultimoRPS.value) + 1 <= parseInt(limiteRPS.value)){
			
				RPS.disabled = false;
				dataRPS.disabled = false;
				RPS.value = parseInt(ultimoRPS.value) + 1;
				
			}else{
				spanRPS.style.display = 'block';
			}				
		}else{
			spanRPS.style.display = 'block';
		}
		
	}else{
		
		RPS.disabled = true;
		dataRPS.disabled = true;
		spanRPS.style.display = 'none';
		RPS.value = '';
		dataRPS.value   = '';
	}

}

function mostraDivServicos(){
	document.getElementById('divServicosNota').style.display = 'block';
	if(!document.getElementById('cmbCodServico1')){
		document.getElementById('btAdicionar').onclick();
	}
}


/*
* Verifica se o checkbox foi marcado ou nao para que a aliquota
* seja manipulada
*/
function verificaCkbAliq(obj, cont){
	if(obj.checked == true){
		document.getElementById('txtAliqServico'+cont).readOnly = false;
		if(document.getElementById('ckISSRetidoManual'+cont).checked == false){
			document.getElementById('ckISSRetidoManual'+cont).click();
		}
	}else{
		document.getElementById('txtAliqServico'+cont).readOnly = true;
		document.getElementById('txtAliqServico'+cont).value = document.getElementById('hdAliqServico'+cont).value;
		if(document.getElementById('ckISSRetidoManual'+cont).checked == true){
			document.getElementById('ckISSRetidoManual'+cont).click();
		}
	}
}

/*
* Funcao que verifica se o tomador do servico e de fora do municipio
* caso seja, habilita checkbox para que a aliquota seja alteravel
*/
function verificaEmpresaFora(cont){
	var municipioPrefeitura = document.getElementById('hdMunicpio').value;
	if(document.getElementById('txtTomadorMunicipio')){
		var municipioTomador = document.getElementById('txtTomadorMunicipio').value;
	}else{
		var municipioTomador = undefined;
	}

	if(municipioTomador == undefined){
		if(document.getElementById('txtInsMunicipioEmpresa')){
			municipioTomador = document.getElementById('txtInsMunicipioEmpresa').value;
		}
	}
	
	if(municipioTomador != undefined){
		if((municipioPrefeitura != municipioTomador) && (municipioTomador)){
			document.getElementById('ckbAliq'+cont).style.visibility = 'visible';
		}else{
			document.getElementById('ckbAliq'+cont).style.visibility = 'hidden';
			document.getElementById('txtAliqServico'+cont).readOnly = true;
		}
	}
}


function calculaISSNfe(hidden, cont){
	var baseservico = document.getElementById('hdBaseServico'+cont).value;
    var iss = null;
	if(baseservico>0){
		iss = (MoedaToDec(document.getElementById('hdBaseServico'+cont).value) * MoedaToDec(document.getElementById('txtAliqServico'+cont).value))/100;
	}else{
		iss = (MoedaToDec(document.getElementById('txtBaseCalcServico'+cont).value) * MoedaToDec(document.getElementById('txtAliqServico'+cont).value))/100;
	}
	

	var aliq      = MoedaToDec(document.getElementById('txtAliqServico'+cont).value);
    var baseCalc  = MoedaToDec(document.getElementById('txtBaseCalcServico'+cont).value);	
	var deducoes  = MoedaToDec(document.getElementById('txtDeducoes'+cont).value);
    var acrescimo = MoedaToDec(document.getElementById('txtAcrescimo'+cont).value);
    var valLiq    = MoedaToDec(document.getElementById('txtValorLiquido'+cont).value);

	if(baseservico>0){
		if(document.getElementById('ckISSRetidoManual'+cont).value=='s'){
			document.getElementById('txtISSRetidoManual'+cont).value = document.getElementById('txtValorIssServico'+cont).value;
		}
		var issRetido = MoedaToDec(document.getElementById('txtISSRetidoManual'+cont).value);
		document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo-issRetido);
	}else{
		document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
		if(document.getElementById('ckISSRetidoManual'+cont).value=='s'){
			document.getElementById('txtISSRetidoManual'+cont).value = document.getElementById('txtValorIssServico'+cont).value;			
		}
		var issRetido = MoedaToDec(document.getElementById('txtISSRetidoManual'+cont).value);
		document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo-issRetido);
	}

	if(issRetido > 0){
		/* exclusivo para prefeitura de curionopulis
          if(issRetido > iss){
			issRetido = iss;
            iss = 0.00;
			document.getElementById('txtISSRetidoManual'+cont).value = DecToMoeda(issRetido);
            document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
		}else{
            iss -= issRetido;
			document.getElementById('txtISSRetidoManual'+cont).value = DecToMoeda(issRetido);
            document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
        }
		document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo);
        document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
        */

       // para demais prefeituras
       if(issRetido > iss){
			issRetido = iss;
			document.getElementById('txtISSRetidoManual'+cont).value = DecToMoeda(issRetido);
		}
		document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo-issRetido);
		document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
	}
	
	/*DBD*/
	
    if(deducoes > 0){
		if(deducoes > baseCalc){
			document.getElementById('txtBaseCalcServico'+cont).value = '0,00';
			document.getElementById('txtValorLiquido'+cont).value = '0,00';
			document.getElementById('txtDeducoes'+cont).value = DecToMoeda(baseCalc);		
		}else{
			document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo-issRetido);
            iss = (MoedaToDec(document.getElementById('txtValorLiquido'+cont).value) * MoedaToDec(document.getElementById('txtAliqServico'+cont).value))/100;
			document.getElementById('txtValorIssServico'+cont).value = DecToMoeda(iss);
			if(document.getElementById('ckISSRetidoManual'+cont).value=='s'){
			 document.getElementById('txtISSRetidoManual'+cont).value = DecToMoeda(iss);			 
			}

		}
    }

    if(acrescimo > 0){
       	document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo-issRetido);
	}
	
	if(MoedaToDec(document.getElementById('txtBaseCalcServico'+cont).value) > 0){
		if(issRetido > baseCalc){
			baseCalc = issRetido;
			document.getElementById('txtBaseCalcServico'+cont).value = DecToMoeda(baseCalc);
			document.getElementById('txtValorLiquido'+cont).value = DecToMoeda(baseCalc-deducoes+acrescimo-issRetido);
		}
	}
    /*DBD*/

	var quantidade = document.getElementById(hidden).value;
	var valorISS = 0;
	issRetido = 0;
	var valorISSRetido = 0;
	baseCalc = 0;
    deducoes = 0;
    acrescimo = 0;
	valLiqTotal = 0;

	for(var contt=1; contt <= quantidade; contt++){

		valorISS = valorISS + MoedaToDec(document.getElementById('txtValorIssServico'+contt).value);
		valorISSRetido = valorISSRetido + MoedaToDec(document.getElementById('txtISSRetidoManual'+contt).value);
		baseCalc = baseCalc + MoedaToDec(document.getElementById('txtBaseCalcServico'+contt).value);
        deducoes = deducoes + MoedaToDec(document.getElementById('txtDeducoes'+contt).value);
        acrescimo = acrescimo + MoedaToDec(document.getElementById('txtAcrescimo'+contt).value);
        valLiqTotal = valLiqTotal + MoedaToDec(document.getElementById('txtValorLiquido'+contt).value);
	}
		
	document.getElementById('txtBaseCalculo').value = DecToMoeda(baseCalc);
	if(document.getElementById('ckISSRetidoManual'+cont).value=='s'){
		document.getElementById('txtISS').value = '0,00';
		document.getElementById('txtIssRetido').value = DecToMoeda(valorISSRetido);
	}else{
		document.getElementById('txtISS').value = DecToMoeda(valorISS);
		document.getElementById('txtIssRetido').value = '0,00';
	}
    document.getElementById('txtValorDeducoes'). value = DecToMoeda(deducoes);
    document.getElementById('txtValorAcrescimos'). value = DecToMoeda(acrescimo);

	//document.getElementById('txtBaseCalculo').onblur();
	document.getElementById('txtValTotal').value = '';
    document.getElementById('txtValTotal').value = DecToMoeda(valLiqTotal);
	
	if(document.getElementById('ckISSRetidoManual'+cont).value=='s'){
			document.getElementById('txtValorIssServico'+cont).value = '0,00';
		}
}


function addLinhaNota(){
    var quantidade = document.getElementById('hdInputs').value;
	quantidade++;
	var codemissor = document.getElementById('hdCodemissor').value;	
	var ultimaLinha = document.getElementById('retornoDivLinha').rows.length;
	var novaLinha   = document.getElementById('retornoDivLinha').insertRow(ultimaLinha);
	var novaColuna  = novaLinha.insertCell(0);
	
	var indiceCombos = [];

	
	//Inseri mais uma linha
	ajax({
		url:'../site/linha_nova_nfe/novalinha.php?quantidade='+quantidade+'&codemissor='+codemissor+'&a=a',
		sucesso: function(){
			novaColuna.innerHTML = respostaAjax;	
			document.getElementById('hdInputs').value = quantidade;
			
			if(quantidade > 1){
				document.getElementById('btRemover').disabled = false;	
			}
			
			if(document.getElementById('hdLimite')){
				if(quantidade >= document.getElementById('hdLimite').value){
					if(document.getElementById('btAdicionar')){
						document.getElementById('btAdicionar').disabled = true;
					}
				}
			}
		}
	});
}

function validaAliquota(number){
    var aliquota = document.getElementById('txtAliqServico'+number).value;
    aliquota = number_format(parseFloat(aliquota),'2','.','');
    if(aliquota < 2 || aliquota > 5){
        alert(utf8_decode('A alíquota não deve ser maior que 5,00% nem menor que 2,00%'));
        document.getElementById('txtAliqServico'+number).focus();
        document.getElementById('txtAliqServico'+number).value = '';
    }
}
	
function removeLinha(idTable,idBotao){
	
	var ultimaLinha = document.getElementById(idTable).rows.length;
	ultimaLinha--;
	document.getElementById(idTable).deleteRow(ultimaLinha);	
	
	if(idBotao !== undefined){
		document.getElementById(idBotao).disabled = false;
	}
	
	var quantidade = document.getElementById('hdInputs').value;
	quantidade--;
	if(quantidade <= 1){
		document.getElementById('btRemover').disabled = true;
	}
	document.getElementById('hdInputs').value = quantidade;
	
	document.getElementById('txtBaseCalcServico1').onblur();
}



/**
*Funcao para adicionar uma nova linha de servico para a nota
*@param id = Tabela onde vai ser inserido nova linha
*/
function adicionaLinhaNfe(id){  


	var quantidade = document.getElementById('hdInputs').value;
	
	var codemissor = document.getElementById('hdCodemissor').value;	
	

	
	var cont = quantidade;
	var valorSERVICO = new Array(quantidade);
	var valorBASECALC = new Array(quantidade);
	var valorALIQUOTA = new Array(quantidade);
	var valorISS = new Array(quantidade);
	var indiceCombos = [];
	var Combo;
	
	while(cont > 0){
		if (document.getElementById('cmbCodServico' + cont).value) {
			valorSERVICO[cont] = document.getElementById('cmbCodServico' + cont).selectedIndex;
		}
		if (document.getElementById('txtBaseCalcServico' + cont).value) {
			valorBASECALC[cont] = document.getElementById('txtBaseCalcServico' + cont).value;
		}
		if (document.getElementById('txtAliqServico' + cont).value) {
			valorALIQUOTA[cont] = document.getElementById('txtAliqServico' + cont).value;
		}
		if (document.getElementById('txtValorIssServico' + cont).value) {
			valorISS[cont] = document.getElementById('txtValorIssServico' + cont).value;
		}
		cont--;	
	}
	quantidade++;
	
	//Inseri mais uma linha
	ajax({
		url:'../site/linha_nova_nfe/novalinha.php?quantidade='+quantidade+'&codemissor='+codemissor+'&a=a',
		sucesso: function(){
			document.getElementById(id).innerHTML = document.getElementById(id).innerHTML + respostaAjax;	
			document.getElementById('hdInputs').value = quantidade;
			
			if (cont >= 0) {
				cont = cont + 1;
				while (cont <= quantidade) {
		
					if (valorSERVICO[cont]) {
						
						document.getElementById('cmbCodServico' + cont).selectedIndex = valorSERVICO[cont];
						Combo = document.getElementById('cmbCodServico' + cont);
						indiceCombos.push(Combo.options[Combo.selectedIndex].value);
					}
					if (valorBASECALC[cont]) {
						document.getElementById('txtBaseCalcServico' + cont).value = valorBASECALC[cont];
					}
			
					if (valorALIQUOTA[cont]) {
						document.getElementById('txtAliqServico' + cont).value = valorALIQUOTA[cont];
					}
			
					if (valorISS[cont]) {
						document.getElementById('txtValorIssServico' + cont).value = valorISS[cont];
					}
					cont++;
				}
			}
			
			tamCombo = document.getElementById('cmbCodServico' + quantidade).length-1;
			for(contador = tamCombo;contador >= 0;contador--){
				for(var contArray in indiceCombos){
					if(document.getElementById('cmbCodServico' + quantidade).options[contador].value == indiceCombos[contArray]){
						document.getElementById('cmbCodServico' + quantidade).remove(contador);
					}
				}
			}
			
			if (quantidade > 1) {
				if(document.getElementById('btRemover')){
					document.getElementById('btRemover').disabled = false;
				}
			}
			
			if(document.getElementById('hdLimite')){
				if(quantidade >= document.getElementById('hdLimite').value){
					if(document.getElementById('btAdicionar')){
						document.getElementById('btAdicionar').disabled = true;
					}
				}
			}

		}
	});
	
	
}  

function removerLinhasNfe(id){
	
	var quantidade = document.getElementById('hdInputs').value;
	var div = document.getElementById(id);
	
	if ((quantidade != 0) && (quantidade != 1)) {

			var ultimaLinhaDiv = document.getElementById('tbl' + quantidade);
			div.removeChild(ultimaLinhaDiv);
			quantidade--;
			document.getElementById('hdInputs').value = quantidade;
	}
	
	if (quantidade <= 1) {
		document.getElementById('btRemover').disabled = true;
	}
	
	if(document.getElementById('hdLimite')){
		if (quantidade < document.getElementById('hdLimite').value) {
			document.getElementById('btAdicionar').disabled = false;
		}
	}
	
	document.getElementById('txtBaseCalcServico1').onblur();
		
}


function servicoNota(tipo, div){
	
	if(tipo == 'adicionar'){
		
		adicionaLinhaNfe(div);
		//addLinhaNota(div);
		
	}else if(tipo == 'remover'){
	
		//removeLinha('retornoDivLinha','btAdicionar');
		removerLinhasNfe(div);
	}
}



// FUN��ES da GUIA DE PAGAMENTO

function GuiaPagamento_TotalISS()
{
	if(document.getElementById('ckTodos').checked ==true)
	{
		 var aux = document.getElementById('txtTotalIssHidden').value;
		 var dados = aux.split("|");
		 var soma = 0;
		 
		 while(dados[1] >= 0)
		 {
		  document.getElementById('ckISS'+dados[1]).checked=true;
		  //document.getElementById('ckISS'+dados[1]).disabled=true;
		  
		  aux= document.getElementById('ckISS'+dados[1]).value;
		  valor = aux.split("|");
		  document.getElementById('txtCodNota'+dados[1]).value=valor[1];
		  soma=parseFloat(soma)+parseFloat(valor[0]);
		  dados[1]--;
		 }
		 document.getElementById('txtTotalIss').value= DecToMoeda(soma);
		 if(document.getElementById('txtTotalPagar'))
			 CalculaMultaDes();
	}
	else
	{
		 var aux = document.getElementById('txtTotalIssHidden').value;
		 var dados = aux.split("|");
		 while(dados[1] >= 0)
		 {
		  //document.getElementById('ckISS'+dados[1]).disabled=false;
		  document.getElementById('ckISS'+dados[1]).checked=false;
		  document.getElementById('txtCodNota'+dados[1]).value='';
		  dados[1]--;
		 }
		 document.getElementById('txtTotalIss').value=DecToMoeda(0);
		 if(document.getElementById('txtTotalPagar'))
			 CalculaMultaDes();
	}
}

function ValidaCkbDec(campo){
	var total = MoedaToDec(document.getElementById(campo).value);
	if(total>0){
		return true;
	}else{
		alert(utf8_decode('É necessário que escolha ao menos uma declaração'));
		return false;
	}
}//teste se tem pelo penos uma declaracao selecionada para gerar a guia

function CalculaMultaDes(){
	var mesComp = window.document.getElementById('cmbMes').value;
	var anoComp = window.document.getElementById('cmbAno').value;
	if (mesComp==''||anoComp=='')
		return false;
		
	var dataServ = window.document.getElementById('hdDataAtual').value.split('/');	
	var diaAtual = dataServ[0];
	var mesAtual = dataServ[1];
	var anoAtual = dataServ[2];
	
	var diaComp = window.document.getElementById('hdDia').value;
	mesComp = parseFloat(mesComp);
	mesComp++;
	
	var dataAtual = new Date(mesAtual+'/'+diaAtual+'/'+anoAtual);
	var dataComp = new Date(mesComp+'/'+diaComp+'/'+anoComp);
	var diasDec = diasDecorridos(dataComp,dataAtual);
	
	var nroMultas = window.document.getElementById('hdNroMultas').value;
	
	if(diasDec>0)
		var multa = 0;
	else
		var multa = -1;
		
	for(var c=0;c < nroMultas; c++){
		var diasMulta = window.document.getElementById('hdMulta_dias'+c).value;
		if(diasDec>diasMulta){
			var multa = c;	
			if(multa<nroMultas-1)
				multa++;
		}//end if
	}//end for
	
	if(document.getElementById('txtTotalIss'))
		var impostototal = MoedaToDec(window.document.getElementById('txtTotalIss').value);
	else
		var impostototal = MoedaToDec(window.document.getElementById('txtImpostoTotal').value);
	if(multa>=0){
		var multavalor = MoedaToDec(window.document.getElementById('hdMulta_valor'+multa).value);
		var multajuros = parseFloat(window.document.getElementById('hdMulta_juros'+multa).value);
		var jurosvalor = impostototal*multajuros/100;
		var multatotal = jurosvalor + multavalor;
		var totalpagar = multatotal + impostototal;
		window.document.getElementById('txtMultaJuros').value = DecToMoeda(multatotal);
		window.document.getElementById('txtTotalPagar').value = DecToMoeda(totalpagar);
	}
	else{
		window.document.getElementById('txtMultaJuros').value = '0,00';
		window.document.getElementById('txtTotalPagar').value = DecToMoeda(impostototal);
	}
}




function GuiaPagamento_SomaISS(iss)
{
	var valor = iss.value.split("|");
	var numero = iss.id.split("ckISS");
	if(iss.checked == true)
    {		
		var total = MoedaToDec(document.getElementById('txtTotalIss').value);				
		total+= parseFloat(valor[0]);		
		total = total.toFixed(2);		
		document.getElementById('txtTotalIss').value=DecToMoeda(total);
		document.getElementById('txtCodNota'+numero[1]).value=valor[1];
		if(document.getElementById('txtTotalPagar'))
			CalculaMultaDes();
    }
	else
	{
		var total = MoedaToDec(document.getElementById('txtTotalIss').value);
		var valor = iss.value.split("|");
		total-= parseFloat(valor[0]);
		total = total.toFixed(2);
		document.getElementById('txtTotalIss').value=DecToMoeda(total);
		document.getElementById('txtCodNota'+numero[1]).value='';
		if(document.getElementById('txtTotalPagar'))
			CalculaMultaDes();
	}
		
}
// FUN��ES da GUIA DE PAGAMENTO fim




function issmanual()
{
 var checado = document.getElementById('ISSManual').checked; 

 if(checado == true)
 {
  document.getElementById('DivISSRetido').style.display='block';
 }
 else
 {
  document.getElementById('txtPissretido').value='';  	 
  document.getElementById('DivISSRetido').style.display='none';	 
  document.getElementById('txtBaseCalculo').focus();
  document.getElementById('txtBaseCalculo').blur();
  //document.getElementById('txtBaseCalculo').blur;
 }
 //document.getElementById('txtIssRetido').readOnly=false;
 
 
}

function inssmanual()
	{
		var checado = document.getElementById('INSSManual').checked; 
		var base         = document.getElementById('txtBaseCalculoAux').value;
		//var valorinicial = document.getElementById('hdValorInicial').value;
		if(checado == true)
			{
				//document.getElementById('hdValorInicial').value = base;
				document.getElementById('DivINSSRetido').style.display='block';
			}
		else
			{
				document.getElementById('txtBaseCalculo').value = document.getElementById('hdCalculos').value;
				document.getElementById('txtPinssretido').value='';	  	 
				document.getElementById('DivINSSRetido').style.display='none';	 
				document.getElementById('txtBaseCalculo').focus();
				document.getElementById('txtBaseCalculo').blur();
			}
	}

function irmanual()
	{
		var checado      = document.getElementById('IRManual').checked;
		var base         = document.getElementById('txtBaseCalculoAux').value;
		//var valorinicial = document.getElementById('hdValorInicial').value;
		if(checado == true)
			{
				//document.getElementById('hdValorInicial').value = base;
				document.getElementById('DivIRRetido').style.display='block';
			}
		else
			{
				document.getElementById('txtBaseCalculo').value = document.getElementById('hdCalculos').value;
				document.getElementById('txtPirretido').value='';	  	 
				document.getElementById('DivIRRetido').style.display='none';	 
				document.getElementById('txtBaseCalculo').focus();
				document.getElementById('txtBaseCalculo').blur();
			}
	}

function baseCalcPct(tributo){
	
	var base_calculo = document.getElementById('txtBaseCalculo');
	var valor_baseCalculo = MoedaToDec(base_calculo.value);
	var campoPctBC = "";
	var campoValorBC = "";
	var aliqTributo = "";
	var valorTributo = "";
	
	if(tributo == "INSS"){
		
		campoPctBC = "txtINSSBCpct";
		campoValorBC = "txtINSSBC";
		aliqTributo = "txtAliquotaINSS";
		valorTributo = "txtValorINSS";
		
	}else if(tributo == "IRRF"){
		
		campoPctBC = "txtIRRFBCpct";
		campoValorBC = "txtIRRFBC";
		aliqTributo = "txtIRRF";
		valorTributo = "txtValorIRRF";
		
	}
	
	if(valor_baseCalculo > 0){
		
		var pctTributo = document.getElementById(campoPctBC).value;
		
		if(pctTributo > 100){
			pctTributo = 100;
			document.getElementById(campoPctBC).value = 100;
		}else if(pctTributo == ""){
			pctTributo = 0;
		}
		
		var calculo = (parseFloat(valor_baseCalculo) * parseFloat(pctTributo))/100;
		
		document.getElementById(campoValorBC).value = DecToMoeda(calculo);
		
		if((MoedaToDec(document.getElementById(campoValorBC).value) > 0) && (MoedaToDec(document.getElementById(campoPctBC).value) > 0)){
			
			//Habilita os campos

			document.getElementById(valorTributo).disabled = false;
			
			if(document.getElementById(aliqTributo).value > 0){
				document.getElementById('txtBaseCalculo').onblur();
			}
		}else{
			
			//Zera os valores
			document.getElementById(aliqTributo).value = 0;
			document.getElementById(valorTributo).value = 0; 
			
			//Desabilita os campos
			 
			document.getElementById(valorTributo).disabled = true;
			
			if(campoPctBC == "txtIRRFBCpct"){
				document.getElementById('txtDeducIRRF').value = 0;
				document.getElementById('txtValorFinalIRRF').value = 0;
				document.getElementById('txtDeducIRRF').disabled = true;
			}
			
			document.getElementById('txtBaseCalculo').onblur();
			
		}
		
	}else{
		alert(utf8_decode('Insira a base de cálculo'));
		document.getElementById(aliqTributo).value = 0;
		document.getElementById(campoPctBC).value = 0;
		base_calculo.focus();
	}
}


function ValorIss(regras_de_credito)
{
    var aux = document.getElementById('cmbCodServico1').value;
	var basecalculorpa = aux.split("|"); 	
	basecalculorpa= 0;
	
	
	
	
	var iss = MoedaToDec(document.getElementById('txtISS').value);
    var credito_final;
	var credito = 0;	 
	var int;
	var float; 
	var tipopessoa = document.getElementById('txtTomadorCNPJ').value.length;
	var valAcrescimo = 0;
	
	var basecalc = MoedaToDec(document.getElementById('txtBaseCalculo').value);

	var valdeduc = MoedaToDec(document.getElementById('txtValorDeducoes').value);
	if(document.getElementById('txtValorAcrescimos')){
		valAcrescimo = MoedaToDec(document.getElementById('txtValorAcrescimos').value);
	}
	
	document.getElementById('txtBaseCalculoAux').value = DecToMoeda(basecalc);
	
	document.getElementById('txtBaseCalculo').value = DecToMoeda(basecalc);
	
	if((basecalculorpa != undefined) && (basecalculorpa>0)){		
		basecalc = basecalculorpa;	
	}
	var base = document.getElementById('txtBaseCalculo').value;
	document.getElementById('hdCalculos').value = base;
	
	
	//--------------------------------------------------------------------------------------
	//Verifica se foi mudado o valor da base de calculo, para que possa corrigir os percentuais dos tributos
	if((MoedaToDec(document.getElementById('hdValorInicial').value) == 0) || (document.getElementById('hdValorInicial').value == "")){
	
		document.getElementById('hdValorInicial').value = base;	
	
	}else if((document.getElementById('hdValorInicial').value != base)&&((basecalculorpa == undefined ) || (basecalculorpa<=0))){
	
		document.getElementById('hdValorInicial').value = base;
		if(document.getElementById('txtIRRFBCpct')){
			document.getElementById('txtIRRFBCpct').onblur();
		}
		if(document.getElementById('txtINSSBCpct')){
			document.getElementById('txtINSSBCpct').onblur();
		}
	
	}
	//---------------------------------------------------------------------------------------
			
	if((tipopessoa == 14) || (tipopessoa == 18)){
		if(basecalc != ""){
			
			//calcula o valor total da nota
            var total;
            if((parseFloat(valdeduc) >= parseFloat(basecalc))){
                total = '0.00';
                document.getElementById('txtValorDeducoes'). value = DecToMoeda(basecalc);
                document.getElementById('txtBaseCalculo'). value = DecToMoeda(total);
            }else{
                total = parseFloat(basecalc) - parseFloat(valdeduc);
                if(document.getElementById('hdBkpBaseCalculo').value == "a" && DecToMoeda(valdeduc) != '0,00'){
                    document.getElementById('hdBkpBaseCalculo').value = DecToMoeda(total);
                }
            }
			if(valAcrescimo > 0){
				total = parseFloat(total) + parseFloat(valAcrescimo);
			}
			
			var qual_tipopessoa = (tipopessoa == 14) ? "PF" : "PJ";

			
			var issretido = MoedaToDec(document.getElementById('txtIssRetido').value);
			var tem_issretido = (issretido > 0) ? tem_issretido = "S" : tem_issretido = "N";

			var array_regras_credito = regras_de_credito.split("-");
			for(var cont in array_regras_credito){
                var array_campos_nfecredito = array_regras_credito[cont].split("|");				
				if((array_campos_nfecredito[0] == qual_tipopessoa)||(array_campos_nfecredito[0] == "PFPJ")){
					if(array_campos_nfecredito[1] == tem_issretido){						
						if(iss <= array_campos_nfecredito[2]){
							credito = array_campos_nfecredito[3];
						}
					}
				}
			}				

			
			
			//calcula o cr�dito final que o tomador receber� ao emitir a nota
			var somaiss= iss+issretido;
			credito_final = (somaiss * parseFloat(credito))/100;
			
			//credito_final = credito_final.toFixed(2);
			document.getElementById('txtCredito').value=DecToMoeda(credito_final);

			//-------------------------------------------------------------------------------------
			//Soma todos os campos de rentencao e mostra para o usuario
			var campoISSRetido = 0;
			var campoINSS = 0;
			var campoIRRF = 0;
			var TotalRentencao = 0;
			var pispasep = 0;
			var contribuicao = 0;
			var cofins = 0;
			
			cofins = MoedaToDec(document.getElementById('txtCofins').value);
			contribuicao = MoedaToDec(document.getElementById('txtContribuicaoSocial').value);
			pispasep = MoedaToDec(document.getElementById('txtPISPASEP').value);
			campoISSRetido = MoedaToDec(document.getElementById('txtIssRetido').value);
			campoINSS = MoedaToDec(document.getElementById('txtValorINSS').value);
			campoIRRF = MoedaToDec(document.getElementById('txtValorFinalIRRF').value);
			RentencaoParcial = 0;
			totalParcial = 0;
			
			if(cofins > 0){
				totalParcial = total;
				RentencaoParcial = parseFloat(campoISSRetido) + parseFloat(campoINSS) + parseFloat(campoIRRF) + parseFloat(pispasep) + parseFloat(contribuicao);
				totalParcial = totalParcial - RentencaoParcial;
				if(cofins > totalParcial){
					cofins = totalParcial;
					document.getElementById('txtCofins').value = DecToMoeda(cofins);
				}
			}
			
			if(contribuicao > 0){
				totalParcial = total;
				RentencaoParcial = parseFloat(campoISSRetido) + parseFloat(campoINSS) + parseFloat(campoIRRF) + parseFloat(pispasep) + parseFloat(cofins);
				totalParcial = totalParcial - RentencaoParcial;
				if(contribuicao > totalParcial){
					contribuicao = totalParcial;
					document.getElementById('txtContribuicaoSocial').value = DecToMoeda(contribuicao);
				}
			}
			
			if(pispasep > 0){
				totalParcial = total;
				RentencaoParcial = parseFloat(campoISSRetido) + parseFloat(campoINSS) + parseFloat(campoIRRF) + parseFloat(contribuicao) + parseFloat(cofins);
				totalParcial = totalParcial - RentencaoParcial;
				if(pispasep > totalParcial){
					pispasep = totalParcial;
					document.getElementById('txtPISPASEP').value = DecToMoeda(pispasep);
				}
			}
			
			if(campoISSRetido > 0){
				totalParcial = total;
				RentencaoParcial = parseFloat(pispasep) + parseFloat(campoINSS) + parseFloat(campoIRRF) + parseFloat(contribuicao) + parseFloat(cofins);
				totalParcial = totalParcial - RentencaoParcial;
				if(campoISSRetido > totalParcial){
					campoISSRetido = totalParcial;
					document.getElementById('txtIssRetido').value = DecToMoeda(campoISSRetido);
				}
			}
			
			if(campoINSS > 0){
				totalParcial = total;
				RentencaoParcial = parseFloat(pispasep) + parseFloat(campoISSRetido) + parseFloat(campoIRRF) + parseFloat(contribuicao) + parseFloat(cofins);
				totalParcial = totalParcial - RentencaoParcial;
				if(campoINSS > totalParcial){
					campoINSS = totalParcial;
					document.getElementById('txtValorINSS').value = DecToMoeda(campoINSS);
				}
			}
			
			if(campoIRRF > 0){
				totalParcial = total;
				RentencaoParcial = parseFloat(pispasep) + parseFloat(campoISSRetido) + parseFloat(campoINSS) + parseFloat(contribuicao) + parseFloat(cofins);
				totalParcial = totalParcial - RentencaoParcial;
				if(campoIRRF > totalParcial){
					campoIRRF = totalParcial;
					document.getElementById('txtValorFinalIRRF').value = DecToMoeda(campoIRRF);
				}
			}
			
			TotalRentencao = parseFloat(campoISSRetido) + parseFloat(campoINSS) + parseFloat(campoIRRF) + parseFloat(pispasep) + parseFloat(contribuicao) + parseFloat(cofins);
			document.getElementById('txtValTotalRetencao').value = DecToMoeda(TotalRentencao);
            
			//var valor_issretido = MoedaToDec(document.getElementById('txtIssRetido').value);
			//total = total - valor_issretido;
			
			document.getElementById('txtValTotal').value=DecToMoeda(total-TotalRentencao);
			
			
			//--------------------------------------------------------------------------------------
			
			
			}//fim if
	}else{
		//alert(utf8_decode("CPF/CNPJ inválido!"));
	}//fim else
}//fim da funcao

function ValorIssRPA(cred_pf_n,val_pf_n,cred_pf_s,val_pf_s,cred_pj_n,val_pj_n,cred_pj_s,val_pj_s)
{
	
	if(document.getElementById('txtPissretido').value>100){ 
	 	document.getElementById('txtPissretido').value = 100; 
		alert(utf8_decode('Não é possível reter mais de 100% de ISS'));
	}
	 else{
	 var credito_final;	
	 var credito = 0;	 
	 var int;
	 var float; 
	 var tipopessoa = document.getElementById('frmInserir').txtTomadorCNPJ.value.length;
	 

	 var basecalc = MoedaToDec(document.getElementById('txtBaseCalculo').value);



	 	 
	 var valdeduc = MoedaToDec(document.getElementById('txtValorDeducoes').value);
	 
	 var aliquota = document.getElementById('txtAliquota').value;
	 
	 document.getElementById('txtBaseCalculoAux').value = DecToMoeda(basecalc);
	 
	 document.getElementById('txtBaseCalculo').value = DecToMoeda(basecalc);
	 
	 var base = document.getElementById('txtBaseCalculo').value;
	 document.getElementById('hdCalculos').value = base;

	 //--------------------------------------------------------------------------------------
	 //Verifica se foi mudado o valor da base de calculo, para que possa corrigir os percentuais dos tributos
	 if((MoedaToDec(document.getElementById('hdValorInicial').value) == 0) || (document.getElementById('hdValorInicial').value == "")){
		 
	 	document.getElementById('hdValorInicial').value = base;	
		
	 }else if(document.getElementById('hdValorInicial').value != base){
		 
		document.getElementById('hdValorInicial').value = base;
		document.getElementById('txtIRRFBCpct').onblur();
		document.getElementById('txtINSSBCpct').onblur();
		
	 }
	 //---------------------------------------------------------------------------------------
	 
	 //----------------------------------------------------------------------------------
	 //Verifica e calcula o IRRF da nota
	 if(document.getElementById('txtIRRF').value > 0){
		 
		var deducoes = 0;
		var baseCalcPct = MoedaToDec(document.getElementById('txtIRRFBC').value);
	 	var IRRF = document.getElementById('txtIRRF').value;
		var campoIRRF = (baseCalcPct*IRRF)/100;
		document.getElementById('txtValorIRRF').value = DecToMoeda(campoIRRF);
		if(document.getElementById('txtDeducIRRF').disabled == true){
			document.getElementById('txtDeducIRRF').disabled = false;
		}
		
		if(MoedaToDec(document.getElementById('txtDeducIRRF').value) > 0){
			deducoes = MoedaToDec(document.getElementById('txtDeducIRRF').value);
		}
		if(deducoes > campoIRRF){
			deducoes = campoIRRF;
			document.getElementById('txtDeducIRRF').value = DecToMoeda(deducoes);	
		}
		var valorIRRFfinal = parseFloat(campoIRRF) - parseFloat(deducoes);
		document.getElementById('txtValorFinalIRRF').value = DecToMoeda(valorIRRFfinal);
		
	 }
	 //------------------------------------------------------------------------------------
	 
	 //------------------------------------------------------------------------------------
	 //Verifica e calcula o INSS da nota
	 if(document.getElementById('txtAliquotaINSS').value > 0){
		 
		var baseCalcPct = MoedaToDec(document.getElementById('txtINSSBC').value);
	 	var INSS = document.getElementById('txtAliquotaINSS').value;
		var campoINSS = (baseCalcPct*INSS)/100;
		document.getElementById('txtValorINSS').value = DecToMoeda(campoINSS);
		
	 }
	 //-------------------------------------------------------------------------------------

	 //-------------------------------------------------------------------------------------
	 //Soma todos os campos de rentencao e mostra para o usuario
	 var campoISSRetido = 0;
	 var campoINSS = 0;
	 var campoIRRF = 0;
	 var TotalRentencao = 0;

	 campoISSRetido = MoedaToDec(document.getElementById('txtIssRetido').value);
	 campoINSS = MoedaToDec(document.getElementById('txtValorINSS').value);
	 campoIRRF = MoedaToDec(document.getElementById('txtValorFinalIRRF').value);
	 
	 TotalRentencao = parseFloat(campoISSRetido) + parseFloat(campoINSS) + parseFloat(campoIRRF);
	 
	 document.getElementById('txtValTotalRetencao').value = DecToMoeda(TotalRentencao);
	 //--------------------------------------------------------------------------------------

	 
	 //calcula o valor total que a nota tem para comparacoes com as regras inseridas no banco
	 
	 var valortotaldanota = parseFloat(valdeduc) + parseFloat(basecalc);
	 
	 //Transforma a string recebida por parametro em um array com n posicoes
	 //---
	 var cred_pf_n = cred_pf_n.split("|");
	 var val_pf_n  = val_pf_n.split("|");
	 var cred_pf_s = cred_pf_s.split("|");
	 var val_pf_s  = val_pf_s.split("|");
	 var cred_pj_n = cred_pj_n.split("|");
	 var val_pj_n  = val_pj_n.split("|");
	 var cred_pj_s = cred_pj_s.split("|");
	 var val_pj_s  = val_pj_s.split("|");
	 //---
	 //var vetor_valor = string_valor.split("|");
	 //var vetor_cred = string_cred.split("|");
	 
	 if((tipopessoa == 14) || (tipopessoa == 18))
	 {
		 
		 if(aliquota != "")
		 { 
			  //separa os valores do combo e pega o valor do cr�dito
			  var aux = document.getElementById('cmbCodServico').value;  
			  var issretido = aux.split("|"); 
		  
		      /*
			  var verificaissretido= document.getElementById('txtPissretido').value;
			  
			  if (verificaissretido !='')
			  {
			   issretido[2] = verificaissretido ; 	 
			  }//fim if 
	 		  */

			  if(basecalc != "")
			  {
			   //calcula o iss
			   
			   var iss = parseFloat(aliquota);  //rpa o calculo � direto e nao por porcetagem 

			   /*a = Math.sqrt(iss);*/
			   iss = iss.toFixed(2);
			   document.getElementById('txtISS').value=DecToMoeda(iss);	  
			  
				  //verifica a quantidade de cr�ditos que o tomador receber�, baseando-se no tipo de pessoa e se tem iss retido ou n�o.
				  if( tipopessoa == 14)
				   {	   
					 if (issretido[2] != 0)
					 {
					    //verifica quantas posicoes tem o vetor e testa o valor com o recebido por parametro
						for(var cont in val_pf_s)
						{
							if(valortotaldanota<=val_pf_s[cont])
							{
								credito = cred_pf_s[cont];	
							}//fim if
						}//fim for
						//ao sair do foreach testa se a variavel e maior que a ultima posicao do array se for imprime o ultimo credito
						if(valortotaldanota>val_pj_n[cont]){
							credito = cred_pj_n[cont];
						}
					 }//fim if
					 else
					 {
					   //verifica quantas posicoes tem o vetor e testa o valor com o recebido por parametro
						for(var cont in val_pf_n)
						{
							if(valortotaldanota<=val_pf_n[cont])
							{
								credito = cred_pf_n[cont];	
							}//fim if
						}//fim for
						//ao sair do foreach testa se a variavel e maior que a ultima posicao do array se for imprime o ultimo credito
						if(valortotaldanota>val_pf_n[cont]){
							credito = cred_pf_n[cont];
						}
					 }//fim else
				   }//fim if
	  
				   else
				   if( tipopessoa == 18 )
				   {
					 if (issretido[2] != 0)
					 {
					   //verifica quantas posicoes tem o vetor e testa o valor com o recebido por parametro
						for(var cont in val_pj_s)
						{
							if(valortotaldanota<=val_pj_s[cont])
							{
								credito = cred_pj_s[cont];	
							}//fim if
						}//fim for
						//ao sair do foreach testa se a variavel e maior que a ultima posicao do array se for imprime o ultimo credito
						if(valortotaldanota>val_pj_s[cont]){
							credito = cred_pj_s[cont];
						}
					 }//fim if
					 else
					 {
					   //verifica quantas posicoes tem o vetor e testa o valor com o recebido por parametro
						for(var cont in val_pj_n)
						{
							if(valortotaldanota<=val_pj_n[cont])
							{
								credito = cred_pj_n[cont];	
							}//fim if
						}//fim for
						//ao sair do foreach testa se a variavel e maior que a ultima posicao do array se for imprime o ultimo credito
						if(valortotaldanota>val_pj_n[cont]){
							credito = cred_pj_n[cont];
						}
					 }//fim else
				   }//fim else if
				   
		

			//calcula o valor do ISS que ser� retido
			var valor_issretido = parseFloat(basecalc) * parseFloat(issretido[2])/100;
			
			//valor_issretido = valor_issretido.toFixed(2);
			document.getElementById('txtIssRetido').value=DecToMoeda(valor_issretido);
		   
			//calcula o valor total da nota
			var total = parseFloat(basecalc) + parseFloat(valdeduc);
			
			total = (total) + parseFloat(iss); // var iss � do valor do rpa que deve ser somado com o valor total da nota

			//   a = Math.sqrt(total);
			//   total = a.toFixed(2);
			document.getElementById('txtValTotal').value=DecToMoeda(total);
		   
			//calcula o cr�dito final que o tomador receber� ao emitir a nota
			credito_final = (parseFloat(iss) * parseFloat(credito))/100;
			//credito_final = credito_final.toFixed(2);
			document.getElementById('txtCredito').value=DecToMoeda(credito_final);
			
			var inss = document.getElementById('txtPinssretido').value;
			var ir   = document.getElementById('txtPirretido').value;
			var iss  = document.getElementById('txtPissretido').value;
			
			if(inss){
				CalculaINSS();
			}else if(iss){
				CalculaISS();
			}else if(ir){
				CalculaIR();
			}
			
		  }//fim if
	 }//fim if aliquota
		 else
			 {
			  alert(utf8_decode("Selecione o serviço!"));
			 }//fim else
	 }//fim if cpf/cnpj
	 else
	 {
	  alert(utf8_decode("CPF/CNPJ inválido!"));
	 }//fim else
	}//fim if issretido
}//fim da funcao



function ValidarInserirNota()
	{
		if((document.frmInserir.txtTomadorNome.value=="")||(document.frmInserir.txtTomadorCNPJ.value==""))
			{
				alert(utf8_decode("Preencha corretamente o Nome/Razão Social e o CNPJ/CPF do tomador"));
				return false;
			}
	}
	
//fun��o gen�rica que requisita confirma��o de envio

function ConfirmaForm()
	{
		if (confirm('Deseja gerar esta guia?'))
			{   
			  return true;
			}
		else
		    {
			  return false;	 
			}
	}	
	
	
/*function CalculaINSS()
	{
		var base    = MoedaToDec(document.getElementById('txtBaseCalculo').value);
		var baseaux = document.getElementById('txtBaseCalculoAux').value;
		var inss    = document.getElementById('txtPinssretido').value;
		if((base!="")&&(inss!=""))
			{
				if (inss<=100)
					{   
					    if(!(baseaux)){
						    document.getElementById('txtBaseCalculoAux').value = MoedaToDec(document.getElementById('txtBaseCalculo').value);
						}
						
						baseaux = document.getElementById('txtBaseCalculoAux').value;
						var x=(inss*baseaux)/100;
						base=baseaux-x;
						document.getElementById('txtBaseCalculo').value = DecToMoeda(base);
						document.getElementById('txtBaseCalculo').onblur();
					}
				else{alert(utf8_decode('Não é possível reter um valor de INSS maior que 100%'));}	
			}
	}*/
	
function CalculaISS(){
	var base = MoedaToDec(document.getElementById('txtBaseCalculo').value);
	var ir   = document.getElementById('txtPirretido').value;
	var inss = document.getElementById('txtPinssretido').value;
	var iss  = document.getElementById('txtPissretido').value;
	
	var iss_servico = MoedaToDec(document.getElementById('txtIssRetido').value);
	var baseAux = MoedaToDec(document.getElementById('txtBaseCalculo').value);
	if((base!="")&&(iss!="")){
		if (iss<=100){
			var x = (ir*baseAux)/100;
			base = parseFloat(base) - parseFloat(x);
			
			var y = (inss*baseAux)/100;
			base = parseFloat(base) - parseFloat(y);
			
			var z = (iss*baseAux)/100;
			base = parseFloat(base) - parseFloat(z);
			
			base = parseFloat(base) - parseFloat(iss_servico);
			base = parseFloat(base) + parseFloat(document.getElementById('txtValorDeducoes').value);
			document.getElementById('txtValTotal').value = DecToMoeda(base);
			
			//document.getElementById('txtBaseCalculo').onblur();
		}else{
			alert(utf8_decode('Não é possível reter um valor de ISS maior que 100%'));
		}	
	}else{
		document.getElementById('txtBaseCalculo').value = DecToMoeda(base);	
		document.getElementById('txtBaseCalculoAux').value = DecToMoeda(base);
	}
}	
	
function CalculaIR(){
	var base = MoedaToDec(document.getElementById('txtBaseCalculo').value);
	var ir   = document.getElementById('txtPirretido').value;
	var inss = document.getElementById('txtPinssretido').value;
	var iss  = document.getElementById('txtPissretido').value;
	
	var iss_servico = MoedaToDec(document.getElementById('txtIssRetido').value);
	var baseAux = MoedaToDec(document.getElementById('txtBaseCalculo').value);
	if((base!="")&&(ir!="")){
		if (ir<=100){
			var x = (ir*baseAux)/100;
			base = parseFloat(base) - parseFloat(x);
			
			var y = (inss*baseAux)/100;
			base = parseFloat(base) - parseFloat(y);
			
			var z = (iss*baseAux)/100;
			base = parseFloat(base) - parseFloat(z);
			
			base = parseFloat(base) - parseFloat(iss_servico);
			base = parseFloat(base) + parseFloat(document.getElementById('txtValorDeducoes').value);
			document.getElementById('txtValTotal').value = DecToMoeda(base);
			//document.getElementById('txtBaseCalculo').onblur();
		}else{
			alert(utf8_decode('Não é possível reter um valor de IR maior que 100%'));
		}	
	}else{
		document.getElementById('txtBaseCalculo').value = DecToMoeda(base);	
		document.getElementById('txtBaseCalculoAux').value = DecToMoeda(base);
	}
}	
	
function CalculaINSS(){
	var base = MoedaToDec(document.getElementById('txtBaseCalculo').value);
	var inss = document.getElementById('txtPinssretido').value;
	var ir   = document.getElementById('txtPirretido').value;
	var iss  = document.getElementById('txtPissretido').value;
	
	var iss_servico = MoedaToDec(document.getElementById('txtIssRetido').value);
	var baseAux = MoedaToDec(document.getElementById('txtBaseCalculo').value);
	if((base!="")&&(inss!="")){
		if (inss<=100){
			var x = (ir*baseAux)/100;
			base = parseFloat(base) - parseFloat(x);
			
			var y = (inss*baseAux)/100;
			base = parseFloat(base) - parseFloat(y);
			
			var z = (iss*baseAux)/100;
			base = parseFloat(base) - parseFloat(z);
			
			base = parseFloat(base) - parseFloat(iss_servico);
			base = parseFloat(base) + parseFloat(document.getElementById('txtValorDeducoes').value);
			document.getElementById('txtValTotal').value = DecToMoeda(base);
			//document.getElementById('txtBaseCalculo').onblur();
		}else{
			alert(utf8_decode('Não é possivel reter um valor de INSS maior que 100%'));
		}	
	}else{
		document.getElementById('txtBaseCalculo').value = DecToMoeda(base);	
		document.getElementById('txtBaseCalculoAux').value = DecToMoeda(base);
	}
}

function buscaCidades(campo, resultado, cadastro) {
	if(cadastro === undefined) cadastro = true;
	if(campo.value!=''){
		var url = cadastro ? 'inc/listamunicipio.ajax.php?UF='+campo.value :'../inc/listamunicipio.ajax.php?UF='+campo.value;
		
		ajax({
			url:url,
			espera: function(){
				document.getElementById(resultado).innerHTML = '<select style="width:150px;"><option/></select>';
			},
			sucesso: function() {
				document.getElementById(resultado).innerHTML = respostaAjax;
			},
			erro: function() {
				ajax({
					url:'../'+url,
					espera: function(){
						document.getElementById(resultado).innerHTML = '<select style="width:150px;"><option/></select>';
					},
					sucesso: function() {
						document.getElementById(resultado).innerHTML = respostaAjax;
					}
				});
			}
		});
	}else{
		document.getElementById(resultado).innerHTML = '<select style="width:150px;"><option/></select>';
	}
}

function creditosNfe($regras_de_credito){
	var array_regras_credito = regras_de_credito.split("|");
		for(var cont in array_regras_credito){
			
			var array_campos_nfecredito = array_regras_credito[cont].split("|");
			if((array_campos_nfecredito[0] == qual_tipopessoa)||(array_campos_nfecredito[0] == "PFPJ")){
				if(array_campos_nfecredito[1] == tem_issretido){
					if(iss <= array_campos_nfecredito[2]){
						credito = array_campos_nfecredito[3];
					}
				}
			}
		}				
	//calcula o cr�dito final que o tomador receber� ao emitir a nota
	credito_final = (iss * parseFloat(credito))/100;
	//credito_final = credito_final.toFixed(2);
	document.getElementById('txtCredito').value=DecToMoeda(credito_final);	
}