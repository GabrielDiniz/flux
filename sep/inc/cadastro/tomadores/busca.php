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
?><div id="draggable" class="box2">
			<a id="close-bot" onclick="document.getElementById('divBuscaTomadores').style.visibility='hidden'" title="Fechar"></a>
<table  border="0" cellspacing="0" cellpadding="0">
	<tr>    <legend>Pesquisar</legend>
    <td align="center">

<form method="post"  name="frmbuscatomadores" id="frmbuscatomadores">
	<input type="hidden" name="include" id="include" value="<?php echo  $_POST['include'];?>" />

	  <tr>
		<td><input name="txtBuscaNomeTomador" id="txtBuscaNomeTomador" type="text" class="texto" size="39"   >	
		<input name="btBuscarCliente" type="submit" value="" id="btBuscarCliente"></td>
	  </tr>
	  <tr>
	
		<select name="CODTOMADOR" id="CODTOMADOR" size="13"  class="combo" onchange="document.frmbuscatomadores.submit();">   		
			<?php 
				if(isset($_POST['txtBuscaNomeTomador']))
				{
					$nome=$_POST['txtBuscaNomeTomador'];
					$sql=mysql_query("
					SELECT 
						codigo,
						nome, 
						IF(cnpj <> '',cnpj,cpf) AS cnpjcpf,
						inscrmunicipal,
						logradouro, 
						numero,
						cep, 
						municipio, 
						uf, 
						email					
					FROM 
						cadastro				
					WHERE
						codtipo = '11' AND
						nome LIKE'%$nome%'
					GROUP BY
						cnpjcpf
					ORDER BY 
						nome
					");
					while(list($codigo,$nome,$cnpjcpf,$inscrmunicipal,$logradouro,$numero,$cep,$municipio,$uf,$email) = mysql_fetch_array($sql)){
						if($nome !=""){ 
							$tp= tipoPessoa($cnpjcpf);
							$tp=='cpf'?$tp='PF':$tp='PJ';
							echo "<option value=\"$codigo\">".$tp.' - '.$nome."</option>";
						}//fim if
					}//fim while
				}?>
		</select>
		
  
</form>
	</td>
	</td>
	</tr>
  </tr>
</table>
</div>
<map name="Map"><area shape="rect" coords="277,4,294,18" onclick="document.getElementById('divBuscaTomadores').style.visibility='hidden';" alt="Fechar">
</map>