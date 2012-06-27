# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: 10.0.0.4    Database: enota
# ------------------------------------------------------
# Server version 5.0.77

DROP DATABASE IF EXISTS `enota`;
CREATE DATABASE `enota` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `enota`;

#
# Table structure for table aidf_docs
#

CREATE TABLE `aidf_docs` (
  `codigo` int(10) NOT NULL auto_increment,
  `codsolicitacao` int(10) default NULL,
  `codespecie` int(11) default NULL,
  `nroinicial` int(10) default NULL,
  `nrofinal` int(10) default NULL,
  `quantidade` int(10) default NULL,
  `validadenotas` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabela de documentos a serem impressos.';
/*!40000 ALTER TABLE `aidf_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table aidf_especie
#

CREATE TABLE `aidf_especie` (
  `codigo` int(11) NOT NULL auto_increment,
  `especie` varchar(200) default '',
  `serie` varchar(10) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
INSERT INTO `aidf_especie` VALUES (11,'Cupom Fiscal de Serviços','C');
INSERT INTO `aidf_especie` VALUES (12,'Nota Avulsa de Serviços','A');
/*!40000 ALTER TABLE `aidf_especie` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table aidf_especie_cadastro
#

CREATE TABLE `aidf_especie_cadastro` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `codespecie` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `aidf_especie_cadastro` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table aidf_solicitacoes
#

CREATE TABLE `aidf_solicitacoes` (
  `codigo` int(10) NOT NULL auto_increment,
  `codemissor` int(10) default NULL COMMENT 'tabela cadastro',
  `codgrafica` int(10) default NULL COMMENT 'tabela cadastro',
  `observacoes` text,
  `estado` char(1) default 'A' COMMENT 'A p/ aguardando, L p/ liberado e I p/ impresso',
  `data` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `aidf_solicitacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table aidfe_solicitacoes
#

CREATE TABLE `aidfe_solicitacoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `solicitante` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `aidfe_solicitacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table autos_infracao
#

CREATE TABLE `autos_infracao` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `origem` varchar(255) default NULL,
  `assunto` varchar(255) default NULL,
  `data_hora` timestamp NULL default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `autos_infracao` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table bancos
#

CREATE TABLE `bancos` (
  `codigo` int(11) NOT NULL auto_increment,
  `banco` varchar(60) default NULL,
  `boleto` varchar(60) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `bancos` VALUES (1,'Banco do Brasil','boleto_bb.php');
INSERT INTO `bancos` VALUES (2,'Bancoob','boleto_bancoob.php');
INSERT INTO `bancos` VALUES (3,'Banespa','boleto_banespa.php');
INSERT INTO `bancos` VALUES (4,'Banestes','boleto_banestes.php');
INSERT INTO `bancos` VALUES (5,'Besc','boleto_besc.php');
INSERT INTO `bancos` VALUES (6,'Bradesco','boleto_bradesco.php');
INSERT INTO `bancos` VALUES (7,'Caixa Econômica Federal','boleto_cef.php');
INSERT INTO `bancos` VALUES (8,'HSBC','boleto_hsbc.php');
INSERT INTO `bancos` VALUES (9,'Itaú','boleto_itau.php');
INSERT INTO `bancos` VALUES (10,'Nossa caixa','boleto_nossacaixa.php');
INSERT INTO `bancos` VALUES (11,'Real','boleto_real.php');
INSERT INTO `bancos` VALUES (12,'Santander','boleto_santander_banespa.php');
INSERT INTO `bancos` VALUES (13,'Sicredi','boleto_sicredi.php');
INSERT INTO `bancos` VALUES (14,'Sudameris','boleto_sudameris.php');
INSERT INTO `bancos` VALUES (15,'Unibanco','boleto_unibanco.php');
INSERT INTO `bancos` VALUES (16,'Caixa Econômica Federal (SINCO)','boleto_cef_sinco.php');
INSERT INTO `bancos` VALUES (17,'Caixa Econômica Federal(SIGCB)','boleto_cef_sigcb.php');
INSERT INTO `bancos` VALUES (18,'Santander Banespa','boleto_banespa.php');
INSERT INTO `bancos` VALUES (19,'Banrisul','boleto_banrisul.php');
/*!40000 ALTER TABLE `bancos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table boleto
#

CREATE TABLE `boleto` (
  `codigo` int(11) NOT NULL auto_increment,
  `tipo` char(1) default 'R' COMMENT 'P para  pagamento e R para recebimento',
  `codbanco` int(10) default NULL,
  `agencia` varchar(60) default NULL,
  `contacorrente` varchar(60) default NULL,
  `convenio` varchar(60) default NULL,
  `contrato` varchar(60) default NULL,
  `carteira` varchar(60) default NULL,
  `codfebraban` int(11) default NULL,
  `instrucoes` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `boleto` VALUES (1,'R',0,'','','','','',0,'Pagamento somente nos bancos Banrisul e conveniados, Banco do Brasil, Caixa Economica Federal e conveniados, Lotéricas e na Tesouraria da Prefeitura Municipal de Nossa Senhora de Lourdes');
/*!40000 ALTER TABLE `boleto` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cadastro
#

CREATE TABLE `cadastro` (
  `codigo` bigint(11) NOT NULL auto_increment,
  `sequencial_empresa` int(11) default NULL,
  `sequencial_escritorio` int(11) default NULL,
  `codtipo` int(11) default NULL,
  `codtipodeclaracao` int(11) default NULL,
  `nome` varchar(200) default NULL,
  `razaosocial` varchar(200) default NULL,
  `cnpj` varchar(20) default NULL,
  `cpf` varchar(20) default NULL,
  `senha` varchar(255) default NULL,
  `inscrmunicipal` varchar(20) default NULL,
  `inscrestadual` varchar(20) default NULL,
  `isentoiss` char(1) default 'N' COMMENT 'S para sim e N para não',
  `logradouro` varchar(200) default NULL,
  `numero` varchar(15) default NULL,
  `complemento` varchar(50) default NULL,
  `bairro` varchar(50) default NULL,
  `cep` varchar(20) default NULL,
  `municipio` varchar(100) default NULL,
  `uf` char(2) default NULL,
  `logo` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `ultimanota` int(10) default '0',
  `notalimite` int(10) default '0',
  `ultima_solicitacao_notalimite` int(11) default NULL,
  `estado` char(2) default 'NL' COMMENT 'NL nao liberado, A ativo, I inativo',
  `codcontador` int(10) default '0',
  `contadoreaidf` varchar(1) default 'N',
  `contadornfe` varchar(1) default 'N',
  `contadorlivro` varchar(1) default 'N',
  `contadorguia` varchar(1) default 'N',
  `contadorrps` varchar(1) default 'N',
  `credito` float(10,2) default NULL,
  `nfe` char(1) default 'N' COMMENT 'Determina se emissor emite nfe',
  `fonecomercial` varchar(15) default NULL,
  `fonecelular` varchar(15) default NULL,
  `pispasep` varchar(20) default NULL,
  `datainicio` date default NULL,
  `datafim` date default '0000-00-00',
  `credito_vencido` char(1) default 'N',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40000 ALTER TABLE `cadastro` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cadastro_resp
#

CREATE TABLE `cadastro_resp` (
  `codigo` int(10) NOT NULL auto_increment,
  `codemissor` int(10) default NULL COMMENT 'tabela cadastro',
  `codcargo` int(11) default NULL,
  `nome` varchar(100) default NULL,
  `cpf` varchar(20) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40000 ALTER TABLE `cadastro_resp` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cadastro_servicos
#

CREATE TABLE `cadastro_servicos` (
  `codigo` bigint(11) NOT NULL auto_increment,
  `codservico` bigint(11) default NULL,
  `codemissor` bigint(11) default NULL COMMENT 'tabela cadastro',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40000 ALTER TABLE `cadastro_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cargos
#

CREATE TABLE `cargos` (
  `codigo` int(11) NOT NULL auto_increment,
  `cargo` varchar(60) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `cargos` VALUES (15,'Diretor');
INSERT INTO `cargos` VALUES (16,'Gerente');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cartorios
#

CREATE TABLE `cartorios` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `admpublica` char(1) default NULL COMMENT 'D direta ou I indireta',
  `nivel` char(1) default NULL COMMENT 'M municipal, E estadual, F federal',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `cartorios` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cartorios_des
#

CREATE TABLE `cartorios_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcartorio` int(11) default NULL,
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `total` decimal(10,2) default NULL,
  `codverificacao` varchar(9) default NULL,
  `iss_emo` decimal(10,2) default NULL COMMENT 'emo=emolumento',
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `cartorios_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cartorios_des_notas
#

CREATE TABLE `cartorios_des_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddec_des` int(11) default NULL,
  `codservico` int(11) default NULL,
  `valornota` decimal(10,2) default NULL,
  `nota_nro` int(11) default NULL,
  `emolumento` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `cartorios_des_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cartorios_servicos
#

CREATE TABLE `cartorios_servicos` (
  `codigo` int(11) NOT NULL auto_increment,
  `codtipo` int(11) default NULL,
  `servicos` varchar(255) default NULL,
  `aliquota` float(10,2) default NULL,
  `estado` char(1) default 'I',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `cartorios_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table cartorios_tipo
#

CREATE TABLE `cartorios_tipo` (
  `codigo` int(11) NOT NULL auto_increment,
  `tipocartorio` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `cartorios_tipo` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table certidoes_negativas
#

CREATE TABLE `certidoes_negativas` (
  `codigo` int(10) NOT NULL auto_increment,
  `codemissor` int(10) default NULL,
  `codverificacao` varchar(9) default NULL,
  `dataemissao` date default NULL,
  `datavalidade` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `certidoes_negativas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table certidoes_pagamento
#

CREATE TABLE `certidoes_pagamento` (
  `codigo` int(10) NOT NULL auto_increment,
  `codemissor` int(10) default NULL,
  `codverificacao` varchar(9) default NULL,
  `dataemissao` date default NULL,
  `datavalidade` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `certidoes_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table configuracoes
#

CREATE TABLE `configuracoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `endereco` varchar(200) default NULL,
  `codmunicipio` int(11) default NULL,
  `cidade` varchar(200) default NULL,
  `estado` varchar(2) default NULL,
  `cnpj` varchar(30) default NULL,
  `email` varchar(100) default NULL,
  `secretaria` varchar(100) default NULL,
  `secretario` varchar(100) default NULL COMMENT 'Nome do sr secretario',
  `chefetributos` varchar(100) default NULL COMMENT 'Nome do sr chefe de tributos',
  `lei` varchar(100) default NULL,
  `decreto` varchar(100) default NULL,
  `topo` varchar(100) default NULL,
  `topo_nfe` varchar(100) default NULL,
  `logo` varchar(100) default NULL,
  `logo_nfe` varchar(100) default NULL,
  `brasao` varchar(60) default NULL,
  `brasao_nfe` varchar(60) default NULL,
  `codlayout` int(10) default NULL,
  `taxacorrecao` decimal(10,2) default '0.00',
  `taxamulta` decimal(10,2) default '0.00',
  `taxajuros` decimal(10,2) default '0.00',
  `data_tributacao` int(2) default '10' COMMENT 'dia do mes para cobranca de tributacao (0 = ultimo dia do mes)',
  `declaracoes_atrazadas` enum('s','n') default 's' COMMENT '(s para sim, n para nao)se a prefeitura permite declaracoes pelo site atrazadas',
  `gerar_guia_site` enum('t','i') default 'i' COMMENT 't para todos, i para individual',
  `ativar_creditos` char(1) default 's' COMMENT 's para creditos ativatos, n para creditos desativados',
  `site` varchar(100) default NULL,
  `aidf_validade` varchar(20) default NULL,
  `validadenota` varchar(20) default NULL,
  `codintegracao` int(11) default NULL,
  `abatimento_iptu` float(10,2) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `configuracoes` VALUES (1,'xxxxxx',1679,'xxxxx','RS','00.000.000/0001-00','prefeiturar@xxx.xx.gov.br','Secretaria Municipal da Fazenda','xxxx','xxx','0.000/00','0.000/00','prefeitura.jpg','prefeitura.jpg','57659.jpg','prefeitura.jpg','prefeitura.png','Logo.jpg',0,0,0,0,10,'s','t','n','www..xxx.xx.xx.xx','10','1',0,0);
/*!40000 ALTER TABLE `configuracoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table ddp_contas
#

CREATE TABLE `ddp_contas` (
  `codigo` int(11) NOT NULL auto_increment,
  `conta` varchar(20) default NULL,
  `descricao` varchar(100) default NULL,
  `aliquota` float(10,2) default NULL,
  `estado` char(1) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `ddp_contas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table ddp_des
#

CREATE TABLE `ddp_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codddp` int(11) default NULL,
  `data` date default NULL,
  `competencia` date default NULL,
  `total` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `codverificacao` varchar(30) default NULL,
  `estado` char(3) default 'N',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `ddp_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table ddp_des_contas
#

CREATE TABLE `ddp_des_contas` (
  `codigo` int(11) NOT NULL auto_increment,
  `codddp_des` int(11) default NULL,
  `contaoficial` varchar(20) default NULL,
  `contacontabil` varchar(50) default NULL,
  `titulo` varchar(50) default NULL,
  `item` int(5) default NULL,
  `saldo_mesanterior` decimal(10,2) default NULL,
  `debito` decimal(10,2) default NULL,
  `credito` decimal(10,2) default NULL,
  `saldo_mesatual` decimal(10,2) default NULL,
  `receita` decimal(10,2) default NULL,
  `aliquota` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `ddp_des_contas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table ddp_des_notas
#

CREATE TABLE `ddp_des_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `codddp_des` int(11) default NULL,
  `codemissor` int(11) default NULL,
  `codservico` int(11) default NULL,
  `valornota` decimal(10,2) default NULL,
  `nota_nro` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `ddp_des_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table decc_des
#

CREATE TABLE `decc_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codempreiteira` int(11) default NULL COMMENT 'tabela cadastro',
  `codobra` int(11) default NULL,
  `data` date default NULL,
  `competencia` date default NULL,
  `total` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `codverificacao` varchar(9) default NULL,
  `estado` char(1) default 'N' COMMENT 'N para normal B para boleto C para cancelada e E para escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `decc_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table decc_des_notas
#

CREATE TABLE `decc_des_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddecc_des` int(11) default NULL,
  `codservico` int(11) default NULL,
  `valornota` decimal(10,2) default NULL,
  `nronota` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `decc_des_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table declaracoes
#

CREATE TABLE `declaracoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `declaracao` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='tipos de declaracoes';
INSERT INTO `declaracoes` VALUES (1,'DES Consolidada');
INSERT INTO `declaracoes` VALUES (2,'DES Simplificada');
INSERT INTO `declaracoes` VALUES (3,'Simples Nacional');
INSERT INTO `declaracoes` VALUES (4,'MEI');
/*!40000 ALTER TABLE `declaracoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des
#

CREATE TABLE `des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(10) default NULL,
  `codcontador` int(11) default NULL COMMENT 'contador que fez a declaracao, se for NULL foi a propria empresa',
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `data` date default NULL,
  `total` float(10,2) default NULL,
  `iss_retido` decimal(10,2) default NULL COMMENT 'valor de iss retido na fonte',
  `iss` decimal(10,2) default NULL,
  `tomador` char(1) default 'n',
  `codverificacao` char(9) default NULL COMMENT 'Codigo de verificacao para a des',
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_issretido
#

CREATE TABLE `des_issretido` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL COMMENT 'tomador',
  `total` decimal(10,2) default NULL,
  `valor` decimal(10,2) default NULL,
  `multa` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `codverificacao` char(9) default NULL,
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `des_issretido` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_issretido_notas
#

CREATE TABLE `des_issretido_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddes_issretido` int(11) default NULL,
  `valor_nota` decimal(20,2) default NULL,
  `codemissor` int(11) default NULL COMMENT 'codigo da tabela cadastro',
  `issretido` decimal(10,2) default NULL,
  `nota_nro` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `des_issretido_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_servicos
#

CREATE TABLE `des_servicos` (
  `codigo` int(10) NOT NULL auto_increment,
  `coddes` int(10) default NULL,
  `codservico` bigint(11) default NULL,
  `data` date default NULL,
  `basedecalculo` float(10,2) default NULL,
  `iss_retido` decimal(10,2) default NULL COMMENT 'valor iss retido na fonte da nota',
  `iss` decimal(10,2) default NULL COMMENT 'valor do imposto de iss da nota',
  `deducao` decimal(10,2) default NULL,
  `valortotal` decimal(10,2) default NULL,
  `tomador_cnpjcpf` varchar(20) default NULL,
  `nota_nro` int(11) default NULL,
  `codespecie` int(11) default NULL,
  `discriminacao` text,
  `discriminacao_nota` text COMMENT 'Discriminação de cada nota',
  `codmunicipio` int(11) default NULL COMMENT 'Local onde foi emitida a nota',
  `cancelada` char(1) default 'N' COMMENT 'N não e S para sim',
  `complementar` int(11) default NULL,
  `observacao` text,
  `motivo_cancelamento` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `des_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_temp
#

CREATE TABLE `des_temp` (
  `codigo` int(11) NOT NULL auto_increment,
  `codemissores_temp` int(11) default NULL,
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `base` decimal(10,2) default NULL,
  `aliq` decimal(10,2) default NULL,
  `codverificacao` varchar(20) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='tabela temporaria para cadastro de emissores nao cadastrados';
/*!40000 ALTER TABLE `des_temp` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_tomadas
#

CREATE TABLE `des_tomadas` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `data` date default NULL,
  `total` float(10,2) default NULL,
  `issretido` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `codverificacao` char(9) default NULL,
  `estado` char(1) default NULL,
  `motivo_cancelamento` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `des_tomadas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_tomadas_servicos
#

CREATE TABLE `des_tomadas_servicos` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddes_tomadas` int(11) default NULL,
  `codservico` bigint(11) default NULL,
  `codespecie` int(11) default NULL,
  `data` date default NULL,
  `basedecalculo` float(10,2) default NULL,
  `iss_retido` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `deducao` decimal(10,2) default NULL,
  `valortotal` decimal(10,2) default NULL,
  `prestador_cnpj` varchar(20) default NULL,
  `nota_nro` int(11) default NULL,
  `discriminacao` text,
  `discriminacao_nota` text,
  `codmunicipio` int(11) default NULL,
  `cancelada` char(1) default 'N' COMMENT 'N não e S para sim',
  `complementar` int(11) default NULL,
  `observacao` text,
  `motivo_cancelamento` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `des_tomadas_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table des_tomadores_notas
#

CREATE TABLE `des_tomadores_notas` (
  `codigo` int(10) NOT NULL auto_increment,
  `cod_tomador` int(10) default NULL,
  `nota` varchar(20) default NULL,
  `dataemissao` date default NULL,
  `cod_emissor` int(11) default NULL COMMENT 'codigo do emissor',
  `valor` float(10,2) default NULL,
  `credito` float(10,2) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='tabela para gerar creditos das declaracoes';
/*!40000 ALTER TABLE `des_tomadores_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table dif_contas
#

CREATE TABLE `dif_contas` (
  `codigo` int(11) NOT NULL auto_increment,
  `conta` varchar(20) default NULL,
  `descricao` varchar(100) default NULL,
  `aliquota` float(10,2) default NULL,
  `estado` char(1) default 'I',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `dif_contas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table dif_des
#

CREATE TABLE `dif_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codinst_financeira` int(11) default NULL,
  `data` date default NULL,
  `competencia` date default NULL,
  `total` decimal(10,2) default NULL,
  `codverificacao` varchar(30) default NULL,
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  `codlivro_iss` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `dif_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table dif_des_contas
#

CREATE TABLE `dif_des_contas` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddif_des` int(11) default NULL,
  `contaoficial` varchar(20) default NULL,
  `contacontabil` varchar(50) default NULL,
  `titulo` varchar(50) default NULL,
  `item` int(5) default NULL,
  `saldo_mesanterior` decimal(10,2) default NULL,
  `debito` decimal(10,2) default NULL,
  `credito` decimal(10,2) default NULL,
  `saldo_mesatual` decimal(10,2) default NULL,
  `receita` decimal(10,2) default NULL,
  `aliquota` decimal(4,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `declarado` char(1) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `dif_des_contas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table doc_contas
#

CREATE TABLE `doc_contas` (
  `codigo` int(11) NOT NULL auto_increment,
  `conta` varchar(20) default NULL,
  `descricao` varchar(100) default NULL,
  `aliquota` float(10,2) default NULL,
  `estado` char(1) default 'I',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `doc_contas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table doc_des
#

CREATE TABLE `doc_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codopr_credito` int(11) default NULL,
  `data` datetime default NULL,
  `competencia` date default NULL,
  `total` decimal(10,2) default NULL,
  `codverificacao` varchar(30) default NULL,
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `doc_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table doc_des_contas
#

CREATE TABLE `doc_des_contas` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddoc_des` int(11) default NULL,
  `contaoficial` varchar(20) default NULL,
  `contacontabil` varchar(50) default NULL,
  `titulo` varchar(50) default NULL,
  `item` int(5) default NULL,
  `saldo_mesanterior` decimal(10,2) default NULL,
  `debito` decimal(10,2) default NULL,
  `credito` decimal(10,2) default NULL,
  `saldo_mesatual` decimal(10,2) default NULL,
  `receita` decimal(10,2) default NULL,
  `aliquota` decimal(4,2) default NULL,
  `iss` decimal(10,2) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `doc_des_contas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table dop_des
#

CREATE TABLE `dop_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codorgaopublico` int(11) default NULL,
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `total` float(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `codverificacao` varchar(9) default NULL,
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `dop_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table dop_des_notas
#

CREATE TABLE `dop_des_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `coddop_des` int(11) default NULL,
  `codemissor` int(11) default NULL,
  `codservico` int(11) default NULL,
  `valornota` decimal(10,2) default NULL,
  `nota_nro` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `dop_des_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table empreiteiras_servicos
#

CREATE TABLE `empreiteiras_servicos` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `codservico` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `empreiteiras_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table empreiteiras_socios
#

CREATE TABLE `empreiteiras_socios` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `nome` varchar(100) default NULL,
  `cpf` char(14) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `empreiteiras_socios` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table faq_isencoes
#

CREATE TABLE `faq_isencoes` (
  `codigo` int(10) NOT NULL auto_increment,
  `tipo` varchar(200) default NULL COMMENT 'Se isencao ou imunidade',
  `texto` text COMMENT 'Texto',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabela de faq para isencoes da prefeitura';
/*!40000 ALTER TABLE `faq_isencoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table fiscais
#

CREATE TABLE `fiscais` (
  `codigo` int(11) NOT NULL auto_increment,
  `nome` varchar(100) default NULL,
  `estado` char(1) default 'A' COMMENT 'A para ativado e D para desativado',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `fiscais` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table guia_pagamento
#

CREATE TABLE `guia_pagamento` (
  `codigo` int(11) NOT NULL auto_increment,
  `dataemissao` date default NULL,
  `datavencimento` date default NULL,
  `valor` float(11,2) default NULL,
  `valormulta` decimal(10,2) default NULL,
  `nossonumero` char(25) default NULL,
  `chavecontroledoc` bigint(20) default NULL,
  `pago` char(1) default 'N',
  `estado` char(1) default 'N' COMMENT 'N normal e C cancelada',
  `motivo_cancelamento` varchar(70) default NULL,
  `codlivro` int(11) default NULL,
  `codlivro_iss` int(11) default NULL,
  `codnota` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `guia_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table guias_cadastro_pg
#

CREATE TABLE `guias_cadastro_pg` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `codguia` int(11) default NULL,
  `codverificacao` char(9) collate latin1_general_ci default NULL,
  `data_gerado` date default NULL,
  `total` float(10,2) default NULL,
  `estado` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40000 ALTER TABLE `guias_cadastro_pg` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table guias_declaracoes
#

CREATE TABLE `guias_declaracoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `codguia` int(11) default NULL,
  `codrelacionamento` int(11) default NULL,
  `relacionamento` varchar(15) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `guias_declaracoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table inconsistencias
#

CREATE TABLE `inconsistencias` (
  `codigo` int(11) NOT NULL auto_increment,
  `codemissor` int(11) default NULL,
  `nota_nro` int(11) default NULL,
  `codtomador` int(11) default NULL,
  `estado` char(1) default NULL,
  `tipo` varchar(30) default NULL,
  `datahorainconsistencia` datetime default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `inconsistencias` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table inst_financeiras
#

CREATE TABLE `inst_financeiras` (
  `codigo` int(10) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `codbanco` int(11) default NULL,
  `agencia` varchar(20) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40000 ALTER TABLE `inst_financeiras` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table integracao
#

CREATE TABLE `integracao` (
  `codigo` int(11) NOT NULL auto_increment,
  `empresa` varchar(50) default NULL,
  `diretorio` varchar(50) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
INSERT INTO `integracao` VALUES (1,'feliz','feliz');
INSERT INTO `integracao` VALUES (2,'novahartz','novahartz');
/*!40000 ALTER TABLE `integracao` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table juros
#

CREATE TABLE `juros` (
  `codigo` int(11) NOT NULL auto_increment,
  `dias` int(11) default NULL,
  `juro` float(10,2) default NULL,
  `estado` char(1) default 'A',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
INSERT INTO `juros` VALUES (3,1,1,'A');
INSERT INTO `juros` VALUES (8,31,1,'A');
INSERT INTO `juros` VALUES (9,61,1,'A');
INSERT INTO `juros` VALUES (10,91,1,'A');
INSERT INTO `juros` VALUES (11,121,1,'A');
INSERT INTO `juros` VALUES (12,151,1,'A');
INSERT INTO `juros` VALUES (13,181,1,'A');
INSERT INTO `juros` VALUES (14,211,1,'A');
INSERT INTO `juros` VALUES (15,241,1,'A');
INSERT INTO `juros` VALUES (16,271,1,'A');
INSERT INTO `juros` VALUES (17,301,1,'A');
INSERT INTO `juros` VALUES (18,331,1,'A');
INSERT INTO `juros` VALUES (19,361,1,'A');
INSERT INTO `juros` VALUES (20,391,1,'A');
/*!40000 ALTER TABLE `juros` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table legislacao
#

CREATE TABLE `legislacao` (
  `codigo` int(10) NOT NULL auto_increment,
  `titulo` varchar(200) default NULL,
  `texto` text,
  `data` date default NULL,
  `arquivo` varchar(255) default NULL,
  `estado` char(1) default 'A' COMMENT 'A=ativo;I=inativo;',
  `tipo` char(1) default 'I' COMMENT 'N=nfe,I=iss;T=todos',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `legislacao` VALUES (30,'Lei Municipal 2490/10 - Institui a Nota Fiscal Eletrônica de Serviços.','Institui a Nota Fiscal Eletrônica de Serviços, a Declaração Eletrônica de Serviços, dispõe sobre a geração e utilização de créditos tributários para tomadores de serviços, e dá outras providências.','2010-12-24','63281.pdf','A','N');
INSERT INTO `legislacao` VALUES (31,'Decreto 2654/11 - Regulamenta a Emissão da Nota Fiscal Eletrônica de Serviços','Regulamenta a emissão da Nota Fiscal Eletrônica de Serviços – NFS-e, a apresentação da Declaração Mensal de Serviços e da outras providências.','2011-02-24','51925.pdf','A','N');
INSERT INTO `legislacao` VALUES (33,'Decreto 2702/11 - Regulamenta critérios para geração de créditos de ISS','Regulamenta critérios para geração de créditos aos tomadores de serviços sujeitos ao Imposto sobre Serviços de Qualquer Natureza - ISSQN do Município de Feliz.','2011-07-08','1843.pdf','A','N');
/*!40000 ALTER TABLE `legislacao` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table livro
#

CREATE TABLE `livro` (
  `codigo` int(10) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `periodo` varchar(255) default '10',
  `vencimento` date default NULL,
  `geracao` date default NULL,
  `basecalculo` float(10,2) default NULL,
  `reducaobc` float(10,2) default NULL,
  `valoriss` float(10,2) default NULL,
  `valorissretido` float(10,2) default NULL,
  `valorisstotal` float(10,2) default NULL,
  `obs` varchar(200) default NULL COMMENT 'E notas emitidas T notas tomadas',
  `estado` char(1) default 'N' COMMENT 'N para normal, b para bolet e c para cancelado',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table livro_iss
#

CREATE TABLE `livro_iss` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `competencia` varchar(255) default NULL,
  `vencimento` date default NULL,
  `geracao` date default NULL,
  `basecalculo` float(10,2) default NULL,
  `reducaobc` float(10,2) default NULL,
  `valoriss` float(10,2) default NULL,
  `valorissretido` float(10,2) default NULL,
  `valorisstotal` float(10,2) default NULL,
  `obs` text,
  `estado` char(1) default 'N' COMMENT 'N para normal e B para boleto e C para cancelado',
  `tipo` char(4) default 'des',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `livro_iss` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table livro_iss_notas
#

CREATE TABLE `livro_iss_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `codlivro` int(11) default NULL,
  `codnota` int(11) default NULL,
  `tipo` char(1) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `livro_iss_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table livro_notas
#

CREATE TABLE `livro_notas` (
  `codigo` int(11) NOT NULL auto_increment,
  `codlivro` int(11) default NULL,
  `codnota` int(11) default NULL,
  `tipo` char(1) default NULL COMMENT '(E) para notas emitidas e (T) para notas tomadas',
  `nfe` char(1) default NULL COMMENT 'S para nfe N para issdigital',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `livro_notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table logs
#

CREATE TABLE `logs` (
  `codigo` int(11) NOT NULL auto_increment,
  `codusuario` int(11) default NULL,
  `ip` varchar(100) default NULL,
  `data` datetime default NULL,
  `acao` varchar(100) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2911 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table mei_des
#

CREATE TABLE `mei_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codemissor` int(11) default NULL,
  `competencia` char(4) default NULL,
  `data_gerado` date default NULL,
  `total` decimal(10,2) default NULL,
  `tomador` char(1) default 'N',
  `codverificacao` char(9) default NULL,
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `mei_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table mei_des_servicos
#

CREATE TABLE `mei_des_servicos` (
  `codigo` int(10) NOT NULL auto_increment,
  `codmei_des` int(10) default NULL,
  `codservico` bigint(11) default NULL,
  `basedecalculo` float(10,2) default NULL,
  `tomador_cnpjcpf` varchar(20) default NULL,
  `nota_nro` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `mei_des_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table mensagem_tipos
#

CREATE TABLE `mensagem_tipos` (
  `codigo` int(11) NOT NULL auto_increment,
  `tipo` varchar(30) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `mensagem_tipos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table mensagens
#

CREATE TABLE `mensagens` (
  `codigo` int(11) NOT NULL auto_increment,
  `assunto` varchar(255) default NULL,
  `mensagem` text,
  `codtipo_mensagem` int(11) default NULL,
  `estado` char(1) default NULL COMMENT 'E = Em análise, L = Liberado e R = Recusado',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `mensagens` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table menus_cadastro
#

CREATE TABLE `menus_cadastro` (
  `codigo` int(11) NOT NULL auto_increment,
  `menu` varchar(100) default NULL,
  `tipo` varchar(100) default NULL,
  `ordem` int(11) default NULL,
  `link` varchar(100) default NULL,
  `visivel` char(1) default 'S',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `menus_cadastro` VALUES (1,'DES Consolidada','des',2,'comtomador','S');
INSERT INTO `menus_cadastro` VALUES (2,'DES Simplificada','des',3,'semtomador','S');
INSERT INTO `menus_cadastro` VALUES (3,'Declaração','dif',2,'declaracao/principal','S');
INSERT INTO `menus_cadastro` VALUES (5,'Guia Pagamento','des',7,'guia_pagamento','S');
INSERT INTO `menus_cadastro` VALUES (7,'Declaração DOP','dop',1,'declaracao','S');
INSERT INTO `menus_cadastro` VALUES (8,'Atualizar Cadastro','dop',2,'atualizarcadastro','S');
INSERT INTO `menus_cadastro` VALUES (10,'Retificação DOP','dop',6,'retificar','S');
INSERT INTO `menus_cadastro` VALUES (11,'Guia de Pagamento','dop',3,'guia_pagamento','N');
INSERT INTO `menus_cadastro` VALUES (12,'Segunda via','dop',5,'segundavia','S');
INSERT INTO `menus_cadastro` VALUES (13,'Atualizar Cadastro','dec',2,'atualizarcadastro','S');
INSERT INTO `menus_cadastro` VALUES (14,'Atualizar Cadastro','decc',1,'atualizar/atualizarcadastro','S');
INSERT INTO `menus_cadastro` VALUES (15,'Atualizar Cadastro','dif',1,'atualizacao/atualizarcadastro','S');
INSERT INTO `menus_cadastro` VALUES (16,'Guia de pagamento','dif',3,'guia_pagamento/index','N');
INSERT INTO `menus_cadastro` VALUES (17,'Declaração DECC','decc',3,'declaracoes/declarar','S');
INSERT INTO `menus_cadastro` VALUES (18,'Obras','decc',2,'obras/obras','S');
INSERT INTO `menus_cadastro` VALUES (19,'Retificação DIF','dif',6,'cancelamento/cancelar','N');
INSERT INTO `menus_cadastro` VALUES (20,'Relatórios','dif',8,'historico/historico','S');
INSERT INTO `menus_cadastro` VALUES (21,'Segunda Via','des',9,'segundavia_prestador','S');
INSERT INTO `menus_cadastro` VALUES (22,'Declaração','dec',1,'declarar','S');
INSERT INTO `menus_cadastro` VALUES (23,'Relatórios','dec',7,'historico','S');
INSERT INTO `menus_cadastro` VALUES (24,'Declaração','doc',1,'declarar','S');
INSERT INTO `menus_cadastro` VALUES (25,'Atualizar Cadastro','doc',2,'atualizarcadastro','S');
INSERT INTO `menus_cadastro` VALUES (26,'Guia de recolhimento','doc',3,'recolhimento','S');
INSERT INTO `menus_cadastro` VALUES (27,'Retificação DOC','doc',5,'retificacao','S');
INSERT INTO `menus_cadastro` VALUES (28,'Segunda Via','doc',4,'segundavia','S');
INSERT INTO `menus_cadastro` VALUES (29,'Relatórios','doc',8,'historico','S');
INSERT INTO `menus_cadastro` VALUES (30,'Retificação','dec',3,'retificar','S');
INSERT INTO `menus_cadastro` VALUES (31,'Retificação DES','des',4,'prestadores_cancelardes','S');
INSERT INTO `menus_cadastro` VALUES (32,'Relatórios','des',10,'historicodes','S');
INSERT INTO `menus_cadastro` VALUES (33,'Declaração','simples',1,'desn','S');
INSERT INTO `menus_cadastro` VALUES (34,'Atualizar Cadastro','simples',2,'alterar_form','S');
INSERT INTO `menus_cadastro` VALUES (35,'Retificação','simples',3,'desn_retificacao','S');
INSERT INTO `menus_cadastro` VALUES (36,'Relatórios','simples',2,'desn_historico','S');
INSERT INTO `menus_cadastro` VALUES (37,'Portal SN','simples',6,'portal_simples','S');
INSERT INTO `menus_cadastro` VALUES (38,'Guia Pagamento','decc',4,'guias/geraguia','S');
INSERT INTO `menus_cadastro` VALUES (39,'Segunda Via','decc',6,'guias/segundavia','S');
INSERT INTO `menus_cadastro` VALUES (40,'Guia de Pagamento','dec',4,'gerarguia','S');
INSERT INTO `menus_cadastro` VALUES (41,'Remessa DES','des',5,'importar','S');
INSERT INTO `menus_cadastro` VALUES (42,'Guia de Pagamento','dif',5,'guia_pagamento/segundavia_prestador','S');
INSERT INTO `menus_cadastro` VALUES (43,'Segunda Via','dec',6,'segundavia','S');
INSERT INTO `menus_cadastro` VALUES (45,'Atualizar Cadastro','des',1,'atualizarcadastro','S');
INSERT INTO `menus_cadastro` VALUES (46,'Retificação Guia','des',8,'prestadores_cancelarguia','N');
INSERT INTO `menus_cadastro` VALUES (47,'Clientes (Contador)','des',0,'clientes','S');
INSERT INTO `menus_cadastro` VALUES (48,'Definir Contador','des',11,'definircontador','S');
INSERT INTO `menus_cadastro` VALUES (50,'Relatórios','mei',5,'mei_historico','S');
INSERT INTO `menus_cadastro` VALUES (51,'Retificação','mei',3,'mei_retificacao','S');
INSERT INTO `menus_cadastro` VALUES (52,'Declaração','mei',1,'declaracao','S');
INSERT INTO `menus_cadastro` VALUES (53,'Retificação Guia','dif',7,'retificacaoguia/dif_cancelarguia','N');
INSERT INTO `menus_cadastro` VALUES (54,'Retificação Guia','doc',7,'doc_cancelarguia','S');
INSERT INTO `menus_cadastro` VALUES (55,'Retificação DECC','decc',7,'retificacao/cancelar','S');
INSERT INTO `menus_cadastro` VALUES (56,'Retificação Guia','decc',8,'retificacao_guia/decc_cancelarguia','S');
INSERT INTO `menus_cadastro` VALUES (58,'Retificação Guia','dop',7,'dop_cancelarguia','N');
INSERT INTO `menus_cadastro` VALUES (59,'Definir Contador','mei',10,'definircontador','S');
INSERT INTO `menus_cadastro` VALUES (60,'Definir Contador','simples',10,'definircontador','S');
INSERT INTO `menus_cadastro` VALUES (61,'Definir Contador','dif',9,'definircontador','N');
INSERT INTO `menus_cadastro` VALUES (62,'Declaração Simples','des',0,'contsimples','N');
INSERT INTO `menus_cadastro` VALUES (63,'DES Tomadas','des',3,'des_tomadas','S');
INSERT INTO `menus_cadastro` VALUES (64,'Declaração','ddp',1,'declarar','S');
INSERT INTO `menus_cadastro` VALUES (65,'Atualizar Cadastro','ddp',2,'atualizar','S');
INSERT INTO `menus_cadastro` VALUES (66,'Guia de Pagamento','ddp',3,'guia_pagamento','S');
INSERT INTO `menus_cadastro` VALUES (67,'Retificação de Guia','ddp',5,'retificacao','S');
INSERT INTO `menus_cadastro` VALUES (68,'Relatórios','ddp',6,'relatorios','S');
INSERT INTO `menus_cadastro` VALUES (69,'Segunda Via','ddp',7,'segunda_via','S');
INSERT INTO `menus_cadastro` VALUES (70,'Livro Digital','ddp',4,'livro_digital','N');
INSERT INTO `menus_cadastro` VALUES (71,'Livro Digital','dec',5,'livro_digital','N');
INSERT INTO `menus_cadastro` VALUES (72,'Livro Digital','decc',5,'livro_digital','N');
INSERT INTO `menus_cadastro` VALUES (73,'Livro Digital','dif',4,'livro_digital','S');
INSERT INTO `menus_cadastro` VALUES (74,'Livro Digital','des',6,'livro_digital','S');
INSERT INTO `menus_cadastro` VALUES (75,'Livro Digital','dop',4,'livro_digital','N');
INSERT INTO `menus_cadastro` VALUES (76,'Livro Digital','doc',6,'livro_digital','N');
INSERT INTO `menus_cadastro` VALUES (77,'Livro Digital','simples',4,'livro_digital','N');
INSERT INTO `menus_cadastro` VALUES (78,'Livro Digital','mei',4,'livro_digital','N');
/*!40000 ALTER TABLE `menus_cadastro` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table menus_prefeitura
#

CREATE TABLE `menus_prefeitura` (
  `codigo` int(11) NOT NULL auto_increment,
  `menu` varchar(100) default NULL,
  `ordem` int(11) default NULL,
  `link` varchar(100) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `menus_prefeitura` VALUES (2,'Serviços',2,'servicos');
INSERT INTO `menus_prefeitura` VALUES (3,'Cadastro',1,'cadastro');
INSERT INTO `menus_prefeitura` VALUES (6,'NFe',3,'nfe');
INSERT INTO `menus_prefeitura` VALUES (15,'Ajuda',20,'ajuda');
INSERT INTO `menus_prefeitura` VALUES (18,'Fiscalização',4,'fiscalizacao');
INSERT INTO `menus_prefeitura` VALUES (20,'Declarações',3,'declaracoes');
INSERT INTO `menus_prefeitura` VALUES (22,'Utilitários',9,'utilitarios');
INSERT INTO `menus_prefeitura` VALUES (29,'Relatórios',8,'relatorios');
INSERT INTO `menus_prefeitura` VALUES (30,'Livro Digital',6,'livro');
INSERT INTO `menus_prefeitura` VALUES (31,'Imposto',4,'imposto');
INSERT INTO `menus_prefeitura` VALUES (33,'Guia de Pagamento',7,'guia');
/*!40000 ALTER TABLE `menus_prefeitura` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table menus_prefeitura_submenus
#

CREATE TABLE `menus_prefeitura_submenus` (
  `codigo` int(11) NOT NULL auto_increment,
  `codmenu` int(11) default NULL,
  `codsubmenu` int(11) default NULL,
  `visivel` char(1) default NULL COMMENT 'S = sim N = nao',
  `ordem` int(11) default NULL,
  `nivel` char(1) default 'M' COMMENT 'A para alto ,M para medio e B para baixo',
  `iss` char(1) default 'N' COMMENT 'S=sim N=nao',
  `nfe` char(1) default 'N' COMMENT 'S=sim N=nao',
  `iptu` char(1) default 'N' COMMENT 'S=sim N=nao',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=147 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
INSERT INTO `menus_prefeitura_submenus` VALUES (3,2,1,'S',1,'B','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (4,2,5,'S',2,'B','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (6,3,16,'S',2,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (7,3,6,'S',3,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (13,7,3,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (14,8,26,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (15,8,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (16,6,11,'S',4,'B','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (17,7,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (24,15,10,'S',NULL,'B','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (25,17,1,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (26,17,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (27,18,3,'S',1,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (28,18,4,'S',2,'A','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (39,17,19,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (42,22,19,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (43,22,20,'S',1,'A','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (44,22,21,'S',5,'A','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (45,22,22,'S',4,'M','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (46,22,23,'S',2,'A','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (47,22,24,'S',3,'B','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (51,22,29,'S',10,'B','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (52,22,30,'S',11,'B','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (53,23,1,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (54,23,6,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (55,23,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (56,23,31,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (57,23,32,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (58,24,1,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (59,24,6,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (60,24,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (61,24,31,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (62,24,32,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (65,25,1,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (66,25,6,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (67,25,31,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (68,27,1,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (70,25,32,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (71,25,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (72,27,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (73,27,31,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (74,27,32,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (75,27,6,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (76,27,35,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (77,28,31,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (78,28,2,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (79,28,32,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (80,28,6,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (82,28,1,'S',NULL,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (83,20,8,'S',8,'B','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (84,20,13,'S',5,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (85,20,14,'S',1,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (86,20,28,'S',7,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (87,20,27,'S',1,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (88,20,38,'S',2,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (89,20,15,'S',6,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (90,20,39,'S',3,'A','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (91,3,12,'S',5,'M','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (92,3,36,'S',6,'B','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (93,6,17,'S',2,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (95,6,6,'S',1,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (96,18,31,'S',3,'B','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (97,18,37,'S',4,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (99,15,42,'S',NULL,'B','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (102,22,26,'S',9,'B','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (103,22,44,'S',6,'A','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (104,20,45,'S',9,'B','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (105,3,46,'S',4,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (106,2,47,'S',3,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (107,2,48,'S',4,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (108,2,49,'S',5,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (109,2,50,'S',6,'A','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (110,3,51,'S',3,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (111,29,52,'S',1,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (112,29,53,'S',3,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (113,20,54,'S',3,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (114,22,55,'S',7,'M','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (115,6,56,'S',5,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (116,29,57,'S',4,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (117,6,58,'S',6,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (118,30,59,'S',2,'M','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (119,30,60,'S',1,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (120,30,61,'S',3,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (121,20,62,'S',10,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (122,29,63,'N',4,'B','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (123,29,64,'N',7,'B','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (124,6,65,'S',3,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (126,32,66,'S',1,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (127,6,67,'S',6,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (128,32,68,'S',2,'M','N','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (129,29,69,'N',5,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (130,29,70,'S',6,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (131,22,71,'S',8,'M','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (132,6,72,'S',7,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (133,33,33,'S',1,'M','S','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (135,20,73,'S',2,'M','S','N','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (136,29,74,'S',8,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (137,29,75,'N',9,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (138,29,76,'N',10,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (139,29,77,'S',10,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (140,29,78,'N',12,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (141,29,79,'S',13,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (142,29,80,'S',14,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (143,29,81,'S',15,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (144,29,82,'S',16,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (145,29,83,'S',17,'M','N','S','N');
INSERT INTO `menus_prefeitura_submenus` VALUES (146,29,84,'S',11,'M','N','S','N');
/*!40000 ALTER TABLE `menus_prefeitura_submenus` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table menus_site
#

CREATE TABLE `menus_site` (
  `codigo` int(11) NOT NULL auto_increment,
  `menu` varchar(100) default NULL,
  `link` varchar(100) default NULL,
  `codservico` int(10) default NULL,
  `ordem` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `menus_site` VALUES (1,'Declaração Eletrônica de Serviços','des.php',5,1);
INSERT INTO `menus_site` VALUES (2,'NFeletrônica','nfe.php',3,2);
/*!40000 ALTER TABLE `menus_site` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table multas
#

CREATE TABLE `multas` (
  `codigo` int(11) NOT NULL auto_increment,
  `dias` int(5) default NULL COMMENT 'contagem de dias do pagamento',
  `multa` decimal(5,2) default NULL COMMENT 'valor da multa em reais',
  `estado` char(1) default 'A',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
INSERT INTO `multas` VALUES (1,1,3,'A');
INSERT INTO `multas` VALUES (2,31,6,'A');
INSERT INTO `multas` VALUES (7,61,10,'A');
/*!40000 ALTER TABLE `multas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table municipios
#

CREATE TABLE `municipios` (
  `codigo` int(11) NOT NULL auto_increment,
  `nome` varchar(80) default NULL,
  `uf` varchar(2) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=5816 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `municipios` VALUES (1,'ABAETÉ','MG');
INSERT INTO `municipios` VALUES (2,'ABAETÉTUBA','PA');
INSERT INTO `municipios` VALUES (3,'ABAIARA','CE');
INSERT INTO `municipios` VALUES (4,'ABAIRA','BA');
INSERT INTO `municipios` VALUES (5,'ABARE','BA');
INSERT INTO `municipios` VALUES (6,'ABATIA','PR');
INSERT INTO `municipios` VALUES (7,'ABDON BATISTA','SC');
INSERT INTO `municipios` VALUES (8,'ABEL FIGUEIREDO','PA');
INSERT INTO `municipios` VALUES (9,'ABELARDO LUZ','SC');
INSERT INTO `municipios` VALUES (10,'ABRE CAMPO','MG');
INSERT INTO `municipios` VALUES (11,'ABREU E LIMA','PE');
INSERT INTO `municipios` VALUES (12,'ABREULÂNDIA','TO');
INSERT INTO `municipios` VALUES (13,'ACAIACA','MG');
INSERT INTO `municipios` VALUES (14,'AÇAILÂNDIA','MA');
INSERT INTO `municipios` VALUES (15,'ACAJUTIBA','BA');
INSERT INTO `municipios` VALUES (16,'ACARÁ','PA');
INSERT INTO `municipios` VALUES (17,'ACARAPE','CE');
INSERT INTO `municipios` VALUES (18,'ACARAU','CE');
INSERT INTO `municipios` VALUES (19,'ACARI','RN');
INSERT INTO `municipios` VALUES (20,'ACAUA','PI');
INSERT INTO `municipios` VALUES (21,'ACEGUÁ','RS');
INSERT INTO `municipios` VALUES (22,'ACOPIARA','CE');
INSERT INTO `municipios` VALUES (23,'ACORIZAL','MT');
INSERT INTO `municipios` VALUES (24,'ACREUNA','GO');
INSERT INTO `municipios` VALUES (25,'AÇU','RN');
INSERT INTO `municipios` VALUES (26,'AÇUCENA','MG');
INSERT INTO `municipios` VALUES (27,'ADAMANTINA','SP');
INSERT INTO `municipios` VALUES (28,'ADELÂNDIA','GO');
INSERT INTO `municipios` VALUES (29,'ADOLFO','SP');
INSERT INTO `municipios` VALUES (30,'ADRIANÓPOLIS','PR');
INSERT INTO `municipios` VALUES (31,'ADUSTINA','BA');
INSERT INTO `municipios` VALUES (32,'AFOGADOS DA INGAZEIRA','PE');
INSERT INTO `municipios` VALUES (33,'AFONSO BEZERRA','RN');
INSERT INTO `municipios` VALUES (34,'AFONSO CLAUDIO','ES');
INSERT INTO `municipios` VALUES (35,'AFONSO CUNHA','MA');
INSERT INTO `municipios` VALUES (36,'AFRANIO','PE');
INSERT INTO `municipios` VALUES (37,'AFUA','PA');
INSERT INTO `municipios` VALUES (38,'AGRESTINA','PE');
INSERT INTO `municipios` VALUES (39,'AGRICOLÂNDIA','PI');
INSERT INTO `municipios` VALUES (40,'AGROLÂNDIA','SC');
INSERT INTO `municipios` VALUES (41,'AGRONÔMICA','SC');
INSERT INTO `municipios` VALUES (42,'ÁGUA AZUL DO NORTE','PA');
INSERT INTO `municipios` VALUES (43,'ÁGUA BOA','MG');
INSERT INTO `municipios` VALUES (44,'ÁGUA BOA','MT');
INSERT INTO `municipios` VALUES (45,'ÁGUA BRANCA','PB');
INSERT INTO `municipios` VALUES (46,'ÁGUA CLARA','MS');
INSERT INTO `municipios` VALUES (47,'ÁGUA COMPRIDA','MG');
INSERT INTO `municipios` VALUES (48,'ÁGUA DOCE','SC');
INSERT INTO `municipios` VALUES (49,'ÁGUA DOCE DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (50,'ÁGUA DOCE DO NORTE','ES');
INSERT INTO `municipios` VALUES (51,'ÁGUA FRIA','BA');
INSERT INTO `municipios` VALUES (52,'ÁGUA FRIA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (53,'ÁGUA LIMPA','GO');
INSERT INTO `municipios` VALUES (54,'ÁGUA NOVA','RN');
INSERT INTO `municipios` VALUES (55,'ÁGUA PRETA','PE');
INSERT INTO `municipios` VALUES (56,'ÁGUA SANTA','RS');
INSERT INTO `municipios` VALUES (57,'ÁGUAI','SP');
INSERT INTO `municipios` VALUES (58,'AGUANIL','MG');
INSERT INTO `municipios` VALUES (59,'ÁGUAS BELAS','PE');
INSERT INTO `municipios` VALUES (60,'ÁGUAS DA PRATA','SP');
INSERT INTO `municipios` VALUES (61,'ÁGUAS DE CHAPECÓ','SC');
INSERT INTO `municipios` VALUES (62,'ÁGUAS DE LINDÓIA','SP');
INSERT INTO `municipios` VALUES (63,'ÁGUAS DE SANTA BÁRBARA','SP');
INSERT INTO `municipios` VALUES (64,'ÁGUAS DE SÃO PEDRO','SP');
INSERT INTO `municipios` VALUES (65,'ÁGUAS FORMOSAS','MG');
INSERT INTO `municipios` VALUES (66,'ÁGUAS FRIAS','SC');
INSERT INTO `municipios` VALUES (67,'ÁGUAS LINDAS','GO');
INSERT INTO `municipios` VALUES (68,'ÁGUAS MORNAS','SC');
INSERT INTO `municipios` VALUES (69,'ÁGUAS VERMELHAS','MG');
INSERT INTO `municipios` VALUES (70,'AGUDO','RS');
INSERT INTO `municipios` VALUES (71,'AGUDOS','SP');
INSERT INTO `municipios` VALUES (72,'AGUDOS  DO SUL','PR');
INSERT INTO `municipios` VALUES (73,'AGUIA BRANCA','ES');
INSERT INTO `municipios` VALUES (74,'AGUIAR','PB');
INSERT INTO `municipios` VALUES (75,'AGUIARNÓPOLIS','TO');
INSERT INTO `municipios` VALUES (76,'AIMORES','MG');
INSERT INTO `municipios` VALUES (77,'AIQUARA','BA');
INSERT INTO `municipios` VALUES (78,'AIUABA','CE');
INSERT INTO `municipios` VALUES (79,'AIURUOCA','MG');
INSERT INTO `municipios` VALUES (80,'AJURICABA','RS');
INSERT INTO `municipios` VALUES (81,'ALAGOA GRANDE','PB');
INSERT INTO `municipios` VALUES (82,'ALAGOA NOVA','PB');
INSERT INTO `municipios` VALUES (83,'ALAGOINHA','PB');
INSERT INTO `municipios` VALUES (84,'ALAGOINHA','PE');
INSERT INTO `municipios` VALUES (85,'ALAGOINHA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (86,'ALAGOINHAS','BA');
INSERT INTO `municipios` VALUES (87,'ALAMBARI','SP');
INSERT INTO `municipios` VALUES (88,'ALBERTINA','MG');
INSERT INTO `municipios` VALUES (89,'ALCANTARA','MA');
INSERT INTO `municipios` VALUES (90,'ALCÂNTARAS','CE');
INSERT INTO `municipios` VALUES (91,'ALCANTIL','PB');
INSERT INTO `municipios` VALUES (92,'ALCINÓPOLIS','MS');
INSERT INTO `municipios` VALUES (93,'ALCOBAÇA','BA');
INSERT INTO `municipios` VALUES (94,'ALDEIAS ALTAS','MA');
INSERT INTO `municipios` VALUES (95,'ALECRIM','RS');
INSERT INTO `municipios` VALUES (96,'ALEGRE','ES');
INSERT INTO `municipios` VALUES (97,'ALEGRETE','RS');
INSERT INTO `municipios` VALUES (98,'ALEGRETE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (99,'ALEGRIA','RS');
INSERT INTO `municipios` VALUES (100,'ALÉM PARAÍBA','MG');
INSERT INTO `municipios` VALUES (101,'ALENQUER','PA');
INSERT INTO `municipios` VALUES (102,'ALEXANDRIA','RN');
INSERT INTO `municipios` VALUES (103,'ALEXANIA','GO');
INSERT INTO `municipios` VALUES (104,'ALFENAS','MG');
INSERT INTO `municipios` VALUES (105,'ALFREDO CHAVES','ES');
INSERT INTO `municipios` VALUES (106,'ALFREDO MARCONDES','SP');
INSERT INTO `municipios` VALUES (107,'ALFREDO VASCONCELOS','MG');
INSERT INTO `municipios` VALUES (108,'ALFREDO WAGNER','SC');
INSERT INTO `municipios` VALUES (109,'ALGODÃO DE JANDAIRA','PB');
INSERT INTO `municipios` VALUES (110,'ALHANDRA','PB');
INSERT INTO `municipios` VALUES (111,'ALIANÇA','PE');
INSERT INTO `municipios` VALUES (112,'ALIANÇA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (113,'ALMADINA','BA');
INSERT INTO `municipios` VALUES (114,'ALMAGE','BA');
INSERT INTO `municipios` VALUES (115,'ALMAS','TO');
INSERT INTO `municipios` VALUES (116,'ALMEIRIM','PA');
INSERT INTO `municipios` VALUES (117,'ALMENARA','MG');
INSERT INTO `municipios` VALUES (118,'ALMINO AFONSO','RN');
INSERT INTO `municipios` VALUES (119,'ALMIRANTE TAMANDARE','PR');
INSERT INTO `municipios` VALUES (120,'ALOÂNDIA','GO');
INSERT INTO `municipios` VALUES (121,'ALPERCATA','MG');
INSERT INTO `municipios` VALUES (122,'ALPESTRE','RS');
INSERT INTO `municipios` VALUES (123,'ALPINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (124,'ALTA FLORESTA','MT');
INSERT INTO `municipios` VALUES (125,'ALTA FLORESTA DO OESTE','RO');
INSERT INTO `municipios` VALUES (126,'ALTAIR','SP');
INSERT INTO `municipios` VALUES (127,'ALTAMIRA','PA');
INSERT INTO `municipios` VALUES (128,'ALTAMIRA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (129,'ALTAMIRA DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (130,'ALTANEIRA','CE');
INSERT INTO `municipios` VALUES (131,'ALTEROSA','MG');
INSERT INTO `municipios` VALUES (132,'ALTINHO','PE');
INSERT INTO `municipios` VALUES (133,'ALTINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (134,'ALTO ALEGRE','RS');
INSERT INTO `municipios` VALUES (135,'ALTO ALEGRE DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (136,'ALTO ARAGUAIA','MT');
INSERT INTO `municipios` VALUES (137,'ALTO BELA VISTA','SC');
INSERT INTO `municipios` VALUES (138,'ALTO BOA VISTA','MT');
INSERT INTO `municipios` VALUES (139,'ALTO CAPARAÓ','MG');
INSERT INTO `municipios` VALUES (140,'ALTO DO RODRIGUES','RN');
INSERT INTO `municipios` VALUES (141,'ALTO FELIZ','RS');
INSERT INTO `municipios` VALUES (142,'ALTO GARÇAS','MT');
INSERT INTO `municipios` VALUES (143,'ALTO HORIZONTE','GO');
INSERT INTO `municipios` VALUES (144,'ALTO JEQUITIBÁ','MG');
INSERT INTO `municipios` VALUES (145,'ALTO LONGA','PI');
INSERT INTO `municipios` VALUES (146,'ALTO PARAGUAI','MT');
INSERT INTO `municipios` VALUES (147,'ALTO PARAISO','RO');
INSERT INTO `municipios` VALUES (148,'ALTO PARAÍSO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (149,'ALTO PARANÁ','PR');
INSERT INTO `municipios` VALUES (150,'ALTO PARNAÍBA','MA');
INSERT INTO `municipios` VALUES (151,'ALTO PIQUIRI','PR');
INSERT INTO `municipios` VALUES (152,'ALTO RIO DOCE','MG');
INSERT INTO `municipios` VALUES (153,'ALTO RIO NOVO','ES');
INSERT INTO `municipios` VALUES (154,'ALTO SANTO','CE');
INSERT INTO `municipios` VALUES (155,'ALTO TAQUARI','MT');
INSERT INTO `municipios` VALUES (156,'ALTONIA','PR');
INSERT INTO `municipios` VALUES (157,'ALTOS','PI');
INSERT INTO `municipios` VALUES (158,'ALUMINIO','SP');
INSERT INTO `municipios` VALUES (159,'ALVARÃES','AM');
INSERT INTO `municipios` VALUES (160,'ALVARENGA','MG');
INSERT INTO `municipios` VALUES (161,'ALVARES FLORENCE','SP');
INSERT INTO `municipios` VALUES (162,'ÁLVARES MACHADO','SP');
INSERT INTO `municipios` VALUES (163,'ÁLVARO DE CARVALHO','SP');
INSERT INTO `municipios` VALUES (164,'ALVINLÂNDIA','SP');
INSERT INTO `municipios` VALUES (165,'ALVINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (166,'ALVORADA','RS');
INSERT INTO `municipios` VALUES (167,'ALVORADA DE MINAS','MG');
INSERT INTO `municipios` VALUES (168,'ALVORADA DO GURGUEIRA','PI');
INSERT INTO `municipios` VALUES (169,'ALVORADA DO NORTE','GO');
INSERT INTO `municipios` VALUES (170,'ALVORADA DO SUL','PR');
INSERT INTO `municipios` VALUES (171,'ALVORADA DO OESTE','RO');
INSERT INTO `municipios` VALUES (172,'AMAJARI','RR');
INSERT INTO `municipios` VALUES (173,'AMAMBAÍ','MS');
INSERT INTO `municipios` VALUES (174,'AMAPÁ','AP');
INSERT INTO `municipios` VALUES (175,'AMAPÁ DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (176,'AMAPORÃ','PR');
INSERT INTO `municipios` VALUES (177,'AMARAJI','PE');
INSERT INTO `municipios` VALUES (178,'AMARAL FERRADOR','RS');
INSERT INTO `municipios` VALUES (179,'AMARALINA','GO');
INSERT INTO `municipios` VALUES (180,'AMARANTE','PI');
INSERT INTO `municipios` VALUES (181,'AMARANTE DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (182,'AMARGOSA','BA');
INSERT INTO `municipios` VALUES (183,'AMATURÁ','AM');
INSERT INTO `municipios` VALUES (184,'AMAZONAS','PR');
INSERT INTO `municipios` VALUES (185,'AMÉLIA RODRIGUES','BA');
INSERT INTO `municipios` VALUES (186,'AMÉRICA DOURADA','BA');
INSERT INTO `municipios` VALUES (187,'AMÉRICANA','SP');
INSERT INTO `municipios` VALUES (188,'AMÉRICANO DO BRASIL','GO');
INSERT INTO `municipios` VALUES (189,'AMÉRICO BRASILIENSE','SP');
INSERT INTO `municipios` VALUES (190,'AMÉRICO DE CAMPOS','SP');
INSERT INTO `municipios` VALUES (191,'AMETISTA DO SUL','RS');
INSERT INTO `municipios` VALUES (192,'AMONTADA','CE');
INSERT INTO `municipios` VALUES (193,'AMORINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (194,'AMPARO','PB');
INSERT INTO `municipios` VALUES (195,'AMPARO','SP');
INSERT INTO `municipios` VALUES (196,'AMPARO DA SERRA','MG');
INSERT INTO `municipios` VALUES (197,'AMPARO DE SÃO FRANCISCO','SE');
INSERT INTO `municipios` VALUES (198,'AMPÉRE','PR');
INSERT INTO `municipios` VALUES (199,'ANADIA','AL');
INSERT INTO `municipios` VALUES (200,'ANAGÉ','BA');
INSERT INTO `municipios` VALUES (201,'ANAHY','PR');
INSERT INTO `municipios` VALUES (202,'ANAJÁS','PA');
INSERT INTO `municipios` VALUES (203,'ANAJATUBA','MA');
INSERT INTO `municipios` VALUES (204,'ANALÂNDIA','SP');
INSERT INTO `municipios` VALUES (205,'ANAMA','AM');
INSERT INTO `municipios` VALUES (206,'ANANÁS','TO');
INSERT INTO `municipios` VALUES (207,'ANANINDEUA','PA');
INSERT INTO `municipios` VALUES (208,'ANÁPOLIS','GO');
INSERT INTO `municipios` VALUES (209,'ANAPU','PA');
INSERT INTO `municipios` VALUES (210,'ANAPURUS','MA');
INSERT INTO `municipios` VALUES (211,'ANASTÁCIO','MS');
INSERT INTO `municipios` VALUES (212,'ANAURILÂNDIA','MS');
INSERT INTO `municipios` VALUES (213,'ANCHIETA','ES');
INSERT INTO `municipios` VALUES (214,'ANDARAI','BA');
INSERT INTO `municipios` VALUES (215,'ANDIRA','PR');
INSERT INTO `municipios` VALUES (216,'ANDORINHA','BA');
INSERT INTO `municipios` VALUES (217,'ANDRADAS','MG');
INSERT INTO `municipios` VALUES (218,'ANDRADINA','SP');
INSERT INTO `municipios` VALUES (219,'ANDRÉ DA ROCHA','RS');
INSERT INTO `municipios` VALUES (220,'ANDRELÂNDIA','MG');
INSERT INTO `municipios` VALUES (221,'ANGATUBA','SP');
INSERT INTO `municipios` VALUES (222,'ANGELÂNDIA','MG');
INSERT INTO `municipios` VALUES (223,'ANGÉLICA','MS');
INSERT INTO `municipios` VALUES (224,'ANGELIM','PE');
INSERT INTO `municipios` VALUES (225,'ANGELINA','SC');
INSERT INTO `municipios` VALUES (226,'ANGICAL','BA');
INSERT INTO `municipios` VALUES (227,'ANGICAL DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (228,'ANGICO','TO');
INSERT INTO `municipios` VALUES (229,'ANGICOS','RN');
INSERT INTO `municipios` VALUES (230,'ANGRA DOS REIS','RJ');
INSERT INTO `municipios` VALUES (231,'ANGUERA','BA');
INSERT INTO `municipios` VALUES (232,'ANGULO','PR');
INSERT INTO `municipios` VALUES (233,'ANHANGUERA','GO');
INSERT INTO `municipios` VALUES (234,'ANHEMBI','SP');
INSERT INTO `municipios` VALUES (235,'ANHUMAS','SP');
INSERT INTO `municipios` VALUES (236,'ANICUNS','GO');
INSERT INTO `municipios` VALUES (237,'ANISIO DE ABREU','PI');
INSERT INTO `municipios` VALUES (238,'ANITA GARIBALDI','SC');
INSERT INTO `municipios` VALUES (239,'ANITAPOLIS','SC');
INSERT INTO `municipios` VALUES (240,'ANORI','AM');
INSERT INTO `municipios` VALUES (241,'ANTA GORDA','RS');
INSERT INTO `municipios` VALUES (242,'ANTAS','BA');
INSERT INTO `municipios` VALUES (243,'ANTONINA','PR');
INSERT INTO `municipios` VALUES (244,'ANTONINA DO NORTE','CE');
INSERT INTO `municipios` VALUES (245,'ANTÔNIO ALMEIDA','PI');
INSERT INTO `municipios` VALUES (246,'ANTÔNIO CARDOSO','BA');
INSERT INTO `municipios` VALUES (247,'ANTÔNIO CARLOS','MG');
INSERT INTO `municipios` VALUES (248,'ANTÔNIO DIAS','MG');
INSERT INTO `municipios` VALUES (249,'ANTÔNIO GONÇALVES','BA');
INSERT INTO `municipios` VALUES (250,'ANTÔNIO JOÃO','MS');
INSERT INTO `municipios` VALUES (251,'ANTÔNIO MARTINS','RN');
INSERT INTO `municipios` VALUES (252,'ANTÔNIO OLINTO','PR');
INSERT INTO `municipios` VALUES (253,'ANTÔNIO PRADO','RS');
INSERT INTO `municipios` VALUES (254,'ANTÔNIO PRADO DE MINAS','MG');
INSERT INTO `municipios` VALUES (255,'APARECIDA','PB');
INSERT INTO `municipios` VALUES (256,'APARECIDA','SP');
INSERT INTO `municipios` VALUES (257,'APARECIDA DE GOIANIA','GO');
INSERT INTO `municipios` VALUES (258,'APARECIDA DO RIO DOCE','GO');
INSERT INTO `municipios` VALUES (259,'APARECIDA DO RIO NEGRO','TO');
INSERT INTO `municipios` VALUES (260,'APARECIDA DO TABOADO','MS');
INSERT INTO `municipios` VALUES (261,'APARECIDA DO OESTE','SP');
INSERT INTO `municipios` VALUES (262,'APERIBÉ','RJ');
INSERT INTO `municipios` VALUES (263,'APIACA','ES');
INSERT INTO `municipios` VALUES (264,'APIACÁS','MT');
INSERT INTO `municipios` VALUES (265,'APIAÍ','SP');
INSERT INTO `municipios` VALUES (266,'APICUM AÇU','MA');
INSERT INTO `municipios` VALUES (267,'APIUNA','SC');
INSERT INTO `municipios` VALUES (268,'APODI','RN');
INSERT INTO `municipios` VALUES (269,'APORA','BA');
INSERT INTO `municipios` VALUES (270,'APORE','GO');
INSERT INTO `municipios` VALUES (271,'APUAREMA','BA');
INSERT INTO `municipios` VALUES (272,'APUCARANA','PR');
INSERT INTO `municipios` VALUES (273,'APUI','AM');
INSERT INTO `municipios` VALUES (274,'APUIARÉS','CE');
INSERT INTO `municipios` VALUES (275,'AQUIDABÃ','SE');
INSERT INTO `municipios` VALUES (276,'AQUIDAUANA','MS');
INSERT INTO `municipios` VALUES (277,'AQUIRAZ','CE');
INSERT INTO `municipios` VALUES (278,'ARABUTÃ','SC');
INSERT INTO `municipios` VALUES (279,'ARAÇAGI','PB');
INSERT INTO `municipios` VALUES (280,'ARAÇAI','MG');
INSERT INTO `municipios` VALUES (281,'ARACAJU','SE');
INSERT INTO `municipios` VALUES (282,'ARAÇARIGUAMA','SP');
INSERT INTO `municipios` VALUES (283,'ARAÇAS','BA');
INSERT INTO `municipios` VALUES (284,'ARAÇATI','CE');
INSERT INTO `municipios` VALUES (285,'ARAÇATU','BA');
INSERT INTO `municipios` VALUES (286,'ARAÇATUBA','SP');
INSERT INTO `municipios` VALUES (287,'ARACI','BA');
INSERT INTO `municipios` VALUES (288,'ARACITABA','MG');
INSERT INTO `municipios` VALUES (289,'ARACOIABA','CE');
INSERT INTO `municipios` VALUES (290,'ARAÇOIABA','PE');
INSERT INTO `municipios` VALUES (291,'ARAÇOIABA DA SERRA','SP');
INSERT INTO `municipios` VALUES (292,'ARACRUZ','ES');
INSERT INTO `municipios` VALUES (293,'ARAÇU','GO');
INSERT INTO `municipios` VALUES (294,'ARAÇUAI','MG');
INSERT INTO `municipios` VALUES (295,'ARAGARÇAS','GO');
INSERT INTO `municipios` VALUES (296,'ARAGOIANIA','GO');
INSERT INTO `municipios` VALUES (297,'ARAGOMINAS','TO');
INSERT INTO `municipios` VALUES (298,'ARÁGUACEMA','TO');
INSERT INTO `municipios` VALUES (299,'ARAGUAÇU','TO');
INSERT INTO `municipios` VALUES (300,'ARÁGUAIANA','MT');
INSERT INTO `municipios` VALUES (301,'ARÁGUAINA','TO');
INSERT INTO `municipios` VALUES (302,'ARAGUANÃ','MA');
INSERT INTO `municipios` VALUES (303,'ARÁGUAPAZ','GO');
INSERT INTO `municipios` VALUES (304,'ARÁGUARI','MG');
INSERT INTO `municipios` VALUES (305,'ARÁGUATINS','TO');
INSERT INTO `municipios` VALUES (306,'ARAIOSES','MA');
INSERT INTO `municipios` VALUES (307,'ARAL MOREIRA','MS');
INSERT INTO `municipios` VALUES (308,'ARAMARI','BA');
INSERT INTO `municipios` VALUES (309,'ARAMBARÉ','RS');
INSERT INTO `municipios` VALUES (310,'ARAME','MA');
INSERT INTO `municipios` VALUES (311,'ARAMINA','SP');
INSERT INTO `municipios` VALUES (312,'ARANDU','SP');
INSERT INTO `municipios` VALUES (313,'ARANTINA','MG');
INSERT INTO `municipios` VALUES (314,'ARAPEI','SP');
INSERT INTO `municipios` VALUES (315,'ARAPIRACA','AL');
INSERT INTO `municipios` VALUES (316,'ARAPIRINA','PE');
INSERT INTO `municipios` VALUES (317,'ARAPOEMA','TO');
INSERT INTO `municipios` VALUES (318,'ARAPONGA','MG');
INSERT INTO `municipios` VALUES (319,'ARAPONGAS','PR');
INSERT INTO `municipios` VALUES (320,'ARAPORA','MG');
INSERT INTO `municipios` VALUES (321,'ARAPOTI','PR');
INSERT INTO `municipios` VALUES (322,'ARAPUA','MG');
INSERT INTO `municipios` VALUES (323,'ARAPUTANGA','MT');
INSERT INTO `municipios` VALUES (324,'ARAQUARI','SC');
INSERT INTO `municipios` VALUES (325,'ARARA','PB');
INSERT INTO `municipios` VALUES (326,'ARARANGUA','SC');
INSERT INTO `municipios` VALUES (327,'ARARAQUARA','SP');
INSERT INTO `municipios` VALUES (328,'ARARAS','SP');
INSERT INTO `municipios` VALUES (329,'ARARENDÁ','CE');
INSERT INTO `municipios` VALUES (330,'ARARICÁ','RS');
INSERT INTO `municipios` VALUES (331,'ARARIPE','CE');
INSERT INTO `municipios` VALUES (332,'ARARIPINA','PE');
INSERT INTO `municipios` VALUES (333,'ARARUAMA','RJ');
INSERT INTO `municipios` VALUES (334,'ARARUNA','PR');
INSERT INTO `municipios` VALUES (335,'ARATACA','BA');
INSERT INTO `municipios` VALUES (336,'ARATIBA','RS');
INSERT INTO `municipios` VALUES (337,'ARATUBA','CE');
INSERT INTO `municipios` VALUES (338,'ARATUIPE','BA');
INSERT INTO `municipios` VALUES (339,'ARAUÁ','SE');
INSERT INTO `municipios` VALUES (340,'ARAUCARIA','PR');
INSERT INTO `municipios` VALUES (341,'ARAUJOS','MG');
INSERT INTO `municipios` VALUES (342,'ARAXA','MG');
INSERT INTO `municipios` VALUES (343,'ARCEBURGO','MG');
INSERT INTO `municipios` VALUES (344,'ARCO IRIS','SP');
INSERT INTO `municipios` VALUES (345,'ARCOS','MG');
INSERT INTO `municipios` VALUES (346,'ARCOVERDE','PE');
INSERT INTO `municipios` VALUES (347,'AREADO','MG');
INSERT INTO `municipios` VALUES (348,'AREAL','RJ');
INSERT INTO `municipios` VALUES (349,'AREALVA','SP');
INSERT INTO `municipios` VALUES (350,'AREIA','PB');
INSERT INTO `municipios` VALUES (351,'AREIA BRANCA','RN');
INSERT INTO `municipios` VALUES (352,'AREIA BRANCA','SE');
INSERT INTO `municipios` VALUES (353,'AREIA DE BARAÚNAS','PB');
INSERT INTO `municipios` VALUES (354,'AREIAL','PB');
INSERT INTO `municipios` VALUES (355,'AREIAS','SP');
INSERT INTO `municipios` VALUES (356,'AREIÓPOLIS','SP');
INSERT INTO `municipios` VALUES (357,'ARENÁPOLIS','MT');
INSERT INTO `municipios` VALUES (358,'ARENÓPOLIS','GO');
INSERT INTO `municipios` VALUES (359,'ARES','RN');
INSERT INTO `municipios` VALUES (360,'ARGIRITA','MG');
INSERT INTO `municipios` VALUES (361,'ARICANDUVA','MG');
INSERT INTO `municipios` VALUES (362,'ARINOS','MG');
INSERT INTO `municipios` VALUES (363,'ARIPUANÃ','MT');
INSERT INTO `municipios` VALUES (364,'ARIQUEMES','RO');
INSERT INTO `municipios` VALUES (365,'ARIRANHA','SP');
INSERT INTO `municipios` VALUES (366,'ARIRANHA DO IVAI','PR');
INSERT INTO `municipios` VALUES (367,'ARMAÇÃO DE BÚZIOS','RJ');
INSERT INTO `municipios` VALUES (368,'ARMAZEM','SC');
INSERT INTO `municipios` VALUES (369,'ARNEIROZ','CE');
INSERT INTO `municipios` VALUES (370,'AROAZES','PI');
INSERT INTO `municipios` VALUES (371,'AROEIRAS','PB');
INSERT INTO `municipios` VALUES (372,'ARRAIAL','PI');
INSERT INTO `municipios` VALUES (373,'ARRAIAL DO CABO','RJ');
INSERT INTO `municipios` VALUES (374,'ARRAIAS','TO');
INSERT INTO `municipios` VALUES (375,'ARROIO DO MEIO','RS');
INSERT INTO `municipios` VALUES (376,'ARROIO DO PADRE','RS');
INSERT INTO `municipios` VALUES (377,'ARROIO DO SAL','RS');
INSERT INTO `municipios` VALUES (378,'ARROIO DO TIGRE','RS');
INSERT INTO `municipios` VALUES (379,'ARROIO DOS RATOS','RS');
INSERT INTO `municipios` VALUES (380,'ARROIO GRANDE','RS');
INSERT INTO `municipios` VALUES (381,'ARROIO TRINTA','SC');
INSERT INTO `municipios` VALUES (382,'ARTUR NOGUEIRA','SP');
INSERT INTO `municipios` VALUES (383,'ARUANA','GO');
INSERT INTO `municipios` VALUES (384,'ARUJA','SP');
INSERT INTO `municipios` VALUES (385,'ARUNA','GO');
INSERT INTO `municipios` VALUES (386,'ARVOREDO','SC');
INSERT INTO `municipios` VALUES (387,'ARVOREZINHA','RS');
INSERT INTO `municipios` VALUES (388,'ASCURRA','SC');
INSERT INTO `municipios` VALUES (389,'ASPÁSIA','SP');
INSERT INTO `municipios` VALUES (390,'ASSAÍ','PR');
INSERT INTO `municipios` VALUES (391,'ASSARE','CE');
INSERT INTO `municipios` VALUES (392,'ASSIS','SP');
INSERT INTO `municipios` VALUES (393,'ASSIS BRASIL','AC');
INSERT INTO `municipios` VALUES (394,'ASSIS CHATEAUBRIAND','PR');
INSERT INTO `municipios` VALUES (395,'ASSUNCÃO','PB');
INSERT INTO `municipios` VALUES (396,'ASSUNÇÃO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (397,'ASTOLFO DUTRA','MG');
INSERT INTO `municipios` VALUES (398,'ASTORGA','PR');
INSERT INTO `municipios` VALUES (399,'ATALAIA','AL');
INSERT INTO `municipios` VALUES (400,'ATALAIA','PR');
INSERT INTO `municipios` VALUES (401,'ATALAIA DO NORTE','AM');
INSERT INTO `municipios` VALUES (402,'ATALANTA','SC');
INSERT INTO `municipios` VALUES (403,'ATALEIA','MG');
INSERT INTO `municipios` VALUES (404,'ATIBAIA','SP');
INSERT INTO `municipios` VALUES (405,'ATILIO VIVACQUA','ES');
INSERT INTO `municipios` VALUES (406,'AUGUSTINÓPOLIS','TO');
INSERT INTO `municipios` VALUES (407,'AUGUSTO CORRÊA','PA');
INSERT INTO `municipios` VALUES (408,'AUGUSTO DE LIMA','MG');
INSERT INTO `municipios` VALUES (409,'AUGUSTO PESTANA','RS');
INSERT INTO `municipios` VALUES (410,'AUREA','RS');
INSERT INTO `municipios` VALUES (411,'AURELINO LEAL','BA');
INSERT INTO `municipios` VALUES (412,'AURIFLAMA','SP');
INSERT INTO `municipios` VALUES (413,'AURILÂNDIA','GO');
INSERT INTO `municipios` VALUES (414,'AURORA','CE');
INSERT INTO `municipios` VALUES (415,'AURORA','SC');
INSERT INTO `municipios` VALUES (416,'AURORA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (417,'AURORA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (418,'AUTAZES','AM');
INSERT INTO `municipios` VALUES (419,'AVAI','SP');
INSERT INTO `municipios` VALUES (420,'AVANHANDAVA','SP');
INSERT INTO `municipios` VALUES (421,'AVARE','SP');
INSERT INTO `municipios` VALUES (422,'AVEIRO','PA');
INSERT INTO `municipios` VALUES (423,'AVELINO LOPES','PI');
INSERT INTO `municipios` VALUES (424,'AVELINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (425,'AXIXA','MA');
INSERT INTO `municipios` VALUES (426,'AXIXÁ DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (427,'BABAÇULÂNDIA','TO');
INSERT INTO `municipios` VALUES (428,'BACABAL','MA');
INSERT INTO `municipios` VALUES (429,'BACURI','MA');
INSERT INTO `municipios` VALUES (430,'BAÇURITUBA','MA');
INSERT INTO `municipios` VALUES (431,'BADY BASSITT','SP');
INSERT INTO `municipios` VALUES (432,'BAEPENDI','MG');
INSERT INTO `municipios` VALUES (433,'BAGÉ','RS');
INSERT INTO `municipios` VALUES (434,'BAGRE','PA');
INSERT INTO `municipios` VALUES (435,'BAIA DA TRAICÃO','PB');
INSERT INTO `municipios` VALUES (436,'BAIA FORMOSA','RN');
INSERT INTO `municipios` VALUES (437,'BAIANÓPOLIS','BA');
INSERT INTO `municipios` VALUES (438,'BAIÃO','PA');
INSERT INTO `municipios` VALUES (439,'BAIRRA DALCANTARA','PI');
INSERT INTO `municipios` VALUES (440,'BAIXA GRANDE','BA');
INSERT INTO `municipios` VALUES (441,'BAIXA GRANDE DO RIBEIRO','PI');
INSERT INTO `municipios` VALUES (442,'BAIXIO','CE');
INSERT INTO `municipios` VALUES (443,'BAIXO GUANDU','ES');
INSERT INTO `municipios` VALUES (444,'BALBINOS','SP');
INSERT INTO `municipios` VALUES (445,'BALDIM','MG');
INSERT INTO `municipios` VALUES (446,'BALIZA','GO');
INSERT INTO `municipios` VALUES (447,'BALNEÁRIO BARRA DO SUL','SC');
INSERT INTO `municipios` VALUES (448,'BALNEÁRIO CAMBORIÚ','SC');
INSERT INTO `municipios` VALUES (449,'BALNEÁRIO GAIVOTA','SC');
INSERT INTO `municipios` VALUES (450,'BALNEÁRIO PINHAL','RS');
INSERT INTO `municipios` VALUES (451,'BALSA NOVA','PR');
INSERT INTO `municipios` VALUES (452,'BALSAMO','SP');
INSERT INTO `municipios` VALUES (453,'BALSAS','MA');
INSERT INTO `municipios` VALUES (454,'BAMBUI','MG');
INSERT INTO `municipios` VALUES (455,'BANABUIU','CE');
INSERT INTO `municipios` VALUES (456,'BANANAL','SP');
INSERT INTO `municipios` VALUES (457,'BANANEIRAS','PB');
INSERT INTO `municipios` VALUES (458,'BANDEIRA','MG');
INSERT INTO `municipios` VALUES (459,'BANDEIRA DO SUL','MG');
INSERT INTO `municipios` VALUES (460,'BANDEIRANTE','TO');
INSERT INTO `municipios` VALUES (461,'BANDEIRANTES','MS');
INSERT INTO `municipios` VALUES (462,'BANNACH','PA');
INSERT INTO `municipios` VALUES (463,'BANZAE','BA');
INSERT INTO `municipios` VALUES (464,'BARÃO','RS');
INSERT INTO `municipios` VALUES (465,'BARÃO DE ANTONINA','SP');
INSERT INTO `municipios` VALUES (466,'BARÃO DE COCAIS','MG');
INSERT INTO `municipios` VALUES (467,'BARÃO DE COTEGIPE','RS');
INSERT INTO `municipios` VALUES (468,'BARÃO DE MELGAÇO','MT');
INSERT INTO `municipios` VALUES (469,'BARÃO DE MONTE ALTO','MG');
INSERT INTO `municipios` VALUES (470,'BARÃO DO GRAJAÚ','MA');
INSERT INTO `municipios` VALUES (471,'BARÃO DO TRIUNFO','RS');
INSERT INTO `municipios` VALUES (472,'BARAÚNA','PB');
INSERT INTO `municipios` VALUES (473,'BARBACENA','MG');
INSERT INTO `municipios` VALUES (474,'BARBALHA','CE');
INSERT INTO `municipios` VALUES (475,'BARBOSA','SP');
INSERT INTO `municipios` VALUES (476,'BARBOSA FERRAZ','PR');
INSERT INTO `municipios` VALUES (477,'BARCELONA','RN');
INSERT INTO `municipios` VALUES (478,'BARCELOS','AM');
INSERT INTO `municipios` VALUES (479,'BARIRI','SP');
INSERT INTO `municipios` VALUES (480,'BARRA','BA');
INSERT INTO `municipios` VALUES (481,'BARRA BONITA','SC');
INSERT INTO `municipios` VALUES (482,'BARRA DA ESTIVA','BA');
INSERT INTO `municipios` VALUES (483,'BARRA DE GUABIRABA','PE');
INSERT INTO `municipios` VALUES (484,'BARRA DE SANTA ROSA','PB');
INSERT INTO `municipios` VALUES (485,'BARRA DE SANTANA','PB');
INSERT INTO `municipios` VALUES (486,'BARRA DE SANTO ANTÔNIO','AL');
INSERT INTO `municipios` VALUES (487,'BARRA DE SÃO FRANCISCO','ES');
INSERT INTO `municipios` VALUES (488,'BARRA DE SÃO MIGUEL','AL');
INSERT INTO `municipios` VALUES (489,'BARRA DO BUGRES','MT');
INSERT INTO `municipios` VALUES (490,'BARRA DO CHAPÉU','SP');
INSERT INTO `municipios` VALUES (491,'BARRA DO CHOCA','BA');
INSERT INTO `municipios` VALUES (492,'BARRA DO CORDA','MA');
INSERT INTO `municipios` VALUES (493,'BARRA DO GARÇAS','MT');
INSERT INTO `municipios` VALUES (494,'BARRA DO GUARITA','RS');
INSERT INTO `municipios` VALUES (495,'BARRA DO JACARÉ','PR');
INSERT INTO `municipios` VALUES (496,'BARRA DO MENDES','BA');
INSERT INTO `municipios` VALUES (497,'BARRA DO OURO','TO');
INSERT INTO `municipios` VALUES (498,'BARRA DO PIRAÍ','RJ');
INSERT INTO `municipios` VALUES (499,'BARRA DO QUARAI','RS');
INSERT INTO `municipios` VALUES (500,'BARRA DO RIBEIRO','RS');
INSERT INTO `municipios` VALUES (501,'BARRA DO RIO AZUL','RS');
INSERT INTO `municipios` VALUES (502,'BARRA DO ROCHA','BA');
INSERT INTO `municipios` VALUES (503,'BARRA DO TURVO','SP');
INSERT INTO `municipios` VALUES (504,'BARRA DOS COQUEIROS','SE');
INSERT INTO `municipios` VALUES (505,'BARRA FUNDA','RS');
INSERT INTO `municipios` VALUES (506,'BARRA LONGA','MG');
INSERT INTO `municipios` VALUES (507,'BARRA MANSA','RJ');
INSERT INTO `municipios` VALUES (508,'BARRA VELHA','SC');
INSERT INTO `municipios` VALUES (509,'BARRACÃO','PR');
INSERT INTO `municipios` VALUES (510,'BARRAÇÃO','RS');
INSERT INTO `municipios` VALUES (511,'BARRAS','PI');
INSERT INTO `municipios` VALUES (512,'BARREIRA','CE');
INSERT INTO `municipios` VALUES (513,'BARREIRAS','BA');
INSERT INTO `municipios` VALUES (514,'BARREIRAS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (515,'BARREIRINHA','AM');
INSERT INTO `municipios` VALUES (516,'BARREIRINHAS','MA');
INSERT INTO `municipios` VALUES (517,'BARREIROS','PE');
INSERT INTO `municipios` VALUES (518,'BARRERAS','PE');
INSERT INTO `municipios` VALUES (519,'BARRETOS','SP');
INSERT INTO `municipios` VALUES (520,'BARRINHA','SP');
INSERT INTO `municipios` VALUES (521,'BARRO','CE');
INSERT INTO `municipios` VALUES (522,'BARRO ALTO','BA');
INSERT INTO `municipios` VALUES (523,'BARRO DURO','PI');
INSERT INTO `municipios` VALUES (524,'BARRO PRETO','BA');
INSERT INTO `municipios` VALUES (525,'BARROLÂNDIA','TO');
INSERT INTO `municipios` VALUES (526,'BARROQUINHA','CE');
INSERT INTO `municipios` VALUES (527,'BARROS CASSAL','RS');
INSERT INTO `municipios` VALUES (528,'BARROSO','MG');
INSERT INTO `municipios` VALUES (529,'BARUERI','SP');
INSERT INTO `municipios` VALUES (530,'BASTOS','SP');
INSERT INTO `municipios` VALUES (531,'BATÁGUASSU','MS');
INSERT INTO `municipios` VALUES (532,'BATAIPORA','MS');
INSERT INTO `municipios` VALUES (533,'BATALHA','AL');
INSERT INTO `municipios` VALUES (534,'BATATAIS','SP');
INSERT INTO `municipios` VALUES (535,'BATURITE','CE');
INSERT INTO `municipios` VALUES (536,'BAURU','SP');
INSERT INTO `municipios` VALUES (537,'BAYEUX','PB');
INSERT INTO `municipios` VALUES (538,'BEBEDOURO','SP');
INSERT INTO `municipios` VALUES (539,'BEBERIBE','CE');
INSERT INTO `municipios` VALUES (540,'BELA CRUZ','CE');
INSERT INTO `municipios` VALUES (541,'BELA VISTA','MG');
INSERT INTO `municipios` VALUES (542,'BELA VISTA','MS');
INSERT INTO `municipios` VALUES (543,'BELA VISTA DA CAROBA','PR');
INSERT INTO `municipios` VALUES (544,'BELA VISTA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (545,'BELA VISTA DE MINAS','MG');
INSERT INTO `municipios` VALUES (546,'BELA VISTA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (547,'BELA VISTA DO TOLDO','SC');
INSERT INTO `municipios` VALUES (548,'BELA VISTA DO PARAÍSO','PR');
INSERT INTO `municipios` VALUES (549,'BELÁGUA','MA');
INSERT INTO `municipios` VALUES (550,'BELEM','PA');
INSERT INTO `municipios` VALUES (551,'BELÉM','PB');
INSERT INTO `municipios` VALUES (552,'BELÉM','AL');
INSERT INTO `municipios` VALUES (553,'BELÉM DE MARIA','PE');
INSERT INTO `municipios` VALUES (554,'BELÉM DE SÃO FRANCISCO','PE');
INSERT INTO `municipios` VALUES (555,'BELÉM DO BREJO DO CRUZ','PB');
INSERT INTO `municipios` VALUES (556,'BELÉM DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (557,'BELFORD ROXO','RJ');
INSERT INTO `municipios` VALUES (558,'BELMIRO BRAGA','MG');
INSERT INTO `municipios` VALUES (559,'BELMONTE','BA');
INSERT INTO `municipios` VALUES (560,'BELO CAMPO','BA');
INSERT INTO `municipios` VALUES (561,'BELO HORIZONTE','MG');
INSERT INTO `municipios` VALUES (562,'BELO JARDIM','PE');
INSERT INTO `municipios` VALUES (563,'BELO MONTE','AL');
INSERT INTO `municipios` VALUES (564,'BELO ORIENTE','MG');
INSERT INTO `municipios` VALUES (565,'BELO VALE','MG');
INSERT INTO `municipios` VALUES (566,'BELTERRA','PA');
INSERT INTO `municipios` VALUES (567,'BENEDITINOS','PI');
INSERT INTO `municipios` VALUES (568,'BENEDITO LEITE','MA');
INSERT INTO `municipios` VALUES (569,'BENEDITO NOVO','SC');
INSERT INTO `municipios` VALUES (570,'BENEVIDES','PA');
INSERT INTO `municipios` VALUES (571,'BENJAMIN CONSTANT DO SUL','RS');
INSERT INTO `municipios` VALUES (572,'BENJAMIN CONSTANT','AM');
INSERT INTO `municipios` VALUES (573,'BENTO DE ABREU','SP');
INSERT INTO `municipios` VALUES (574,'BENTO FERNANDES','RN');
INSERT INTO `municipios` VALUES (575,'BENTO GONÇALVES','RS');
INSERT INTO `municipios` VALUES (576,'BEQUIMÃO','MA');
INSERT INTO `municipios` VALUES (577,'BERILO','MG');
INSERT INTO `municipios` VALUES (578,'BERIZAL','MG');
INSERT INTO `municipios` VALUES (579,'BERNARDINO BATISTA','PB');
INSERT INTO `municipios` VALUES (580,'BERNARDINO DE CAMPOS','SP');
INSERT INTO `municipios` VALUES (581,'BERNARDO SAYÃO','TO');
INSERT INTO `municipios` VALUES (582,'BERTIOGA','SP');
INSERT INTO `municipios` VALUES (583,'BERTOLÍNIA','PI');
INSERT INTO `municipios` VALUES (584,'BERTÓPOLIS','MG');
INSERT INTO `municipios` VALUES (585,'BERURI','AM');
INSERT INTO `municipios` VALUES (586,'BETANIA','PE');
INSERT INTO `municipios` VALUES (587,'BETANIA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (588,'BETIM','MG');
INSERT INTO `municipios` VALUES (589,'BEZERROS','PE');
INSERT INTO `municipios` VALUES (590,'BIAS FORTES','MG');
INSERT INTO `municipios` VALUES (591,'BICAS','MG');
INSERT INTO `municipios` VALUES (592,'BIGUAÇU','SC');
INSERT INTO `municipios` VALUES (593,'BILAC','SP');
INSERT INTO `municipios` VALUES (594,'BIQUINHAS','MG');
INSERT INTO `municipios` VALUES (595,'BIRIGUI','SP');
INSERT INTO `municipios` VALUES (596,'BIRITIBA-MIRIM','SP');
INSERT INTO `municipios` VALUES (597,'BIRITINGA','BA');
INSERT INTO `municipios` VALUES (598,'BITURUNA','PR');
INSERT INTO `municipios` VALUES (599,'BLUMENAU','SC');
INSERT INTO `municipios` VALUES (600,'BOA ESPERANÇA','ES');
INSERT INTO `municipios` VALUES (601,'BOA ESPERANÇA','PR');
INSERT INTO `municipios` VALUES (602,'BOA ESPERANÇA DO SUL','SP');
INSERT INTO `municipios` VALUES (603,'BOA ESPERANÇA DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (604,'BOA HORA','PI');
INSERT INTO `municipios` VALUES (605,'BOA NOVA','BA');
INSERT INTO `municipios` VALUES (606,'BOA SAÚDE','RN');
INSERT INTO `municipios` VALUES (607,'BOA VENTURA','PB');
INSERT INTO `municipios` VALUES (608,'BOA VENTURA DE SÃO ROQUE','PR');
INSERT INTO `municipios` VALUES (609,'BOA VIAGEM','CE');
INSERT INTO `municipios` VALUES (610,'BOA VISTA','PB');
INSERT INTO `municipios` VALUES (611,'BOA VISTA','RR');
INSERT INTO `municipios` VALUES (612,'BOA VISTA DA APARECIDA','PR');
INSERT INTO `municipios` VALUES (613,'BOA VISTA DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (614,'BOA VISTA DO BURICA','RS');
INSERT INTO `municipios` VALUES (615,'BOA VISTA DO GURUPI','MA');
INSERT INTO `municipios` VALUES (616,'BOA VISTA DO RAMOS','AM');
INSERT INTO `municipios` VALUES (617,'BOA VISTA DO SUL','RS');
INSERT INTO `municipios` VALUES (618,'BOA VISTA DO TUPIM','BA');
INSERT INTO `municipios` VALUES (619,'BOCA DA MATA','AL');
INSERT INTO `municipios` VALUES (620,'BOCA DO ACRE','AM');
INSERT INTO `municipios` VALUES (621,'BOCAINA','PI');
INSERT INTO `municipios` VALUES (622,'BOCAINA DE MINAS','MG');
INSERT INTO `municipios` VALUES (623,'BOCAINA DO SUL','SC');
INSERT INTO `municipios` VALUES (624,'BOCAIUVA','MG');
INSERT INTO `municipios` VALUES (625,'BOCAIUVA DO SUL','PR');
INSERT INTO `municipios` VALUES (626,'BODO','RN');
INSERT INTO `municipios` VALUES (627,'BODOCO','PE');
INSERT INTO `municipios` VALUES (628,'BODOQUENA','MS');
INSERT INTO `municipios` VALUES (629,'BOFETE','SP');
INSERT INTO `municipios` VALUES (630,'BOITUVA','SP');
INSERT INTO `municipios` VALUES (631,'BOM CAVATI','MG');
INSERT INTO `municipios` VALUES (632,'BOM CONSELHO','PE');
INSERT INTO `municipios` VALUES (633,'BOM DESPACHO','MG');
INSERT INTO `municipios` VALUES (634,'BOM JARDIM','MA');
INSERT INTO `municipios` VALUES (635,'BOM JARDIM DA SERRA','SC');
INSERT INTO `municipios` VALUES (636,'BOM JARDIM DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (637,'BOM JARDIM DE MINAS','MG');
INSERT INTO `municipios` VALUES (638,'BOM JESUS','PB');
INSERT INTO `municipios` VALUES (639,'BOM JESUS','SC');
INSERT INTO `municipios` VALUES (640,'BOM JESUS DE ITABAPOANA','RJ');
INSERT INTO `municipios` VALUES (641,'BOM JESUS DA LAPA','BA');
INSERT INTO `municipios` VALUES (642,'BOM JESUS DA PENHA','MG');
INSERT INTO `municipios` VALUES (643,'BOM JESUS DA SERRA','BA');
INSERT INTO `municipios` VALUES (644,'BOM JESUS DAS SELVAS','MA');
INSERT INTO `municipios` VALUES (645,'BOM JESUS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (646,'BOM JESUS DO AMPARO','MG');
INSERT INTO `municipios` VALUES (647,'BOM JESUS DO GALHO','MG');
INSERT INTO `municipios` VALUES (648,'BOM JESUS DO NORTE','ES');
INSERT INTO `municipios` VALUES (649,'BOM JESUS DO OESTE','SC');
INSERT INTO `municipios` VALUES (650,'BOM JESUS DO TOCANTINS','PA');
INSERT INTO `municipios` VALUES (651,'BOM JESUS DOS PERDÕES','SP');
INSERT INTO `municipios` VALUES (652,'BOM LUGAR','MA');
INSERT INTO `municipios` VALUES (653,'BOM PRINCIPIO','RS');
INSERT INTO `municipios` VALUES (654,'BOM PRINCIPIO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (655,'BOM PROGRESSO','RS');
INSERT INTO `municipios` VALUES (656,'BOM REPOUSO','MG');
INSERT INTO `municipios` VALUES (657,'BOM RETIRO','SC');
INSERT INTO `municipios` VALUES (658,'BOM RETIRO DO SUL','RS');
INSERT INTO `municipios` VALUES (659,'BOM SUCESSO','MG');
INSERT INTO `municipios` VALUES (660,'BOM SUCESSO','PB');
INSERT INTO `municipios` VALUES (661,'BOM SUCESSO DE ITARARÉ','SP');
INSERT INTO `municipios` VALUES (662,'BOM SUCESSO','PR');
INSERT INTO `municipios` VALUES (663,'BOMBINHAS','SC');
INSERT INTO `municipios` VALUES (664,'BONFIM','MG');
INSERT INTO `municipios` VALUES (665,'BONFIM','RR');
INSERT INTO `municipios` VALUES (666,'BONFIM DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (667,'BONFINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (668,'BONFINÓPOLIS DE MINAS','MG');
INSERT INTO `municipios` VALUES (669,'BONINAL','BA');
INSERT INTO `municipios` VALUES (670,'BONITO','BA');
INSERT INTO `municipios` VALUES (671,'BONITO DE SANTA FÉ','PB');
INSERT INTO `municipios` VALUES (672,'BONÓPOLIS','GO');
INSERT INTO `municipios` VALUES (673,'BOQUEIRÃO','PB');
INSERT INTO `municipios` VALUES (674,'BOQUEIRÃO DO LEÃO','RS');
INSERT INTO `municipios` VALUES (675,'BOQUEIRÃO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (676,'BOQUIM','SE');
INSERT INTO `municipios` VALUES (677,'BOQUIRA','BA');
INSERT INTO `municipios` VALUES (678,'BORA','SP');
INSERT INTO `municipios` VALUES (679,'BORACEIA','SP');
INSERT INTO `municipios` VALUES (680,'BORBA','AM');
INSERT INTO `municipios` VALUES (681,'BORBOREMA','PB');
INSERT INTO `municipios` VALUES (682,'BORDA DA MATA','MG');
INSERT INTO `municipios` VALUES (683,'BOREBI','SP');
INSERT INTO `municipios` VALUES (684,'BORRAZÓPOLIS','PR');
INSERT INTO `municipios` VALUES (685,'BOSSOROCA','RS');
INSERT INTO `municipios` VALUES (686,'BOTELHOS','MG');
INSERT INTO `municipios` VALUES (687,'BOTUCATU','SP');
INSERT INTO `municipios` VALUES (688,'BOTUMIRIM','MG');
INSERT INTO `municipios` VALUES (689,'BOTUPORA','BA');
INSERT INTO `municipios` VALUES (690,'BOTUVERA','SC');
INSERT INTO `municipios` VALUES (691,'BRACO DO NORTE','SC');
INSERT INTO `municipios` VALUES (692,'BRACO DO TROMBUDO','SC');
INSERT INTO `municipios` VALUES (693,'BRAGA','RS');
INSERT INTO `municipios` VALUES (694,'BRAGANÇA','PA');
INSERT INTO `municipios` VALUES (695,'BRAGANÇA PAULISTA','SP');
INSERT INTO `municipios` VALUES (696,'BRAGANEY','PR');
INSERT INTO `municipios` VALUES (697,'BRANQUINHA','AL');
INSERT INTO `municipios` VALUES (698,'BRAS PIRES','MG');
INSERT INTO `municipios` VALUES (699,'BRASIL NOVO','PA');
INSERT INTO `municipios` VALUES (700,'BRASILÂNDIA','MS');
INSERT INTO `municipios` VALUES (701,'BRASILÂNDIA DE MINAS','MG');
INSERT INTO `municipios` VALUES (702,'BRASILÂNDIA DO SUL','PR');
INSERT INTO `municipios` VALUES (703,'BRASILÂNDIA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (704,'BRASILÉIA','AC');
INSERT INTO `municipios` VALUES (705,'BRASILEIRA','PI');
INSERT INTO `municipios` VALUES (706,'BRASILIA','DF');
INSERT INTO `municipios` VALUES (707,'BRASÍLIA DE MINAS','MG');
INSERT INTO `municipios` VALUES (708,'BRASNORTE','MT');
INSERT INTO `municipios` VALUES (709,'BRASÓPOLIS','MG');
INSERT INTO `municipios` VALUES (710,'BRAÚNA','SP');
INSERT INTO `municipios` VALUES (711,'BRAUNAS','MG');
INSERT INTO `municipios` VALUES (712,'BRAZABRANTES','GO');
INSERT INTO `municipios` VALUES (713,'BRAZILÂNDIA DO OESTE','RO');
INSERT INTO `municipios` VALUES (714,'BREJÃO','PE');
INSERT INTO `municipios` VALUES (715,'BREJETUBA','ES');
INSERT INTO `municipios` VALUES (716,'BREJINHO','PE');
INSERT INTO `municipios` VALUES (717,'BREJINHO DE NAZARÉ','TO');
INSERT INTO `municipios` VALUES (718,'BREJO','MA');
INSERT INTO `municipios` VALUES (719,'BREJO ALEGRE','SP');
INSERT INTO `municipios` VALUES (720,'BREJO DA MADRE DE DEUS','PE');
INSERT INTO `municipios` VALUES (721,'BREJO DE AREIA','MA');
INSERT INTO `municipios` VALUES (722,'BREJO DO CRUZ','PB');
INSERT INTO `municipios` VALUES (723,'BREJO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (724,'BREJO DOS SANTOS','PB');
INSERT INTO `municipios` VALUES (725,'BREJO GRANDE','SE');
INSERT INTO `municipios` VALUES (726,'BREJO GRANDE DO ARÁGUAIA','PA');
INSERT INTO `municipios` VALUES (727,'BREJO SANTO','CE');
INSERT INTO `municipios` VALUES (728,'BREJOES','BA');
INSERT INTO `municipios` VALUES (729,'BREJOLÂNDIA','BA');
INSERT INTO `municipios` VALUES (730,'BREU BRANCO','PA');
INSERT INTO `municipios` VALUES (731,'BREVES','PA');
INSERT INTO `municipios` VALUES (732,'BRITANIA','GO');
INSERT INTO `municipios` VALUES (733,'BROCHIER','RS');
INSERT INTO `municipios` VALUES (734,'BRODOWSKI','SP');
INSERT INTO `municipios` VALUES (735,'BROTAS','SP');
INSERT INTO `municipios` VALUES (736,'BROTAS DE MACAÚBAS','BA');
INSERT INTO `municipios` VALUES (737,'BRUMADINHO','MG');
INSERT INTO `municipios` VALUES (738,'BRUMADO','BA');
INSERT INTO `municipios` VALUES (739,'BRUNÓPOLIS','SC');
INSERT INTO `municipios` VALUES (740,'BRUSQUE','SC');
INSERT INTO `municipios` VALUES (741,'BUENO BRANDÃO','MG');
INSERT INTO `municipios` VALUES (742,'BUENÓPOLIS','MG');
INSERT INTO `municipios` VALUES (743,'BUENOS AIRES','PE');
INSERT INTO `municipios` VALUES (744,'BUERAREMA','BA');
INSERT INTO `municipios` VALUES (745,'BUGRE','MG');
INSERT INTO `municipios` VALUES (746,'BUÍQUE','PE');
INSERT INTO `municipios` VALUES (747,'BUJARI','AC');
INSERT INTO `municipios` VALUES (748,'BUJARU','PA');
INSERT INTO `municipios` VALUES (749,'BURI','SP');
INSERT INTO `municipios` VALUES (750,'BURITAMA','SP');
INSERT INTO `municipios` VALUES (751,'BURITI','MA');
INSERT INTO `municipios` VALUES (752,'BURITI ALEGRE','GO');
INSERT INTO `municipios` VALUES (753,'BURITI BRAVO','MA');
INSERT INTO `municipios` VALUES (754,'BURITI DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (755,'BURITI DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (756,'BURITI DOS LOPES','PI');
INSERT INTO `municipios` VALUES (757,'BURITI DOS MONTES','PI');
INSERT INTO `municipios` VALUES (758,'BURITICUPU','MA');
INSERT INTO `municipios` VALUES (759,'BURITINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (760,'BURITIRAMA','BA');
INSERT INTO `municipios` VALUES (761,'BURITIRANA','MA');
INSERT INTO `municipios` VALUES (762,'BURITIS','MG');
INSERT INTO `municipios` VALUES (763,'BURITIS','RO');
INSERT INTO `municipios` VALUES (764,'BURITIZAL','SP');
INSERT INTO `municipios` VALUES (765,'BURITIZEIRO','MG');
INSERT INTO `municipios` VALUES (766,'BUTIA','RS');
INSERT INTO `municipios` VALUES (767,'CAAPIRANGA','AM');
INSERT INTO `municipios` VALUES (768,'CAAPORA','PB');
INSERT INTO `municipios` VALUES (769,'CAARAPO','MS');
INSERT INTO `municipios` VALUES (770,'CAATIBA','BA');
INSERT INTO `municipios` VALUES (771,'CABACEIRAS','PB');
INSERT INTO `municipios` VALUES (772,'CABACEIRAS DO PARAGUAÇU','BA');
INSERT INTO `municipios` VALUES (773,'CABECEIRA GRANDE','MG');
INSERT INTO `municipios` VALUES (774,'CABECEIRAS','GO');
INSERT INTO `municipios` VALUES (775,'CABECEIRAS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (776,'CABEDELO','PB');
INSERT INTO `municipios` VALUES (777,'CABO DE SANTO AGOSTINHO','PE');
INSERT INTO `municipios` VALUES (778,'CABO FRIO','RJ');
INSERT INTO `municipios` VALUES (779,'CABO VERDE','MG');
INSERT INTO `municipios` VALUES (780,'CABRÁLIA PAULISTA','SP');
INSERT INTO `municipios` VALUES (781,'CABREUVA','SP');
INSERT INTO `municipios` VALUES (782,'CABROBO','PE');
INSERT INTO `municipios` VALUES (783,'CACADOR','SC');
INSERT INTO `municipios` VALUES (784,'CAÇAPAVA','SP');
INSERT INTO `municipios` VALUES (785,'CAÇAPAVA DO SUL','RS');
INSERT INTO `municipios` VALUES (786,'CACAULÂNDIA','RO');
INSERT INTO `municipios` VALUES (787,'CACEQUI','RS');
INSERT INTO `municipios` VALUES (788,'CÁCERES','MT');
INSERT INTO `municipios` VALUES (789,'CACHOEIRA','BA');
INSERT INTO `municipios` VALUES (790,'CACHOEIRA ALTA','GO');
INSERT INTO `municipios` VALUES (791,'CACHOEIRA DA PRATA','MG');
INSERT INTO `municipios` VALUES (792,'CACHOEIRA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (793,'CACHOEIRA DE MINAS','MG');
INSERT INTO `municipios` VALUES (794,'CACHOEIRA DO ARARI','PA');
INSERT INTO `municipios` VALUES (795,'CACHOEIRA DO PAJEU','MG');
INSERT INTO `municipios` VALUES (796,'CACHOEIRA DO PIRIA','PA');
INSERT INTO `municipios` VALUES (797,'CACHOEIRA DO SUL','RS');
INSERT INTO `municipios` VALUES (798,'CACHOEIRA DOS ÍNDIOS','PB');
INSERT INTO `municipios` VALUES (799,'CACHOEIRA DOURADA','GO');
INSERT INTO `municipios` VALUES (800,'CACHOEIRA GRANDE','MA');
INSERT INTO `municipios` VALUES (801,'CACHOEIRA PAULISTA','SP');
INSERT INTO `municipios` VALUES (802,'CACHOEIRAS DE MACAÇU','RJ');
INSERT INTO `municipios` VALUES (803,'CACHOEIRINHA','PE');
INSERT INTO `municipios` VALUES (804,'CACHOEIRINHA','RS');
INSERT INTO `municipios` VALUES (805,'CACHOEIRINHA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (806,'CACHOEIRO DO ITAPEMIRIM','ES');
INSERT INTO `municipios` VALUES (807,'CACIMBA DE AREIA','PB');
INSERT INTO `municipios` VALUES (808,'CACIMBA DE DENTRO','PB');
INSERT INTO `municipios` VALUES (809,'CACIMBAS','PB');
INSERT INTO `municipios` VALUES (810,'CACIMBINHAS','AL');
INSERT INTO `municipios` VALUES (811,'CACIQUE DOBLE','RS');
INSERT INTO `municipios` VALUES (812,'CACOAL','RO');
INSERT INTO `municipios` VALUES (813,'CACONDE','SP');
INSERT INTO `municipios` VALUES (814,'CAÇU','GO');
INSERT INTO `municipios` VALUES (815,'CACULÉ','BA');
INSERT INTO `municipios` VALUES (816,'CAEM','BA');
INSERT INTO `municipios` VALUES (817,'CAETANÓPOLIS','MG');
INSERT INTO `municipios` VALUES (818,'CAETANOS','BA');
INSERT INTO `municipios` VALUES (819,'CAETÉ','MG');
INSERT INTO `municipios` VALUES (820,'CAETÉS','PE');
INSERT INTO `municipios` VALUES (821,'CAETITÉ','BA');
INSERT INTO `municipios` VALUES (822,'CAFARNAUM','BA');
INSERT INTO `municipios` VALUES (823,'CAFEARA','PR');
INSERT INTO `municipios` VALUES (824,'CAFELÂNDIA','PR');
INSERT INTO `municipios` VALUES (825,'CAFEZAL DO SUL','PR');
INSERT INTO `municipios` VALUES (826,'CAIABU','SP');
INSERT INTO `municipios` VALUES (827,'CAIANA','MG');
INSERT INTO `municipios` VALUES (828,'CAIAPÔNIA','GO');
INSERT INTO `municipios` VALUES (829,'CAIBATE','RS');
INSERT INTO `municipios` VALUES (830,'CAIBI','SC');
INSERT INTO `municipios` VALUES (831,'CAIÇARA','PB');
INSERT INTO `municipios` VALUES (832,'CAIÇARA','RS');
INSERT INTO `municipios` VALUES (833,'CAIÇARA DO NORTE','RN');
INSERT INTO `municipios` VALUES (834,'CAIÇARA DO RIO DO VENTO','RN');
INSERT INTO `municipios` VALUES (835,'CAICO','RN');
INSERT INTO `municipios` VALUES (836,'CAIEIRAS','SP');
INSERT INTO `municipios` VALUES (837,'CAIRU','BA');
INSERT INTO `municipios` VALUES (838,'CAIUÁ','SP');
INSERT INTO `municipios` VALUES (839,'CAJAMAR','SP');
INSERT INTO `municipios` VALUES (840,'CAJAPIO','MA');
INSERT INTO `municipios` VALUES (841,'CAJARI','MA');
INSERT INTO `municipios` VALUES (842,'CAJATI','SP');
INSERT INTO `municipios` VALUES (843,'CAJAZEIRAS','PB');
INSERT INTO `municipios` VALUES (844,'CAJAZEIRAS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (845,'CAJAZEIRINHAS','PB');
INSERT INTO `municipios` VALUES (846,'CAJOBI','SP');
INSERT INTO `municipios` VALUES (847,'CAJUEIRO','AL');
INSERT INTO `municipios` VALUES (848,'CAJUEIRO DA PRAIA','PI');
INSERT INTO `municipios` VALUES (849,'CAJURI','MG');
INSERT INTO `municipios` VALUES (850,'CAJURU','SP');
INSERT INTO `municipios` VALUES (851,'CALCADO','PE');
INSERT INTO `municipios` VALUES (852,'CALÇADO','PE');
INSERT INTO `municipios` VALUES (853,'CALÇOENE','AP');
INSERT INTO `municipios` VALUES (854,'CALDAS','MG');
INSERT INTO `municipios` VALUES (855,'CALDAS BRANDÃO','PB');
INSERT INTO `municipios` VALUES (856,'CALDAS NOVAS','GO');
INSERT INTO `municipios` VALUES (857,'CALDAZINHA','GO');
INSERT INTO `municipios` VALUES (858,'CALDEIRÃO GRANDE','BA');
INSERT INTO `municipios` VALUES (859,'CALDEIRÃO GRANDE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (860,'CALIFORNIA','PR');
INSERT INTO `municipios` VALUES (861,'CALMON','SC');
INSERT INTO `municipios` VALUES (862,'CALUMBI','PE');
INSERT INTO `municipios` VALUES (863,'CAMACA','BA');
INSERT INTO `municipios` VALUES (864,'CAMACAN','BA');
INSERT INTO `municipios` VALUES (865,'CAMACARI','BA');
INSERT INTO `municipios` VALUES (866,'CAMACHO','MG');
INSERT INTO `municipios` VALUES (867,'CAMALAU','PB');
INSERT INTO `municipios` VALUES (868,'CAMAMU','BA');
INSERT INTO `municipios` VALUES (869,'CAMANDUCAIA','MG');
INSERT INTO `municipios` VALUES (870,'CAMAPUÃ','MS');
INSERT INTO `municipios` VALUES (871,'CAMAQUÃ','RS');
INSERT INTO `municipios` VALUES (872,'CAMARAGIBE','PE');
INSERT INTO `municipios` VALUES (873,'CAMARAGIPE','PE');
INSERT INTO `municipios` VALUES (874,'CAMARGO','RS');
INSERT INTO `municipios` VALUES (875,'CAMBARÁ','PR');
INSERT INTO `municipios` VALUES (876,'CAMBARÁ DO SUL','RS');
INSERT INTO `municipios` VALUES (877,'CAMBÉ','PR');
INSERT INTO `municipios` VALUES (878,'CAMBIRA','PR');
INSERT INTO `municipios` VALUES (879,'CAMBORIU','SC');
INSERT INTO `municipios` VALUES (880,'CAMBUCI','RJ');
INSERT INTO `municipios` VALUES (881,'CAMBUI','MG');
INSERT INTO `municipios` VALUES (882,'CAMBUQUIRA','MG');
INSERT INTO `municipios` VALUES (883,'CAMETA','PA');
INSERT INTO `municipios` VALUES (884,'CAMOCIM','CE');
INSERT INTO `municipios` VALUES (885,'CAMOCIM DE SÃO FELIX','PE');
INSERT INTO `municipios` VALUES (886,'CAMPANÁRIO','MG');
INSERT INTO `municipios` VALUES (887,'CAMPANHA','MG');
INSERT INTO `municipios` VALUES (888,'CAMPESTRE','AL');
INSERT INTO `municipios` VALUES (889,'CAMPESTRE DA SERRA','RS');
INSERT INTO `municipios` VALUES (890,'CAMPESTRE DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (891,'CAMPESTRE DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (892,'CAMPINA DA LAGOA','PR');
INSERT INTO `municipios` VALUES (893,'CAMPINA DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (894,'CAMPINA DO SIMÃO','PR');
INSERT INTO `municipios` VALUES (895,'CAMPINA GRANDE','PB');
INSERT INTO `municipios` VALUES (896,'CAMPINA GRANDE DO SUL','PR');
INSERT INTO `municipios` VALUES (897,'CAMPINA DO MONTE ALEGRE','SP');
INSERT INTO `municipios` VALUES (898,'CAMPINA VERDE','MG');
INSERT INTO `municipios` VALUES (899,'CAMPINAÇU','GO');
INSERT INTO `municipios` VALUES (900,'CAMPINÁPOLIS','MT');
INSERT INTO `municipios` VALUES (901,'CAMPINAS','SP');
INSERT INTO `municipios` VALUES (902,'CAMPINAS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (903,'CAMPINAS DO SUL','RS');
INSERT INTO `municipios` VALUES (904,'CAMPINORTE','GO');
INSERT INTO `municipios` VALUES (905,'CAMPO ALEGRE','AL');
INSERT INTO `municipios` VALUES (906,'CAMPO ALEGRE DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (907,'CAMPO ALEGRE DE LOURDES','BA');
INSERT INTO `municipios` VALUES (908,'CAMPO ALEGRE DO FIDALGO','PI');
INSERT INTO `municipios` VALUES (909,'CAMPO BELO','MG');
INSERT INTO `municipios` VALUES (910,'CAMPO BELO DO SUL','SC');
INSERT INTO `municipios` VALUES (911,'CAMPO BOM','RS');
INSERT INTO `municipios` VALUES (912,'CAMPO BONITO','PR');
INSERT INTO `municipios` VALUES (913,'CAMPO DO BRITO','SE');
INSERT INTO `municipios` VALUES (914,'CAMPO DO MEIO','MG');
INSERT INTO `municipios` VALUES (915,'CAMPO DO TENENTE','PR');
INSERT INTO `municipios` VALUES (916,'CAMPO FLORIDO','MG');
INSERT INTO `municipios` VALUES (917,'CAMPO FORMOSO','BA');
INSERT INTO `municipios` VALUES (918,'CAMPO GRANDE','AL');
INSERT INTO `municipios` VALUES (919,'CAMPO GRANDE','MS');
INSERT INTO `municipios` VALUES (920,'CAMPO GRANDE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (921,'CAMPO LARGO','PR');
INSERT INTO `municipios` VALUES (922,'CAMPO LARGO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (923,'CAMPO LIMPO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (924,'CAMPO LIMPO PAULISTA','SP');
INSERT INTO `municipios` VALUES (925,'CAMPO MAGRO','PR');
INSERT INTO `municipios` VALUES (926,'CAMPO MAIOR','PI');
INSERT INTO `municipios` VALUES (927,'CAMPO MOURÃO','PR');
INSERT INTO `municipios` VALUES (928,'CAMPO NOVO','RS');
INSERT INTO `municipios` VALUES (929,'CAMPO NOVO DE RONDONIA','RO');
INSERT INTO `municipios` VALUES (930,'CAMPO NOVO DO PARECIS','MT');
INSERT INTO `municipios` VALUES (931,'CAMPO REDONDO','RN');
INSERT INTO `municipios` VALUES (932,'CAMPO VERDE','MT');
INSERT INTO `municipios` VALUES (933,'CAMPO ERÊ','SC');
INSERT INTO `municipios` VALUES (934,'CAMPOS ALTOS','MG');
INSERT INTO `municipios` VALUES (935,'CAMPOS BELOS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (936,'CAMPOS BORGES','RS');
INSERT INTO `municipios` VALUES (937,'CAMPOS DE JÚLIO','MT');
INSERT INTO `municipios` VALUES (938,'CAMPOS DO JORDÃO','SP');
INSERT INTO `municipios` VALUES (939,'CAMPOS DOS GOYTACAZES','RJ');
INSERT INTO `municipios` VALUES (940,'CAMPOS GERAIS','MG');
INSERT INTO `municipios` VALUES (941,'CAMPOS LINDOS','TO');
INSERT INTO `municipios` VALUES (942,'CAMPOS NOVOS','SC');
INSERT INTO `municipios` VALUES (943,'CAMPOS NOVOS PAULISTA','SP');
INSERT INTO `municipios` VALUES (944,'CAMPOS SALES','CE');
INSERT INTO `municipios` VALUES (945,'CAMPOS VERDES','GO');
INSERT INTO `municipios` VALUES (946,'CAMUTANGA','PE');
INSERT INTO `municipios` VALUES (947,'CANA BRAVA DO NORTE','MT');
INSERT INTO `municipios` VALUES (948,'CANA VERDE','MG');
INSERT INTO `municipios` VALUES (949,'CANAÃ','MG');
INSERT INTO `municipios` VALUES (950,'CANAÃ DOS CARAJAS','PA');
INSERT INTO `municipios` VALUES (951,'CANANÉIA','SP');
INSERT INTO `municipios` VALUES (952,'CANAPI','AL');
INSERT INTO `municipios` VALUES (953,'CANÁPOLIS','BA');
INSERT INTO `municipios` VALUES (954,'CANARANA','BA');
INSERT INTO `municipios` VALUES (955,'CANAS','SP');
INSERT INTO `municipios` VALUES (956,'CANAVIEIRA','PI');
INSERT INTO `municipios` VALUES (957,'CANAVIEIRAS','BA');
INSERT INTO `municipios` VALUES (958,'CANDEIAS','BA');
INSERT INTO `municipios` VALUES (959,'CANDEIAS DO JAMARI','RO');
INSERT INTO `municipios` VALUES (960,'CANDELÁRIA','RS');
INSERT INTO `municipios` VALUES (961,'CÂNDIDO DE ABREU','PR');
INSERT INTO `municipios` VALUES (962,'CÂNDIDO GODOI','RS');
INSERT INTO `municipios` VALUES (963,'CÂNDIDO MENDES','MA');
INSERT INTO `municipios` VALUES (964,'CÂNDIDO MOTA','SP');
INSERT INTO `municipios` VALUES (965,'CÂNDIDO RODRIGUES','SP');
INSERT INTO `municipios` VALUES (966,'CÂNDIDO SALES','BA');
INSERT INTO `municipios` VALUES (967,'CANDIIBA','BA');
INSERT INTO `municipios` VALUES (968,'CANDIOTA','RS');
INSERT INTO `municipios` VALUES (969,'CANDOI','PR');
INSERT INTO `municipios` VALUES (970,'CANELA','RS');
INSERT INTO `municipios` VALUES (971,'CANELINHA','SC');
INSERT INTO `municipios` VALUES (972,'CANGUARETAMA','RN');
INSERT INTO `municipios` VALUES (973,'CANGUÇU','RS');
INSERT INTO `municipios` VALUES (974,'CANHOBA','SE');
INSERT INTO `municipios` VALUES (975,'CANHOTINHO','PE');
INSERT INTO `municipios` VALUES (976,'CANINDE','CE');
INSERT INTO `municipios` VALUES (977,'CANINDÉ DO SÃO FRANCISCO','SE');
INSERT INTO `municipios` VALUES (978,'CANINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (979,'CANITAR','SP');
INSERT INTO `municipios` VALUES (980,'CANOAS','RS');
INSERT INTO `municipios` VALUES (981,'CANOINHAS','SC');
INSERT INTO `municipios` VALUES (982,'CANSANCÃO','BA');
INSERT INTO `municipios` VALUES (983,'CANTÁ','RR');
INSERT INTO `municipios` VALUES (984,'CANTAGALO','PR');
INSERT INTO `municipios` VALUES (985,'CANTAGALO','RJ');
INSERT INTO `municipios` VALUES (986,'CANTANHEDE','MA');
INSERT INTO `municipios` VALUES (987,'CANTO DO BURITI','PI');
INSERT INTO `municipios` VALUES (988,'CANUDOS','BA');
INSERT INTO `municipios` VALUES (989,'CANUDOS DO VALE','RS');
INSERT INTO `municipios` VALUES (990,'CANUTAMA','AM');
INSERT INTO `municipios` VALUES (991,'CAPANEMA','PA');
INSERT INTO `municipios` VALUES (992,'CAPÃO ALTO','SC');
INSERT INTO `municipios` VALUES (993,'CAPÃO BONITO','SP');
INSERT INTO `municipios` VALUES (994,'CAPÃO DA CANOA','RS');
INSERT INTO `municipios` VALUES (995,'CAPÃO DO LEÃO','RS');
INSERT INTO `municipios` VALUES (996,'CAPARÃO','MG');
INSERT INTO `municipios` VALUES (997,'CAPELA','AL');
INSERT INTO `municipios` VALUES (998,'CAPELA DE SANTANA','RS');
INSERT INTO `municipios` VALUES (999,'CAPELA DO ALTO','SP');
INSERT INTO `municipios` VALUES (1000,'CAPELA DO ALTO ALEGRE','BA');
INSERT INTO `municipios` VALUES (1001,'CAPELA NOVA','MG');
INSERT INTO `municipios` VALUES (1002,'CAPELINHA','MG');
INSERT INTO `municipios` VALUES (1003,'CAPETINGA','MG');
INSERT INTO `municipios` VALUES (1004,'CAPIM','PB');
INSERT INTO `municipios` VALUES (1005,'CAPIM BRANCO','MG');
INSERT INTO `municipios` VALUES (1006,'CAPIM GROSSO','BA');
INSERT INTO `municipios` VALUES (1007,'CAPINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1008,'CAPINZAL','SC');
INSERT INTO `municipios` VALUES (1009,'CAPITÃO','RS');
INSERT INTO `municipios` VALUES (1010,'CAPITÃO ANDRADE','MG');
INSERT INTO `municipios` VALUES (1011,'CAPITÃO DE CAMPOS','PI');
INSERT INTO `municipios` VALUES (1012,'CAPITÃO ENÉAS','MG');
INSERT INTO `municipios` VALUES (1013,'CAPITÃO GERVÁSIO DE OLIVEIRA','PI');
INSERT INTO `municipios` VALUES (1014,'CAPITÃO LEÔNIDAS MARQUES','PR');
INSERT INTO `municipios` VALUES (1015,'CAPITÃO POÇO','PA');
INSERT INTO `municipios` VALUES (1016,'CAPITÓLIO','MG');
INSERT INTO `municipios` VALUES (1017,'CAPIVARI','SP');
INSERT INTO `municipios` VALUES (1018,'CAPIVARI DE BAIXO','SC');
INSERT INTO `municipios` VALUES (1019,'CAPIVARI DO SUL','RS');
INSERT INTO `municipios` VALUES (1020,'CAPIXABA','AC');
INSERT INTO `municipios` VALUES (1021,'CAPOEIRAS','PE');
INSERT INTO `municipios` VALUES (1022,'CAPRISTANO','CE');
INSERT INTO `municipios` VALUES (1023,'CAPUTIRA','MG');
INSERT INTO `municipios` VALUES (1024,'CARAA','RS');
INSERT INTO `municipios` VALUES (1025,'CARACARAI','RR');
INSERT INTO `municipios` VALUES (1026,'CARACOL','MS');
INSERT INTO `municipios` VALUES (1027,'CARAGUATATUBA','SP');
INSERT INTO `municipios` VALUES (1028,'CARAÍ','MG');
INSERT INTO `municipios` VALUES (1029,'CARAIBAS','BA');
INSERT INTO `municipios` VALUES (1030,'CARAMBEI','PR');
INSERT INTO `municipios` VALUES (1031,'CARANAIBA','MG');
INSERT INTO `municipios` VALUES (1032,'CARANDAÍ','MG');
INSERT INTO `municipios` VALUES (1033,'CARANGOLA','MG');
INSERT INTO `municipios` VALUES (1034,'CARAPEBUS','RJ');
INSERT INTO `municipios` VALUES (1035,'CARAPICUIBA','SP');
INSERT INTO `municipios` VALUES (1036,'CARATINGA','MG');
INSERT INTO `municipios` VALUES (1037,'CARAUARI','AM');
INSERT INTO `municipios` VALUES (1038,'CARAUBAS','PB');
INSERT INTO `municipios` VALUES (1039,'CARAÚBAS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1040,'CARAVELAS','BA');
INSERT INTO `municipios` VALUES (1041,'CARAZINHO','RS');
INSERT INTO `municipios` VALUES (1042,'CARBONITA','MG');
INSERT INTO `municipios` VALUES (1043,'CARDEAL DA SILVA','BA');
INSERT INTO `municipios` VALUES (1044,'CARDOSO','SP');
INSERT INTO `municipios` VALUES (1045,'CARDOSO MOREIRA','RJ');
INSERT INTO `municipios` VALUES (1046,'CAREAÇU','MG');
INSERT INTO `municipios` VALUES (1047,'CAREIRO CASTANHO','AM');
INSERT INTO `municipios` VALUES (1048,'CAREIRO DA VARZEA','AM');
INSERT INTO `municipios` VALUES (1049,'CARIAÇICA','ES');
INSERT INTO `municipios` VALUES (1050,'CARIDADE','CE');
INSERT INTO `municipios` VALUES (1051,'CARIDADE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1052,'CARINHANHA','BA');
INSERT INTO `municipios` VALUES (1053,'CARIRA','SE');
INSERT INTO `municipios` VALUES (1054,'CARIRE','CE');
INSERT INTO `municipios` VALUES (1055,'CARIRI DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (1056,'CARIRIAÇU','CE');
INSERT INTO `municipios` VALUES (1057,'CARIUS','CE');
INSERT INTO `municipios` VALUES (1058,'CARLINDA','MT');
INSERT INTO `municipios` VALUES (1059,'CARLÓPOLIS','PR');
INSERT INTO `municipios` VALUES (1060,'CARLOS BARBOSA','RS');
INSERT INTO `municipios` VALUES (1061,'CARLOS CHAGAS','MG');
INSERT INTO `municipios` VALUES (1062,'CARLOS GOMES','RS');
INSERT INTO `municipios` VALUES (1063,'CARMESIA','MG');
INSERT INTO `municipios` VALUES (1064,'CARMO','RJ');
INSERT INTO `municipios` VALUES (1065,'CARMO DA CACHOEIRA','MG');
INSERT INTO `municipios` VALUES (1066,'CARMO DA MATA','MG');
INSERT INTO `municipios` VALUES (1067,'CARMO DE MINAS','MG');
INSERT INTO `municipios` VALUES (1068,'CARMO DO CAJURU','MG');
INSERT INTO `municipios` VALUES (1069,'CARMO DO PARANAÍBA','MG');
INSERT INTO `municipios` VALUES (1070,'CARMO DO RIO CLARO','MG');
INSERT INTO `municipios` VALUES (1071,'CARMO DO RIO VERDE','GO');
INSERT INTO `municipios` VALUES (1072,'CARMOLÂNDIA','TO');
INSERT INTO `municipios` VALUES (1073,'CARMÓPOLIS','SE');
INSERT INTO `municipios` VALUES (1074,'CARMÓPOLIS DE MINAS','MG');
INSERT INTO `municipios` VALUES (1075,'CARNAIBA','PE');
INSERT INTO `municipios` VALUES (1076,'CARNAÚBA DOS DANTAS','RN');
INSERT INTO `municipios` VALUES (1077,'CARNAUBAIS','RN');
INSERT INTO `municipios` VALUES (1078,'CARNAUBAL','CE');
INSERT INTO `municipios` VALUES (1079,'CARNAUBEIRA DA PENHA','PE');
INSERT INTO `municipios` VALUES (1080,'CARNEIRINHO','MG');
INSERT INTO `municipios` VALUES (1081,'CARNEIROS','AL');
INSERT INTO `municipios` VALUES (1082,'CAROEBE','RR');
INSERT INTO `municipios` VALUES (1083,'CAROLINA','MA');
INSERT INTO `municipios` VALUES (1084,'CARPINA','PE');
INSERT INTO `municipios` VALUES (1085,'CARRANCAS','MG');
INSERT INTO `municipios` VALUES (1086,'CARRAPATEIRA','PB');
INSERT INTO `municipios` VALUES (1087,'CARRASCO BONITO','TO');
INSERT INTO `municipios` VALUES (1088,'CARUARU','PE');
INSERT INTO `municipios` VALUES (1089,'CARUTAPERA','MA');
INSERT INTO `municipios` VALUES (1090,'CARVALHÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1091,'CARVALHOS','MG');
INSERT INTO `municipios` VALUES (1092,'CASA BRANCA','SP');
INSERT INTO `municipios` VALUES (1093,'CASA GRANDE','MG');
INSERT INTO `municipios` VALUES (1094,'CASA NOVA','BA');
INSERT INTO `municipios` VALUES (1095,'CASCA','RS');
INSERT INTO `municipios` VALUES (1096,'CASCALHO RICO','MG');
INSERT INTO `municipios` VALUES (1097,'CASCAVEL','CE');
INSERT INTO `municipios` VALUES (1098,'CASCAVEL','PR');
INSERT INTO `municipios` VALUES (1099,'CASEARA','TO');
INSERT INTO `municipios` VALUES (1100,'CASEIROS','RS');
INSERT INTO `municipios` VALUES (1101,'CASIMIRO DE ABREU','RJ');
INSERT INTO `municipios` VALUES (1102,'CASINHAS','PE');
INSERT INTO `municipios` VALUES (1103,'CASSERENGUE','PB');
INSERT INTO `municipios` VALUES (1104,'CASSIA','MG');
INSERT INTO `municipios` VALUES (1105,'CÁSSIA DOS COQUEIROS','SP');
INSERT INTO `municipios` VALUES (1106,'CASSILÂNDIA','MS');
INSERT INTO `municipios` VALUES (1107,'CASTANHAL','PA');
INSERT INTO `municipios` VALUES (1108,'CASTANHEIRA','MT');
INSERT INTO `municipios` VALUES (1109,'CASTANHEIRAS','RO');
INSERT INTO `municipios` VALUES (1110,'CASTELÂNDIA','GO');
INSERT INTO `municipios` VALUES (1111,'CASTELO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1112,'CASTILHO','SP');
INSERT INTO `municipios` VALUES (1113,'CASTRO','PR');
INSERT INTO `municipios` VALUES (1114,'CASTRO ALVES','BA');
INSERT INTO `municipios` VALUES (1115,'CATÁGUASES','MG');
INSERT INTO `municipios` VALUES (1116,'CATALÃO','GO');
INSERT INTO `municipios` VALUES (1117,'CATANDUVA','SC');
INSERT INTO `municipios` VALUES (1118,'CATANDUVA','SP');
INSERT INTO `municipios` VALUES (1119,'CATANDUVAS','PR');
INSERT INTO `municipios` VALUES (1120,'CATARINA','CE');
INSERT INTO `municipios` VALUES (1121,'CATAS ALTAS ','MG');
INSERT INTO `municipios` VALUES (1122,'CATENDE','PE');
INSERT INTO `municipios` VALUES (1123,'CATIGUA','SP');
INSERT INTO `municipios` VALUES (1124,'CATINGUEIRA','PB');
INSERT INTO `municipios` VALUES (1125,'CATOLÂNDIA','BA');
INSERT INTO `municipios` VALUES (1126,'CATOLÉ DO ROCHA','PB');
INSERT INTO `municipios` VALUES (1127,'CATU','BA');
INSERT INTO `municipios` VALUES (1128,'CATUIPE','RS');
INSERT INTO `municipios` VALUES (1129,'CATUJI','MG');
INSERT INTO `municipios` VALUES (1130,'CATUNDA','CE');
INSERT INTO `municipios` VALUES (1131,'CATURAÍ','GO');
INSERT INTO `municipios` VALUES (1132,'CATURAMA','BA');
INSERT INTO `municipios` VALUES (1133,'CATURITE','PB');
INSERT INTO `municipios` VALUES (1134,'CATUTI','MG');
INSERT INTO `municipios` VALUES (1135,'CAUCAIA','CE');
INSERT INTO `municipios` VALUES (1136,'CAVALCANTE','GO');
INSERT INTO `municipios` VALUES (1137,'CAXAMBU','MG');
INSERT INTO `municipios` VALUES (1138,'CAXAMBU DO SUL','SC');
INSERT INTO `municipios` VALUES (1139,'CAXIAS','MA');
INSERT INTO `municipios` VALUES (1140,'CAXIAS DO SUL','RS');
INSERT INTO `municipios` VALUES (1141,'CAXINGO','PI');
INSERT INTO `municipios` VALUES (1142,'CEARÁ MIRIM','RN');
INSERT INTO `municipios` VALUES (1143,'CEDRAL','MA');
INSERT INTO `municipios` VALUES (1144,'CEDRO','CE');
INSERT INTO `municipios` VALUES (1145,'CEDRO DO ABAETÉ','MG');
INSERT INTO `municipios` VALUES (1146,'CEDRO SÃO JOÃO','SE');
INSERT INTO `municipios` VALUES (1147,'CELSO RAMOS','SC');
INSERT INTO `municipios` VALUES (1148,'CENTENARIO','RS');
INSERT INTO `municipios` VALUES (1149,'CENTENARIO DO SUL','PR');
INSERT INTO `municipios` VALUES (1150,'CENTRAL','BA');
INSERT INTO `municipios` VALUES (1151,'CENTRAL DE MINAS','MG');
INSERT INTO `municipios` VALUES (1152,'CENTRAL DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (1153,'CENTRALINA','MG');
INSERT INTO `municipios` VALUES (1154,'CENTRO DO GUILHERME','MA');
INSERT INTO `municipios` VALUES (1155,'CENTRO NOVO DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (1156,'CEREJEIRAS','RO');
INSERT INTO `municipios` VALUES (1157,'CERES','GO');
INSERT INTO `municipios` VALUES (1158,'CERQUEIRA CESAR','SP');
INSERT INTO `municipios` VALUES (1159,'CERQUILHO','SP');
INSERT INTO `municipios` VALUES (1160,'CERRITO','RS');
INSERT INTO `municipios` VALUES (1161,'CERRO BRANCO','RS');
INSERT INTO `municipios` VALUES (1162,'CERRO CORA','RN');
INSERT INTO `municipios` VALUES (1163,'CERRO GRANDE','RS');
INSERT INTO `municipios` VALUES (1164,'CERRO GRANDE DO SUL','RS');
INSERT INTO `municipios` VALUES (1165,'CERRO LARGO','RS');
INSERT INTO `municipios` VALUES (1166,'CERRO NEGRO','SC');
INSERT INTO `municipios` VALUES (1167,'CESÁRIO LANGE','SP');
INSERT INTO `municipios` VALUES (1168,'CEU AZUL','PR');
INSERT INTO `municipios` VALUES (1169,'CEZARINA','GO');
INSERT INTO `municipios` VALUES (1170,'CHÃ DE ALEGRIA','PE');
INSERT INTO `municipios` VALUES (1171,'CHA GRANDE','PE');
INSERT INTO `municipios` VALUES (1172,'CHÃ PRETA','AL');
INSERT INTO `municipios` VALUES (1173,'CHACARA','MG');
INSERT INTO `municipios` VALUES (1174,'CHALE','MG');
INSERT INTO `municipios` VALUES (1175,'CHAPADA','RS');
INSERT INTO `municipios` VALUES (1176,'CHAPADA DA AREIA','TO');
INSERT INTO `municipios` VALUES (1177,'CHAPADA DA NATIVIDADE','TO');
INSERT INTO `municipios` VALUES (1178,'CHAPADA DO NORTE','MG');
INSERT INTO `municipios` VALUES (1179,'CHAPADA DOS GUIMARÃES','MT');
INSERT INTO `municipios` VALUES (1180,'CHAPADA GAÚCHA','MG');
INSERT INTO `municipios` VALUES (1181,'CHAPADÃO DO CEU','GO');
INSERT INTO `municipios` VALUES (1182,'CHAPADÃO DO LAGEADO','SC');
INSERT INTO `municipios` VALUES (1183,'CHAPADÃO DO SUL','MS');
INSERT INTO `municipios` VALUES (1184,'CHAPADINHA','MA');
INSERT INTO `municipios` VALUES (1185,'CHAPECÓ','SC');
INSERT INTO `municipios` VALUES (1186,'CHARQUEADA','SP');
INSERT INTO `municipios` VALUES (1187,'CHARQUEADAS','RS');
INSERT INTO `municipios` VALUES (1188,'CHARRUA','RS');
INSERT INTO `municipios` VALUES (1189,'CHAVAL','CE');
INSERT INTO `municipios` VALUES (1190,'CHAVANTES','SP');
INSERT INTO `municipios` VALUES (1191,'CHAVES','PA');
INSERT INTO `municipios` VALUES (1192,'CHIADOR','MG');
INSERT INTO `municipios` VALUES (1193,'CHIAPETTA','RS');
INSERT INTO `municipios` VALUES (1194,'CHOPINZINHO','PR');
INSERT INTO `municipios` VALUES (1195,'CHORO','CE');
INSERT INTO `municipios` VALUES (1196,'CHOROZINHO','CE');
INSERT INTO `municipios` VALUES (1197,'CHORROCHO','BA');
INSERT INTO `municipios` VALUES (1198,'CHUI','RS');
INSERT INTO `municipios` VALUES (1199,'CHUPINGUAIA','RO');
INSERT INTO `municipios` VALUES (1200,'CHUVISCA','RS');
INSERT INTO `municipios` VALUES (1201,'CIANORTE','PR');
INSERT INTO `municipios` VALUES (1202,'CICERO DANTAS','BA');
INSERT INTO `municipios` VALUES (1203,'CIDADE DO RECIFE','PE');
INSERT INTO `municipios` VALUES (1204,'CIDADE GAÚCHA','PR');
INSERT INTO `municipios` VALUES (1205,'CIDADE OCIDENTAL','GO');
INSERT INTO `municipios` VALUES (1206,'CIDELÂNDIA','MA');
INSERT INTO `municipios` VALUES (1207,'CIDREIRA','RS');
INSERT INTO `municipios` VALUES (1208,'CIPO','BA');
INSERT INTO `municipios` VALUES (1209,'CIPOTÂNEA','MG');
INSERT INTO `municipios` VALUES (1210,'CIRIACO','RS');
INSERT INTO `municipios` VALUES (1211,'CLARAVAL','MG');
INSERT INTO `municipios` VALUES (1212,'CLARO DOS POÇÕES','MG');
INSERT INTO `municipios` VALUES (1213,'CLÁUDIA','MT');
INSERT INTO `municipios` VALUES (1214,'CLAUDIO','MG');
INSERT INTO `municipios` VALUES (1215,'CLEMENTINA','SP');
INSERT INTO `municipios` VALUES (1216,'CLEVELÂNDIA','PR');
INSERT INTO `municipios` VALUES (1217,'COARACI','BA');
INSERT INTO `municipios` VALUES (1218,'COARI','AM');
INSERT INTO `municipios` VALUES (1219,'COCAL','PI');
INSERT INTO `municipios` VALUES (1220,'COCAL DE TELHA','PI');
INSERT INTO `municipios` VALUES (1221,'COCAL DOS ALVES','PI');
INSERT INTO `municipios` VALUES (1222,'COCAL DO SUL','SC');
INSERT INTO `municipios` VALUES (1223,'COCALINHO','MT');
INSERT INTO `municipios` VALUES (1224,'COCALZINHO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (1225,'COCEICÃO DA APARECIDA','MG');
INSERT INTO `municipios` VALUES (1226,'COCOS','BA');
INSERT INTO `municipios` VALUES (1227,'CODAJAS','AM');
INSERT INTO `municipios` VALUES (1228,'CODO','MA');
INSERT INTO `municipios` VALUES (1229,'COELHO NETO','MA');
INSERT INTO `municipios` VALUES (1230,'COIMBRA','MG');
INSERT INTO `municipios` VALUES (1231,'COITE DO NOIA','AL');
INSERT INTO `municipios` VALUES (1232,'COIVARAS','PI');
INSERT INTO `municipios` VALUES (1233,'COLARES','PA');
INSERT INTO `municipios` VALUES (1234,'COLATINA','ES');
INSERT INTO `municipios` VALUES (1235,'COLIDER','MT');
INSERT INTO `municipios` VALUES (1236,'COLINA','SP');
INSERT INTO `municipios` VALUES (1237,'COLINAS','MA');
INSERT INTO `municipios` VALUES (1238,'COLINAS DO SUL','GO');
INSERT INTO `municipios` VALUES (1239,'COLINAS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (1240,'COLMEIA','TO');
INSERT INTO `municipios` VALUES (1241,'COLOMBIA','SP');
INSERT INTO `municipios` VALUES (1242,'COLOMBO','PR');
INSERT INTO `municipios` VALUES (1243,'COLONIA DE LEOPOLDINA','AL');
INSERT INTO `municipios` VALUES (1244,'COLÔNIA DO GURGUÉIA','PI');
INSERT INTO `municipios` VALUES (1245,'COLONIA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1246,'COLORADO','PR');
INSERT INTO `municipios` VALUES (1247,'COLORADO D\'OESTE','RO');
INSERT INTO `municipios` VALUES (1248,'COLUNA','MG');
INSERT INTO `municipios` VALUES (1249,'COMBINADO','TO');
INSERT INTO `municipios` VALUES (1250,'COMENDADOR GOMES','MG');
INSERT INTO `municipios` VALUES (1251,'COMENDADOR LEVY GASPARIAN','RJ');
INSERT INTO `municipios` VALUES (1252,'COMERCINHO','MG');
INSERT INTO `municipios` VALUES (1253,'COMODORO','MT');
INSERT INTO `municipios` VALUES (1254,'CONCEIÇÃO','PB');
INSERT INTO `municipios` VALUES (1255,'CONCEIÇÃO ARÁGUAIA','PA');
INSERT INTO `municipios` VALUES (1256,'CONCEIÇÃO BARRA DE MINAS','MG');
INSERT INTO `municipios` VALUES (1257,'CONCEIÇÃO DA BARRA','ES');
INSERT INTO `municipios` VALUES (1258,'CONCEIÇÃO DA FEIRA','BA');
INSERT INTO `municipios` VALUES (1259,'CONCEIÇÃO DAS ALAGOAS','MG');
INSERT INTO `municipios` VALUES (1260,'CONCEIÇÃO DAS PEDRAS','MG');
INSERT INTO `municipios` VALUES (1261,'CONCEIÇÃO DE IPANEMA','MG');
INSERT INTO `municipios` VALUES (1262,'CONCEIÇÃO DE MACABU','RJ');
INSERT INTO `municipios` VALUES (1263,'CONCEIÇÃO DO ALMEIDA','BA');
INSERT INTO `municipios` VALUES (1264,'CONCEIÇÃO DO CANINDE','PI');
INSERT INTO `municipios` VALUES (1265,'CONCEIÇÃO DO CASTELO','ES');
INSERT INTO `municipios` VALUES (1266,'CONCEIÇÃO DO COITÉ','BA');
INSERT INTO `municipios` VALUES (1267,'CONCEIÇÃO DO JAÇUIPE','BA');
INSERT INTO `municipios` VALUES (1268,'CONCEIÇÃO DO LAGO AÇU','MA');
INSERT INTO `municipios` VALUES (1269,'CONCEIÇÃO DO MATO DENTRO','MG');
INSERT INTO `municipios` VALUES (1270,'CONCEIÇÃO DO PARA','MG');
INSERT INTO `municipios` VALUES (1271,'CONCEIÇÃO DO RIO VERDE','MG');
INSERT INTO `municipios` VALUES (1272,'CONCEIÇÃO DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (1273,'CONCEIÇÃO DOS OUROS','MG');
INSERT INTO `municipios` VALUES (1274,'CONCHAL','SP');
INSERT INTO `municipios` VALUES (1275,'CONCHAS','SP');
INSERT INTO `municipios` VALUES (1276,'CONCORDIA','SC');
INSERT INTO `municipios` VALUES (1277,'CONCÓRDIA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (1278,'CONDADO','PB');
INSERT INTO `municipios` VALUES (1279,'CONDE','BA');
INSERT INTO `municipios` VALUES (1280,'CONDEUBA','BA');
INSERT INTO `municipios` VALUES (1281,'CONDOR','RS');
INSERT INTO `municipios` VALUES (1282,'CONFINS','MG');
INSERT INTO `municipios` VALUES (1283,'CONFRESA','MT');
INSERT INTO `municipios` VALUES (1284,'CONGO','PB');
INSERT INTO `municipios` VALUES (1285,'CONGONHAL','MG');
INSERT INTO `municipios` VALUES (1286,'CONGONHAS DO CAMPO','MG');
INSERT INTO `municipios` VALUES (1287,'CONGONHAS DO NORTE','MG');
INSERT INTO `municipios` VALUES (1288,'CONGONHINHAS','PR');
INSERT INTO `municipios` VALUES (1289,'CONQUISTA','MG');
INSERT INTO `municipios` VALUES (1290,'CONSELHEIRO LAFAIETE','MG');
INSERT INTO `municipios` VALUES (1291,'CONSELHEIRO MAIRINCK','PR');
INSERT INTO `municipios` VALUES (1292,'CONSELHEIRO PENA','MG');
INSERT INTO `municipios` VALUES (1293,'CONSOLACÃO','MG');
INSERT INTO `municipios` VALUES (1294,'CONSTANTINA','RS');
INSERT INTO `municipios` VALUES (1295,'CONTAGEM','MG');
INSERT INTO `municipios` VALUES (1296,'CONTENDA','PR');
INSERT INTO `municipios` VALUES (1297,'CONTENDAS DO SINCORA','BA');
INSERT INTO `municipios` VALUES (1298,'COQUEIRAL','MG');
INSERT INTO `municipios` VALUES (1299,'COQUEIRO BAIXO','RS');
INSERT INTO `municipios` VALUES (1300,'COQUEIRO SECO','AL');
INSERT INTO `municipios` VALUES (1301,'COQUEIROS DO SUL','RS');
INSERT INTO `municipios` VALUES (1302,'CORAÇÃO DE JESUS','MG');
INSERT INTO `municipios` VALUES (1303,'CORAÇÃO DE MARIA','BA');
INSERT INTO `municipios` VALUES (1304,'CORBÉLIA','PR');
INSERT INTO `municipios` VALUES (1305,'CORDEIRO','RJ');
INSERT INTO `municipios` VALUES (1306,'CORDEIRÓPOLIS','SP');
INSERT INTO `municipios` VALUES (1307,'CORDEIROS','BA');
INSERT INTO `municipios` VALUES (1308,'CORDILHEIRA ALTA','SC');
INSERT INTO `municipios` VALUES (1309,'CORDISBURGO','MG');
INSERT INTO `municipios` VALUES (1310,'CORDISLÂNDIA','MG');
INSERT INTO `municipios` VALUES (1311,'COREAU','CE');
INSERT INTO `municipios` VALUES (1312,'COREMAS','PB');
INSERT INTO `municipios` VALUES (1313,'CORGUINHO','MS');
INSERT INTO `municipios` VALUES (1314,'CORIBE','BA');
INSERT INTO `municipios` VALUES (1315,'CORINTO','MG');
INSERT INTO `municipios` VALUES (1316,'CORNÉLIO PROCÓPIO','PR');
INSERT INTO `municipios` VALUES (1317,'COROACI','MG');
INSERT INTO `municipios` VALUES (1318,'COROADOS','SP');
INSERT INTO `municipios` VALUES (1319,'COROATA','MA');
INSERT INTO `municipios` VALUES (1320,'COROMANDEL','MG');
INSERT INTO `municipios` VALUES (1321,'CORONEL BARROS','RS');
INSERT INTO `municipios` VALUES (1322,'CORONEL BICACO','RS');
INSERT INTO `municipios` VALUES (1323,'CORONEL DOMINGOS SOARES','PR');
INSERT INTO `municipios` VALUES (1324,'CORONEL EZEQUIEL','RN');
INSERT INTO `municipios` VALUES (1325,'CORONEL FABRICIANO','MG');
INSERT INTO `municipios` VALUES (1326,'CORONEL FREITAS','SC');
INSERT INTO `municipios` VALUES (1327,'CORONEL JOÃO PESSOA','RN');
INSERT INTO `municipios` VALUES (1328,'CORONEL JOÃO SÁ','BA');
INSERT INTO `municipios` VALUES (1329,'CORONEL JOSÉ DIAS','PI');
INSERT INTO `municipios` VALUES (1330,'CORONEL MACEDO','SP');
INSERT INTO `municipios` VALUES (1331,'CORONEL MARTINS','SC');
INSERT INTO `municipios` VALUES (1332,'CORONEL MURTA','MG');
INSERT INTO `municipios` VALUES (1333,'CORONEL PACHECO','MG');
INSERT INTO `municipios` VALUES (1334,'CORONEL PILAR','RS');
INSERT INTO `municipios` VALUES (1335,'CORONEL SAPUCAIA','MS');
INSERT INTO `municipios` VALUES (1336,'CORONEL VIVIDA','PR');
INSERT INTO `municipios` VALUES (1337,'CORONEL XAVIER CHAVES','MG');
INSERT INTO `municipios` VALUES (1338,'CORREGO DANTA','MG');
INSERT INTO `municipios` VALUES (1339,'CORREGO DO BOM JESUS','MG');
INSERT INTO `municipios` VALUES (1340,'CORREGO DO OURO','GO');
INSERT INTO `municipios` VALUES (1341,'CÓRREGO NOVO','MG');
INSERT INTO `municipios` VALUES (1342,'CORREIA PINTO','SC');
INSERT INTO `municipios` VALUES (1343,'CORRENTE','PI');
INSERT INTO `municipios` VALUES (1344,'CORRENTES','PE');
INSERT INTO `municipios` VALUES (1345,'CORRENTINA','BA');
INSERT INTO `municipios` VALUES (1346,'CORTES','PE');
INSERT INTO `municipios` VALUES (1347,'CORUMBA','MS');
INSERT INTO `municipios` VALUES (1348,'CORUMBA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (1349,'CORUMBAIBA','GO');
INSERT INTO `municipios` VALUES (1350,'CORUMBATAI','SP');
INSERT INTO `municipios` VALUES (1351,'CORUMBATAI DO SUL','PR');
INSERT INTO `municipios` VALUES (1352,'CORUMBIARA','RO');
INSERT INTO `municipios` VALUES (1353,'CORUPA','SC');
INSERT INTO `municipios` VALUES (1354,'CORURIPE','AL');
INSERT INTO `municipios` VALUES (1355,'COSMÓPOLIS','SP');
INSERT INTO `municipios` VALUES (1356,'COSMORAMA','SP');
INSERT INTO `municipios` VALUES (1357,'COSTA MARQUES','RO');
INSERT INTO `municipios` VALUES (1358,'COSTA RICA','MS');
INSERT INTO `municipios` VALUES (1359,'COTEGIPE','BA');
INSERT INTO `municipios` VALUES (1360,'COTIA','SP');
INSERT INTO `municipios` VALUES (1361,'COTIPORA','RS');
INSERT INTO `municipios` VALUES (1362,'COTRIGUAÇU','MT');
INSERT INTO `municipios` VALUES (1363,'COUTO DE MAGALHAES MINAS','MG');
INSERT INTO `municipios` VALUES (1364,'COUTO MAGALHAES','TO');
INSERT INTO `municipios` VALUES (1365,'COXILHA','RS');
INSERT INTO `municipios` VALUES (1366,'COXIM','MS');
INSERT INTO `municipios` VALUES (1367,'COXIXOLA','PB');
INSERT INTO `municipios` VALUES (1368,'CRAIBAS','AL');
INSERT INTO `municipios` VALUES (1369,'CRATEUS','CE');
INSERT INTO `municipios` VALUES (1370,'CRATO','CE');
INSERT INTO `municipios` VALUES (1371,'CRAVINHOS','SP');
INSERT INTO `municipios` VALUES (1372,'CRAVOLÂNDIA','BA');
INSERT INTO `municipios` VALUES (1373,'CRICIUMA','SC');
INSERT INTO `municipios` VALUES (1374,'CRISÓLITA','MG');
INSERT INTO `municipios` VALUES (1375,'CRISÓPOLIS','BA');
INSERT INTO `municipios` VALUES (1376,'CRISSIUMAL','RS');
INSERT INTO `municipios` VALUES (1377,'CRISTAIS','MG');
INSERT INTO `municipios` VALUES (1378,'CRISTAIS PAULISTA','SP');
INSERT INTO `municipios` VALUES (1379,'CRISTAL','RS');
INSERT INTO `municipios` VALUES (1380,'CRISTAL DO SUL','RS');
INSERT INTO `municipios` VALUES (1381,'CRISTALÂNDIA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1382,'CRISTÁLIA','MG');
INSERT INTO `municipios` VALUES (1383,'CRISTALINA','GO');
INSERT INTO `municipios` VALUES (1384,'CRISTIANO OTONI','MG');
INSERT INTO `municipios` VALUES (1385,'CRISTIANÓPOLIS','GO');
INSERT INTO `municipios` VALUES (1386,'CRISTINA','MG');
INSERT INTO `municipios` VALUES (1387,'CRISTINÁPOLIS','SE');
INSERT INTO `municipios` VALUES (1388,'CRISTINO CASTRO','PI');
INSERT INTO `municipios` VALUES (1389,'CRISTÓPOLIS','BA');
INSERT INTO `municipios` VALUES (1390,'CRIXAS','GO');
INSERT INTO `municipios` VALUES (1391,'CRIXAS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (1392,'CROATÁ','CE');
INSERT INTO `municipios` VALUES (1393,'CROMINIA','GO');
INSERT INTO `municipios` VALUES (1394,'CRUCILÂNDIA','MG');
INSERT INTO `municipios` VALUES (1395,'CRUZ','CE');
INSERT INTO `municipios` VALUES (1396,'CRUZ ALTA','RS');
INSERT INTO `municipios` VALUES (1397,'CRUZ DAS ALMAS','BA');
INSERT INTO `municipios` VALUES (1398,'CRUZ DO ESPÍRITO SANTO','PB');
INSERT INTO `municipios` VALUES (1399,'CRUZ MACHADO','PR');
INSERT INTO `municipios` VALUES (1400,'CRUZALIA','SP');
INSERT INTO `municipios` VALUES (1401,'CRUZEIRO','SP');
INSERT INTO `municipios` VALUES (1402,'CRUZEIRO DA FORTALEZA','MG');
INSERT INTO `municipios` VALUES (1403,'CRUZEIRO DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (1404,'CRUZEIRO DO OESTE','PR');
INSERT INTO `municipios` VALUES (1405,'CRUZEIRO DO SUL','AC');
INSERT INTO `municipios` VALUES (1406,'CRUZETA','RN');
INSERT INTO `municipios` VALUES (1407,'CRUZILIA','MG');
INSERT INTO `municipios` VALUES (1408,'CRUZMALTINA','PR');
INSERT INTO `municipios` VALUES (1409,'CUBATÃO','SP');
INSERT INTO `municipios` VALUES (1410,'CUBATI','PB');
INSERT INTO `municipios` VALUES (1411,'CUIABÁ','MT');
INSERT INTO `municipios` VALUES (1412,'CUITE','PB');
INSERT INTO `municipios` VALUES (1413,'CUITE DE MAMANGUAPE','PB');
INSERT INTO `municipios` VALUES (1414,'CUITEGI','PB');
INSERT INTO `municipios` VALUES (1415,'CUMARI','GO');
INSERT INTO `municipios` VALUES (1416,'CUMARU','PE');
INSERT INTO `municipios` VALUES (1417,'CUMARU DO NORTE','PA');
INSERT INTO `municipios` VALUES (1418,'CUMBE','SE');
INSERT INTO `municipios` VALUES (1419,'CUNHA','SP');
INSERT INTO `municipios` VALUES (1420,'CUNHAPORA','SC');
INSERT INTO `municipios` VALUES (1421,'CUNHATAI','SC');
INSERT INTO `municipios` VALUES (1422,'CUPARAQUE','MG');
INSERT INTO `municipios` VALUES (1423,'CUPIRA','PE');
INSERT INTO `municipios` VALUES (1424,'CURAÇÁ','BA');
INSERT INTO `municipios` VALUES (1425,'CURIMATA','PI');
INSERT INTO `municipios` VALUES (1426,'CURIONÓPOLIS','PA');
INSERT INTO `municipios` VALUES (1427,'CURITIBA','PR');
INSERT INTO `municipios` VALUES (1428,'CURITIBANOS','SC');
INSERT INTO `municipios` VALUES (1429,'CURIUVA','PR');
INSERT INTO `municipios` VALUES (1430,'CURRAIS','PI');
INSERT INTO `municipios` VALUES (1431,'CURRAIS NOVOS','RN');
INSERT INTO `municipios` VALUES (1432,'CURRAL DE CIMA','PB');
INSERT INTO `municipios` VALUES (1433,'CURRAL DE DENTRO','MG');
INSERT INTO `municipios` VALUES (1434,'CURRAL NOVO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1435,'CURRAL VELHO','PB');
INSERT INTO `municipios` VALUES (1436,'CURRALINHO','PA');
INSERT INTO `municipios` VALUES (1437,'CURRALINHOS','PI');
INSERT INTO `municipios` VALUES (1438,'CURUÁ','PA');
INSERT INTO `municipios` VALUES (1439,'CURUÇÁ','PA');
INSERT INTO `municipios` VALUES (1440,'CURURUPU','MA');
INSERT INTO `municipios` VALUES (1441,'CURVELO','MG');
INSERT INTO `municipios` VALUES (1442,'CUSTÓDIA','PE');
INSERT INTO `municipios` VALUES (1443,'CUTIAS DO ARAGUARI','AP');
INSERT INTO `municipios` VALUES (1444,'DAMIANÓPOLIS','GO');
INSERT INTO `municipios` VALUES (1445,'DAMIÃO','PB');
INSERT INTO `municipios` VALUES (1446,'DAMOLÂNDIA','GO');
INSERT INTO `municipios` VALUES (1447,'DARCINÓPOLIS','TO');
INSERT INTO `municipios` VALUES (1448,'DARIO MEIRA','BA');
INSERT INTO `municipios` VALUES (1449,'DATAS','MG');
INSERT INTO `municipios` VALUES (1450,'DAVID CANABARRO','RS');
INSERT INTO `municipios` VALUES (1451,'DAVINÓPOLIS','MA');
INSERT INTO `municipios` VALUES (1452,'DELFIM MOREIRA','MG');
INSERT INTO `municipios` VALUES (1453,'DELFINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1454,'DELMIRO GOLVEIA','AL');
INSERT INTO `municipios` VALUES (1455,'DELTA','MG');
INSERT INTO `municipios` VALUES (1456,'DEMERVAL LOBAO','PI');
INSERT INTO `municipios` VALUES (1457,'DENISE','MT');
INSERT INTO `municipios` VALUES (1458,'DEODÁPOLIS','MS');
INSERT INTO `municipios` VALUES (1459,'DEPUTADO IRAPUAN PINHEIRO','CE');
INSERT INTO `municipios` VALUES (1460,'DERESÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1461,'DERRUBADAS','RS');
INSERT INTO `municipios` VALUES (1462,'DESCALVADO','SP');
INSERT INTO `municipios` VALUES (1463,'DESCANSO','SC');
INSERT INTO `municipios` VALUES (1464,'DESCOBERTO','MG');
INSERT INTO `municipios` VALUES (1465,'DESTERRO','PB');
INSERT INTO `municipios` VALUES (1466,'DESTERRO DE ENTRE RIOS','MG');
INSERT INTO `municipios` VALUES (1467,'DESTERRO DO MELO','MG');
INSERT INTO `municipios` VALUES (1468,'DEZESSEIS DE NOVEMBRO','RS');
INSERT INTO `municipios` VALUES (1469,'DIADEMA','SP');
INSERT INTO `municipios` VALUES (1470,'DIAMANTE','PB');
INSERT INTO `municipios` VALUES (1471,'DIAMANTE DO NORTE','PR');
INSERT INTO `municipios` VALUES (1472,'DIAMANTE DO SUL','PR');
INSERT INTO `municipios` VALUES (1473,'DIAMANTE D\'OESTE','PR');
INSERT INTO `municipios` VALUES (1474,'DIAMANTINA','MG');
INSERT INTO `municipios` VALUES (1475,'DIAMANTINO','MT');
INSERT INTO `municipios` VALUES (1476,'DIANÓPOLIS','TO');
INSERT INTO `municipios` VALUES (1477,'DIAS D\'AVILA','BA');
INSERT INTO `municipios` VALUES (1478,'DILERMANDO DE AGUIAR','RS');
INSERT INTO `municipios` VALUES (1479,'DIOGO DE VASCONCELOS','MG');
INSERT INTO `municipios` VALUES (1480,'DIONISIO','MG');
INSERT INTO `municipios` VALUES (1481,'DIONISIO CERQUEIRA','SC');
INSERT INTO `municipios` VALUES (1482,'DIORAMA','GO');
INSERT INTO `municipios` VALUES (1483,'DIRCE REIS','SP');
INSERT INTO `municipios` VALUES (1484,'DIRCEU ARCOVERDE','PI');
INSERT INTO `municipios` VALUES (1485,'DIVIANÓPOLIS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (1486,'DIVINA PASTORA','SE');
INSERT INTO `municipios` VALUES (1487,'DIVINÉSIA','MG');
INSERT INTO `municipios` VALUES (1488,'DIVINO','MG');
INSERT INTO `municipios` VALUES (1489,'DIVINO DAS LARANJEIRAS','MG');
INSERT INTO `municipios` VALUES (1490,'DIVINO SÃO LOURENCO','ES');
INSERT INTO `municipios` VALUES (1491,'DIVINOLÂNDIA','SP');
INSERT INTO `municipios` VALUES (1492,'DIVINOLÂNDIA DE MINAS','MG');
INSERT INTO `municipios` VALUES (1493,'DIVINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1494,'DIVINÓPOLIS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (1495,'DIVISA ALEGRE','MG');
INSERT INTO `municipios` VALUES (1496,'DIVISA NOVA','MG');
INSERT INTO `municipios` VALUES (1497,'DIVISÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1498,'DOBRADA','SP');
INSERT INTO `municipios` VALUES (1499,'DOIS CORREGOS','SP');
INSERT INTO `municipios` VALUES (1500,'DOIS IRMAOS','RS');
INSERT INTO `municipios` VALUES (1501,'DOIS IRMÃOS DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (1502,'DOIS IRMÃOS DO BURITI','MS');
INSERT INTO `municipios` VALUES (1503,'DOIS IRMAOS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (1504,'DOIS LAJEADOS','RS');
INSERT INTO `municipios` VALUES (1505,'DOIS RIACHOS','AL');
INSERT INTO `municipios` VALUES (1506,'DOIS VIZINHOS','PR');
INSERT INTO `municipios` VALUES (1507,'DOLCINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (1508,'DOM AQUINO','MT');
INSERT INTO `municipios` VALUES (1509,'DOM BASILIO','BA');
INSERT INTO `municipios` VALUES (1510,'DOM BOSCO','MG');
INSERT INTO `municipios` VALUES (1511,'DOM CAVATI','MG');
INSERT INTO `municipios` VALUES (1512,'DOM ELISEU','PA');
INSERT INTO `municipios` VALUES (1513,'DOM EXPEDITO LOPES','PI');
INSERT INTO `municipios` VALUES (1514,'DOM FELICIANO','RS');
INSERT INTO `municipios` VALUES (1515,'DOM INOCÊNCIO','PI');
INSERT INTO `municipios` VALUES (1516,'DOM JOAQUIM','MG');
INSERT INTO `municipios` VALUES (1517,'DOM MACEDO COSTA','BA');
INSERT INTO `municipios` VALUES (1518,'DOM PEDRITO','RS');
INSERT INTO `municipios` VALUES (1519,'DOM PEDRO','MA');
INSERT INTO `municipios` VALUES (1520,'DOM PEDRO DE ALCANTARA','RS');
INSERT INTO `municipios` VALUES (1521,'DOM SILVERIO','MG');
INSERT INTO `municipios` VALUES (1522,'DOM VICOSO','MG');
INSERT INTO `municipios` VALUES (1523,'DOMINGOS MARTINS','ES');
INSERT INTO `municipios` VALUES (1524,'DOMINGOS MOURÃO','PI');
INSERT INTO `municipios` VALUES (1525,'DONA EMMA','SC');
INSERT INTO `municipios` VALUES (1526,'DONA EUZÉBIA','MG');
INSERT INTO `municipios` VALUES (1527,'DONA FRANCISCA','RS');
INSERT INTO `municipios` VALUES (1528,'DONA INES','PB');
INSERT INTO `municipios` VALUES (1529,'DORES DE CAMPOS','MG');
INSERT INTO `municipios` VALUES (1530,'DORES DE GUANHÃES','MG');
INSERT INTO `municipios` VALUES (1531,'DORES DO INDAIÁ','MG');
INSERT INTO `municipios` VALUES (1532,'DORES DO RIO PRETO','ES');
INSERT INTO `municipios` VALUES (1533,'DORES DO TURVO','MG');
INSERT INTO `municipios` VALUES (1534,'DORESÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1535,'DORMENTES','PE');
INSERT INTO `municipios` VALUES (1536,'DOURADINA','PR');
INSERT INTO `municipios` VALUES (1537,'DOURADO','SP');
INSERT INTO `municipios` VALUES (1538,'DOURADOQUARA','MG');
INSERT INTO `municipios` VALUES (1539,'DOURADOS','MS');
INSERT INTO `municipios` VALUES (1540,'DOUTOR MAURICIO CARDOSO','RS');
INSERT INTO `municipios` VALUES (1541,'DOUTOR PEDRINHO','SC');
INSERT INTO `municipios` VALUES (1542,'DOUTOR RICARDO','RS');
INSERT INTO `municipios` VALUES (1543,'DOUTOR SEVERIANO','RN');
INSERT INTO `municipios` VALUES (1544,'DOUTOR ULYSSES','PR');
INSERT INTO `municipios` VALUES (1545,'DOVERLÂNDIA','GO');
INSERT INTO `municipios` VALUES (1546,'DRACENA','SP');
INSERT INTO `municipios` VALUES (1547,'DUARTINA','SP');
INSERT INTO `municipios` VALUES (1548,'DUAS BARRAS','RJ');
INSERT INTO `municipios` VALUES (1549,'DUAS ESTRADAS','PB');
INSERT INTO `municipios` VALUES (1550,'DUERE','TO');
INSERT INTO `municipios` VALUES (1551,'DUMONT','SP');
INSERT INTO `municipios` VALUES (1552,'DUQUE BACELAR','MA');
INSERT INTO `municipios` VALUES (1553,'DUQUE DE CAXIAS','RJ');
INSERT INTO `municipios` VALUES (1554,'DURANDE','MG');
INSERT INTO `municipios` VALUES (1555,'ECHAPORÃ','SP');
INSERT INTO `municipios` VALUES (1556,'ECOPORANGA','ES');
INSERT INTO `municipios` VALUES (1557,'EDEALINA','GO');
INSERT INTO `municipios` VALUES (1558,'EDEIA','GO');
INSERT INTO `municipios` VALUES (1559,'EIRUNEPE','AM');
INSERT INTO `municipios` VALUES (1560,'ELDORADO','MS');
INSERT INTO `municipios` VALUES (1561,'ELDORADO DO SUL','RS');
INSERT INTO `municipios` VALUES (1562,'ELDORADO DOS CARAJÁS','PA');
INSERT INTO `municipios` VALUES (1563,'ELESBAO VELOSO','PI');
INSERT INTO `municipios` VALUES (1564,'ELIAS FAUSTO','SP');
INSERT INTO `municipios` VALUES (1565,'ELISIARIO','SP');
INSERT INTO `municipios` VALUES (1566,'ELISIO MEBRADO','BA');
INSERT INTO `municipios` VALUES (1567,'ELISEU MARTINS','PI');
INSERT INTO `municipios` VALUES (1568,'ELOI MENDES','MG');
INSERT INTO `municipios` VALUES (1569,'EMAS','PB');
INSERT INTO `municipios` VALUES (1570,'EMBAUBA','SP');
INSERT INTO `municipios` VALUES (1571,'EMBU','SP');
INSERT INTO `municipios` VALUES (1572,'EMBU-GUAÇU','SP');
INSERT INTO `municipios` VALUES (1573,'EMILIANÓPOLIS','SP');
INSERT INTO `municipios` VALUES (1574,'ENCANTADO','RS');
INSERT INTO `municipios` VALUES (1575,'ENCANTO','RN');
INSERT INTO `municipios` VALUES (1576,'ENCRUZILHADA','BA');
INSERT INTO `municipios` VALUES (1577,'ENCRUZILHADA DO SUL','RS');
INSERT INTO `municipios` VALUES (1578,'ENÉAS MARQUES','PR');
INSERT INTO `municipios` VALUES (1579,'ENGENHEIRO PAULO FRONTIN','RJ');
INSERT INTO `municipios` VALUES (1580,'ENGENHEIRO BELTRÃO','PR');
INSERT INTO `municipios` VALUES (1581,'ENGENHEIRO CALDAS','MG');
INSERT INTO `municipios` VALUES (1582,'ENGENHEIRO COELHO','SP');
INSERT INTO `municipios` VALUES (1583,'ENGENHEIRO NAVARRO','MG');
INSERT INTO `municipios` VALUES (1584,'ENGENHO VELHO','RS');
INSERT INTO `municipios` VALUES (1585,'ENTRE FOLHAS','MG');
INSERT INTO `municipios` VALUES (1586,'ENTRE IJUIS','RS');
INSERT INTO `municipios` VALUES (1587,'ENTRE RIOS DE MINAS','MG');
INSERT INTO `municipios` VALUES (1588,'ENTRE RIOS DO OESTE','PR');
INSERT INTO `municipios` VALUES (1589,'ENTRE RIOS DO SUL','RS');
INSERT INTO `municipios` VALUES (1590,'ENTRE RIOS SUL','RS');
INSERT INTO `municipios` VALUES (1591,'ENVIRA','AM');
INSERT INTO `municipios` VALUES (1592,'EPITACIOLÂNDIA','AC');
INSERT INTO `municipios` VALUES (1593,'EQUADOR','RN');
INSERT INTO `municipios` VALUES (1594,'EREBANGO','RS');
INSERT INTO `municipios` VALUES (1595,'ERECHIM','RS');
INSERT INTO `municipios` VALUES (1596,'ERERE','CE');
INSERT INTO `municipios` VALUES (1597,'ERICO CARDOSO','BA');
INSERT INTO `municipios` VALUES (1598,'ERMO','SC');
INSERT INTO `municipios` VALUES (1599,'ERNESTINA','RS');
INSERT INTO `municipios` VALUES (1600,'ERVAL GRANDE','RS');
INSERT INTO `municipios` VALUES (1601,'ERVAL SECO','RS');
INSERT INTO `municipios` VALUES (1602,'ERVAL VELHO','SC');
INSERT INTO `municipios` VALUES (1603,'ERVALIA','MG');
INSERT INTO `municipios` VALUES (1604,'ESCADA','PE');
INSERT INTO `municipios` VALUES (1605,'ESMERALDA','RS');
INSERT INTO `municipios` VALUES (1606,'ESMERALDAS','MG');
INSERT INTO `municipios` VALUES (1607,'ESPERA FELIZ','MG');
INSERT INTO `municipios` VALUES (1608,'ESPERANÇA','PB');
INSERT INTO `municipios` VALUES (1609,'ESPERANÇA DO SUL','RS');
INSERT INTO `municipios` VALUES (1610,'ESPERANÇA NOVA','PR');
INSERT INTO `municipios` VALUES (1611,'ESPERANTINA','PI');
INSERT INTO `municipios` VALUES (1612,'ESPERANTINÓPOLIS','MA');
INSERT INTO `municipios` VALUES (1613,'ESPIGAO ALTO DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (1614,'ESPIGÃO DO OESTE','RO');
INSERT INTO `municipios` VALUES (1615,'ESPINOSA','MG');
INSERT INTO `municipios` VALUES (1616,'ESPIRITO SANTO','RN');
INSERT INTO `municipios` VALUES (1617,'ESPIRITO SANTO DO DOURADO','MG');
INSERT INTO `municipios` VALUES (1618,'ESPIRITO SANTO DO OESTE','RN');
INSERT INTO `municipios` VALUES (1619,'ESPIRITO SANTO DO PINHAL','SP');
INSERT INTO `municipios` VALUES (1620,'ESPIRITO SANTO DO TURVO','SP');
INSERT INTO `municipios` VALUES (1621,'ESPLANADA','BA');
INSERT INTO `municipios` VALUES (1622,'ESPUMOSO','RS');
INSERT INTO `municipios` VALUES (1623,'ESTACÃO','RS');
INSERT INTO `municipios` VALUES (1624,'ESTÂNCIA','SE');
INSERT INTO `municipios` VALUES (1625,'ESTÂNCIA CLIMÁTICA DE MORUNGABA','SP');
INSERT INTO `municipios` VALUES (1626,'ESTÂNCIA VELHA','RS');
INSERT INTO `municipios` VALUES (1627,'ESTEIO','RS');
INSERT INTO `municipios` VALUES (1628,'ESTIVA','MG');
INSERT INTO `municipios` VALUES (1629,'ESTIVA GERBI','SP');
INSERT INTO `municipios` VALUES (1630,'ESTREITO','MA');
INSERT INTO `municipios` VALUES (1631,'ESTRELA','RS');
INSERT INTO `municipios` VALUES (1632,'ESTRELA DALVA','MG');
INSERT INTO `municipios` VALUES (1633,'ESTRELA DE ALAGOAS','AL');
INSERT INTO `municipios` VALUES (1634,'ESTRELA DO INDAIÁ','MG');
INSERT INTO `municipios` VALUES (1635,'ESTRELA DO NORTE','GO');
INSERT INTO `municipios` VALUES (1636,'ESTRELA DO SUL','MG');
INSERT INTO `municipios` VALUES (1637,'ESTRELA DO OESTE','SP');
INSERT INTO `municipios` VALUES (1638,'ESTRELA VELHA','RS');
INSERT INTO `municipios` VALUES (1639,'EUCLIDES DA CUNHA PAULISTA','SP');
INSERT INTO `municipios` VALUES (1640,'EUCLIDES DA CUNHA','BA');
INSERT INTO `municipios` VALUES (1641,'EUGENIO DE CASTRO','RS');
INSERT INTO `municipios` VALUES (1642,'EUGENÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1643,'EUNÁPOLIS','BA');
INSERT INTO `municipios` VALUES (1644,'EUSEBIO','CE');
INSERT INTO `municipios` VALUES (1645,'EWBANK DA CAMARA','MG');
INSERT INTO `municipios` VALUES (1646,'EXTREMA','MG');
INSERT INTO `municipios` VALUES (1647,'EXTREMOZ','RN');
INSERT INTO `municipios` VALUES (1648,'EXU','PE');
INSERT INTO `municipios` VALUES (1649,'FAGUNDES','PB');
INSERT INTO `municipios` VALUES (1650,'FAGUNDES VARELA','RS');
INSERT INTO `municipios` VALUES (1651,'FAINA','GO');
INSERT INTO `municipios` VALUES (1652,'FAMA','MG');
INSERT INTO `municipios` VALUES (1653,'FARIA LEMOS','MG');
INSERT INTO `municipios` VALUES (1654,'FARIAS BRITO','CE');
INSERT INTO `municipios` VALUES (1655,'FARO','PA');
INSERT INTO `municipios` VALUES (1656,'FAROL','PR');
INSERT INTO `municipios` VALUES (1657,'FARROUPILHA','RS');
INSERT INTO `municipios` VALUES (1658,'FARTURA','SP');
INSERT INTO `municipios` VALUES (1659,'FARTURA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1660,'FÁTIMA','BA');
INSERT INTO `municipios` VALUES (1661,'FÁTIMA DO SUL','MS');
INSERT INTO `municipios` VALUES (1662,'FAXINAL','PR');
INSERT INTO `municipios` VALUES (1663,'FAXINAL DO SOTURNO','RS');
INSERT INTO `municipios` VALUES (1664,'FAXINAL DOS GUEDES','SC');
INSERT INTO `municipios` VALUES (1665,'FAXINALZINHO','RS');
INSERT INTO `municipios` VALUES (1666,'FAZENDA NOVA','GO');
INSERT INTO `municipios` VALUES (1667,'FAZENDA RIO GRANDE','PR');
INSERT INTO `municipios` VALUES (1668,'FAZENDA VILA NOVA','RS');
INSERT INTO `municipios` VALUES (1669,'FEIJÓ','AC');
INSERT INTO `municipios` VALUES (1670,'FEIRA DA MATA','BA');
INSERT INTO `municipios` VALUES (1671,'FEIRA DE SANTANA','BA');
INSERT INTO `municipios` VALUES (1672,'FEIRA GRANDE','AL');
INSERT INTO `municipios` VALUES (1673,'FEIRA NOVA','SE');
INSERT INTO `municipios` VALUES (1674,'FEIRA NOVA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (1675,'FELICIO DOS SANTOS','MG');
INSERT INTO `municipios` VALUES (1676,'FELIPE GUERRA','RN');
INSERT INTO `municipios` VALUES (1677,'FELIZBURGO','MG');
INSERT INTO `municipios` VALUES (1678,'FELIXLÂNDIA','MG');
INSERT INTO `municipios` VALUES (1679,'FELIZ','RS');
INSERT INTO `municipios` VALUES (1680,'FELIZ DESERTO','AL');
INSERT INTO `municipios` VALUES (1681,'FELIZ NATAL','MT');
INSERT INTO `municipios` VALUES (1682,'FÊNIX','PR');
INSERT INTO `municipios` VALUES (1683,'FERNANDES TOURINHO','MG');
INSERT INTO `municipios` VALUES (1684,'FERNANDO FALCÃO','MA');
INSERT INTO `municipios` VALUES (1685,'FERNANDO PEDROZA','RN');
INSERT INTO `municipios` VALUES (1686,'FERNANDO PRESTES','SP');
INSERT INTO `municipios` VALUES (1687,'FERNANDÓPOLIS','SP');
INSERT INTO `municipios` VALUES (1688,'FERNÃO','SP');
INSERT INTO `municipios` VALUES (1689,'FERRAZ DE VASCONCELOS','SP');
INSERT INTO `municipios` VALUES (1690,'FERREIRA GOMES','AP');
INSERT INTO `municipios` VALUES (1691,'FERREIROS','PE');
INSERT INTO `municipios` VALUES (1692,'FERROS','MG');
INSERT INTO `municipios` VALUES (1693,'FERVEDOURO','MG');
INSERT INTO `municipios` VALUES (1694,'FIGUEIRA','PR');
INSERT INTO `municipios` VALUES (1695,'FIGUEIRÓPOLIS','TO');
INSERT INTO `municipios` VALUES (1696,'FIGUEIRÓPOLIS DO OESTE','MT');
INSERT INTO `municipios` VALUES (1697,'FILADELFIA','BA');
INSERT INTO `municipios` VALUES (1698,'FIRMINO ALVES','BA');
INSERT INTO `municipios` VALUES (1699,'FIRMINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (1700,'FLEXEIRAS','AL');
INSERT INTO `municipios` VALUES (1701,'FLOR DA SERRA DO SUL','PR');
INSERT INTO `municipios` VALUES (1702,'FLOR DO SERTÃO','SC');
INSERT INTO `municipios` VALUES (1703,'FLORA RICA','SP');
INSERT INTO `municipios` VALUES (1704,'FLORAÍ','PR');
INSERT INTO `municipios` VALUES (1705,'FLORANIA','RN');
INSERT INTO `municipios` VALUES (1706,'FLOREAL','SP');
INSERT INTO `municipios` VALUES (1707,'FLORES','PE');
INSERT INTO `municipios` VALUES (1708,'FLORES DA CUNHA','RS');
INSERT INTO `municipios` VALUES (1709,'FLORES DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (1710,'FLORES DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1711,'FLORESTA','PE');
INSERT INTO `municipios` VALUES (1712,'FLORESTA','PR');
INSERT INTO `municipios` VALUES (1713,'FLORESTA AZUL','BA');
INSERT INTO `municipios` VALUES (1714,'FLORESTA DO ARAGUAIA','PA');
INSERT INTO `municipios` VALUES (1715,'FLORESTA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (1716,'FLORESTAL','MG');
INSERT INTO `municipios` VALUES (1717,'FLORESTÓPOLIS','PR');
INSERT INTO `municipios` VALUES (1718,'FLORIANO','PI');
INSERT INTO `municipios` VALUES (1719,'FLORIANO PEIXOTO','RS');
INSERT INTO `municipios` VALUES (1720,'FLORIANÓPOLIS','SC');
INSERT INTO `municipios` VALUES (1721,'FLORIDA','PR');
INSERT INTO `municipios` VALUES (1722,'FLORIDA PAULISTA','SP');
INSERT INTO `municipios` VALUES (1723,'FLORÍNEA','SP');
INSERT INTO `municipios` VALUES (1724,'FONTE BOA','AM');
INSERT INTO `municipios` VALUES (1725,'FONTOURA XAVIER','RS');
INSERT INTO `municipios` VALUES (1726,'FORMIGA','MG');
INSERT INTO `municipios` VALUES (1727,'FORMIGUEIRO','RS');
INSERT INTO `municipios` VALUES (1728,'FORMOSA','GO');
INSERT INTO `municipios` VALUES (1729,'FORMOSA DA SERRA NEGRA','MA');
INSERT INTO `municipios` VALUES (1730,'FORMOSA DO OESTE','PR');
INSERT INTO `municipios` VALUES (1731,'FORMOSA DO RIO PRETO','BA');
INSERT INTO `municipios` VALUES (1732,'FORMOSA DO SUL','SC');
INSERT INTO `municipios` VALUES (1733,'FORMOSO','GO');
INSERT INTO `municipios` VALUES (1734,'FORMOSO DO ARAGUAIA','TO');
INSERT INTO `municipios` VALUES (1735,'FORQUILHA','CE');
INSERT INTO `municipios` VALUES (1736,'FORQUILHINHA','SC');
INSERT INTO `municipios` VALUES (1737,'FORTALEZA','CE');
INSERT INTO `municipios` VALUES (1738,'FORTALEZA DE MINAS','MG');
INSERT INTO `municipios` VALUES (1739,'FORTALEZA DO TABOCÃO','TO');
INSERT INTO `municipios` VALUES (1740,'FORTALEZA DOS NOGUEIRAS','MA');
INSERT INTO `municipios` VALUES (1741,'FORTALEZA DOS VALOS','RS');
INSERT INTO `municipios` VALUES (1742,'FORTIM','CE');
INSERT INTO `municipios` VALUES (1743,'FORTUNA','MA');
INSERT INTO `municipios` VALUES (1744,'FORTUNA DE MINAS','MG');
INSERT INTO `municipios` VALUES (1745,'FOZ DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (1746,'FOZ DO JORDÃO','PR');
INSERT INTO `municipios` VALUES (1747,'FRAIBURGO','SC');
INSERT INTO `municipios` VALUES (1748,'FRANCA','SP');
INSERT INTO `municipios` VALUES (1749,'FRANCINÓPOLIS','PI');
INSERT INTO `municipios` VALUES (1750,'FRANCISCO ALVES','PR');
INSERT INTO `municipios` VALUES (1751,'FRANCISCO AYRES','PI');
INSERT INTO `municipios` VALUES (1752,'FRANCISCO BADARÓ','MG');
INSERT INTO `municipios` VALUES (1753,'FRANCISCO BELTRÃO','PR');
INSERT INTO `municipios` VALUES (1754,'FRANCISCO DANTAS','RN');
INSERT INTO `municipios` VALUES (1755,'FRANCISCO DUMONT','MG');
INSERT INTO `municipios` VALUES (1756,'FRANCISCO MACEDO','PI');
INSERT INTO `municipios` VALUES (1757,'FRANCISCO MORATO','SP');
INSERT INTO `municipios` VALUES (1758,'FRANCISCO SÁ','MG');
INSERT INTO `municipios` VALUES (1759,'FRANCISCO SANTOS','PI');
INSERT INTO `municipios` VALUES (1760,'FRANCISCÓPOLIS','MG');
INSERT INTO `municipios` VALUES (1761,'FRANCO DA ROCHA','SP');
INSERT INTO `municipios` VALUES (1762,'FRECHEIRINHA','CE');
INSERT INTO `municipios` VALUES (1763,'FREDERICO WESTPHALEN','RS');
INSERT INTO `municipios` VALUES (1764,'FREI GASPAR','MG');
INSERT INTO `municipios` VALUES (1765,'FREI INOCENCIO','MG');
INSERT INTO `municipios` VALUES (1766,'FREI LAGO NEGRO','MG');
INSERT INTO `municipios` VALUES (1767,'FREI MARTINHO','PB');
INSERT INTO `municipios` VALUES (1768,'FREI MIGUELINHO','PE');
INSERT INTO `municipios` VALUES (1769,'FREI PAULO','SE');
INSERT INTO `municipios` VALUES (1770,'FRONTEIRA','MG');
INSERT INTO `municipios` VALUES (1771,'FRONTEIRA DOS VALES','MG');
INSERT INTO `municipios` VALUES (1772,'FRONTEIRAS','PI');
INSERT INTO `municipios` VALUES (1773,'FRUTAL','MG');
INSERT INTO `municipios` VALUES (1774,'FRUTUOSO GOMES','RN');
INSERT INTO `municipios` VALUES (1775,'FUNDÃO','ES');
INSERT INTO `municipios` VALUES (1776,'FUNILÂNDIA','MG');
INSERT INTO `municipios` VALUES (1777,'GABRIEL MONTEIRO','SP');
INSERT INTO `municipios` VALUES (1778,'GADO BRAVO','PB');
INSERT INTO `municipios` VALUES (1779,'GALIA','SP');
INSERT INTO `municipios` VALUES (1780,'GALILEIA','MG');
INSERT INTO `municipios` VALUES (1781,'GALINHOS','RN');
INSERT INTO `municipios` VALUES (1782,'GALVÃO','SC');
INSERT INTO `municipios` VALUES (1783,'GAMELEIRA','PE');
INSERT INTO `municipios` VALUES (1784,'GAMELEIRAS','MG');
INSERT INTO `municipios` VALUES (1785,'GANBU','BA');
INSERT INTO `municipios` VALUES (1786,'GARANHUNS','PE');
INSERT INTO `municipios` VALUES (1787,'GARARU','SE');
INSERT INTO `municipios` VALUES (1788,'GARÇA','SP');
INSERT INTO `municipios` VALUES (1789,'GARIBALDI','RS');
INSERT INTO `municipios` VALUES (1790,'GAROPABA','SC');
INSERT INTO `municipios` VALUES (1791,'GARRAFÃO DO NORTE','PA');
INSERT INTO `municipios` VALUES (1792,'GARRUCHOS','RS');
INSERT INTO `municipios` VALUES (1793,'GARUVA','SC');
INSERT INTO `municipios` VALUES (1794,'GASPAR','SC');
INSERT INTO `municipios` VALUES (1795,'GASTÃO VIDIGAL','SP');
INSERT INTO `municipios` VALUES (1796,'GAÚCHA DO NORTE','MT');
INSERT INTO `municipios` VALUES (1797,'GAURAMA','RS');
INSERT INTO `municipios` VALUES (1798,'GAVIÃO','BA');
INSERT INTO `municipios` VALUES (1799,'GAVIÃO PEIXOTO','SP');
INSERT INTO `municipios` VALUES (1800,'GEMINIANO','PI');
INSERT INTO `municipios` VALUES (1801,'GENERAL CAMARA','RS');
INSERT INTO `municipios` VALUES (1802,'GENERAL CARNEIRO','MT');
INSERT INTO `municipios` VALUES (1803,'GENERAL MAYNARD','SE');
INSERT INTO `municipios` VALUES (1804,'GENERAL SALGADO','SP');
INSERT INTO `municipios` VALUES (1805,'GENERAL SAMPAIO','CE');
INSERT INTO `municipios` VALUES (1806,'GENTIL','RS');
INSERT INTO `municipios` VALUES (1807,'GENTIO DO OURO','BA');
INSERT INTO `municipios` VALUES (1808,'GETULINA','SP');
INSERT INTO `municipios` VALUES (1809,'GETULIO VARGAS','RS');
INSERT INTO `municipios` VALUES (1810,'GILBUES','PI');
INSERT INTO `municipios` VALUES (1811,'GIRAU DO PONCIANO','AL');
INSERT INTO `municipios` VALUES (1812,'GIRUA','RS');
INSERT INTO `municipios` VALUES (1813,'GLAUCILÂNDIA','MG');
INSERT INTO `municipios` VALUES (1814,'GLICERIO','SP');
INSERT INTO `municipios` VALUES (1815,'GLÓRIA','BA');
INSERT INTO `municipios` VALUES (1816,'GLÓRIA DE DOURADOS','MS');
INSERT INTO `municipios` VALUES (1817,'GLÓRIA DO GOITA','PE');
INSERT INTO `municipios` VALUES (1818,'GLÓRIA D\'OESTE','MT');
INSERT INTO `municipios` VALUES (1819,'GLORINHA','RS');
INSERT INTO `municipios` VALUES (1820,'GODOFREDO VIANA','MA');
INSERT INTO `municipios` VALUES (1821,'GODOY MOREIRA','PR');
INSERT INTO `municipios` VALUES (1822,'GOIANÁ','MG');
INSERT INTO `municipios` VALUES (1823,'GOIANÁPOLIS','GO');
INSERT INTO `municipios` VALUES (1824,'GOIANDIRA','GO');
INSERT INTO `municipios` VALUES (1825,'GOIANESIA','GO');
INSERT INTO `municipios` VALUES (1826,'GOIANÉSIA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (1827,'GOIANIA','GO');
INSERT INTO `municipios` VALUES (1828,'GOIANINHA','RN');
INSERT INTO `municipios` VALUES (1829,'GOIANIRA','GO');
INSERT INTO `municipios` VALUES (1830,'GOIANORTE','TO');
INSERT INTO `municipios` VALUES (1831,'GOIÁS','GO');
INSERT INTO `municipios` VALUES (1832,'GOIATINS','TO');
INSERT INTO `municipios` VALUES (1833,'GOIATUBA','GO');
INSERT INTO `municipios` VALUES (1834,'GOIOERE','PR');
INSERT INTO `municipios` VALUES (1835,'GOIOXIM','PR');
INSERT INTO `municipios` VALUES (1836,'GONÇALVES','MG');
INSERT INTO `municipios` VALUES (1837,'GONÇALVES DIAS','MA');
INSERT INTO `municipios` VALUES (1838,'GONGOGI','BA');
INSERT INTO `municipios` VALUES (1839,'GONZAGA','MG');
INSERT INTO `municipios` VALUES (1840,'GOUVEIA','MG');
INSERT INTO `municipios` VALUES (1841,'GOUVELÂNDIA','GO');
INSERT INTO `municipios` VALUES (1842,'GOVERNADOR DIX-SEPT ROSADO','RN');
INSERT INTO `municipios` VALUES (1843,'GOVERNADOR ARCHER','MA');
INSERT INTO `municipios` VALUES (1844,'GOVERNADOR CELSO RAMOS','SC');
INSERT INTO `municipios` VALUES (1845,'GOVERNADOR EDSON LOBAO','MA');
INSERT INTO `municipios` VALUES (1846,'GOVERNADOR EUGENIO BARROS','MA');
INSERT INTO `municipios` VALUES (1847,'GOVERNADOR LOMANTO JUNIOR','BA');
INSERT INTO `municipios` VALUES (1848,'GOVERNADOR LUIS ROCHA','MA');
INSERT INTO `municipios` VALUES (1849,'GOVERNADOR MANGABEIRA','BA');
INSERT INTO `municipios` VALUES (1850,'GOVERNADOR NEWTON BELO','MA');
INSERT INTO `municipios` VALUES (1851,'GOVERNADOR NUNES FREIRE','MA');
INSERT INTO `municipios` VALUES (1852,'GOVERNADOR VALADARES','MG');
INSERT INTO `municipios` VALUES (1853,'GRAÇA','CE');
INSERT INTO `municipios` VALUES (1854,'GRAÇA ARANHA','MA');
INSERT INTO `municipios` VALUES (1855,'GRACCHO CARDOSO','SE');
INSERT INTO `municipios` VALUES (1856,'GRAJAU','MA');
INSERT INTO `municipios` VALUES (1857,'GRAMADO','RS');
INSERT INTO `municipios` VALUES (1858,'GRAMADO DOS LOUREIROS','RS');
INSERT INTO `municipios` VALUES (1859,'GRAMADO XAVIER','RS');
INSERT INTO `municipios` VALUES (1860,'GRANDES RIOS','PR');
INSERT INTO `municipios` VALUES (1861,'GRANITO','PE');
INSERT INTO `municipios` VALUES (1862,'GRANJA','CE');
INSERT INTO `municipios` VALUES (1863,'GRANJEIRO','CE');
INSERT INTO `municipios` VALUES (1864,'GRÃO MOGOL','MG');
INSERT INTO `municipios` VALUES (1865,'GRÃO-PARA','SC');
INSERT INTO `municipios` VALUES (1866,'GRAVATA','PE');
INSERT INTO `municipios` VALUES (1867,'GRAVATAÍ','RS');
INSERT INTO `municipios` VALUES (1868,'GRAVATAL','SC');
INSERT INTO `municipios` VALUES (1869,'GROAIRAS','CE');
INSERT INTO `municipios` VALUES (1870,'GROSSOS','RN');
INSERT INTO `municipios` VALUES (1871,'GRUPIARA','MG');
INSERT INTO `municipios` VALUES (1872,'GUABIJU','RS');
INSERT INTO `municipios` VALUES (1873,'GUABIRUBA','SC');
INSERT INTO `municipios` VALUES (1874,'GUAÇUÍ','ES');
INSERT INTO `municipios` VALUES (1875,'GUADALUPE','PI');
INSERT INTO `municipios` VALUES (1876,'GUAIBA','RS');
INSERT INTO `municipios` VALUES (1877,'GUAIÇARA','SP');
INSERT INTO `municipios` VALUES (1878,'GUAIMBÉ','SP');
INSERT INTO `municipios` VALUES (1879,'GUAIRA','PR');
INSERT INTO `municipios` VALUES (1880,'GUAIRAÇÁ','PR');
INSERT INTO `municipios` VALUES (1881,'GUAIUBA','CE');
INSERT INTO `municipios` VALUES (1882,'GUAJARA','AC');
INSERT INTO `municipios` VALUES (1883,'GUAJARA-MIRIM','RO');
INSERT INTO `municipios` VALUES (1884,'GUAJERU','BA');
INSERT INTO `municipios` VALUES (1885,'GUAMARE','RN');
INSERT INTO `municipios` VALUES (1886,'GUAMIRANGA','PR');
INSERT INTO `municipios` VALUES (1887,'GUANANBI','BA');
INSERT INTO `municipios` VALUES (1888,'GUANHÃES','MG');
INSERT INTO `municipios` VALUES (1889,'GUAPE','MG');
INSERT INTO `municipios` VALUES (1890,'GUAPIAÇU','SP');
INSERT INTO `municipios` VALUES (1891,'GUAPIARA','SP');
INSERT INTO `municipios` VALUES (1892,'GUAPIMIRIM','RJ');
INSERT INTO `municipios` VALUES (1893,'GUAPIRAMA','PR');
INSERT INTO `municipios` VALUES (1894,'GUAPÓ','GO');
INSERT INTO `municipios` VALUES (1895,'GUAPORE','RS');
INSERT INTO `municipios` VALUES (1896,'GUAPOREMA','PR');
INSERT INTO `municipios` VALUES (1897,'GUARA','SP');
INSERT INTO `municipios` VALUES (1898,'GUARABIRA','PB');
INSERT INTO `municipios` VALUES (1899,'GUARAÇAÍ','SP');
INSERT INTO `municipios` VALUES (1900,'GUARACI','PR');
INSERT INTO `municipios` VALUES (1901,'GUARACIABA','MG');
INSERT INTO `municipios` VALUES (1902,'GUARACIABA DO NORTE','CE');
INSERT INTO `municipios` VALUES (1903,'GUARACIAMA','MG');
INSERT INTO `municipios` VALUES (1904,'GUARAI','TO');
INSERT INTO `municipios` VALUES (1905,'GUARAÍTA','GO');
INSERT INTO `municipios` VALUES (1906,'GUARAMIRANGA','CE');
INSERT INTO `municipios` VALUES (1907,'GUARAMIRIM','SC');
INSERT INTO `municipios` VALUES (1908,'GUARANESIA','MG');
INSERT INTO `municipios` VALUES (1909,'GUARANI','MG');
INSERT INTO `municipios` VALUES (1910,'GUARANI DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (1911,'GUARANI DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (1912,'GUARANI DO OESTE','SP');
INSERT INTO `municipios` VALUES (1913,'GUARANIAÇU','PR');
INSERT INTO `municipios` VALUES (1914,'GUARANTÃ','SP');
INSERT INTO `municipios` VALUES (1915,'GUARANTA DO NORTE','MT');
INSERT INTO `municipios` VALUES (1916,'GUARAPARI','ES');
INSERT INTO `municipios` VALUES (1917,'GUARAPUAVA','PR');
INSERT INTO `municipios` VALUES (1918,'GUARAQUECABA','PR');
INSERT INTO `municipios` VALUES (1919,'GUARARA','MG');
INSERT INTO `municipios` VALUES (1920,'GUARARAPES','SP');
INSERT INTO `municipios` VALUES (1921,'GUARAREMA','SP');
INSERT INTO `municipios` VALUES (1922,'GUARATINGA','BA');
INSERT INTO `municipios` VALUES (1923,'GUARATINGUETA','SP');
INSERT INTO `municipios` VALUES (1924,'GUARATUBA','PR');
INSERT INTO `municipios` VALUES (1925,'GUARDA-MOR','MG');
INSERT INTO `municipios` VALUES (1926,'GUAREI','SP');
INSERT INTO `municipios` VALUES (1927,'GUARIBA','SP');
INSERT INTO `municipios` VALUES (1928,'GUARIBAS','PI');
INSERT INTO `municipios` VALUES (1929,'GUARINOS','GO');
INSERT INTO `municipios` VALUES (1930,'GUARUJA','SP');
INSERT INTO `municipios` VALUES (1931,'GUARUJA DO SUL','SC');
INSERT INTO `municipios` VALUES (1932,'GUARULHOS','SP');
INSERT INTO `municipios` VALUES (1933,'GUATAMBU','SC');
INSERT INTO `municipios` VALUES (1934,'GUATAPARÁ','SP');
INSERT INTO `municipios` VALUES (1935,'GUAXUPE','MG');
INSERT INTO `municipios` VALUES (1936,'GUIA LOPES DA LAGUNA','MS');
INSERT INTO `municipios` VALUES (1937,'GUIDOVAL','MG');
INSERT INTO `municipios` VALUES (1938,'GUIMARAES','MA');
INSERT INTO `municipios` VALUES (1939,'GUIMARANIA','MG');
INSERT INTO `municipios` VALUES (1940,'GUIRATINGA','MT');
INSERT INTO `municipios` VALUES (1941,'GUIRICEMA','MG');
INSERT INTO `municipios` VALUES (1942,'GURINHATA','MG');
INSERT INTO `municipios` VALUES (1943,'GURINHÉM','PB');
INSERT INTO `municipios` VALUES (1944,'GURJÃO','PB');
INSERT INTO `municipios` VALUES (1945,'GURUPA','PA');
INSERT INTO `municipios` VALUES (1946,'GURUPI','TO');
INSERT INTO `municipios` VALUES (1947,'GUZOLÂNDIA','SP');
INSERT INTO `municipios` VALUES (1948,'HARMONIA','RS');
INSERT INTO `municipios` VALUES (1949,'HEITORAI','GO');
INSERT INTO `municipios` VALUES (1950,'HELIODORA','MG');
INSERT INTO `municipios` VALUES (1951,'HELIÓPOLIS','BA');
INSERT INTO `municipios` VALUES (1952,'HERCULÂNDIA','SP');
INSERT INTO `municipios` VALUES (1953,'HERVAL','RS');
INSERT INTO `municipios` VALUES (1954,'HERVAL D\'OESTE','SC');
INSERT INTO `municipios` VALUES (1955,'HERVEIRAS','RS');
INSERT INTO `municipios` VALUES (1956,'HIDROLÂNDIA','CE');
INSERT INTO `municipios` VALUES (1957,'HIDROLINA','GO');
INSERT INTO `municipios` VALUES (1958,'HOLAMBRA','SP');
INSERT INTO `municipios` VALUES (1959,'HONORIO SERPA','PR');
INSERT INTO `municipios` VALUES (1960,'HORIZONTE','CE');
INSERT INTO `municipios` VALUES (1961,'HORIZONTINA','RS');
INSERT INTO `municipios` VALUES (1962,'HORTOLÂNDIA','SP');
INSERT INTO `municipios` VALUES (1963,'HUGO NAPOLEÃO','PI');
INSERT INTO `municipios` VALUES (1964,'HULHA NEGRA','RS');
INSERT INTO `municipios` VALUES (1965,'HUMAITA','AM');
INSERT INTO `municipios` VALUES (1966,'HUMBERTO DE CAMPOS','MA');
INSERT INTO `municipios` VALUES (1967,'IACANGA','SP');
INSERT INTO `municipios` VALUES (1968,'IACIARA','GO');
INSERT INTO `municipios` VALUES (1969,'IACRI','SP');
INSERT INTO `municipios` VALUES (1970,'IAÇU','BA');
INSERT INTO `municipios` VALUES (1971,'IAPU','MG');
INSERT INTO `municipios` VALUES (1972,'IARAS','SP');
INSERT INTO `municipios` VALUES (1973,'IATI','PE');
INSERT INTO `municipios` VALUES (1974,'IBAITI','PR');
INSERT INTO `municipios` VALUES (1975,'IBARAMA','RS');
INSERT INTO `municipios` VALUES (1976,'IBARETAMA','CE');
INSERT INTO `municipios` VALUES (1977,'IBATE','SP');
INSERT INTO `municipios` VALUES (1978,'IBATEGUARA','AL');
INSERT INTO `municipios` VALUES (1979,'IBATIBA','ES');
INSERT INTO `municipios` VALUES (1980,'IBEMA','PR');
INSERT INTO `municipios` VALUES (1981,'IBERTIOGA','MG');
INSERT INTO `municipios` VALUES (1982,'IBIA','MG');
INSERT INTO `municipios` VALUES (1983,'IBIACA','RS');
INSERT INTO `municipios` VALUES (1984,'IBIAI','MG');
INSERT INTO `municipios` VALUES (1985,'IBIAM','SC');
INSERT INTO `municipios` VALUES (1986,'IBIAPINA','CE');
INSERT INTO `municipios` VALUES (1987,'IBIARA','PB');
INSERT INTO `municipios` VALUES (1988,'IBIASSUCE','BA');
INSERT INTO `municipios` VALUES (1989,'IBICARAI','BA');
INSERT INTO `municipios` VALUES (1990,'IBICARE','SC');
INSERT INTO `municipios` VALUES (1991,'IBICOARA','BA');
INSERT INTO `municipios` VALUES (1992,'IBICUI','BA');
INSERT INTO `municipios` VALUES (1993,'IBICUTINGA','CE');
INSERT INTO `municipios` VALUES (1994,'IBIMIRIM','PE');
INSERT INTO `municipios` VALUES (1995,'IBIPEBA','BA');
INSERT INTO `municipios` VALUES (1996,'IBIPITANGA','BA');
INSERT INTO `municipios` VALUES (1997,'IBIPORÃ','PR');
INSERT INTO `municipios` VALUES (1998,'IBIQUERA','BA');
INSERT INTO `municipios` VALUES (1999,'IBIRA','SP');
INSERT INTO `municipios` VALUES (2000,'IBIRACATU','MG');
INSERT INTO `municipios` VALUES (2001,'IBIRACI','MG');
INSERT INTO `municipios` VALUES (2002,'IBIRAÇU','ES');
INSERT INTO `municipios` VALUES (2003,'IBIRAIARAS','RS');
INSERT INTO `municipios` VALUES (2004,'IBIRAJUBA','PE');
INSERT INTO `municipios` VALUES (2005,'IBIRAMA','SC');
INSERT INTO `municipios` VALUES (2006,'IBIRAPITANGA','BA');
INSERT INTO `municipios` VALUES (2007,'IBIRAPUÃ','BA');
INSERT INTO `municipios` VALUES (2008,'IBIRAPUITA','RS');
INSERT INTO `municipios` VALUES (2009,'IBIRAREMA','SP');
INSERT INTO `municipios` VALUES (2010,'IBIRATAIA','BA');
INSERT INTO `municipios` VALUES (2011,'IBIRITE','MG');
INSERT INTO `municipios` VALUES (2012,'IBIRUBA','RS');
INSERT INTO `municipios` VALUES (2013,'IBITIARA','BA');
INSERT INTO `municipios` VALUES (2014,'IBITIBA','BA');
INSERT INTO `municipios` VALUES (2015,'IBITINGA','SP');
INSERT INTO `municipios` VALUES (2016,'IBITIRAMA','ES');
INSERT INTO `municipios` VALUES (2017,'IBITIURA','MG');
INSERT INTO `municipios` VALUES (2018,'IBITIÚRA DE MINAS','MG');
INSERT INTO `municipios` VALUES (2019,'IBITURUNA','MG');
INSERT INTO `municipios` VALUES (2020,'IBIUNA','SP');
INSERT INTO `municipios` VALUES (2021,'ICAPUI','CE');
INSERT INTO `municipios` VALUES (2022,'ICARA','PA');
INSERT INTO `municipios` VALUES (2023,'ICARAI DE MINAS','MG');
INSERT INTO `municipios` VALUES (2024,'ICARAIMA','PR');
INSERT INTO `municipios` VALUES (2025,'ICATU','MA');
INSERT INTO `municipios` VALUES (2026,'ICÉM','SP');
INSERT INTO `municipios` VALUES (2027,'ICHU','BA');
INSERT INTO `municipios` VALUES (2028,'ICO','CE');
INSERT INTO `municipios` VALUES (2029,'ICONHA','ES');
INSERT INTO `municipios` VALUES (2030,'IELMO MARINHO','RN');
INSERT INTO `municipios` VALUES (2031,'IEPE','SP');
INSERT INTO `municipios` VALUES (2032,'IGAPORA','BA');
INSERT INTO `municipios` VALUES (2033,'IGARAÇU DO TIETE','SP');
INSERT INTO `municipios` VALUES (2034,'IGARACY','PB');
INSERT INTO `municipios` VALUES (2035,'IGARAPAVA','SP');
INSERT INTO `municipios` VALUES (2036,'IGARAPÉ DO MEIO','MA');
INSERT INTO `municipios` VALUES (2037,'IGARAPE GRANDE','MA');
INSERT INTO `municipios` VALUES (2038,'IGARAPÉ-AÇU','PA');
INSERT INTO `municipios` VALUES (2039,'IGARAPE-MIRIM','PA');
INSERT INTO `municipios` VALUES (2040,'IGARASSU','PE');
INSERT INTO `municipios` VALUES (2041,'IGARATÁ','SP');
INSERT INTO `municipios` VALUES (2042,'IGARATINGA','MG');
INSERT INTO `municipios` VALUES (2043,'IGREJA NOVA','AL');
INSERT INTO `municipios` VALUES (2044,'IGREJINHA','RS');
INSERT INTO `municipios` VALUES (2045,'IGUABA GRANDE','RJ');
INSERT INTO `municipios` VALUES (2046,'IGUACI','AL');
INSERT INTO `municipios` VALUES (2047,'IGUAI','BA');
INSERT INTO `municipios` VALUES (2048,'IGUAPE','SP');
INSERT INTO `municipios` VALUES (2049,'IGUARACI','PE');
INSERT INTO `municipios` VALUES (2050,'IGUARAÇU','PR');
INSERT INTO `municipios` VALUES (2051,'IGUATAMA','MG');
INSERT INTO `municipios` VALUES (2052,'IGUATEMI','MS');
INSERT INTO `municipios` VALUES (2053,'IGUATU','CE');
INSERT INTO `municipios` VALUES (2054,'IJACI','MG');
INSERT INTO `municipios` VALUES (2055,'IJUI','RS');
INSERT INTO `municipios` VALUES (2056,'ILHA COMPRIDA','SP');
INSERT INTO `municipios` VALUES (2057,'ILHA DE ITAMARACÁ','PE');
INSERT INTO `municipios` VALUES (2058,'ILHA GRANDE','PI');
INSERT INTO `municipios` VALUES (2059,'ILHA SOLTEIRA','SP');
INSERT INTO `municipios` VALUES (2060,'ILHABELA','SP');
INSERT INTO `municipios` VALUES (2061,'ILHA DAS FLORES','SE');
INSERT INTO `municipios` VALUES (2062,'ILHEUS','BA');
INSERT INTO `municipios` VALUES (2063,'ILHOTA','SC');
INSERT INTO `municipios` VALUES (2064,'ILICINEA','MG');
INSERT INTO `municipios` VALUES (2065,'ILÓPOLIS','RS');
INSERT INTO `municipios` VALUES (2066,'IMACULADA','PB');
INSERT INTO `municipios` VALUES (2067,'IMARUI','SC');
INSERT INTO `municipios` VALUES (2068,'IMBAU','PR');
INSERT INTO `municipios` VALUES (2069,'IMBÉ','RS');
INSERT INTO `municipios` VALUES (2070,'IMBITUBA','SC');
INSERT INTO `municipios` VALUES (2071,'IMBITUVA','PR');
INSERT INTO `municipios` VALUES (2072,'IMBUIA','SC');
INSERT INTO `municipios` VALUES (2073,'IMIGRANTE','RS');
INSERT INTO `municipios` VALUES (2074,'IMPERATRIZ','MA');
INSERT INTO `municipios` VALUES (2075,'INACIO MARTINS','PR');
INSERT INTO `municipios` VALUES (2076,'INACIOLÂNDIA','GO');
INSERT INTO `municipios` VALUES (2077,'INAJÁ','PR');
INSERT INTO `municipios` VALUES (2078,'INAJÁ','PE');
INSERT INTO `municipios` VALUES (2079,'INCONFIDENTES','MG');
INSERT INTO `municipios` VALUES (2080,'INDAIAL','SC');
INSERT INTO `municipios` VALUES (2081,'INDAIATUBA','SP');
INSERT INTO `municipios` VALUES (2082,'INDAJAVIRA','MG');
INSERT INTO `municipios` VALUES (2083,'INDEPENDÊNCIA','CE');
INSERT INTO `municipios` VALUES (2084,'INDIANA','SP');
INSERT INTO `municipios` VALUES (2085,'INDIANÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2086,'INDIAPORA','SP');
INSERT INTO `municipios` VALUES (2087,'INDIARA','GO');
INSERT INTO `municipios` VALUES (2088,'INDIAROBA','SE');
INSERT INTO `municipios` VALUES (2089,'INDIAVAI','MT');
INSERT INTO `municipios` VALUES (2090,'INGA','PB');
INSERT INTO `municipios` VALUES (2091,'INGAI','MG');
INSERT INTO `municipios` VALUES (2092,'INGAZEIRA','PE');
INSERT INTO `municipios` VALUES (2093,'INHACORA','RS');
INSERT INTO `municipios` VALUES (2094,'INHAMBUPE','BA');
INSERT INTO `municipios` VALUES (2095,'INHANGAPI','PA');
INSERT INTO `municipios` VALUES (2096,'INHAPI','AL');
INSERT INTO `municipios` VALUES (2097,'INHAPIM','MG');
INSERT INTO `municipios` VALUES (2098,'INHAUMA','MG');
INSERT INTO `municipios` VALUES (2099,'INHUMA','PI');
INSERT INTO `municipios` VALUES (2100,'INHUMAS','GO');
INSERT INTO `municipios` VALUES (2101,'INIMUTABA','MG');
INSERT INTO `municipios` VALUES (2102,'INOCÊNCIA','MS');
INSERT INTO `municipios` VALUES (2103,'INUBIA PAULISTA','SP');
INSERT INTO `municipios` VALUES (2104,'IOMERE','SC');
INSERT INTO `municipios` VALUES (2105,'IPABA','MG');
INSERT INTO `municipios` VALUES (2106,'IPAMERI','GO');
INSERT INTO `municipios` VALUES (2107,'IPANEMA','MG');
INSERT INTO `municipios` VALUES (2108,'IPANGUAÇU','RN');
INSERT INTO `municipios` VALUES (2109,'IPAPORANGA','CE');
INSERT INTO `municipios` VALUES (2110,'IPATINGA','MG');
INSERT INTO `municipios` VALUES (2111,'IPAUMIRIM','CE');
INSERT INTO `municipios` VALUES (2112,'IPAUSSU','SP');
INSERT INTO `municipios` VALUES (2113,'IPÊ','RS');
INSERT INTO `municipios` VALUES (2114,'IPECAETA','BA');
INSERT INTO `municipios` VALUES (2115,'IPERÓ','SP');
INSERT INTO `municipios` VALUES (2116,'IPEUNA','SP');
INSERT INTO `municipios` VALUES (2117,'IPIAÇU','MG');
INSERT INTO `municipios` VALUES (2118,'IPIAU','BA');
INSERT INTO `municipios` VALUES (2119,'IPIGUA','SP');
INSERT INTO `municipios` VALUES (2120,'IPIRÁ','BA');
INSERT INTO `municipios` VALUES (2121,'IPIRANGA','PR');
INSERT INTO `municipios` VALUES (2122,'IPIRANGA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2123,'IPIRANGA DO SUL','RS');
INSERT INTO `municipios` VALUES (2124,'IPIXUNA','AM');
INSERT INTO `municipios` VALUES (2125,'IPIXUNA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (2126,'IPOJUCA','PE');
INSERT INTO `municipios` VALUES (2127,'IPORA','GO');
INSERT INTO `municipios` VALUES (2128,'IPORA DO OESTE','SC');
INSERT INTO `municipios` VALUES (2129,'IPORANGA','SP');
INSERT INTO `municipios` VALUES (2130,'IPU','CE');
INSERT INTO `municipios` VALUES (2131,'IPUA','SP');
INSERT INTO `municipios` VALUES (2132,'IPUAÇU','SC');
INSERT INTO `municipios` VALUES (2133,'IPUBI','PE');
INSERT INTO `municipios` VALUES (2134,'IPUEIRA','RN');
INSERT INTO `municipios` VALUES (2135,'IPUEIRAS','CE');
INSERT INTO `municipios` VALUES (2136,'IPUIUNA','MG');
INSERT INTO `municipios` VALUES (2137,'IPUMIRIM','SC');
INSERT INTO `municipios` VALUES (2138,'IPUPIARA','BA');
INSERT INTO `municipios` VALUES (2139,'IRACEMA','CE');
INSERT INTO `municipios` VALUES (2140,'IRACEMA DO OESTE','PR');
INSERT INTO `municipios` VALUES (2141,'IRACEMAPOLIS','SP');
INSERT INTO `municipios` VALUES (2142,'IRACEMINHA','SC');
INSERT INTO `municipios` VALUES (2143,'IRAÍ','RS');
INSERT INTO `municipios` VALUES (2144,'IRAÍ DE MINAS','MG');
INSERT INTO `municipios` VALUES (2145,'IRAJUBA','BA');
INSERT INTO `municipios` VALUES (2146,'IRAMAIA','BA');
INSERT INTO `municipios` VALUES (2147,'IRAMUTA','RR');
INSERT INTO `municipios` VALUES (2148,'IRANDUBA','AM');
INSERT INTO `municipios` VALUES (2149,'IRANI','SC');
INSERT INTO `municipios` VALUES (2150,'IRAPUA','SP');
INSERT INTO `municipios` VALUES (2151,'IRAPURU','SP');
INSERT INTO `municipios` VALUES (2152,'IRARA','BA');
INSERT INTO `municipios` VALUES (2153,'IRATI','PR');
INSERT INTO `municipios` VALUES (2154,'IRAUCUBA','CE');
INSERT INTO `municipios` VALUES (2155,'IRECE','BA');
INSERT INTO `municipios` VALUES (2156,'IRETAMA','PR');
INSERT INTO `municipios` VALUES (2157,'IRINEÓPOLIS','SC');
INSERT INTO `municipios` VALUES (2158,'IRITUIA','PA');
INSERT INTO `municipios` VALUES (2159,'IRUPI','ES');
INSERT INTO `municipios` VALUES (2160,'ISAIAS COELHO','PI');
INSERT INTO `municipios` VALUES (2161,'ISRAELÂNDIA','GO');
INSERT INTO `municipios` VALUES (2162,'ITA','SC');
INSERT INTO `municipios` VALUES (2163,'ITAARA','RS');
INSERT INTO `municipios` VALUES (2164,'ITABAIANA','PB');
INSERT INTO `municipios` VALUES (2165,'ITABAIANA','SE');
INSERT INTO `municipios` VALUES (2166,'ITABAIANINHA','SE');
INSERT INTO `municipios` VALUES (2167,'ITABELA','BA');
INSERT INTO `municipios` VALUES (2168,'ITABERA','SP');
INSERT INTO `municipios` VALUES (2169,'ITABERABA','BA');
INSERT INTO `municipios` VALUES (2170,'ITABERAI','GO');
INSERT INTO `municipios` VALUES (2171,'ITABI','SE');
INSERT INTO `municipios` VALUES (2172,'ITABIRA','MG');
INSERT INTO `municipios` VALUES (2173,'ITABIRINHA DE MANTENA','MG');
INSERT INTO `municipios` VALUES (2174,'ITABIRITO','MG');
INSERT INTO `municipios` VALUES (2175,'ITABORAÍ','RJ');
INSERT INTO `municipios` VALUES (2176,'ITABUNA','BA');
INSERT INTO `municipios` VALUES (2177,'ITACAJA','TO');
INSERT INTO `municipios` VALUES (2178,'ITACAMBIRA','MG');
INSERT INTO `municipios` VALUES (2179,'ITACARAMBI','MG');
INSERT INTO `municipios` VALUES (2180,'ITACARÉ','BA');
INSERT INTO `municipios` VALUES (2181,'ITACOATIARA','AM');
INSERT INTO `municipios` VALUES (2182,'ITACURUBA','PE');
INSERT INTO `municipios` VALUES (2183,'ITAÇURUBI','RS');
INSERT INTO `municipios` VALUES (2184,'ITAETE','BA');
INSERT INTO `municipios` VALUES (2185,'ITAGI','BA');
INSERT INTO `municipios` VALUES (2186,'ITAGIBA','BA');
INSERT INTO `municipios` VALUES (2187,'ITAGIMIRIM','BA');
INSERT INTO `municipios` VALUES (2188,'ITAGUAÇU','ES');
INSERT INTO `municipios` VALUES (2189,'ITÁGUAÇU DA BAHIA','BA');
INSERT INTO `municipios` VALUES (2190,'ITAGUAÍ','RJ');
INSERT INTO `municipios` VALUES (2191,'ITAGUAJÉ','PR');
INSERT INTO `municipios` VALUES (2192,'ITÁGUARA','MG');
INSERT INTO `municipios` VALUES (2193,'ITAGUARI','GO');
INSERT INTO `municipios` VALUES (2194,'ITÁGUARU','GO');
INSERT INTO `municipios` VALUES (2195,'ITÁGUATINS','TO');
INSERT INTO `municipios` VALUES (2196,'ITAI','SP');
INSERT INTO `municipios` VALUES (2197,'ITAÍBA','PE');
INSERT INTO `municipios` VALUES (2198,'ITAICABA','CE');
INSERT INTO `municipios` VALUES (2199,'ITAINÓPOLIS','PI');
INSERT INTO `municipios` VALUES (2200,'ITAIÓPOLIS','SC');
INSERT INTO `municipios` VALUES (2201,'ITAIPAVA DO GRAJAU','MA');
INSERT INTO `municipios` VALUES (2202,'ITAIPÉ','MG');
INSERT INTO `municipios` VALUES (2203,'ITAIPULÂNDIA','PR');
INSERT INTO `municipios` VALUES (2204,'ITAITINGA','CE');
INSERT INTO `municipios` VALUES (2205,'ITAITUBA','PA');
INSERT INTO `municipios` VALUES (2206,'ITAJA','GO');
INSERT INTO `municipios` VALUES (2207,'ITAJAI','SC');
INSERT INTO `municipios` VALUES (2208,'ITAJOBI','SP');
INSERT INTO `municipios` VALUES (2209,'ITAJU','SP');
INSERT INTO `municipios` VALUES (2210,'ITAJU DO COLONIA','BA');
INSERT INTO `municipios` VALUES (2211,'ITAJUBA','MG');
INSERT INTO `municipios` VALUES (2212,'ITAJUIPE','BA');
INSERT INTO `municipios` VALUES (2213,'ITALVA','RJ');
INSERT INTO `municipios` VALUES (2214,'ITAMAGNA','BA');
INSERT INTO `municipios` VALUES (2215,'ITAMARAÇA','PE');
INSERT INTO `municipios` VALUES (2216,'ITAMARAJU','BA');
INSERT INTO `municipios` VALUES (2217,'ITAMARANDIBA','MG');
INSERT INTO `municipios` VALUES (2218,'ITAMARATI','AM');
INSERT INTO `municipios` VALUES (2219,'ITAMARATI DE MINAS','MG');
INSERT INTO `municipios` VALUES (2220,'ITAMARI','BA');
INSERT INTO `municipios` VALUES (2221,'ITAMBAÇURI','MG');
INSERT INTO `municipios` VALUES (2222,'ITAMBARAÇA','PR');
INSERT INTO `municipios` VALUES (2223,'ITAMBÉ','BA');
INSERT INTO `municipios` VALUES (2224,'ITAMBE DO MATO DENTRO','MG');
INSERT INTO `municipios` VALUES (2225,'ITAMOGI','MG');
INSERT INTO `municipios` VALUES (2226,'ITAMONTE','MG');
INSERT INTO `municipios` VALUES (2227,'ITANAGRA','BA');
INSERT INTO `municipios` VALUES (2228,'ITANHAEM','SP');
INSERT INTO `municipios` VALUES (2229,'ITANHANDU','MG');
INSERT INTO `municipios` VALUES (2230,'ITANHÉM','BA');
INSERT INTO `municipios` VALUES (2231,'ITANHOMI','MG');
INSERT INTO `municipios` VALUES (2232,'ITAOBIM','MG');
INSERT INTO `municipios` VALUES (2233,'ITAÓCA','SP');
INSERT INTO `municipios` VALUES (2234,'ITAPACI','GO');
INSERT INTO `municipios` VALUES (2235,'ITAPAGIPE','MG');
INSERT INTO `municipios` VALUES (2236,'ITAPAJE','CE');
INSERT INTO `municipios` VALUES (2237,'ITAPARICA','BA');
INSERT INTO `municipios` VALUES (2238,'ITAPÉ','BA');
INSERT INTO `municipios` VALUES (2239,'ITAPEBI','BA');
INSERT INTO `municipios` VALUES (2240,'ITAPECERICA','MG');
INSERT INTO `municipios` VALUES (2241,'ITAPECERICA DA SERRA','SP');
INSERT INTO `municipios` VALUES (2242,'ITAPECURU-MIRIM','MA');
INSERT INTO `municipios` VALUES (2243,'ITAPEJARA DO OESTE','PR');
INSERT INTO `municipios` VALUES (2244,'ITAPEMA','SC');
INSERT INTO `municipios` VALUES (2245,'ITAPEMIRIM','ES');
INSERT INTO `municipios` VALUES (2246,'ITAPERUCU','PR');
INSERT INTO `municipios` VALUES (2247,'ITAPERUNA','RJ');
INSERT INTO `municipios` VALUES (2248,'ITAPETIM','PE');
INSERT INTO `municipios` VALUES (2249,'ITAPETINGA','BA');
INSERT INTO `municipios` VALUES (2250,'ITAPETININGA','SP');
INSERT INTO `municipios` VALUES (2251,'ITAPEVA','MG');
INSERT INTO `municipios` VALUES (2252,'ITAPEVA','SP');
INSERT INTO `municipios` VALUES (2253,'ITAPEVI','SP');
INSERT INTO `municipios` VALUES (2254,'ITAPICURU','BA');
INSERT INTO `municipios` VALUES (2255,'ITAPIPOCA','CE');
INSERT INTO `municipios` VALUES (2256,'ITAPIRA','SP');
INSERT INTO `municipios` VALUES (2257,'ITAPIRANGA','AM');
INSERT INTO `municipios` VALUES (2258,'ITAPIRAPUA','GO');
INSERT INTO `municipios` VALUES (2259,'ITAPIRAPUÃ PAULISTA','SP');
INSERT INTO `municipios` VALUES (2260,'ITAPIRATINS','TO');
INSERT INTO `municipios` VALUES (2261,'ITAPISSUMA','PE');
INSERT INTO `municipios` VALUES (2262,'ITAPITANGA','BA');
INSERT INTO `municipios` VALUES (2263,'ITAPIUNA','CE');
INSERT INTO `municipios` VALUES (2264,'ITAPOÃ','SC');
INSERT INTO `municipios` VALUES (2265,'ITAPOA DO OESTE','RO');
INSERT INTO `municipios` VALUES (2266,'ITÁPOLIS','SP');
INSERT INTO `municipios` VALUES (2267,'ITAPORÃ','MS');
INSERT INTO `municipios` VALUES (2268,'ITAPORA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2269,'ITAPORANGA','PB');
INSERT INTO `municipios` VALUES (2270,'ITAPORANGA','SP');
INSERT INTO `municipios` VALUES (2271,'ITAPORANGA D\'AJUDA','SE');
INSERT INTO `municipios` VALUES (2272,'ITAPOROROCA','PB');
INSERT INTO `municipios` VALUES (2273,'ITAPUCA','RS');
INSERT INTO `municipios` VALUES (2274,'ITAPUI','SP');
INSERT INTO `municipios` VALUES (2275,'ITAPURA','SP');
INSERT INTO `municipios` VALUES (2276,'ITAPURANGA','GO');
INSERT INTO `municipios` VALUES (2277,'ITAQUAQUECETUBA','SP');
INSERT INTO `municipios` VALUES (2278,'ITAQUARA','BA');
INSERT INTO `municipios` VALUES (2279,'ITAQUI','RS');
INSERT INTO `municipios` VALUES (2280,'ITAQUIRAÍ','MS');
INSERT INTO `municipios` VALUES (2281,'ITAQUITINGA','PE');
INSERT INTO `municipios` VALUES (2282,'ITARANA','ES');
INSERT INTO `municipios` VALUES (2283,'ITARANTIM','BA');
INSERT INTO `municipios` VALUES (2284,'ITARARE','SP');
INSERT INTO `municipios` VALUES (2285,'ITAREMA','CE');
INSERT INTO `municipios` VALUES (2286,'ITARIRI','SP');
INSERT INTO `municipios` VALUES (2287,'ITARUMA','GO');
INSERT INTO `municipios` VALUES (2288,'ITATI','PR');
INSERT INTO `municipios` VALUES (2289,'ITATIAIA','RJ');
INSERT INTO `municipios` VALUES (2290,'ITATIAIUCU','MG');
INSERT INTO `municipios` VALUES (2291,'ITATIBA','SP');
INSERT INTO `municipios` VALUES (2292,'ITATIBA DO SUL','RS');
INSERT INTO `municipios` VALUES (2293,'ITATIM','BA');
INSERT INTO `municipios` VALUES (2294,'ITATINGA','SP');
INSERT INTO `municipios` VALUES (2295,'ITATIRA','CE');
INSERT INTO `municipios` VALUES (2296,'ITATUBA','PB');
INSERT INTO `municipios` VALUES (2297,'ITAU','RN');
INSERT INTO `municipios` VALUES (2298,'ITAU DE MINAS','MG');
INSERT INTO `municipios` VALUES (2299,'ITAÚBA','MT');
INSERT INTO `municipios` VALUES (2300,'ITAUBAL','AP');
INSERT INTO `municipios` VALUES (2301,'ITAUCU','GO');
INSERT INTO `municipios` VALUES (2302,'ITAUEIRA','PI');
INSERT INTO `municipios` VALUES (2303,'ITAUNA','MG');
INSERT INTO `municipios` VALUES (2304,'ITAÚNA DO SUL','PR');
INSERT INTO `municipios` VALUES (2305,'ITAVERAVA','MG');
INSERT INTO `municipios` VALUES (2306,'ITINGA','MG');
INSERT INTO `municipios` VALUES (2307,'ITINGA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (2308,'ITIQUIRA','MT');
INSERT INTO `municipios` VALUES (2309,'ITIRAPINA','SP');
INSERT INTO `municipios` VALUES (2310,'ITIRAPUA','SP');
INSERT INTO `municipios` VALUES (2311,'ITIRUÇU','BA');
INSERT INTO `municipios` VALUES (2312,'ITIÚBA','BA');
INSERT INTO `municipios` VALUES (2313,'ITOBI','SP');
INSERT INTO `municipios` VALUES (2314,'ITORORO','BA');
INSERT INTO `municipios` VALUES (2315,'ITU','SP');
INSERT INTO `municipios` VALUES (2316,'ITUAÇU','BA');
INSERT INTO `municipios` VALUES (2317,'ITUBERA','BA');
INSERT INTO `municipios` VALUES (2318,'ITUETA','MG');
INSERT INTO `municipios` VALUES (2319,'ITUIUTABA','MG');
INSERT INTO `municipios` VALUES (2320,'ITUMBIARA','GO');
INSERT INTO `municipios` VALUES (2321,'ITUMIRIM','MG');
INSERT INTO `municipios` VALUES (2322,'ITUPEVA','SP');
INSERT INTO `municipios` VALUES (2323,'ITUPIRANGA','PA');
INSERT INTO `municipios` VALUES (2324,'ITUPORANGA','SC');
INSERT INTO `municipios` VALUES (2325,'ITURAMA','MG');
INSERT INTO `municipios` VALUES (2326,'ITUTINGA','MG');
INSERT INTO `municipios` VALUES (2327,'ITUVERAVA','SP');
INSERT INTO `municipios` VALUES (2328,'IUIU','BA');
INSERT INTO `municipios` VALUES (2329,'IUNA','ES');
INSERT INTO `municipios` VALUES (2330,'IVAÍ','PR');
INSERT INTO `municipios` VALUES (2331,'IVAIPORÃ','PR');
INSERT INTO `municipios` VALUES (2332,'IVATE','PR');
INSERT INTO `municipios` VALUES (2333,'IVATUBA','PR');
INSERT INTO `municipios` VALUES (2334,'IVINHEMA','MS');
INSERT INTO `municipios` VALUES (2335,'IVOLÂNDIA','GO');
INSERT INTO `municipios` VALUES (2336,'IVORA','RS');
INSERT INTO `municipios` VALUES (2337,'IVOTI','RS');
INSERT INTO `municipios` VALUES (2338,'JABOATÃO DOS GUARARAPES','PE');
INSERT INTO `municipios` VALUES (2339,'JABORA','SC');
INSERT INTO `municipios` VALUES (2340,'JABORANDI','BA');
INSERT INTO `municipios` VALUES (2341,'JABOTI','PR');
INSERT INTO `municipios` VALUES (2342,'JABOTICABA','RS');
INSERT INTO `municipios` VALUES (2343,'JABOTICABAL','SP');
INSERT INTO `municipios` VALUES (2344,'JABOTICATUBAS','MG');
INSERT INTO `municipios` VALUES (2345,'JACANA','RN');
INSERT INTO `municipios` VALUES (2346,'JACARACI','BA');
INSERT INTO `municipios` VALUES (2347,'JACARAU','PB');
INSERT INTO `municipios` VALUES (2348,'JACARÉ DOS HOMENS','AL');
INSERT INTO `municipios` VALUES (2349,'JACARÉACANGA','PA');
INSERT INTO `municipios` VALUES (2350,'JACARÉÍ','SP');
INSERT INTO `municipios` VALUES (2351,'JACARÉZINHO','PR');
INSERT INTO `municipios` VALUES (2352,'JACI','SP');
INSERT INTO `municipios` VALUES (2353,'JACIARA','MT');
INSERT INTO `municipios` VALUES (2354,'JACINTO','MG');
INSERT INTO `municipios` VALUES (2355,'JACINTO MACHADO','SC');
INSERT INTO `municipios` VALUES (2356,'JACOBINA','BA');
INSERT INTO `municipios` VALUES (2357,'JACOBINA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2358,'JAÇUI','MG');
INSERT INTO `municipios` VALUES (2359,'JAÇUNDA','PA');
INSERT INTO `municipios` VALUES (2360,'JACUPIRANGA','SP');
INSERT INTO `municipios` VALUES (2361,'JACUTINGA','RS');
INSERT INTO `municipios` VALUES (2362,'JAÇUTINGA','MG');
INSERT INTO `municipios` VALUES (2363,'JÁGUAPITA','PR');
INSERT INTO `municipios` VALUES (2364,'JÁGUAQUARA','BA');
INSERT INTO `municipios` VALUES (2365,'JÁGUARAÇU','MG');
INSERT INTO `municipios` VALUES (2366,'JAGUARÃO','RS');
INSERT INTO `municipios` VALUES (2367,'JAGUARARI','BA');
INSERT INTO `municipios` VALUES (2368,'JÁGUARE','ES');
INSERT INTO `municipios` VALUES (2369,'JÁGUARETAMA','CE');
INSERT INTO `municipios` VALUES (2370,'JÁGUARI','RS');
INSERT INTO `municipios` VALUES (2371,'JAGUARIAÍVA','PR');
INSERT INTO `municipios` VALUES (2372,'JÁGUARIBARA','CE');
INSERT INTO `municipios` VALUES (2373,'JÁGUARIBE','CE');
INSERT INTO `municipios` VALUES (2374,'JÁGUARIUNA','SP');
INSERT INTO `municipios` VALUES (2375,'JÁGUARUANA','CE');
INSERT INTO `municipios` VALUES (2376,'JÁGUARUNA','SC');
INSERT INTO `municipios` VALUES (2377,'JAÍBA','MG');
INSERT INTO `municipios` VALUES (2378,'JAICOS','PI');
INSERT INTO `municipios` VALUES (2379,'JALES','SP');
INSERT INTO `municipios` VALUES (2380,'JAMARI','RO');
INSERT INTO `municipios` VALUES (2381,'JAMBEIRO','SP');
INSERT INTO `municipios` VALUES (2382,'JAMPRUCA','MG');
INSERT INTO `municipios` VALUES (2383,'JANAÚBA','MG');
INSERT INTO `municipios` VALUES (2384,'JANDAIA','GO');
INSERT INTO `municipios` VALUES (2385,'JANDAIA DO SUL','PR');
INSERT INTO `municipios` VALUES (2386,'JANDAÍRA','BA');
INSERT INTO `municipios` VALUES (2387,'JANDIRA','SP');
INSERT INTO `municipios` VALUES (2388,'JANDUIS','RN');
INSERT INTO `municipios` VALUES (2389,'JANGADA','MT');
INSERT INTO `municipios` VALUES (2390,'JANIÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2391,'JANUARIA','MG');
INSERT INTO `municipios` VALUES (2392,'JAPARAÍBA','MG');
INSERT INTO `municipios` VALUES (2393,'JAPARATINGA','AL');
INSERT INTO `municipios` VALUES (2394,'JAPARATUBA','SE');
INSERT INTO `municipios` VALUES (2395,'JAPERI','RJ');
INSERT INTO `municipios` VALUES (2396,'JAPI','RN');
INSERT INTO `municipios` VALUES (2397,'JAPIRA','PR');
INSERT INTO `municipios` VALUES (2398,'JAPOATÃ','SE');
INSERT INTO `municipios` VALUES (2399,'JAPORÃ','MS');
INSERT INTO `municipios` VALUES (2400,'JAPURA','AM');
INSERT INTO `municipios` VALUES (2401,'JAQUARIPE','BA');
INSERT INTO `municipios` VALUES (2402,'JAQUEIRA','PE');
INSERT INTO `municipios` VALUES (2403,'JAQUIRANA','RS');
INSERT INTO `municipios` VALUES (2404,'JARÁGUA','GO');
INSERT INTO `municipios` VALUES (2405,'JARÁGUA DO SUL','SC');
INSERT INTO `municipios` VALUES (2406,'JARAGUARI','MS');
INSERT INTO `municipios` VALUES (2407,'JARAMATAIA','AL');
INSERT INTO `municipios` VALUES (2408,'JARDIM','CE');
INSERT INTO `municipios` VALUES (2409,'JARDIM ALEGRE','PR');
INSERT INTO `municipios` VALUES (2410,'JARDIM DE ANGICOS','RN');
INSERT INTO `municipios` VALUES (2411,'JARDIM DE MULATO','PI');
INSERT INTO `municipios` VALUES (2412,'JARDIM DE PIRANHAS','RN');
INSERT INTO `municipios` VALUES (2413,'JARDIM OLINDA','PR');
INSERT INTO `municipios` VALUES (2414,'JARDIM SERIDO','RN');
INSERT INTO `municipios` VALUES (2415,'JARDINÓPOLIS','SC');
INSERT INTO `municipios` VALUES (2416,'JARI','RS');
INSERT INTO `municipios` VALUES (2417,'JARINU','SP');
INSERT INTO `municipios` VALUES (2418,'JARU','RO');
INSERT INTO `municipios` VALUES (2419,'JATAI','GO');
INSERT INTO `municipios` VALUES (2420,'JATAIZINHO','PR');
INSERT INTO `municipios` VALUES (2421,'JATAUBA','PE');
INSERT INTO `municipios` VALUES (2422,'JATEI','MS');
INSERT INTO `municipios` VALUES (2423,'JATI','CE');
INSERT INTO `municipios` VALUES (2424,'JATOBÁ','MA');
INSERT INTO `municipios` VALUES (2425,'JATOBA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2426,'JAÚ DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2427,'JAU DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2428,'JAUPACI','GO');
INSERT INTO `municipios` VALUES (2429,'JAURU','MT');
INSERT INTO `municipios` VALUES (2430,'JECEABA','MG');
INSERT INTO `municipios` VALUES (2431,'JENIPAPO DE MINAS','MG');
INSERT INTO `municipios` VALUES (2432,'JENIPAPO DOS VIEIRAS','MA');
INSERT INTO `municipios` VALUES (2433,'JEQUERI','MG');
INSERT INTO `municipios` VALUES (2434,'JEQUIE','BA');
INSERT INTO `municipios` VALUES (2435,'JEQUITAÍ','MG');
INSERT INTO `municipios` VALUES (2436,'JEQUITIBÁ','MG');
INSERT INTO `municipios` VALUES (2437,'JEQUITINHONHA','MG');
INSERT INTO `municipios` VALUES (2438,'JEREMOABO','BA');
INSERT INTO `municipios` VALUES (2439,'JERICÓ','PB');
INSERT INTO `municipios` VALUES (2440,'JERIQUARA','SP');
INSERT INTO `municipios` VALUES (2441,'JERONIMO MONTEIRO','ES');
INSERT INTO `municipios` VALUES (2442,'JERUMENHA','PI');
INSERT INTO `municipios` VALUES (2443,'JESUANIA','MG');
INSERT INTO `municipios` VALUES (2444,'JESUITAS','PR');
INSERT INTO `municipios` VALUES (2445,'JESUPOLIS','GO');
INSERT INTO `municipios` VALUES (2446,'JIJOCA','CE');
INSERT INTO `municipios` VALUES (2447,'JI-PARANÁ','RO');
INSERT INTO `municipios` VALUES (2448,'JIQUIRICA','BA');
INSERT INTO `municipios` VALUES (2449,'JITAUMA','BA');
INSERT INTO `municipios` VALUES (2450,'JOAÇABA','SC');
INSERT INTO `municipios` VALUES (2451,'JOAIMA','MG');
INSERT INTO `municipios` VALUES (2452,'JOANÉSIA','MG');
INSERT INTO `municipios` VALUES (2453,'JOANÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2454,'JOÃO ALFREDO','PE');
INSERT INTO `municipios` VALUES (2455,'JOÃO CÂMARA','RN');
INSERT INTO `municipios` VALUES (2456,'JOÃO COSTA','PI');
INSERT INTO `municipios` VALUES (2457,'JOÃO DIAS','RN');
INSERT INTO `municipios` VALUES (2458,'JOÃO DOURADO','BA');
INSERT INTO `municipios` VALUES (2459,'JOÃO LISBOA','MA');
INSERT INTO `municipios` VALUES (2460,'JOÃO MONLEVADE','MG');
INSERT INTO `municipios` VALUES (2461,'JOÃO NEIVA','ES');
INSERT INTO `municipios` VALUES (2462,'JOÃO PESSOA','PB');
INSERT INTO `municipios` VALUES (2463,'JOÃO PINHEIRO','MG');
INSERT INTO `municipios` VALUES (2464,'JOÃO RAMALHO','SP');
INSERT INTO `municipios` VALUES (2465,'JOAQUIM FELICIO','MG');
INSERT INTO `municipios` VALUES (2466,'JOAQUIM GOMES','AL');
INSERT INTO `municipios` VALUES (2467,'JOAQUIM NABUCO','PE');
INSERT INTO `municipios` VALUES (2468,'JOAQUIM PIRES','PI');
INSERT INTO `municipios` VALUES (2469,'JOAQUIM TAVORA','PR');
INSERT INTO `municipios` VALUES (2470,'JOCA MARQUES','PI');
INSERT INTO `municipios` VALUES (2471,'JOIA','RS');
INSERT INTO `municipios` VALUES (2472,'JOINVILLE','SC');
INSERT INTO `municipios` VALUES (2473,'JORDANIA','MG');
INSERT INTO `municipios` VALUES (2474,'JORDÃO','AC');
INSERT INTO `municipios` VALUES (2475,'JOSÉ BOITEUX','SC');
INSERT INTO `municipios` VALUES (2476,'JOSÉ BONIFACIO','SP');
INSERT INTO `municipios` VALUES (2477,'JOSÉ DA PENHA','RN');
INSERT INTO `municipios` VALUES (2478,'JOSÉ DE FREITAS','PI');
INSERT INTO `municipios` VALUES (2479,'JOSÉ GONÇALVES DE MINAS','MG');
INSERT INTO `municipios` VALUES (2480,'JOSÉ RAYDAN','MG');
INSERT INTO `municipios` VALUES (2481,'JOSÉLÂNDIA','MA');
INSERT INTO `municipios` VALUES (2482,'JOSENÓPOLIS','MG');
INSERT INTO `municipios` VALUES (2483,'JOVIÂNIA','GO');
INSERT INTO `municipios` VALUES (2484,'JUARA','MT');
INSERT INTO `municipios` VALUES (2485,'JUAREZ TAVORA','PB');
INSERT INTO `municipios` VALUES (2486,'JUARINA','TO');
INSERT INTO `municipios` VALUES (2487,'JUATUBA','MG');
INSERT INTO `municipios` VALUES (2488,'JUAZEIRINHO','PB');
INSERT INTO `municipios` VALUES (2489,'JUAZEIRO','BA');
INSERT INTO `municipios` VALUES (2490,'JUAZEIRO DO NORTE','CE');
INSERT INTO `municipios` VALUES (2491,'JUAZEIRO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2492,'JUCAS','CE');
INSERT INTO `municipios` VALUES (2493,'JUCATI','PE');
INSERT INTO `municipios` VALUES (2494,'JUCURUÇU','BA');
INSERT INTO `municipios` VALUES (2495,'JUCURUTU','RN');
INSERT INTO `municipios` VALUES (2496,'JUÍNA','MT');
INSERT INTO `municipios` VALUES (2497,'JUIZ DE FORA','MG');
INSERT INTO `municipios` VALUES (2498,'JULIO BORGES','PI');
INSERT INTO `municipios` VALUES (2499,'JÚLIO DE CASTILHOS','RS');
INSERT INTO `municipios` VALUES (2500,'JÚLIO MESQUITA','SP');
INSERT INTO `municipios` VALUES (2501,'JUMIRIM','SP');
INSERT INTO `municipios` VALUES (2502,'JUNCO DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (2503,'JUNCO DO SERIDO','PB');
INSERT INTO `municipios` VALUES (2504,'JUNDIA','AL');
INSERT INTO `municipios` VALUES (2505,'JUNDIAI','SP');
INSERT INTO `municipios` VALUES (2506,'JUNDIAI DO SUL','PR');
INSERT INTO `municipios` VALUES (2507,'JUNQUEIRO','AL');
INSERT INTO `municipios` VALUES (2508,'JUNQUEIRÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2509,'JUPI','PE');
INSERT INTO `municipios` VALUES (2510,'JUPIÁ','SC');
INSERT INTO `municipios` VALUES (2511,'JUQUIÁ','SP');
INSERT INTO `municipios` VALUES (2512,'JUQUITIBA','SP');
INSERT INTO `municipios` VALUES (2513,'JURAMENTO','MG');
INSERT INTO `municipios` VALUES (2514,'JURANDA','PR');
INSERT INTO `municipios` VALUES (2515,'JUREMA','PE');
INSERT INTO `municipios` VALUES (2516,'JURIPIRANGA','PB');
INSERT INTO `municipios` VALUES (2517,'JURU','PB');
INSERT INTO `municipios` VALUES (2518,'JURUA','AM');
INSERT INTO `municipios` VALUES (2519,'JURUAIA','MG');
INSERT INTO `municipios` VALUES (2520,'JURUENA','MT');
INSERT INTO `municipios` VALUES (2521,'JURUTI','PA');
INSERT INTO `municipios` VALUES (2522,'JUSCIMEIRA','MT');
INSERT INTO `municipios` VALUES (2523,'JUSSARA','GO');
INSERT INTO `municipios` VALUES (2524,'JUSSARA','PR');
INSERT INTO `municipios` VALUES (2525,'JUSSARI','BA');
INSERT INTO `municipios` VALUES (2526,'JUSSIAPE','BA');
INSERT INTO `municipios` VALUES (2527,'JUTAÍ','AM');
INSERT INTO `municipios` VALUES (2528,'JUTI','MS');
INSERT INTO `municipios` VALUES (2529,'KALORÉ','PR');
INSERT INTO `municipios` VALUES (2530,'LABREA','AM');
INSERT INTO `municipios` VALUES (2531,'LACERDÓPOLIS','SC');
INSERT INTO `municipios` VALUES (2532,'LADAINHA','MG');
INSERT INTO `municipios` VALUES (2533,'LADÁRIO','MS');
INSERT INTO `municipios` VALUES (2534,'LAFAIETE COUTINHO','BA');
INSERT INTO `municipios` VALUES (2535,'LAGAMAR','MG');
INSERT INTO `municipios` VALUES (2536,'LAGARTO','SE');
INSERT INTO `municipios` VALUES (2537,'LAGE','BA');
INSERT INTO `municipios` VALUES (2538,'LAGEADO','TO');
INSERT INTO `municipios` VALUES (2539,'LAGES','RN');
INSERT INTO `municipios` VALUES (2540,'LAGO DA PEDRA','MA');
INSERT INTO `municipios` VALUES (2541,'LAGO DO JUNCO','MA');
INSERT INTO `municipios` VALUES (2542,'LAGO DO MATO','MA');
INSERT INTO `municipios` VALUES (2543,'LAGO DOS RODRIGUES','MA');
INSERT INTO `municipios` VALUES (2544,'LAGO VERDE','MA');
INSERT INTO `municipios` VALUES (2545,'LAGOA','PB');
INSERT INTO `municipios` VALUES (2546,'LAGOA ALEGRE','PI');
INSERT INTO `municipios` VALUES (2547,'LAGOA DA CANOA','AL');
INSERT INTO `municipios` VALUES (2548,'LAGOA DA CONFUSÃO','TO');
INSERT INTO `municipios` VALUES (2549,'LAGOA DA PRATA','MG');
INSERT INTO `municipios` VALUES (2550,'LAGOA D\'ANTA','RN');
INSERT INTO `municipios` VALUES (2551,'LAGOA DE DENTRO','PB');
INSERT INTO `municipios` VALUES (2552,'LAGOA DE ITAENGA','PE');
INSERT INTO `municipios` VALUES (2553,'LAGOA DE PEDRAS','RN');
INSERT INTO `municipios` VALUES (2554,'LAGOA DE SÃO FRANCISCO','PI');
INSERT INTO `municipios` VALUES (2555,'LAGOA DE VELHOS','RN');
INSERT INTO `municipios` VALUES (2556,'LAGOA DO  PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2557,'LAGOA DO BARRO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2558,'LAGOA DO CARRO','PE');
INSERT INTO `municipios` VALUES (2559,'LAGOA DO OURO','PE');
INSERT INTO `municipios` VALUES (2560,'LAGOA DO SITIO','PI');
INSERT INTO `municipios` VALUES (2561,'LAGOA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2562,'LAGOA DOS GATOS','PE');
INSERT INTO `municipios` VALUES (2563,'LAGOA DOS PATOS','MG');
INSERT INTO `municipios` VALUES (2564,'IRACEMA','RR');
INSERT INTO `municipios` VALUES (2565,'LAGOA DOS TRÊS CANTOS','RS');
INSERT INTO `municipios` VALUES (2566,'LAGOA DOURADA','MG');
INSERT INTO `municipios` VALUES (2567,'LAGOA FORMOSA','MG');
INSERT INTO `municipios` VALUES (2568,'LAGOA GRANDE','MG');
INSERT INTO `municipios` VALUES (2569,'LAGOA GRANDE DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (2570,'LAGOA NOVA','RN');
INSERT INTO `municipios` VALUES (2571,'LAGOA REAL','BA');
INSERT INTO `municipios` VALUES (2572,'LAGOA SALGADA','RN');
INSERT INTO `municipios` VALUES (2573,'LAGOA SANTA','MG');
INSERT INTO `municipios` VALUES (2574,'LAGOA SECA','PB');
INSERT INTO `municipios` VALUES (2575,'LAGOA VERMELHA','RS');
INSERT INTO `municipios` VALUES (2576,'LAGOAO','RS');
INSERT INTO `municipios` VALUES (2577,'LAGOINHA','SP');
INSERT INTO `municipios` VALUES (2578,'LAGOINHA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2579,'LAGUNA','SC');
INSERT INTO `municipios` VALUES (2580,'LAGUNA CARAPÃ','MS');
INSERT INTO `municipios` VALUES (2581,'LAJE DO MURIAÉ','RJ');
INSERT INTO `municipios` VALUES (2582,'LAJEADO','RS');
INSERT INTO `municipios` VALUES (2583,'LAJEADO DO BUGRE','RS');
INSERT INTO `municipios` VALUES (2584,'LAJEADO GRANDE','SC');
INSERT INTO `municipios` VALUES (2585,'LAJEADO NOVO','MA');
INSERT INTO `municipios` VALUES (2586,'LAJEDÃO','BA');
INSERT INTO `municipios` VALUES (2587,'LAJEDINHO','BA');
INSERT INTO `municipios` VALUES (2588,'LAJEDO','PE');
INSERT INTO `municipios` VALUES (2589,'LAJEDO DO TABOCAL','BA');
INSERT INTO `municipios` VALUES (2590,'LAJES PINTADAS','RN');
INSERT INTO `municipios` VALUES (2591,'LAJINHA','MG');
INSERT INTO `municipios` VALUES (2592,'LAMARÃO','BA');
INSERT INTO `municipios` VALUES (2593,'LAMBARI','MG');
INSERT INTO `municipios` VALUES (2594,'LAMBARI DO OESTE','MT');
INSERT INTO `municipios` VALUES (2595,'LAMIM','MG');
INSERT INTO `municipios` VALUES (2596,'LANDRI SALES','PI');
INSERT INTO `municipios` VALUES (2597,'LAPA','PR');
INSERT INTO `municipios` VALUES (2598,'LAPÃO','BA');
INSERT INTO `municipios` VALUES (2599,'LARANJA DA TERRA','ES');
INSERT INTO `municipios` VALUES (2600,'LARANJAL','MG');
INSERT INTO `municipios` VALUES (2601,'LARANJAL DO JARI','AP');
INSERT INTO `municipios` VALUES (2602,'LARANJAL PAULISTA','SP');
INSERT INTO `municipios` VALUES (2603,'LARANJEIRAS','SE');
INSERT INTO `municipios` VALUES (2604,'LASSANCE','MG');
INSERT INTO `municipios` VALUES (2605,'LASTRO','PB');
INSERT INTO `municipios` VALUES (2606,'LAURENTINO','SC');
INSERT INTO `municipios` VALUES (2607,'LAURO DE FREITAS','BA');
INSERT INTO `municipios` VALUES (2608,'LAURO MULLER','SC');
INSERT INTO `municipios` VALUES (2609,'LAVANDEIRA','TO');
INSERT INTO `municipios` VALUES (2610,'LAVINIA','SP');
INSERT INTO `municipios` VALUES (2611,'LAVRAS','MG');
INSERT INTO `municipios` VALUES (2612,'LAVRAS DA MANGABEIRA','CE');
INSERT INTO `municipios` VALUES (2613,'LAVRAS DO SUL','RS');
INSERT INTO `municipios` VALUES (2614,'LAVRINHAS','SP');
INSERT INTO `municipios` VALUES (2615,'LEANDRO FERREIRA','MG');
INSERT INTO `municipios` VALUES (2616,'LEBON REGIS','SC');
INSERT INTO `municipios` VALUES (2617,'LEME','SP');
INSERT INTO `municipios` VALUES (2618,'LEME DO PRADO','MG');
INSERT INTO `municipios` VALUES (2619,'LENÇÓIS','BA');
INSERT INTO `municipios` VALUES (2620,'LENÇÓIS PAULISTA','SP');
INSERT INTO `municipios` VALUES (2621,'LEOBERTO LEAL','SC');
INSERT INTO `municipios` VALUES (2622,'LEOPOLDINA','MG');
INSERT INTO `municipios` VALUES (2623,'LEOPOLDO DE BULHOES','GO');
INSERT INTO `municipios` VALUES (2624,'LEÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2625,'LIBERATO SALZANO','RS');
INSERT INTO `municipios` VALUES (2626,'LIBERDADE','MG');
INSERT INTO `municipios` VALUES (2627,'LICINIO DE ALMEIDA','BA');
INSERT INTO `municipios` VALUES (2628,'LIDIANÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2629,'LIMA CAMPOS','MA');
INSERT INTO `municipios` VALUES (2630,'LIMA DUARTE','MG');
INSERT INTO `municipios` VALUES (2631,'LIMEIRA','SP');
INSERT INTO `municipios` VALUES (2632,'LIMEIRA DO OESTE','MG');
INSERT INTO `municipios` VALUES (2633,'LIMOEIRO','PE');
INSERT INTO `municipios` VALUES (2634,'LIMOEIRO DE ANADIA','AL');
INSERT INTO `municipios` VALUES (2635,'LIMOEIRO DO AJURU','PA');
INSERT INTO `municipios` VALUES (2636,'LIMOEIRO DO NORTE','CE');
INSERT INTO `municipios` VALUES (2637,'LINDOESTE','PR');
INSERT INTO `municipios` VALUES (2638,'LINDÓIA','SP');
INSERT INTO `municipios` VALUES (2639,'LINDOIA DO SUL','SC');
INSERT INTO `municipios` VALUES (2640,'LINDOLFO COLLOR','RS');
INSERT INTO `municipios` VALUES (2641,'LINHA NOVA','RS');
INSERT INTO `municipios` VALUES (2642,'LINHARES','ES');
INSERT INTO `municipios` VALUES (2643,'LINS','SP');
INSERT INTO `municipios` VALUES (2644,'LIV DE NOSSA SENHORA','BA');
INSERT INTO `municipios` VALUES (2645,'LIVRAMENTO','PB');
INSERT INTO `municipios` VALUES (2646,'LIZARDA','TO');
INSERT INTO `municipios` VALUES (2647,'LOANDA','PR');
INSERT INTO `municipios` VALUES (2648,'LOBATO','PR');
INSERT INTO `municipios` VALUES (2649,'LOGRADOURO','PB');
INSERT INTO `municipios` VALUES (2650,'LONDRINA','PR');
INSERT INTO `municipios` VALUES (2651,'LONTRA','MG');
INSERT INTO `municipios` VALUES (2652,'LONTRAS','SC');
INSERT INTO `municipios` VALUES (2653,'LORENA','SP');
INSERT INTO `municipios` VALUES (2654,'LORETO','MA');
INSERT INTO `municipios` VALUES (2655,'LOURDES','SP');
INSERT INTO `municipios` VALUES (2656,'LOUVEIRA','SP');
INSERT INTO `municipios` VALUES (2657,'LUCAS DO RIO VERDE','MT');
INSERT INTO `municipios` VALUES (2658,'LUCELIA','SP');
INSERT INTO `municipios` VALUES (2659,'LUCENA','PB');
INSERT INTO `municipios` VALUES (2660,'LUCIANÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2661,'LUCIARA','MT');
INSERT INTO `municipios` VALUES (2662,'LUCRECIA','RN');
INSERT INTO `municipios` VALUES (2663,'LUGAR CEDRO','MA');
INSERT INTO `municipios` VALUES (2664,'LUIS ALVES','SC');
INSERT INTO `municipios` VALUES (2665,'LUIS DOMINGUES','MA');
INSERT INTO `municipios` VALUES (2666,'LUIS GOMES','RN');
INSERT INTO `municipios` VALUES (2667,'LUIZIANA','PR');
INSERT INTO `municipios` VALUES (2668,'LUISIANIA','SP');
INSERT INTO `municipios` VALUES (2669,'LUIZ ANTÔNIO','SP');
INSERT INTO `municipios` VALUES (2670,'LUIZ CORREIA','PI');
INSERT INTO `municipios` VALUES (2671,'LUMINÁRIAS','MG');
INSERT INTO `municipios` VALUES (2672,'LUNARDELLI','PR');
INSERT INTO `municipios` VALUES (2673,'LUPERCIO','SP');
INSERT INTO `municipios` VALUES (2674,'LUPIONÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2675,'LUTÉCIA','SP');
INSERT INTO `municipios` VALUES (2676,'LUZ','MG');
INSERT INTO `municipios` VALUES (2677,'LUZERNA','SC');
INSERT INTO `municipios` VALUES (2678,'LUZIANIA','GO');
INSERT INTO `municipios` VALUES (2679,'LUZILÂNDIA','PI');
INSERT INTO `municipios` VALUES (2680,'LUZINÓPOLIS','TO');
INSERT INTO `municipios` VALUES (2681,'MACAÉ','RJ');
INSERT INTO `municipios` VALUES (2682,'MACAIBA','RN');
INSERT INTO `municipios` VALUES (2683,'MACAJUBA','BA');
INSERT INTO `municipios` VALUES (2684,'MACAMBARA','RS');
INSERT INTO `municipios` VALUES (2685,'MACAMBIRA','SE');
INSERT INTO `municipios` VALUES (2686,'MACAPÁ','AP');
INSERT INTO `municipios` VALUES (2687,'MACAPARANÁ','PE');
INSERT INTO `municipios` VALUES (2688,'MACARANI','BA');
INSERT INTO `municipios` VALUES (2689,'MACATUBA','SP');
INSERT INTO `municipios` VALUES (2690,'MACAU','RN');
INSERT INTO `municipios` VALUES (2691,'MACAUBAL','SP');
INSERT INTO `municipios` VALUES (2692,'MACAUBAS','BA');
INSERT INTO `municipios` VALUES (2693,'MACÊDO','PI');
INSERT INTO `municipios` VALUES (2694,'MACEDÔNIA','SP');
INSERT INTO `municipios` VALUES (2695,'MACEIÓ','AL');
INSERT INTO `municipios` VALUES (2696,'MACHACALIS','MG');
INSERT INTO `municipios` VALUES (2697,'MACHADINHO','RS');
INSERT INTO `municipios` VALUES (2698,'MACHADINHO DO OESTE','RO');
INSERT INTO `municipios` VALUES (2699,'MACHADO','MG');
INSERT INTO `municipios` VALUES (2700,'MACHADOS','PE');
INSERT INTO `municipios` VALUES (2701,'MACHALIS','MG');
INSERT INTO `municipios` VALUES (2702,'MACIEIRA','SC');
INSERT INTO `municipios` VALUES (2703,'MACUCO','RJ');
INSERT INTO `municipios` VALUES (2704,'MAÇURURE','BA');
INSERT INTO `municipios` VALUES (2705,'MADALENA','CE');
INSERT INTO `municipios` VALUES (2706,'MADEIRO','PI');
INSERT INTO `municipios` VALUES (2707,'MADRE DE DEUS','BA');
INSERT INTO `municipios` VALUES (2708,'MADRE DE DEUS DE MINAS','MG');
INSERT INTO `municipios` VALUES (2709,'MAE DA ÁGUA','PB');
INSERT INTO `municipios` VALUES (2710,'MAE DO RIO','PA');
INSERT INTO `municipios` VALUES (2711,'MAETINGA','BA');
INSERT INTO `municipios` VALUES (2712,'MAFRA','SC');
INSERT INTO `municipios` VALUES (2713,'MAGALHÃES BARATA','PA');
INSERT INTO `municipios` VALUES (2714,'MAGALHAES DE ALMEIDA','MA');
INSERT INTO `municipios` VALUES (2715,'MAGDA','SP');
INSERT INTO `municipios` VALUES (2716,'MAGÉ','RJ');
INSERT INTO `municipios` VALUES (2717,'MAIQUINIQUE','BA');
INSERT INTO `municipios` VALUES (2718,'MAIRI','BA');
INSERT INTO `municipios` VALUES (2719,'MAIRINQUE','SP');
INSERT INTO `municipios` VALUES (2720,'MAIRIPORA','SP');
INSERT INTO `municipios` VALUES (2721,'MAIRIPOTABA','GO');
INSERT INTO `municipios` VALUES (2722,'MAJOR GERCINO','SC');
INSERT INTO `municipios` VALUES (2723,'MAJOR ISIDORO','AL');
INSERT INTO `municipios` VALUES (2724,'MAJOR SALES','RN');
INSERT INTO `municipios` VALUES (2725,'MAJOR VIEIRA','SC');
INSERT INTO `municipios` VALUES (2726,'MALACACHETA','MG');
INSERT INTO `municipios` VALUES (2727,'MALHADA','BA');
INSERT INTO `municipios` VALUES (2728,'MALHADA DE PEDRAS','BA');
INSERT INTO `municipios` VALUES (2729,'MALHADA DOS BOIS','SE');
INSERT INTO `municipios` VALUES (2730,'MALHADOR','SE');
INSERT INTO `municipios` VALUES (2731,'MALLET','PR');
INSERT INTO `municipios` VALUES (2732,'MALTA','PB');
INSERT INTO `municipios` VALUES (2733,'MAMANGUAPE','PB');
INSERT INTO `municipios` VALUES (2734,'MAMBAÍ','GO');
INSERT INTO `municipios` VALUES (2735,'MAMBORÊ','PR');
INSERT INTO `municipios` VALUES (2736,'MAMONAS','MG');
INSERT INTO `municipios` VALUES (2737,'MAMPITUBA','RS');
INSERT INTO `municipios` VALUES (2738,'MANACAPURU','AM');
INSERT INTO `municipios` VALUES (2739,'MANAÍRA','PB');
INSERT INTO `municipios` VALUES (2740,'MANAQUIRI','AM');
INSERT INTO `municipios` VALUES (2741,'MANARI','PE');
INSERT INTO `municipios` VALUES (2742,'MANAUS','AM');
INSERT INTO `municipios` VALUES (2743,'MÂNCIO LIMA','AC');
INSERT INTO `municipios` VALUES (2744,'MANDÁGUAÇU','PR');
INSERT INTO `municipios` VALUES (2745,'MANDAGUARI','PR');
INSERT INTO `municipios` VALUES (2746,'MANDIRITUBA','PR');
INSERT INTO `municipios` VALUES (2747,'MANDURI','SP');
INSERT INTO `municipios` VALUES (2748,'MANFRINÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2749,'MANGA','MG');
INSERT INTO `municipios` VALUES (2750,'MANGARATIBA','RJ');
INSERT INTO `municipios` VALUES (2751,'MANGUEIRINHA','PR');
INSERT INTO `municipios` VALUES (2752,'MANHUAÇU','MG');
INSERT INTO `municipios` VALUES (2753,'MANHUMIRIM','MG');
INSERT INTO `municipios` VALUES (2754,'MANICORE','AM');
INSERT INTO `municipios` VALUES (2755,'MANOEL EMÍDIO','PI');
INSERT INTO `municipios` VALUES (2756,'MANOEL RIBAS','PR');
INSERT INTO `municipios` VALUES (2757,'MANOEL URBANO','AC');
INSERT INTO `municipios` VALUES (2758,'MANOEL VIANA','RS');
INSERT INTO `municipios` VALUES (2759,'MANOEL VITORINO','BA');
INSERT INTO `municipios` VALUES (2760,'MANSIDÃO','BA');
INSERT INTO `municipios` VALUES (2761,'MANTENA','MG');
INSERT INTO `municipios` VALUES (2762,'MANTENÓPOLIS','ES');
INSERT INTO `municipios` VALUES (2763,'MAQUINÉ','RS');
INSERT INTO `municipios` VALUES (2764,'MAR DE ESPANHA','MG');
INSERT INTO `municipios` VALUES (2765,'MARA ROSA','GO');
INSERT INTO `municipios` VALUES (2766,'MARAA','AM');
INSERT INTO `municipios` VALUES (2767,'MARABA','PA');
INSERT INTO `municipios` VALUES (2768,'MARABA PAULISTA','SP');
INSERT INTO `municipios` VALUES (2769,'MARAÇAÇUME','MA');
INSERT INTO `municipios` VALUES (2770,'MARAÇAI','SP');
INSERT INTO `municipios` VALUES (2771,'MARAÇAJA','SC');
INSERT INTO `municipios` VALUES (2772,'MARACAJU','MS');
INSERT INTO `municipios` VALUES (2773,'MARACANÃ','PA');
INSERT INTO `municipios` VALUES (2774,'MARAÇANAU','CE');
INSERT INTO `municipios` VALUES (2775,'MARAÇAS','BA');
INSERT INTO `municipios` VALUES (2776,'MARAGOGI','AL');
INSERT INTO `municipios` VALUES (2777,'MARAGOJIPE','BA');
INSERT INTO `municipios` VALUES (2778,'MARAIAL','PE');
INSERT INTO `municipios` VALUES (2779,'MARAJA DO SENA','MA');
INSERT INTO `municipios` VALUES (2780,'MARANDIBA','PE');
INSERT INTO `municipios` VALUES (2781,'MARANGUAPE','CE');
INSERT INTO `municipios` VALUES (2782,'MARANHÃOZINHO','MA');
INSERT INTO `municipios` VALUES (2783,'MARAPANIM','PA');
INSERT INTO `municipios` VALUES (2784,'MARAPOAMA','SP');
INSERT INTO `municipios` VALUES (2785,'MARATÁ','RS');
INSERT INTO `municipios` VALUES (2786,'MARATAIZES','ES');
INSERT INTO `municipios` VALUES (2787,'MARAÚ','BA');
INSERT INTO `municipios` VALUES (2788,'MARAVILHA','AL');
INSERT INTO `municipios` VALUES (2789,'MARAVILHAS','MG');
INSERT INTO `municipios` VALUES (2790,'MARCAÇÃO','PB');
INSERT INTO `municipios` VALUES (2791,'MARCELÂNDIA','MT');
INSERT INTO `municipios` VALUES (2792,'MARCELINO RAMOS','RS');
INSERT INTO `municipios` VALUES (2793,'MARCELINO VIEIRA','RN');
INSERT INTO `municipios` VALUES (2794,'MARCIONILIO SOUZA','BA');
INSERT INTO `municipios` VALUES (2795,'MARCO','CE');
INSERT INTO `municipios` VALUES (2796,'MARCOLÂNDIA','PI');
INSERT INTO `municipios` VALUES (2797,'MARCOS PARENTE','PI');
INSERT INTO `municipios` VALUES (2798,'MARECHAL CÂNDIDO RONDON','PR');
INSERT INTO `municipios` VALUES (2799,'MARECHAL DEODORO','AL');
INSERT INTO `municipios` VALUES (2800,'MARECHAL FLORIANO','ES');
INSERT INTO `municipios` VALUES (2801,'MARECHAL TRAUMATURGO','AC');
INSERT INTO `municipios` VALUES (2802,'MAREMA','SC');
INSERT INTO `municipios` VALUES (2803,'MARI','PB');
INSERT INTO `municipios` VALUES (2804,'MARIA DA FE','MG');
INSERT INTO `municipios` VALUES (2805,'MARIA HELENA','PR');
INSERT INTO `municipios` VALUES (2806,'MARIALVA','PR');
INSERT INTO `municipios` VALUES (2807,'MARIANA','MG');
INSERT INTO `municipios` VALUES (2808,'MARIANA PIMENTEL','RS');
INSERT INTO `municipios` VALUES (2809,'MARIANO MORO','RS');
INSERT INTO `municipios` VALUES (2810,'MARIANÓPOLIS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2811,'MARIAPOLIS','SP');
INSERT INTO `municipios` VALUES (2812,'MARIBONDO','AL');
INSERT INTO `municipios` VALUES (2813,'MARICÁ','RJ');
INSERT INTO `municipios` VALUES (2814,'MARILAC','MG');
INSERT INTO `municipios` VALUES (2815,'MARILÂNDIA','ES');
INSERT INTO `municipios` VALUES (2816,'MARILÂNDIA DO SUL','PR');
INSERT INTO `municipios` VALUES (2817,'MARILENA','PR');
INSERT INTO `municipios` VALUES (2818,'MARILIA','SP');
INSERT INTO `municipios` VALUES (2819,'MARILUZ','PR');
INSERT INTO `municipios` VALUES (2820,'MARINGÁ','PR');
INSERT INTO `municipios` VALUES (2821,'MARINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2822,'MARIO CAMPOS','MG');
INSERT INTO `municipios` VALUES (2823,'MARIÓPOLIS','PR');
INSERT INTO `municipios` VALUES (2824,'MARIPA','PR');
INSERT INTO `municipios` VALUES (2825,'MARIPA DE MINAS','MG');
INSERT INTO `municipios` VALUES (2826,'MARITUBA','PA');
INSERT INTO `municipios` VALUES (2827,'MARIZÓPOLIS','PB');
INSERT INTO `municipios` VALUES (2828,'MARLIERIA','MG');
INSERT INTO `municipios` VALUES (2829,'MARMELEIRO','PR');
INSERT INTO `municipios` VALUES (2830,'MARMELÓPOLIS','MG');
INSERT INTO `municipios` VALUES (2831,'MARQUES DE SOUZA','RS');
INSERT INTO `municipios` VALUES (2832,'MARQUINHO','PR');
INSERT INTO `municipios` VALUES (2833,'MARTINHO CAMPOS','MG');
INSERT INTO `municipios` VALUES (2834,'MARTINOPOLE','CE');
INSERT INTO `municipios` VALUES (2835,'MARTINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2836,'MARTINS','RN');
INSERT INTO `municipios` VALUES (2837,'MARTINS SOARES','MG');
INSERT INTO `municipios` VALUES (2838,'MARUIM','SE');
INSERT INTO `municipios` VALUES (2839,'MARUMBI','PR');
INSERT INTO `municipios` VALUES (2840,'MARZAGAO','GO');
INSERT INTO `municipios` VALUES (2841,'MASCOTE','BA');
INSERT INTO `municipios` VALUES (2842,'MASSAPE','CE');
INSERT INTO `municipios` VALUES (2843,'MASSAPE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2844,'MASSARANDUBA','PB');
INSERT INTO `municipios` VALUES (2845,'MASSARANDUBA','SC');
INSERT INTO `municipios` VALUES (2846,'MATA','RS');
INSERT INTO `municipios` VALUES (2847,'MATA DE SÃO JOÃO','BA');
INSERT INTO `municipios` VALUES (2848,'MATA GRANDE','AL');
INSERT INTO `municipios` VALUES (2849,'MATA ROMA','MA');
INSERT INTO `municipios` VALUES (2850,'MATA VERDE','MG');
INSERT INTO `municipios` VALUES (2851,'MATÃO','SP');
INSERT INTO `municipios` VALUES (2852,'MATARAÇA','PB');
INSERT INTO `municipios` VALUES (2853,'MATEIROS','TO');
INSERT INTO `municipios` VALUES (2854,'MATELÂNDIA','PR');
INSERT INTO `municipios` VALUES (2855,'MATERLÂNDIA','MG');
INSERT INTO `municipios` VALUES (2856,'MATEUS LEME','MG');
INSERT INTO `municipios` VALUES (2857,'MATHIAS LOBATO','MG');
INSERT INTO `municipios` VALUES (2858,'MATIAS BARBOSA','MG');
INSERT INTO `municipios` VALUES (2859,'MATIAS CARDOSO','MG');
INSERT INTO `municipios` VALUES (2860,'MATIAS OLIMPIO','PI');
INSERT INTO `municipios` VALUES (2861,'MATINA','BA');
INSERT INTO `municipios` VALUES (2862,'MATINHA','MA');
INSERT INTO `municipios` VALUES (2863,'MATINHAS','PB');
INSERT INTO `municipios` VALUES (2864,'MATINHOS','PR');
INSERT INTO `municipios` VALUES (2865,'MATIPO','MG');
INSERT INTO `municipios` VALUES (2866,'MATO CASTELHANO','RS');
INSERT INTO `municipios` VALUES (2867,'MATO GROSSO','PB');
INSERT INTO `municipios` VALUES (2868,'MATO LEITÃO','RS');
INSERT INTO `municipios` VALUES (2869,'MATO RICO','PR');
INSERT INTO `municipios` VALUES (2870,'MATO VERDE','MG');
INSERT INTO `municipios` VALUES (2871,'MATÕES','MA');
INSERT INTO `municipios` VALUES (2872,'MATOES DO NORTE','MA');
INSERT INTO `municipios` VALUES (2873,'MATOS COSTA','SC');
INSERT INTO `municipios` VALUES (2874,'MATOZINHOS','MG');
INSERT INTO `municipios` VALUES (2875,'MATRINCHA','GO');
INSERT INTO `municipios` VALUES (2876,'MATRIZ DE CAMARAGIBE','AL');
INSERT INTO `municipios` VALUES (2877,'MATUPA','MT');
INSERT INTO `municipios` VALUES (2878,'MATUREIA','PB');
INSERT INTO `municipios` VALUES (2879,'MATUTINA','MG');
INSERT INTO `municipios` VALUES (2880,'MAUA','SP');
INSERT INTO `municipios` VALUES (2881,'MAUA DA SERRA','PR');
INSERT INTO `municipios` VALUES (2882,'MAUES','AM');
INSERT INTO `municipios` VALUES (2883,'MAURILÂNDIA','GO');
INSERT INTO `municipios` VALUES (2884,'MAURILÂNDIA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2885,'MAURITI','CE');
INSERT INTO `municipios` VALUES (2886,'MAXARANGUAPE','RN');
INSERT INTO `municipios` VALUES (2887,'MAXIMILIANO DE ALMEIDA','RS');
INSERT INTO `municipios` VALUES (2888,'MAZAGÃO','AP');
INSERT INTO `municipios` VALUES (2889,'MEDEIROS','MG');
INSERT INTO `municipios` VALUES (2890,'MEDEIROS NETO','BA');
INSERT INTO `municipios` VALUES (2891,'MEDIANEIRA','PR');
INSERT INTO `municipios` VALUES (2892,'MEDICILÂNDIA','PA');
INSERT INTO `municipios` VALUES (2893,'MEDINA','MG');
INSERT INTO `municipios` VALUES (2894,'MELEIRO','SC');
INSERT INTO `municipios` VALUES (2895,'MELGACO','PA');
INSERT INTO `municipios` VALUES (2896,'MENDES','RJ');
INSERT INTO `municipios` VALUES (2897,'MENDES PIMENTEL','MG');
INSERT INTO `municipios` VALUES (2898,'MENDONCA','SP');
INSERT INTO `municipios` VALUES (2899,'MERCEDES','PR');
INSERT INTO `municipios` VALUES (2900,'MERCES','MG');
INSERT INTO `municipios` VALUES (2901,'MERIDIANO','SP');
INSERT INTO `municipios` VALUES (2902,'MERUOCA','CE');
INSERT INTO `municipios` VALUES (2903,'MESÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2904,'MESQUITA','MG');
INSERT INTO `municipios` VALUES (2905,'MESSIAS','AL');
INSERT INTO `municipios` VALUES (2906,'MESSIAS TARGINO','RN');
INSERT INTO `municipios` VALUES (2907,'MIGUEL ALVES','PI');
INSERT INTO `municipios` VALUES (2908,'MIGUEL CALMON','BA');
INSERT INTO `municipios` VALUES (2909,'MIGUEL LEÃO','PI');
INSERT INTO `municipios` VALUES (2910,'MIGUEL PEREIRA','RJ');
INSERT INTO `municipios` VALUES (2911,'MIGUELÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2912,'MILAGRES','BA');
INSERT INTO `municipios` VALUES (2913,'MILAGRES DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (2914,'MILHA','CE');
INSERT INTO `municipios` VALUES (2915,'MILTON BRANDÃO','PI');
INSERT INTO `municipios` VALUES (2916,'MIMOSO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (2917,'MIMOSO DO SUL','ES');
INSERT INTO `municipios` VALUES (2918,'MINAÇU','GO');
INSERT INTO `municipios` VALUES (2919,'MINADOR DO NEGRÃO','AL');
INSERT INTO `municipios` VALUES (2920,'MINAS DO LEÃO','RS');
INSERT INTO `municipios` VALUES (2921,'MINAS NOVAS','MG');
INSERT INTO `municipios` VALUES (2922,'MINDURI','MG');
INSERT INTO `municipios` VALUES (2923,'MINEIROS','GO');
INSERT INTO `municipios` VALUES (2924,'MINEIROS DO TIETE','SP');
INSERT INTO `municipios` VALUES (2925,'MINISTRO ANDRÉAZA','RO');
INSERT INTO `municipios` VALUES (2926,'MINISTRO ANDRÉAZZA','RO');
INSERT INTO `municipios` VALUES (2927,'MIRA ESTRELA','SP');
INSERT INTO `municipios` VALUES (2928,'MIRABELA','MG');
INSERT INTO `municipios` VALUES (2929,'MIRACATU','SP');
INSERT INTO `municipios` VALUES (2930,'MIRACEMA','RJ');
INSERT INTO `municipios` VALUES (2931,'MIRACEMA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (2932,'MIRADOR','MA');
INSERT INTO `municipios` VALUES (2933,'MIRADOR','PR');
INSERT INTO `municipios` VALUES (2934,'MIRADOURO','MG');
INSERT INTO `municipios` VALUES (2935,'MIRÁGUAI','RS');
INSERT INTO `municipios` VALUES (2936,'MIRAÍ','MG');
INSERT INTO `municipios` VALUES (2937,'MIRAÍMA','CE');
INSERT INTO `municipios` VALUES (2938,'MIRANDA','MS');
INSERT INTO `municipios` VALUES (2939,'MIRANDA DO NORTE','MA');
INSERT INTO `municipios` VALUES (2940,'MIRANDIBA','PE');
INSERT INTO `municipios` VALUES (2941,'MIRANDÓPOLIS','SP');
INSERT INTO `municipios` VALUES (2942,'MIRANGABA','BA');
INSERT INTO `municipios` VALUES (2943,'MIRANORTE','TO');
INSERT INTO `municipios` VALUES (2944,'MIRANTE','BA');
INSERT INTO `municipios` VALUES (2945,'MIRANTE DA SERRA','RO');
INSERT INTO `municipios` VALUES (2946,'MIRANTE DO PARANÁPANEMA','SP');
INSERT INTO `municipios` VALUES (2947,'MIRASELVA','PR');
INSERT INTO `municipios` VALUES (2948,'MIRASSOL','SP');
INSERT INTO `municipios` VALUES (2949,'MIRASSOL D\'OESTE','MT');
INSERT INTO `municipios` VALUES (2950,'MIRASSOLÂNDIA','SP');
INSERT INTO `municipios` VALUES (2951,'MIRAVÂNIA','MG');
INSERT INTO `municipios` VALUES (2952,'MIRIM DOCE','SC');
INSERT INTO `municipios` VALUES (2953,'MIRINZAL','MA');
INSERT INTO `municipios` VALUES (2954,'MISSAL','PR');
INSERT INTO `municipios` VALUES (2955,'MISSÃO VELHA','CE');
INSERT INTO `municipios` VALUES (2956,'MOCAJUBA','PA');
INSERT INTO `municipios` VALUES (2957,'MOCOCA','SP');
INSERT INTO `municipios` VALUES (2958,'MODELO','SC');
INSERT INTO `municipios` VALUES (2959,'MOEDA','MG');
INSERT INTO `municipios` VALUES (2960,'MOEMA','MG');
INSERT INTO `municipios` VALUES (2961,'MOGEIRO','PB');
INSERT INTO `municipios` VALUES (2962,'MOGI DAS CRUZES','SP');
INSERT INTO `municipios` VALUES (2963,'MOGI GUAÇU','SP');
INSERT INTO `municipios` VALUES (2964,'MOGI MIRIM','SP');
INSERT INTO `municipios` VALUES (2965,'MOIPORA','GO');
INSERT INTO `municipios` VALUES (2966,'MOITA BONITA','SE');
INSERT INTO `municipios` VALUES (2967,'MOJU','PA');
INSERT INTO `municipios` VALUES (2968,'MOMBAÇA','CE');
INSERT INTO `municipios` VALUES (2969,'MOMBUCA','SP');
INSERT INTO `municipios` VALUES (2970,'MONCÃO','MA');
INSERT INTO `municipios` VALUES (2971,'MONÇÕES','SP');
INSERT INTO `municipios` VALUES (2972,'MONDAI','SC');
INSERT INTO `municipios` VALUES (2973,'MONGAGUÁ','SP');
INSERT INTO `municipios` VALUES (2974,'MONJOLOS','MG');
INSERT INTO `municipios` VALUES (2975,'MONSENHOR GIL','PI');
INSERT INTO `municipios` VALUES (2976,'MONSENHOR HIPÓLITO','PI');
INSERT INTO `municipios` VALUES (2977,'MONSENHOR PAULO','MG');
INSERT INTO `municipios` VALUES (2978,'MONSENHOR TABOSA','CE');
INSERT INTO `municipios` VALUES (2979,'MONTADAS','PB');
INSERT INTO `municipios` VALUES (2980,'MONTALVÂNIA','MG');
INSERT INTO `municipios` VALUES (2981,'MONTANHA','ES');
INSERT INTO `municipios` VALUES (2982,'MONTANHAS','RN');
INSERT INTO `municipios` VALUES (2983,'MONTAURI','RS');
INSERT INTO `municipios` VALUES (2984,'MONTE ALEGRE','PA');
INSERT INTO `municipios` VALUES (2985,'MONTE ALEGRE','SE');
INSERT INTO `municipios` VALUES (2986,'MONTE ALEGRE DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (2987,'MONTE ALEGRE DE MINAS','MG');
INSERT INTO `municipios` VALUES (2988,'MONTE ALEGRE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (2989,'MONTE ALEGRE DO SUL','SP');
INSERT INTO `municipios` VALUES (2990,'MONTE ALEGRE DOS CAMPOS','RS');
INSERT INTO `municipios` VALUES (2991,'MONTE ALTO','SP');
INSERT INTO `municipios` VALUES (2992,'MONTE APRAZIVEL','SP');
INSERT INTO `municipios` VALUES (2993,'MONTE AZUL','MG');
INSERT INTO `municipios` VALUES (2994,'MONTE AZUL PAULISTA','SP');
INSERT INTO `municipios` VALUES (2995,'MONTE BELO','MG');
INSERT INTO `municipios` VALUES (2996,'MONTE BELO DO SUL','RS');
INSERT INTO `municipios` VALUES (2997,'MONTE CARLO','SC');
INSERT INTO `municipios` VALUES (2998,'MONTE CARMELO','MG');
INSERT INTO `municipios` VALUES (2999,'MONTE CASTELO','SC');
INSERT INTO `municipios` VALUES (3000,'MONTE DAS GAMELEIRAS','RN');
INSERT INTO `municipios` VALUES (3001,'MONTE DO CARMO','TO');
INSERT INTO `municipios` VALUES (3002,'MONTE FORMOSO','MG');
INSERT INTO `municipios` VALUES (3003,'MONTE HOREBE','PB');
INSERT INTO `municipios` VALUES (3004,'MONTE MOR','SP');
INSERT INTO `municipios` VALUES (3005,'MONTE SANTO','BA');
INSERT INTO `municipios` VALUES (3006,'MONTE SANTO DE MINAS','MG');
INSERT INTO `municipios` VALUES (3007,'MONTE SIÃO','MG');
INSERT INTO `municipios` VALUES (3008,'MONTEIRO','PB');
INSERT INTO `municipios` VALUES (3009,'MONTEIRO LOBATO','SP');
INSERT INTO `municipios` VALUES (3010,'MONTENEGRO','RS');
INSERT INTO `municipios` VALUES (3011,'MONTES ALTOS','MA');
INSERT INTO `municipios` VALUES (3012,'MONTES CLAROS','MG');
INSERT INTO `municipios` VALUES (3013,'MONTES CLAROS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3014,'MONTEZUMA','MG');
INSERT INTO `municipios` VALUES (3015,'MONTIVIDIU','GO');
INSERT INTO `municipios` VALUES (3016,'MONTIVIDIU DO NORTE','GO');
INSERT INTO `municipios` VALUES (3017,'MORADA NOVA','CE');
INSERT INTO `municipios` VALUES (3018,'MORADA NOVA DE MINAS','MG');
INSERT INTO `municipios` VALUES (3019,'MORAUJO','CE');
INSERT INTO `municipios` VALUES (3020,'MOREIRA SALES','PR');
INSERT INTO `municipios` VALUES (3021,'MORENO','PE');
INSERT INTO `municipios` VALUES (3022,'MORMAÇO','RS');
INSERT INTO `municipios` VALUES (3023,'MORPARÁ','BA');
INSERT INTO `municipios` VALUES (3024,'MORRETES','PR');
INSERT INTO `municipios` VALUES (3025,'MORRINHAS DO SUL','RS');
INSERT INTO `municipios` VALUES (3026,'MORRINHOS','CE');
INSERT INTO `municipios` VALUES (3027,'MORRINHOS DO SUL','RS');
INSERT INTO `municipios` VALUES (3028,'MORRO AGUDO','SP');
INSERT INTO `municipios` VALUES (3029,'MORRO AGUDO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3030,'MORRO CABEÇA NO TEMPO','PI');
INSERT INTO `municipios` VALUES (3031,'MORRO DA FUMAÇA','SC');
INSERT INTO `municipios` VALUES (3032,'MORRO DA GARÇA','MG');
INSERT INTO `municipios` VALUES (3033,'MORRO DO CHAPÉU','BA');
INSERT INTO `municipios` VALUES (3034,'MORRO DO CHAPÉU DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3035,'MORRO DO PILAR','MG');
INSERT INTO `municipios` VALUES (3036,'MORRO GRANDE','SC');
INSERT INTO `municipios` VALUES (3037,'MORRO REDONDO','RS');
INSERT INTO `municipios` VALUES (3038,'MORRO REUTER','RS');
INSERT INTO `municipios` VALUES (3039,'MORROS','MA');
INSERT INTO `municipios` VALUES (3040,'MORTUGABA','BA');
INSERT INTO `municipios` VALUES (3041,'MORUNGABA','SP');
INSERT INTO `municipios` VALUES (3042,'MOSSAMEDES','GO');
INSERT INTO `municipios` VALUES (3043,'MOSSORÓ','RN');
INSERT INTO `municipios` VALUES (3044,'MOSTARDAS','RS');
INSERT INTO `municipios` VALUES (3045,'MOTUCA','SP');
INSERT INTO `municipios` VALUES (3046,'MOZARLÂNDIA','GO');
INSERT INTO `municipios` VALUES (3047,'MUANA','PA');
INSERT INTO `municipios` VALUES (3048,'MUCAJAÍ','RR');
INSERT INTO `municipios` VALUES (3049,'MUCAMBO','CE');
INSERT INTO `municipios` VALUES (3050,'MUCUGE','BA');
INSERT INTO `municipios` VALUES (3051,'MUÇUM','RS');
INSERT INTO `municipios` VALUES (3052,'MUCURI','BA');
INSERT INTO `municipios` VALUES (3053,'MUCURICI','ES');
INSERT INTO `municipios` VALUES (3054,'MUITOS CAPOES','RS');
INSERT INTO `municipios` VALUES (3055,'MULITERNO','RS');
INSERT INTO `municipios` VALUES (3056,'MULUNGU','CE');
INSERT INTO `municipios` VALUES (3057,'MULUNGU DO MORRO','BA');
INSERT INTO `municipios` VALUES (3058,'MUNDO NOVO','BA');
INSERT INTO `municipios` VALUES (3059,'MUNHOZ','MG');
INSERT INTO `municipios` VALUES (3060,'MUNHOZ DE MELO','PR');
INSERT INTO `municipios` VALUES (3061,'MUNIZ FERREIRA','BA');
INSERT INTO `municipios` VALUES (3062,'MUNIZ FREIRE','ES');
INSERT INTO `municipios` VALUES (3063,'MUQUEM DO SÃO FRANCISCO','BA');
INSERT INTO `municipios` VALUES (3064,'MUQUI','ES');
INSERT INTO `municipios` VALUES (3065,'MURIAÉ','MG');
INSERT INTO `municipios` VALUES (3066,'MURIBECA','SE');
INSERT INTO `municipios` VALUES (3067,'MURICI','AL');
INSERT INTO `municipios` VALUES (3068,'MURICI DOS PORTELA','PI');
INSERT INTO `municipios` VALUES (3069,'MURICILÂNDIA','TO');
INSERT INTO `municipios` VALUES (3070,'MURITIBA','BA');
INSERT INTO `municipios` VALUES (3071,'MURUTINGA DO SUL','SP');
INSERT INTO `municipios` VALUES (3072,'MUTUIPE','BA');
INSERT INTO `municipios` VALUES (3073,'MUTUM','MG');
INSERT INTO `municipios` VALUES (3074,'MUTUNÓPOLIS','GO');
INSERT INTO `municipios` VALUES (3075,'MUZAMBINHO','MG');
INSERT INTO `municipios` VALUES (3076,'NACIF RAYDAN','MG');
INSERT INTO `municipios` VALUES (3077,'NANTES','SP');
INSERT INTO `municipios` VALUES (3078,'NANUQUE','MG');
INSERT INTO `municipios` VALUES (3079,'NÃO ME TOQUE','RS');
INSERT INTO `municipios` VALUES (3080,'NAQUE','MG');
INSERT INTO `municipios` VALUES (3081,'NARANDIBA','SP');
INSERT INTO `municipios` VALUES (3082,'NATAL','RN');
INSERT INTO `municipios` VALUES (3083,'NATALÂNDIA','MG');
INSERT INTO `municipios` VALUES (3084,'NATÉRCIA','MG');
INSERT INTO `municipios` VALUES (3085,'NATIVIDADE','RJ');
INSERT INTO `municipios` VALUES (3086,'NATIVIDADE DA SERRA','SP');
INSERT INTO `municipios` VALUES (3087,'NATUBA','PB');
INSERT INTO `municipios` VALUES (3088,'NAVEGANTES','SC');
INSERT INTO `municipios` VALUES (3089,'NAVIRAÍ','MS');
INSERT INTO `municipios` VALUES (3090,'NAZARÉ','BA');
INSERT INTO `municipios` VALUES (3091,'NAZARÉ DA MATA','PE');
INSERT INTO `municipios` VALUES (3092,'NAZARÉ DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3093,'NAZARÉ PAULISTA','SP');
INSERT INTO `municipios` VALUES (3094,'NAZARENO','MG');
INSERT INTO `municipios` VALUES (3095,'NAZARÉZINHO','PB');
INSERT INTO `municipios` VALUES (3096,'NAZARIO','GO');
INSERT INTO `municipios` VALUES (3097,'NEÓPOLIS','SE');
INSERT INTO `municipios` VALUES (3098,'NEPOMUCENO','MG');
INSERT INTO `municipios` VALUES (3099,'NERÓPOLIS','GO');
INSERT INTO `municipios` VALUES (3100,'NEVES PAULISTA','SP');
INSERT INTO `municipios` VALUES (3101,'NHAMUNDA','AM');
INSERT INTO `municipios` VALUES (3102,'NHANDEARA','SP');
INSERT INTO `municipios` VALUES (3103,'NICOLAU VERGUEIRO','RS');
INSERT INTO `municipios` VALUES (3104,'NILO PEÇANHA','BA');
INSERT INTO `municipios` VALUES (3105,'NILÓPOLIS','RJ');
INSERT INTO `municipios` VALUES (3106,'NINA RODRIGUES','MA');
INSERT INTO `municipios` VALUES (3107,'NINHEIRA','MG');
INSERT INTO `municipios` VALUES (3108,'NIOAQUE','MS');
INSERT INTO `municipios` VALUES (3109,'NIPOÃ','SP');
INSERT INTO `municipios` VALUES (3110,'NIQUELÂNDIA','GO');
INSERT INTO `municipios` VALUES (3111,'NISIA FLORESTA','RN');
INSERT INTO `municipios` VALUES (3112,'NITERÓI','RJ');
INSERT INTO `municipios` VALUES (3113,'NOBRES','MT');
INSERT INTO `municipios` VALUES (3114,'NONOAI','RS');
INSERT INTO `municipios` VALUES (3115,'NORDESTINA','BA');
INSERT INTO `municipios` VALUES (3116,'NORMANDIA','RR');
INSERT INTO `municipios` VALUES (3117,'NORTELÂNDIA','MT');
INSERT INTO `municipios` VALUES (3118,'NOSSA SENHORA APARECIDA','SE');
INSERT INTO `municipios` VALUES (3119,'NOSSA SENHORA DA GLÓRIA','SE');
INSERT INTO `municipios` VALUES (3120,'NOSSA SENHORA DAS DORES','SE');
INSERT INTO `municipios` VALUES (3121,'NOSSA SENHORA DAS GRAÇAS','PR');
INSERT INTO `municipios` VALUES (3122,'NOSSA SENHORA DE NAZARÉ','PI');
INSERT INTO `municipios` VALUES (3123,'NOSSA SENHORA DO LIVRAMENTO','MT');
INSERT INTO `municipios` VALUES (3124,'NOSSA SENHORA DO SOCORRO','SE');
INSERT INTO `municipios` VALUES (3125,'NOSSA SENHORA DOS REMÉDIOS','PI');
INSERT INTO `municipios` VALUES (3126,'NOSSA SENHORA DE LOURDES','SE');
INSERT INTO `municipios` VALUES (3127,'NOVA ALIANÇA','SP');
INSERT INTO `municipios` VALUES (3128,'NOVA ALIANÇA DO IVAÍ','PR');
INSERT INTO `municipios` VALUES (3129,'NOVA ALVORADA','RS');
INSERT INTO `municipios` VALUES (3130,'NOVA ALVORADA DO SUL','MS');
INSERT INTO `municipios` VALUES (3131,'NOVA AMÉRICA','GO');
INSERT INTO `municipios` VALUES (3132,'NOVA AMÉRICA DA COLINA','PR');
INSERT INTO `municipios` VALUES (3133,'NOVA ANDRADINA','MS');
INSERT INTO `municipios` VALUES (3134,'NOVA ARAÇA','RS');
INSERT INTO `municipios` VALUES (3135,'NOVA AURORA','GO');
INSERT INTO `municipios` VALUES (3136,'NOVA BANDEIRANTE','MT');
INSERT INTO `municipios` VALUES (3137,'NOVA BASSANO','RS');
INSERT INTO `municipios` VALUES (3138,'NOVA BELÉM','MG');
INSERT INTO `municipios` VALUES (3139,'NOVA BOA BISTA','RS');
INSERT INTO `municipios` VALUES (3140,'NOVA BOA VISTA','RS');
INSERT INTO `municipios` VALUES (3141,'NOVA BRASILÂNDIA','MT');
INSERT INTO `municipios` VALUES (3142,'NOVA BRAZILÂNDIA DO OESTE','RO');
INSERT INTO `municipios` VALUES (3143,'NOVA BRÉSCIA','RS');
INSERT INTO `municipios` VALUES (3144,'NOVA CAMPINA','SP');
INSERT INTO `municipios` VALUES (3145,'NOVA CANAÃ','BA');
INSERT INTO `municipios` VALUES (3146,'NOVA CANAÃ DO NORTE','MT');
INSERT INTO `municipios` VALUES (3147,'NOVA CANAÃ PAULISTA','SP');
INSERT INTO `municipios` VALUES (3148,'NOVA CANDELÁRIA','RS');
INSERT INTO `municipios` VALUES (3149,'NOVA CANTU','PR');
INSERT INTO `municipios` VALUES (3150,'NOVA CASTILHO','SP');
INSERT INTO `municipios` VALUES (3151,'NOVA COLINAS','MA');
INSERT INTO `municipios` VALUES (3152,'NOVA CRIXAS','GO');
INSERT INTO `municipios` VALUES (3153,'NOVA CRUZ','RN');
INSERT INTO `municipios` VALUES (3154,'NOVA ERA','MG');
INSERT INTO `municipios` VALUES (3155,'NOVA ERECHIM','SC');
INSERT INTO `municipios` VALUES (3156,'NOVA ESPERANÇA','PR');
INSERT INTO `municipios` VALUES (3157,'NOVA ESPERANÇA DO PIRIÁ','PA');
INSERT INTO `municipios` VALUES (3158,'NOVA ESPERANÇA DO SUL','RS');
INSERT INTO `municipios` VALUES (3159,'NOVA ESPERANÇA DO SUDOESTE','PR');
INSERT INTO `municipios` VALUES (3160,'NOVA EUROPA','SP');
INSERT INTO `municipios` VALUES (3161,'NOVA FÁTIMA','BA');
INSERT INTO `municipios` VALUES (3162,'NOVA FLORESTA','PB');
INSERT INTO `municipios` VALUES (3163,'NOVA FRIBURGO','RJ');
INSERT INTO `municipios` VALUES (3164,'NOVA GLÓRIA','GO');
INSERT INTO `municipios` VALUES (3165,'NOVA GRANADA','SP');
INSERT INTO `municipios` VALUES (3166,'NOVA GUARITA','MT');
INSERT INTO `municipios` VALUES (3167,'NOVA GUATAPORANGA','SP');
INSERT INTO `municipios` VALUES (3168,'NOVA HARTZ','RS');
INSERT INTO `municipios` VALUES (3169,'NOVA IBIA','BA');
INSERT INTO `municipios` VALUES (3170,'NOVA IGUAÇU','GO');
INSERT INTO `municipios` VALUES (3171,'NOVA IGUAÇU DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3172,'NOVA INDEPENDÊNCIA','SP');
INSERT INTO `municipios` VALUES (3173,'NOVA IORQUE','MA');
INSERT INTO `municipios` VALUES (3174,'NOVA IPIXUNA','PA');
INSERT INTO `municipios` VALUES (3175,'NOVA ITABERABA','SC');
INSERT INTO `municipios` VALUES (3176,'NOVA ITARANA','BA');
INSERT INTO `municipios` VALUES (3177,'NOVA LACERDA','MT');
INSERT INTO `municipios` VALUES (3178,'NOVA LARANJEIRAS','PR');
INSERT INTO `municipios` VALUES (3179,'NOVA LIMA','MG');
INSERT INTO `municipios` VALUES (3180,'NOVA LONDRINA','PR');
INSERT INTO `municipios` VALUES (3181,'NOVA LUZITANIA','SP');
INSERT INTO `municipios` VALUES (3182,'NOVA MAMORÉ','RO');
INSERT INTO `municipios` VALUES (3183,'NOVA MARILÂNDIA','MT');
INSERT INTO `municipios` VALUES (3184,'NOVA MARINGÁ','MT');
INSERT INTO `municipios` VALUES (3185,'NOVA MODICA','MG');
INSERT INTO `municipios` VALUES (3186,'NOVA MONTE VERDE','MT');
INSERT INTO `municipios` VALUES (3187,'NOVA MUTUM','MT');
INSERT INTO `municipios` VALUES (3188,'NOVA ODESSA','SP');
INSERT INTO `municipios` VALUES (3189,'NOVA OLÍMPIA','MT');
INSERT INTO `municipios` VALUES (3190,'NOVA OLÍMPIA','PR');
INSERT INTO `municipios` VALUES (3191,'NOVA OLINDA','CE');
INSERT INTO `municipios` VALUES (3192,'NOVA OLINDA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (3193,'NOVA OLINDA DO NORTE','AM');
INSERT INTO `municipios` VALUES (3194,'NOVA PÁDUA','RS');
INSERT INTO `municipios` VALUES (3195,'NOVA PALMA','RS');
INSERT INTO `municipios` VALUES (3196,'NOVA PALMEIRA','PB');
INSERT INTO `municipios` VALUES (3197,'NOVA PETRÓPOLIS','RS');
INSERT INTO `municipios` VALUES (3198,'NOVA PONTE','MG');
INSERT INTO `municipios` VALUES (3199,'NOVA PORTEIRINHA','MG');
INSERT INTO `municipios` VALUES (3200,'NOVA PRATA','RS');
INSERT INTO `municipios` VALUES (3201,'NOVA PRATA DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (3202,'NOVA RAMADA','RS');
INSERT INTO `municipios` VALUES (3203,'NOVA REDENCÃO','BA');
INSERT INTO `municipios` VALUES (3204,'NOVA RESENDE','MG');
INSERT INTO `municipios` VALUES (3205,'NOVA ROMA','GO');
INSERT INTO `municipios` VALUES (3206,'NOVA ROMA DO SUL','RS');
INSERT INTO `municipios` VALUES (3207,'NOVA ROSALÂNDIA','TO');
INSERT INTO `municipios` VALUES (3208,'NOVA RUSSAS','CE');
INSERT INTO `municipios` VALUES (3209,'NOVA SANTA BÁRBARA','PR');
INSERT INTO `municipios` VALUES (3210,'NOVA SANTA RITA','PI');
INSERT INTO `municipios` VALUES (3211,'NOVA SANTA ROSA','PR');
INSERT INTO `municipios` VALUES (3212,'NOVA SERRANA','MG');
INSERT INTO `municipios` VALUES (3213,'NOVA SOURE','BA');
INSERT INTO `municipios` VALUES (3214,'NOVA TEBAS','PR');
INSERT INTO `municipios` VALUES (3215,'NOVA TIMBOTEUA','PA');
INSERT INTO `municipios` VALUES (3216,'NOVA TRENTO','SC');
INSERT INTO `municipios` VALUES (3217,'NOVA UBIRATAN','MT');
INSERT INTO `municipios` VALUES (3218,'NOVA UNIÃO','MG');
INSERT INTO `municipios` VALUES (3219,'NOVA VENÉCIA','ES');
INSERT INTO `municipios` VALUES (3220,'NOVA VENEZA','GO');
INSERT INTO `municipios` VALUES (3221,'NOVA VIÇOSA','BA');
INSERT INTO `municipios` VALUES (3222,'NOVA XAVANTINA','MT');
INSERT INTO `municipios` VALUES (3223,'NOVAIS','SP');
INSERT INTO `municipios` VALUES (3224,'NOVO ACORDO','TO');
INSERT INTO `municipios` VALUES (3225,'NOVO AIRÃO','AM');
INSERT INTO `municipios` VALUES (3226,'NOVO ALEGRE','TO');
INSERT INTO `municipios` VALUES (3227,'NOVO ARIPUANÃ','AM');
INSERT INTO `municipios` VALUES (3228,'NOVO BARREIRO','RS');
INSERT INTO `municipios` VALUES (3229,'NOVO BRASIL','GO');
INSERT INTO `municipios` VALUES (3230,'NOVO CABRAIS','RS');
INSERT INTO `municipios` VALUES (3231,'NOVO CRUZEIRO','MG');
INSERT INTO `municipios` VALUES (3232,'NOVO GAMA','GO');
INSERT INTO `municipios` VALUES (3233,'NOVO HAMBURGO','RS');
INSERT INTO `municipios` VALUES (3234,'NOVO HORIZONTE','BA');
INSERT INTO `municipios` VALUES (3235,'NOVO HORIZONTE','SP');
INSERT INTO `municipios` VALUES (3236,'NOVO HORIZONTE DO NORTE','MT');
INSERT INTO `municipios` VALUES (3237,'NOVO HORIZONTE DO OESTE','RO');
INSERT INTO `municipios` VALUES (3238,'NOVO HORIZONTE DO SUL','MS');
INSERT INTO `municipios` VALUES (3239,'NOVO ITACOLOMI','PR');
INSERT INTO `municipios` VALUES (3240,'NOVO JARDIM','TO');
INSERT INTO `municipios` VALUES (3241,'NOVO LINO','AL');
INSERT INTO `municipios` VALUES (3242,'NOVO MACHADO','RS');
INSERT INTO `municipios` VALUES (3243,'NOVO MUNDO','MT');
INSERT INTO `municipios` VALUES (3244,'NOVO ORIENTE','CE');
INSERT INTO `municipios` VALUES (3245,'NOVO ORIENTE DE MINAS','MG');
INSERT INTO `municipios` VALUES (3246,'NOVO ORIENTE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3247,'NOVO PLANALTO','GO');
INSERT INTO `municipios` VALUES (3248,'NOVO PROGRESSO','PA');
INSERT INTO `municipios` VALUES (3249,'NOVO REPARTIMENTO','PA');
INSERT INTO `municipios` VALUES (3250,'NOVO SANTO ANTÔNIO','PI');
INSERT INTO `municipios` VALUES (3251,'NOVO SÃO JOAQUIM','MT');
INSERT INTO `municipios` VALUES (3252,'NOVO TIRADENTES','RS');
INSERT INTO `municipios` VALUES (3253,'NOVO TRIUNFO','BA');
INSERT INTO `municipios` VALUES (3254,'NOVO XINGU','RS');
INSERT INTO `municipios` VALUES (3255,'NOVORIZANTE','MG');
INSERT INTO `municipios` VALUES (3256,'NUPORANGA','SP');
INSERT INTO `municipios` VALUES (3257,'ÓBIDOS','PA');
INSERT INTO `municipios` VALUES (3258,'OCARA','CE');
INSERT INTO `municipios` VALUES (3259,'OCAUÇU','SP');
INSERT INTO `municipios` VALUES (3260,'OEIRAS','PI');
INSERT INTO `municipios` VALUES (3261,'OEIRAS DO PARA','PA');
INSERT INTO `municipios` VALUES (3262,'OIAPOQUE','AP');
INSERT INTO `municipios` VALUES (3263,'OLARIA','MG');
INSERT INTO `municipios` VALUES (3264,'ÓLEO','SP');
INSERT INTO `municipios` VALUES (3265,'OLHO D\'ÁGUA','PB');
INSERT INTO `municipios` VALUES (3266,'OLHO D\'ÁGUA DAS CUNHAS','MA');
INSERT INTO `municipios` VALUES (3267,'OLHO D\'ÁGUA DAS FLORES','AL');
INSERT INTO `municipios` VALUES (3268,'OLHO D\'ÁGUA DO CASADO','AL');
INSERT INTO `municipios` VALUES (3269,'OLHO D\'ÁGUA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3270,'OLHO D\'ÁGUA DOS BORGES','RN');
INSERT INTO `municipios` VALUES (3271,'OLIMPIA','SP');
INSERT INTO `municipios` VALUES (3272,'OLIMPIO NORONHA','MG');
INSERT INTO `municipios` VALUES (3273,'OLINDA','PE');
INSERT INTO `municipios` VALUES (3274,'OLINDA NOVA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (3275,'OLINDINA','BA');
INSERT INTO `municipios` VALUES (3276,'OLIVEDOS','PB');
INSERT INTO `municipios` VALUES (3277,'OLIVEIRA','MG');
INSERT INTO `municipios` VALUES (3278,'OLIVEIRA DE FÁTIMA','TO');
INSERT INTO `municipios` VALUES (3279,'OLIVEIRA DOS BREJINHOS','BA');
INSERT INTO `municipios` VALUES (3280,'OLIVEIRA FORTES','MG');
INSERT INTO `municipios` VALUES (3281,'OLIVENÇA','AL');
INSERT INTO `municipios` VALUES (3282,'ONÇA DO PITANGUI','MG');
INSERT INTO `municipios` VALUES (3283,'ONDA VERDE','SP');
INSERT INTO `municipios` VALUES (3284,'ORATÓRIOS','MG');
INSERT INTO `municipios` VALUES (3285,'ORIENTE','SP');
INSERT INTO `municipios` VALUES (3286,'ORINDIUVA','SP');
INSERT INTO `municipios` VALUES (3287,'ORIXIMINA DO NORTE','PA');
INSERT INTO `municipios` VALUES (3288,'ORIZONA','GO');
INSERT INTO `municipios` VALUES (3289,'ORLÂNDIA','SP');
INSERT INTO `municipios` VALUES (3290,'ORLEANS','SC');
INSERT INTO `municipios` VALUES (3291,'OROBÓ','PE');
INSERT INTO `municipios` VALUES (3292,'OROCÓ','PE');
INSERT INTO `municipios` VALUES (3293,'OROS','CE');
INSERT INTO `municipios` VALUES (3294,'ORTIGUEIRA','PR');
INSERT INTO `municipios` VALUES (3295,'OSASCO','SP');
INSERT INTO `municipios` VALUES (3296,'OSCAR BRESSANE','SP');
INSERT INTO `municipios` VALUES (3297,'OSÓRIO','RS');
INSERT INTO `municipios` VALUES (3298,'OSVALDO CRUZ','SP');
INSERT INTO `municipios` VALUES (3299,'OTACÍLIO COSTA','SC');
INSERT INTO `municipios` VALUES (3300,'OUREM','PA');
INSERT INTO `municipios` VALUES (3301,'OURICANGAS','BA');
INSERT INTO `municipios` VALUES (3302,'OURICURI','PE');
INSERT INTO `municipios` VALUES (3303,'OURILÂNDIA DO NORTE','PA');
INSERT INTO `municipios` VALUES (3304,'OURINHOS','SP');
INSERT INTO `municipios` VALUES (3305,'OURIZONA','PR');
INSERT INTO `municipios` VALUES (3306,'OURO','SC');
INSERT INTO `municipios` VALUES (3307,'OURO BRANCO','AL');
INSERT INTO `municipios` VALUES (3308,'OURO BRANCO','RN');
INSERT INTO `municipios` VALUES (3309,'OURO FINO','MG');
INSERT INTO `municipios` VALUES (3310,'OURO PRETO','MG');
INSERT INTO `municipios` VALUES (3311,'OURO PRETO DO OESTE','RO');
INSERT INTO `municipios` VALUES (3312,'OURO VELHO','PB');
INSERT INTO `municipios` VALUES (3313,'OURO VERDE','SP');
INSERT INTO `municipios` VALUES (3314,'OURO VERDE DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3315,'OURO VERDE DE MINAS','MG');
INSERT INTO `municipios` VALUES (3316,'OURO VERDE DO OESTE','PR');
INSERT INTO `municipios` VALUES (3317,'OUROESTE','SP');
INSERT INTO `municipios` VALUES (3318,'OUROLÂNDIA','BA');
INSERT INTO `municipios` VALUES (3319,'OUVIDOR','GO');
INSERT INTO `municipios` VALUES (3320,'PACAEMBU','SP');
INSERT INTO `municipios` VALUES (3321,'PACAJA','PA');
INSERT INTO `municipios` VALUES (3322,'PACAJUS','CE');
INSERT INTO `municipios` VALUES (3323,'PACARAIMA','RR');
INSERT INTO `municipios` VALUES (3324,'PACATUBA','CE');
INSERT INTO `municipios` VALUES (3325,'PACO DO LUMIAR','MA');
INSERT INTO `municipios` VALUES (3326,'PACOTI','CE');
INSERT INTO `municipios` VALUES (3327,'PAÇUJA','CE');
INSERT INTO `municipios` VALUES (3328,'PADRE BERNARDO','GO');
INSERT INTO `municipios` VALUES (3329,'PADRE CARVALHO','MG');
INSERT INTO `municipios` VALUES (3330,'PADRE MARCOS','PI');
INSERT INTO `municipios` VALUES (3331,'PADRE PARAISO','MG');
INSERT INTO `municipios` VALUES (3332,'PAES LANDIM','PI');
INSERT INTO `municipios` VALUES (3333,'PAI PEDRO','MG');
INSERT INTO `municipios` VALUES (3334,'PAIAL','SC');
INSERT INTO `municipios` VALUES (3335,'PAIÇANDU','PR');
INSERT INTO `municipios` VALUES (3336,'PAIM FILHO','RS');
INSERT INTO `municipios` VALUES (3337,'PAINEIRAS','MG');
INSERT INTO `municipios` VALUES (3338,'PAINEL','SC');
INSERT INTO `municipios` VALUES (3339,'PAINS','MG');
INSERT INTO `municipios` VALUES (3340,'PAIVA','MG');
INSERT INTO `municipios` VALUES (3341,'PAJEU DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3342,'PALESTINA','AL');
INSERT INTO `municipios` VALUES (3343,'PALESTINA','SP');
INSERT INTO `municipios` VALUES (3344,'PALESTINA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3345,'PALESTINA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (3346,'PALHANO','CE');
INSERT INTO `municipios` VALUES (3347,'PALHOÇA','SC');
INSERT INTO `municipios` VALUES (3348,'PALMA','MG');
INSERT INTO `municipios` VALUES (3349,'PALMA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (3350,'PALMA SOLA','SC');
INSERT INTO `municipios` VALUES (3351,'PALMACIA','CE');
INSERT INTO `municipios` VALUES (3352,'PALMARES','PE');
INSERT INTO `municipios` VALUES (3353,'PALMARES DO SUL','RS');
INSERT INTO `municipios` VALUES (3354,'PALMARES PAULISTA','SP');
INSERT INTO `municipios` VALUES (3355,'PALMAS','PR');
INSERT INTO `municipios` VALUES (3356,'PALMAS','TO');
INSERT INTO `municipios` VALUES (3357,'PALMAS DE MONTE ALTO','BA');
INSERT INTO `municipios` VALUES (3358,'PALMEIRA','PR');
INSERT INTO `municipios` VALUES (3359,'PALMEIRA DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (3360,'PALMEIRA DO OESTE','SP');
INSERT INTO `municipios` VALUES (3361,'PALMEIRA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3362,'PALMEIRA DOS ÍNDIOS','AL');
INSERT INTO `municipios` VALUES (3363,'PALMEIRAÍS','PI');
INSERT INTO `municipios` VALUES (3364,'PALMEIRÂNDIA','MA');
INSERT INTO `municipios` VALUES (3365,'PALMEIRANTE','TO');
INSERT INTO `municipios` VALUES (3366,'PALMEIRAS','BA');
INSERT INTO `municipios` VALUES (3367,'PALMEIRAS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3368,'PALMEIRAS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (3369,'PALMERINA','PE');
INSERT INTO `municipios` VALUES (3370,'PALMEIRÓPOLIS','TO');
INSERT INTO `municipios` VALUES (3371,'PALMELO','GO');
INSERT INTO `municipios` VALUES (3372,'PALMINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (3373,'PALMITAL','PR');
INSERT INTO `municipios` VALUES (3374,'PALMITINHO','RS');
INSERT INTO `municipios` VALUES (3375,'PALMITOS','SC');
INSERT INTO `municipios` VALUES (3376,'PALMÓPOLIS','MG');
INSERT INTO `municipios` VALUES (3377,'PALOTINA','PR');
INSERT INTO `municipios` VALUES (3378,'PANAMÁ','GO');
INSERT INTO `municipios` VALUES (3379,'PANAMBI','RS');
INSERT INTO `municipios` VALUES (3380,'PANCAS','ES');
INSERT INTO `municipios` VALUES (3381,'PANELAS','PE');
INSERT INTO `municipios` VALUES (3382,'PANORAMA','SP');
INSERT INTO `municipios` VALUES (3383,'PANTANA GRANDE','RS');
INSERT INTO `municipios` VALUES (3384,'PÂNTANO GRANDE','RS');
INSERT INTO `municipios` VALUES (3385,'PÃO DE AÇUCAR','AL');
INSERT INTO `municipios` VALUES (3386,'PAPAGAIOS','MG');
INSERT INTO `municipios` VALUES (3387,'PAPANDUVA','SC');
INSERT INTO `municipios` VALUES (3388,'PAQUETA','PI');
INSERT INTO `municipios` VALUES (3389,'PARÁ DE MINAS','MG');
INSERT INTO `municipios` VALUES (3390,'PARACAMBI','RJ');
INSERT INTO `municipios` VALUES (3391,'PARACATU','MG');
INSERT INTO `municipios` VALUES (3392,'PARAÇURU','CE');
INSERT INTO `municipios` VALUES (3393,'PARAGOMINAS','PA');
INSERT INTO `municipios` VALUES (3394,'PARÁGUAÇU','MG');
INSERT INTO `municipios` VALUES (3395,'PARÁGUAÇU PAULISTA','SP');
INSERT INTO `municipios` VALUES (3396,'PARAÍ','RS');
INSERT INTO `municipios` VALUES (3397,'PARAÍBA DO SUL','RJ');
INSERT INTO `municipios` VALUES (3398,'PARAÍBANO','MA');
INSERT INTO `municipios` VALUES (3399,'PARAIBUNA','SP');
INSERT INTO `municipios` VALUES (3400,'PARAIPABA','CE');
INSERT INTO `municipios` VALUES (3401,'PARAISO','SC');
INSERT INTO `municipios` VALUES (3402,'PARAÍSO','SP');
INSERT INTO `municipios` VALUES (3403,'PARAISO DO NORTE','PR');
INSERT INTO `municipios` VALUES (3404,'PARAISO DO SUL','RS');
INSERT INTO `municipios` VALUES (3405,'PARAISO DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (3406,'PARAISÓPOLIS','MG');
INSERT INTO `municipios` VALUES (3407,'PARAMBU','CE');
INSERT INTO `municipios` VALUES (3408,'PARAMIRIM','BA');
INSERT INTO `municipios` VALUES (3409,'PARAMOTI','CE');
INSERT INTO `municipios` VALUES (3410,'PARANÁ','RN');
INSERT INTO `municipios` VALUES (3411,'PARANÁCITY','PR');
INSERT INTO `municipios` VALUES (3412,'PARANAGUÁ','PR');
INSERT INTO `municipios` VALUES (3413,'PARANÁIBA','MS');
INSERT INTO `municipios` VALUES (3414,'PARANÁIGUARA','GO');
INSERT INTO `municipios` VALUES (3415,'PARANAÍTA','MT');
INSERT INTO `municipios` VALUES (3416,'PARANÁPANEMA','SP');
INSERT INTO `municipios` VALUES (3417,'PARANAPOEMA','PR');
INSERT INTO `municipios` VALUES (3418,'PARANAPUA','SP');
INSERT INTO `municipios` VALUES (3419,'PARANÁTAMA','PE');
INSERT INTO `municipios` VALUES (3420,'PARANÁTINGA','MT');
INSERT INTO `municipios` VALUES (3421,'PARANAVAÍ','PR');
INSERT INTO `municipios` VALUES (3422,'PARANHOS','MS');
INSERT INTO `municipios` VALUES (3423,'PARAOPEBA','MG');
INSERT INTO `municipios` VALUES (3424,'PARAPUA','SP');
INSERT INTO `municipios` VALUES (3425,'PARARI','PB');
INSERT INTO `municipios` VALUES (3426,'PARATINGA','BA');
INSERT INTO `municipios` VALUES (3427,'PARATY','RJ');
INSERT INTO `municipios` VALUES (3428,'PARAU','RN');
INSERT INTO `municipios` VALUES (3429,'PARAUAPEBAS','PA');
INSERT INTO `municipios` VALUES (3430,'PARAUNA','GO');
INSERT INTO `municipios` VALUES (3431,'PARAZINHO','RN');
INSERT INTO `municipios` VALUES (3432,'PARDINHO','SP');
INSERT INTO `municipios` VALUES (3433,'PARECI NOVO','RS');
INSERT INTO `municipios` VALUES (3434,'PARECIS','RO');
INSERT INTO `municipios` VALUES (3435,'PARELHAS','RN');
INSERT INTO `municipios` VALUES (3436,'PARICONHA','AL');
INSERT INTO `municipios` VALUES (3437,'PARINTINS','AM');
INSERT INTO `municipios` VALUES (3438,'PARIPIRANGA','BA');
INSERT INTO `municipios` VALUES (3439,'PARIPUEIRA','AL');
INSERT INTO `municipios` VALUES (3440,'PARIQUERA-AÇU','SP');
INSERT INTO `municipios` VALUES (3441,'PARISI','SP');
INSERT INTO `municipios` VALUES (3442,'PARNÁGUA','PI');
INSERT INTO `municipios` VALUES (3443,'PARNAIBA','PI');
INSERT INTO `municipios` VALUES (3444,'PARNAMIRIM','PE');
INSERT INTO `municipios` VALUES (3445,'PARNARAMA','MA');
INSERT INTO `municipios` VALUES (3446,'PAROBÉ','RS');
INSERT INTO `municipios` VALUES (3447,'PASSA E FICA','RN');
INSERT INTO `municipios` VALUES (3448,'PASSA QUATRO','MG');
INSERT INTO `municipios` VALUES (3449,'PASSA SETE','RS');
INSERT INTO `municipios` VALUES (3450,'PASSA TEMPO','MG');
INSERT INTO `municipios` VALUES (3451,'PASSA VINTE','MG');
INSERT INTO `municipios` VALUES (3452,'PASSABÉM','MG');
INSERT INTO `municipios` VALUES (3453,'PASSAGEM','PB');
INSERT INTO `municipios` VALUES (3454,'PASSAGEM','RN');
INSERT INTO `municipios` VALUES (3455,'PASSAGEM FRANCA','MA');
INSERT INTO `municipios` VALUES (3456,'PASSAGEM FRANCA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3457,'PASSIRA','PE');
INSERT INTO `municipios` VALUES (3458,'PASSO DE CAMARAGIBE','AL');
INSERT INTO `municipios` VALUES (3459,'PASSO DE TORRES','SC');
INSERT INTO `municipios` VALUES (3460,'PASSO DO SOBRADO','RS');
INSERT INTO `municipios` VALUES (3461,'PASSO FUNDO','RS');
INSERT INTO `municipios` VALUES (3462,'PASSOS','MG');
INSERT INTO `municipios` VALUES (3463,'PASSOS MAIA','SC');
INSERT INTO `municipios` VALUES (3464,'PASTOS BONS','MA');
INSERT INTO `municipios` VALUES (3465,'PATO BRAGADO','PR');
INSERT INTO `municipios` VALUES (3466,'PATO BRANCO','PR');
INSERT INTO `municipios` VALUES (3467,'PATOS','PB');
INSERT INTO `municipios` VALUES (3468,'PATOS DE MINAS','MG');
INSERT INTO `municipios` VALUES (3469,'PATOS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3470,'PATROCINIO','MG');
INSERT INTO `municipios` VALUES (3471,'PATROCÍNIO DE MURIAÉ','MG');
INSERT INTO `municipios` VALUES (3472,'PATROCINIO PAULISTA','SP');
INSERT INTO `municipios` VALUES (3473,'PATU','RN');
INSERT INTO `municipios` VALUES (3474,'PATY DO ALFERES','RJ');
INSERT INTO `municipios` VALUES (3475,'PAU BRASIL','BA');
INSERT INTO `municipios` VALUES (3476,'PAU D\'ARCO','PA');
INSERT INTO `municipios` VALUES (3477,'PAU DOS FERROS','RN');
INSERT INTO `municipios` VALUES (3478,'PAUDALHO','PE');
INSERT INTO `municipios` VALUES (3479,'PAUINI','AM');
INSERT INTO `municipios` VALUES (3480,'PAULA CÂNDIDO','MG');
INSERT INTO `municipios` VALUES (3481,'PAULA FREITAS','PR');
INSERT INTO `municipios` VALUES (3482,'PAULICÉIA','SP');
INSERT INTO `municipios` VALUES (3483,'PAULINIA','SP');
INSERT INTO `municipios` VALUES (3484,'PAULINO NEVES','MA');
INSERT INTO `municipios` VALUES (3485,'PAULISTA','PB');
INSERT INTO `municipios` VALUES (3486,'PAULISTANA','PI');
INSERT INTO `municipios` VALUES (3487,'PAULISTANIA','SP');
INSERT INTO `municipios` VALUES (3488,'PAULISTAS','MG');
INSERT INTO `municipios` VALUES (3489,'PAULO AFONSO','BA');
INSERT INTO `municipios` VALUES (3490,'PAULO DE FARIA','SP');
INSERT INTO `municipios` VALUES (3491,'PAULO FRONTIN','PR');
INSERT INTO `municipios` VALUES (3492,'PAULO JACINTO','AL');
INSERT INTO `municipios` VALUES (3493,'PAULO LOPES','SC');
INSERT INTO `municipios` VALUES (3494,'PAULO RAMOS','MA');
INSERT INTO `municipios` VALUES (3495,'PAVÃO','MG');
INSERT INTO `municipios` VALUES (3496,'PAVERAMA','RS');
INSERT INTO `municipios` VALUES (3497,'PAVUSSU','PI');
INSERT INTO `municipios` VALUES (3498,'PÉ DE SERRA','BA');
INSERT INTO `municipios` VALUES (3499,'PEABIRU','PR');
INSERT INTO `municipios` VALUES (3500,'PEÇANHA','MG');
INSERT INTO `municipios` VALUES (3501,'PEDERNEIRAS','SP');
INSERT INTO `municipios` VALUES (3502,'PEDRA','PE');
INSERT INTO `municipios` VALUES (3503,'PEDRA AZUL','MG');
INSERT INTO `municipios` VALUES (3504,'PEDRA BELA','SP');
INSERT INTO `municipios` VALUES (3505,'PEDRA BRANCA','CE');
INSERT INTO `municipios` VALUES (3506,'PEDRA BRANCA DO AMAPARI','AP');
INSERT INTO `municipios` VALUES (3507,'PEDRA DO ANTA','MG');
INSERT INTO `municipios` VALUES (3508,'PEDRA DO INDAIA','MG');
INSERT INTO `municipios` VALUES (3509,'PEDRA DOURADA','MG');
INSERT INTO `municipios` VALUES (3510,'PEDRA GRANDE','RN');
INSERT INTO `municipios` VALUES (3511,'PEDRA LAVRADA','PB');
INSERT INTO `municipios` VALUES (3512,'PEDRA MOLE','SE');
INSERT INTO `municipios` VALUES (3513,'PEDRA PRETA','MT');
INSERT INTO `municipios` VALUES (3514,'PEDRALVA','MG');
INSERT INTO `municipios` VALUES (3515,'PEDRANÓPOLIS','SP');
INSERT INTO `municipios` VALUES (3516,'PEDRÃO','BA');
INSERT INTO `municipios` VALUES (3517,'PEDRAS DE FOGO','PB');
INSERT INTO `municipios` VALUES (3518,'PEDRAS DE MARIA DA CRUZ','MG');
INSERT INTO `municipios` VALUES (3519,'PEDRAS GRANDES','SC');
INSERT INTO `municipios` VALUES (3520,'PEDREGULHO','SP');
INSERT INTO `municipios` VALUES (3521,'PEDREIRA','SP');
INSERT INTO `municipios` VALUES (3522,'PEDREIRAS','MA');
INSERT INTO `municipios` VALUES (3523,'PEDRINHAS','SE');
INSERT INTO `municipios` VALUES (3524,'PEDRINHAS PAULISTA','SP');
INSERT INTO `municipios` VALUES (3525,'PEDRINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (3526,'PEDRO AFONSO','TO');
INSERT INTO `municipios` VALUES (3527,'PEDRO ALEXANDRÉ','BA');
INSERT INTO `municipios` VALUES (3528,'PEDRO AVELINO','RN');
INSERT INTO `municipios` VALUES (3529,'PEDRO CANÁRIO','ES');
INSERT INTO `municipios` VALUES (3530,'PEDRO DE TOLEDO','SP');
INSERT INTO `municipios` VALUES (3531,'PEDRO DO ROSÁRIO','MA');
INSERT INTO `municipios` VALUES (3532,'PEDRO GOMES','MS');
INSERT INTO `municipios` VALUES (3533,'PEDRO II','PI');
INSERT INTO `municipios` VALUES (3534,'PEDRO LAURENTINO','PI');
INSERT INTO `municipios` VALUES (3535,'PEDRO LEOPOLDO','MG');
INSERT INTO `municipios` VALUES (3536,'PEDRO OSÓRIO','RS');
INSERT INTO `municipios` VALUES (3537,'PEDRO REGIS','PB');
INSERT INTO `municipios` VALUES (3538,'PEDRO TEIXEIRA','MG');
INSERT INTO `municipios` VALUES (3539,'PEDRO VELHO','RN');
INSERT INTO `municipios` VALUES (3540,'PEIXE','TO');
INSERT INTO `municipios` VALUES (3541,'PEIXE-BOI','PA');
INSERT INTO `municipios` VALUES (3542,'PEIXOTO DE AZEVEDO','MT');
INSERT INTO `municipios` VALUES (3543,'PEJUCARA','RS');
INSERT INTO `municipios` VALUES (3544,'PELOTAS','RS');
INSERT INTO `municipios` VALUES (3545,'PENAFORTE','CE');
INSERT INTO `municipios` VALUES (3546,'PENALVA','MA');
INSERT INTO `municipios` VALUES (3547,'PENÁPOLIS','SP');
INSERT INTO `municipios` VALUES (3548,'PENEDO','AL');
INSERT INTO `municipios` VALUES (3549,'PENHA','SC');
INSERT INTO `municipios` VALUES (3550,'PENTECOSTE','CE');
INSERT INTO `municipios` VALUES (3551,'PEQUERI','MG');
INSERT INTO `municipios` VALUES (3552,'PEQUI','MG');
INSERT INTO `municipios` VALUES (3553,'PEQUIZEIRO','TO');
INSERT INTO `municipios` VALUES (3554,'PERDIGAO','MG');
INSERT INTO `municipios` VALUES (3555,'PERDIZES','MG');
INSERT INTO `municipios` VALUES (3556,'PERDÕES','MG');
INSERT INTO `municipios` VALUES (3557,'PEREIRA BARRETO','SP');
INSERT INTO `municipios` VALUES (3558,'PEREIRAS','SP');
INSERT INTO `municipios` VALUES (3559,'PEREIRO','CE');
INSERT INTO `municipios` VALUES (3560,'PERI-MIRIM','MA');
INSERT INTO `municipios` VALUES (3561,'PERIQUITO','MG');
INSERT INTO `municipios` VALUES (3562,'PERITIBA','SC');
INSERT INTO `municipios` VALUES (3563,'PERITORO','MA');
INSERT INTO `municipios` VALUES (3564,'PEROBAL','PR');
INSERT INTO `municipios` VALUES (3565,'PEROLA','PR');
INSERT INTO `municipios` VALUES (3566,'PEROLA  D`OESTE','PR');
INSERT INTO `municipios` VALUES (3567,'PEROLÂNDIA','GO');
INSERT INTO `municipios` VALUES (3568,'PERUIBE','SP');
INSERT INTO `municipios` VALUES (3569,'PESCADOR','MG');
INSERT INTO `municipios` VALUES (3570,'PESQUEIRA','PE');
INSERT INTO `municipios` VALUES (3571,'PETROLÂNDIA','PE');
INSERT INTO `municipios` VALUES (3572,'PETROLINA','PE');
INSERT INTO `municipios` VALUES (3573,'PETROLINA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3574,'PETRÓPOLIS','RJ');
INSERT INTO `municipios` VALUES (3575,'PIACABUCU','AL');
INSERT INTO `municipios` VALUES (3576,'PIACATU','SP');
INSERT INTO `municipios` VALUES (3577,'PIANCÓ','PB');
INSERT INTO `municipios` VALUES (3578,'PIATÃ','BA');
INSERT INTO `municipios` VALUES (3579,'PIAU','MG');
INSERT INTO `municipios` VALUES (3580,'PICADA CAFE','RS');
INSERT INTO `municipios` VALUES (3581,'PICARRA','PA');
INSERT INTO `municipios` VALUES (3582,'PIÇARRAS','SC');
INSERT INTO `municipios` VALUES (3583,'PICOS','PI');
INSERT INTO `municipios` VALUES (3584,'PICUI','PB');
INSERT INTO `municipios` VALUES (3585,'PIEDADE','SP');
INSERT INTO `municipios` VALUES (3586,'PIEDADE DE CARATINGA','MG');
INSERT INTO `municipios` VALUES (3587,'PIEDADE DE PONTE NOVA','MG');
INSERT INTO `municipios` VALUES (3588,'PIEDADE DO RIO GRANDE','MG');
INSERT INTO `municipios` VALUES (3589,'PIEDADE DOS GERAIS','MG');
INSERT INTO `municipios` VALUES (3590,'PIEN','PR');
INSERT INTO `municipios` VALUES (3591,'PILÃO ARCADO','BA');
INSERT INTO `municipios` VALUES (3592,'PILAR','AL');
INSERT INTO `municipios` VALUES (3593,'PILAR','PB');
INSERT INTO `municipios` VALUES (3594,'PILAR DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (3595,'PILAR DO SUL','SP');
INSERT INTO `municipios` VALUES (3596,'PILOES','PB');
INSERT INTO `municipios` VALUES (3597,'PILÕES','RN');
INSERT INTO `municipios` VALUES (3598,'PILÕEZINHOS','PB');
INSERT INTO `municipios` VALUES (3599,'PIMENTA','MG');
INSERT INTO `municipios` VALUES (3600,'PIMENTA BUENO','RO');
INSERT INTO `municipios` VALUES (3601,'PIMENTEIRAS','PI');
INSERT INTO `municipios` VALUES (3602,'PIMENTEIRAS DO OESTE','RO');
INSERT INTO `municipios` VALUES (3603,'PINDAI (OURO BRANCO)','BA');
INSERT INTO `municipios` VALUES (3604,'PINDAMONHANGABA','SP');
INSERT INTO `municipios` VALUES (3605,'PINDARÉ MIRIM','MA');
INSERT INTO `municipios` VALUES (3606,'PINDOBAÇU','BA');
INSERT INTO `municipios` VALUES (3607,'PINDORAMA','SP');
INSERT INTO `municipios` VALUES (3608,'PINDORAMA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (3609,'PINDORETAMA','CE');
INSERT INTO `municipios` VALUES (3610,'PINHAIS','PR');
INSERT INTO `municipios` VALUES (3611,'PINHAL','RS');
INSERT INTO `municipios` VALUES (3612,'PINHAL DA SERRA','RS');
INSERT INTO `municipios` VALUES (3613,'PINHAL DE SÃO BENTO','PR');
INSERT INTO `municipios` VALUES (3614,'PINHAL GRANDE','RS');
INSERT INTO `municipios` VALUES (3615,'PINHALÃO','PR');
INSERT INTO `municipios` VALUES (3616,'PINHALZINHO','SP');
INSERT INTO `municipios` VALUES (3617,'PINHÃO','PR');
INSERT INTO `municipios` VALUES (3618,'PINHÃO','SE');
INSERT INTO `municipios` VALUES (3619,'PINHEIRAL','RJ');
INSERT INTO `municipios` VALUES (3620,'PINHEIRINHO DO VALE','RS');
INSERT INTO `municipios` VALUES (3621,'PINHEIRO','MA');
INSERT INTO `municipios` VALUES (3622,'PINHEIRO MACHADO','RS');
INSERT INTO `municipios` VALUES (3623,'PINHEIRO PRETO','SC');
INSERT INTO `municipios` VALUES (3624,'PINTADAS','BA');
INSERT INTO `municipios` VALUES (3625,'PIO IX','PI');
INSERT INTO `municipios` VALUES (3626,'PIO XII','MA');
INSERT INTO `municipios` VALUES (3627,'PIQUEROBI','SP');
INSERT INTO `municipios` VALUES (3628,'PIQUET CARNEIRO','CE');
INSERT INTO `municipios` VALUES (3629,'PIQUETE','SP');
INSERT INTO `municipios` VALUES (3630,'PIRACAIA','SP');
INSERT INTO `municipios` VALUES (3631,'PIRACANJUBA','GO');
INSERT INTO `municipios` VALUES (3632,'PIRACEMA','MG');
INSERT INTO `municipios` VALUES (3633,'PIRACICABA','SP');
INSERT INTO `municipios` VALUES (3634,'PIRAÇURUCA','PI');
INSERT INTO `municipios` VALUES (3635,'PIRAÍ','RJ');
INSERT INTO `municipios` VALUES (3636,'PIRAÍ DO NORTE','BA');
INSERT INTO `municipios` VALUES (3637,'PIRAÍ DO SUL','PR');
INSERT INTO `municipios` VALUES (3638,'PIRAJU','SP');
INSERT INTO `municipios` VALUES (3639,'PIRAJUBA','MG');
INSERT INTO `municipios` VALUES (3640,'PIRAJUI','SP');
INSERT INTO `municipios` VALUES (3641,'PIRAMBU','SE');
INSERT INTO `municipios` VALUES (3642,'PIRANGA','MG');
INSERT INTO `municipios` VALUES (3643,'PIRANGI','SP');
INSERT INTO `municipios` VALUES (3644,'PIRANGUCU','MG');
INSERT INTO `municipios` VALUES (3645,'PIRANGUINHO','MG');
INSERT INTO `municipios` VALUES (3646,'PIRANHAS','AL');
INSERT INTO `municipios` VALUES (3647,'PIRAPEMAS','MA');
INSERT INTO `municipios` VALUES (3648,'PIRAPETINGA','MG');
INSERT INTO `municipios` VALUES (3649,'PIRAPO','RS');
INSERT INTO `municipios` VALUES (3650,'PIRAPORA','MG');
INSERT INTO `municipios` VALUES (3651,'PIRAPORA DO BOM JESUS','SP');
INSERT INTO `municipios` VALUES (3652,'PIRAPOZINHO','SP');
INSERT INTO `municipios` VALUES (3653,'PIRAQUARA','PR');
INSERT INTO `municipios` VALUES (3654,'PIRAQUE','TO');
INSERT INTO `municipios` VALUES (3655,'PIRASSUNUNGA','SP');
INSERT INTO `municipios` VALUES (3656,'PIRATINI','RS');
INSERT INTO `municipios` VALUES (3657,'PIRATININGA','SP');
INSERT INTO `municipios` VALUES (3658,'PIRATUBA','SC');
INSERT INTO `municipios` VALUES (3659,'PIRAÚBA','MG');
INSERT INTO `municipios` VALUES (3660,'PIRENÓPOLIS','GO');
INSERT INTO `municipios` VALUES (3661,'PIRES DO RIO','GO');
INSERT INTO `municipios` VALUES (3662,'PIRES FERREIRA','CE');
INSERT INTO `municipios` VALUES (3663,'PIRIPA','BA');
INSERT INTO `municipios` VALUES (3664,'PIRIPIRI','PI');
INSERT INTO `municipios` VALUES (3665,'PIRPIRITUBA','PB');
INSERT INTO `municipios` VALUES (3666,'PITANGA','PR');
INSERT INTO `municipios` VALUES (3667,'PITANGUEIRAS','PR');
INSERT INTO `municipios` VALUES (3668,'PITANGUI','MG');
INSERT INTO `municipios` VALUES (3669,'PITIMBU','PB');
INSERT INTO `municipios` VALUES (3670,'PIUM','TO');
INSERT INTO `municipios` VALUES (3671,'PIUMA','ES');
INSERT INTO `municipios` VALUES (3672,'PIUM-I','MG');
INSERT INTO `municipios` VALUES (3673,'PLACAS','PA');
INSERT INTO `municipios` VALUES (3674,'PLÁCIDO DE CASTRO','AC');
INSERT INTO `municipios` VALUES (3675,'PLANALTINA','GO');
INSERT INTO `municipios` VALUES (3676,'PLANALTINA DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (3677,'PLANALTINO','BA');
INSERT INTO `municipios` VALUES (3678,'PLANALTO','BA');
INSERT INTO `municipios` VALUES (3679,'PLANALTO ALEGRE','SC');
INSERT INTO `municipios` VALUES (3680,'PLANALTO DA SERRA','MT');
INSERT INTO `municipios` VALUES (3681,'PLANURA','MG');
INSERT INTO `municipios` VALUES (3682,'PLATINA','SP');
INSERT INTO `municipios` VALUES (3683,'POA','SP');
INSERT INTO `municipios` VALUES (3684,'POÇÃO','PE');
INSERT INTO `municipios` VALUES (3685,'POÇÃO DE PEDRAS','MA');
INSERT INTO `municipios` VALUES (3686,'POCINHOS','PB');
INSERT INTO `municipios` VALUES (3687,'POÇO BRANCO','RN');
INSERT INTO `municipios` VALUES (3688,'POÇO DANTAS','PB');
INSERT INTO `municipios` VALUES (3689,'POÇO DAS ANTAS','RS');
INSERT INTO `municipios` VALUES (3690,'POÇO DAS TRINCHEIRAS','AL');
INSERT INTO `municipios` VALUES (3691,'POÇO DE JOSÉ DE MOURA','PB');
INSERT INTO `municipios` VALUES (3692,'POÇO FUNDO','MG');
INSERT INTO `municipios` VALUES (3693,'POÇO REDONDO','SE');
INSERT INTO `municipios` VALUES (3694,'POÇO VERDE','SE');
INSERT INTO `municipios` VALUES (3695,'POÇÕES','BA');
INSERT INTO `municipios` VALUES (3696,'POCONÉ','MT');
INSERT INTO `municipios` VALUES (3697,'POÇOS DE CALDAS','MG');
INSERT INTO `municipios` VALUES (3698,'POCRANE','MG');
INSERT INTO `municipios` VALUES (3699,'POJUCA','BA');
INSERT INTO `municipios` VALUES (3700,'POLONI','SP');
INSERT INTO `municipios` VALUES (3701,'POMBAL','PB');
INSERT INTO `municipios` VALUES (3702,'POMBOS','PE');
INSERT INTO `municipios` VALUES (3703,'POMERODE','SC');
INSERT INTO `municipios` VALUES (3704,'POMPÉIA','SP');
INSERT INTO `municipios` VALUES (3705,'POMPÉU','MG');
INSERT INTO `municipios` VALUES (3706,'PONGAÍ','SP');
INSERT INTO `municipios` VALUES (3707,'PONTA DE PEDRAS','PA');
INSERT INTO `municipios` VALUES (3708,'PONTA GROSSA','PR');
INSERT INTO `municipios` VALUES (3709,'PONTALINDA','SP');
INSERT INTO `municipios` VALUES (3710,'PONTA PORÃ','MS');
INSERT INTO `municipios` VALUES (3711,'PONTAL','SP');
INSERT INTO `municipios` VALUES (3712,'PONTAL DO ARAGUAIA','MT');
INSERT INTO `municipios` VALUES (3713,'PONTAL DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (3714,'PONTALINA','GO');
INSERT INTO `municipios` VALUES (3715,'PONTÃO','RS');
INSERT INTO `municipios` VALUES (3716,'PONTE','MG');
INSERT INTO `municipios` VALUES (3717,'PONTE ALTA','SC');
INSERT INTO `municipios` VALUES (3718,'PONTE ALTA DO BOM JESUS','TO');
INSERT INTO `municipios` VALUES (3719,'PONTE ALTA DO NORTE','SC');
INSERT INTO `municipios` VALUES (3720,'PONTE ALTA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (3721,'PONTE BRANCA','MT');
INSERT INTO `municipios` VALUES (3722,'PONTE NOVA','MG');
INSERT INTO `municipios` VALUES (3723,'PONTE PRETA','RS');
INSERT INTO `municipios` VALUES (3724,'PONTE SERRADA','SC');
INSERT INTO `municipios` VALUES (3725,'PONTES E LACERDA','MT');
INSERT INTO `municipios` VALUES (3726,'PONTES GESTAL','SP');
INSERT INTO `municipios` VALUES (3727,'PONTO BELO','ES');
INSERT INTO `municipios` VALUES (3728,'PONTO CHIQUE','MG');
INSERT INTO `municipios` VALUES (3729,'PONTO DOS VOLANTES','MG');
INSERT INTO `municipios` VALUES (3730,'PONTO NOVO','BA');
INSERT INTO `municipios` VALUES (3731,'POPULINA','SP');
INSERT INTO `municipios` VALUES (3732,'PORANGA','CE');
INSERT INTO `municipios` VALUES (3733,'PORANGABA','CE');
INSERT INTO `municipios` VALUES (3734,'PORANGABA','SP');
INSERT INTO `municipios` VALUES (3735,'PORANGATU','GO');
INSERT INTO `municipios` VALUES (3736,'PORCIÚNCULA','RJ');
INSERT INTO `municipios` VALUES (3737,'PORECATU','PR');
INSERT INTO `municipios` VALUES (3738,'PORTALEGRE','RN');
INSERT INTO `municipios` VALUES (3739,'PORTÃO','RS');
INSERT INTO `municipios` VALUES (3740,'PORTEIRÃO','GO');
INSERT INTO `municipios` VALUES (3741,'PORTEIRAS','CE');
INSERT INTO `municipios` VALUES (3742,'PORTEIRINHA','MG');
INSERT INTO `municipios` VALUES (3743,'PORTEL','PA');
INSERT INTO `municipios` VALUES (3744,'PORTELÂNDIA','GO');
INSERT INTO `municipios` VALUES (3745,'PORTO','PI');
INSERT INTO `municipios` VALUES (3746,'PORTO ACRE','AC');
INSERT INTO `municipios` VALUES (3747,'PORTO ALEGRE','RS');
INSERT INTO `municipios` VALUES (3748,'PORTO ALEGRE DO NORTE','MT');
INSERT INTO `municipios` VALUES (3749,'PORTO ALEGRE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3750,'PORTO ALEGRE DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (3751,'PORTO AMAZONAS','PR');
INSERT INTO `municipios` VALUES (3752,'PORTO BARREIRO','PR');
INSERT INTO `municipios` VALUES (3753,'PORTO BELO','SC');
INSERT INTO `municipios` VALUES (3754,'PORTO CALVO','AL');
INSERT INTO `municipios` VALUES (3755,'PORTO DA FOLHA','SE');
INSERT INTO `municipios` VALUES (3756,'PORTO DE MOZ','PA');
INSERT INTO `municipios` VALUES (3757,'PORTO DE PEDRAS','AL');
INSERT INTO `municipios` VALUES (3758,'PORTO DO MANGUE','RN');
INSERT INTO `municipios` VALUES (3759,'PORTO DOS GAÚCHOS','MT');
INSERT INTO `municipios` VALUES (3760,'PORTO ESPERIDIÃO','MT');
INSERT INTO `municipios` VALUES (3761,'PORTO ESTRELA','MT');
INSERT INTO `municipios` VALUES (3762,'PORTO FELIZ','SP');
INSERT INTO `municipios` VALUES (3763,'PORTO FERREIRA','SP');
INSERT INTO `municipios` VALUES (3764,'PORTO FIRME','MG');
INSERT INTO `municipios` VALUES (3765,'PORTO FRANCO','MA');
INSERT INTO `municipios` VALUES (3766,'PORTO GRANDE','AP');
INSERT INTO `municipios` VALUES (3767,'PORTO LUCENA','RS');
INSERT INTO `municipios` VALUES (3768,'PORTO MAUA','RS');
INSERT INTO `municipios` VALUES (3769,'PORTO MURTINHO','MS');
INSERT INTO `municipios` VALUES (3770,'PORTO NACIONAL','TO');
INSERT INTO `municipios` VALUES (3771,'PORTO REAL','RJ');
INSERT INTO `municipios` VALUES (3772,'PORTO REAL DO COLÉGIO','AL');
INSERT INTO `municipios` VALUES (3773,'PORTO RICO','PR');
INSERT INTO `municipios` VALUES (3774,'PORTO RICO DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (3775,'PORTO SEGURO','BA');
INSERT INTO `municipios` VALUES (3776,'PORTO UNIÃO','SC');
INSERT INTO `municipios` VALUES (3777,'PORTO VELHO','RO');
INSERT INTO `municipios` VALUES (3778,'PORTO VERA CRUZ','RS');
INSERT INTO `municipios` VALUES (3779,'PORTO VITÓRIA','PR');
INSERT INTO `municipios` VALUES (3780,'PORTO WALTER','AC');
INSERT INTO `municipios` VALUES (3781,'PORTO XAVIER','RS');
INSERT INTO `municipios` VALUES (3782,'POSSE','GO');
INSERT INTO `municipios` VALUES (3783,'POTÉ','MG');
INSERT INTO `municipios` VALUES (3784,'POTENGI','CE');
INSERT INTO `municipios` VALUES (3785,'POTIM','SP');
INSERT INTO `municipios` VALUES (3786,'POTIRÁGUA','BA');
INSERT INTO `municipios` VALUES (3787,'POTIRENDABA','SP');
INSERT INTO `municipios` VALUES (3788,'POTIRETAMA','CE');
INSERT INTO `municipios` VALUES (3789,'POUSO ALEGRE','MG');
INSERT INTO `municipios` VALUES (3790,'POUSO ALTO','MG');
INSERT INTO `municipios` VALUES (3791,'POUSO NOVO','RS');
INSERT INTO `municipios` VALUES (3792,'POUSO REDONDO','SC');
INSERT INTO `municipios` VALUES (3793,'POXOREO','MT');
INSERT INTO `municipios` VALUES (3794,'PRACINHA','SP');
INSERT INTO `municipios` VALUES (3795,'PRACUÚBA','AP');
INSERT INTO `municipios` VALUES (3796,'PRADO','BA');
INSERT INTO `municipios` VALUES (3797,'PRADO FERREIRA','PR');
INSERT INTO `municipios` VALUES (3798,'PRADÓPOLIS','SP');
INSERT INTO `municipios` VALUES (3799,'PRADOS','MG');
INSERT INTO `municipios` VALUES (3800,'PRAIA GRANDE','SC');
INSERT INTO `municipios` VALUES (3801,'PRAIA NORTE','TO');
INSERT INTO `municipios` VALUES (3802,'PRAINHA','PA');
INSERT INTO `municipios` VALUES (3803,'PRANCHITA','PR');
INSERT INTO `municipios` VALUES (3804,'PRATA','MG');
INSERT INTO `municipios` VALUES (3805,'PRATA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3806,'PRATÂNIA','SP');
INSERT INTO `municipios` VALUES (3807,'PRATAPOLIS','MG');
INSERT INTO `municipios` VALUES (3808,'PRATINHA','MG');
INSERT INTO `municipios` VALUES (3809,'PREFEITO DE PINHÃO','SE');
INSERT INTO `municipios` VALUES (3810,'PRESIDENTE ALVES','SP');
INSERT INTO `municipios` VALUES (3811,'PRESIDENTE BERNARDES','MG');
INSERT INTO `municipios` VALUES (3812,'PRESIDENTE BERNARDES','SP');
INSERT INTO `municipios` VALUES (3813,'PRESIDENTE CASTELO BRANCO','PR');
INSERT INTO `municipios` VALUES (3814,'PRESIDENTE DUTRA','BA');
INSERT INTO `municipios` VALUES (3815,'PRESIDENTE EPITACIO','SP');
INSERT INTO `municipios` VALUES (3816,'PRESIDENTE FIGUEIREDO','AM');
INSERT INTO `municipios` VALUES (3817,'PRESIDENTE GETULIO','SC');
INSERT INTO `municipios` VALUES (3818,'PRESIDENTE JANIO QUADROS','BA');
INSERT INTO `municipios` VALUES (3819,'PRESIDENTE JUSCELINO','MA');
INSERT INTO `municipios` VALUES (3820,'PRESIDENTE KENNEDY','ES');
INSERT INTO `municipios` VALUES (3821,'PRESIDENTE KENNEDY','TO');
INSERT INTO `municipios` VALUES (3822,'PRESIDENTE KUBITSCHEK','MG');
INSERT INTO `municipios` VALUES (3823,'PRESIDENTE LUCENA','RS');
INSERT INTO `municipios` VALUES (3824,'PRESIDENTE MEDICI','MA');
INSERT INTO `municipios` VALUES (3825,'PRESIDENTE NEREU','SC');
INSERT INTO `municipios` VALUES (3826,'PRESIDENTE OLEGARIO','MG');
INSERT INTO `municipios` VALUES (3827,'PRESIDENTE PRUDENTE','SP');
INSERT INTO `municipios` VALUES (3828,'PRESIDENTE SARNEY','MA');
INSERT INTO `municipios` VALUES (3829,'PRESIDENTE TANCREDO NEVES','BA');
INSERT INTO `municipios` VALUES (3830,'PRESIDENTE VARGAS','MA');
INSERT INTO `municipios` VALUES (3831,'PRESIDENTE VENCESLAU','SP');
INSERT INTO `municipios` VALUES (3832,'PRIMAVERA','PA');
INSERT INTO `municipios` VALUES (3833,'PRIMAVERA','PE');
INSERT INTO `municipios` VALUES (3834,'PRIMAVERA DE RONDONIA','RO');
INSERT INTO `municipios` VALUES (3835,'PRIMAVERA DO LESTE','MT');
INSERT INTO `municipios` VALUES (3836,'PRIMEIRA CRUZ','MA');
INSERT INTO `municipios` VALUES (3837,'PRIMEIRO DE MAIO','PR');
INSERT INTO `municipios` VALUES (3838,'PRINCESA','SC');
INSERT INTO `municipios` VALUES (3839,'PRINCESA ISABEL','PB');
INSERT INTO `municipios` VALUES (3840,'PROFESSOR JAMIL','GO');
INSERT INTO `municipios` VALUES (3841,'PROGRESSO','RS');
INSERT INTO `municipios` VALUES (3842,'PROMISSÃO','SP');
INSERT INTO `municipios` VALUES (3843,'PROPRIA','SE');
INSERT INTO `municipios` VALUES (3844,'PROTÁSIO ALVES','RS');
INSERT INTO `municipios` VALUES (3845,'PRUDENTE DE MORAIS','MG');
INSERT INTO `municipios` VALUES (3846,'PRUDENTÓPOLIS','PR');
INSERT INTO `municipios` VALUES (3847,'PUGMIL','TO');
INSERT INTO `municipios` VALUES (3848,'PUREZA','RN');
INSERT INTO `municipios` VALUES (3849,'PUTINGA','RS');
INSERT INTO `municipios` VALUES (3850,'PUXINANA','PB');
INSERT INTO `municipios` VALUES (3851,'QUADRA','SP');
INSERT INTO `municipios` VALUES (3852,'QUARAI','RS');
INSERT INTO `municipios` VALUES (3853,'QUARTEL GERAL','MG');
INSERT INTO `municipios` VALUES (3854,'QUARTO CENTENARIO','PR');
INSERT INTO `municipios` VALUES (3855,'QUATA','SP');
INSERT INTO `municipios` VALUES (3856,'QUATIGUA','PR');
INSERT INTO `municipios` VALUES (3857,'QUATIPURU','PA');
INSERT INTO `municipios` VALUES (3858,'QUATIS','RJ');
INSERT INTO `municipios` VALUES (3859,'QUATRO BARRAS','PR');
INSERT INTO `municipios` VALUES (3860,'QUATRO PONTES','PR');
INSERT INTO `municipios` VALUES (3861,'QUEBRANGULO','AL');
INSERT INTO `municipios` VALUES (3862,'QUEDAS DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (3863,'QUEIMADA NOVA','PI');
INSERT INTO `municipios` VALUES (3864,'QUEIMADAS','BA');
INSERT INTO `municipios` VALUES (3865,'QUEIMADOS','RJ');
INSERT INTO `municipios` VALUES (3866,'QUEIROZ','SP');
INSERT INTO `municipios` VALUES (3867,'QUELUZ','SP');
INSERT INTO `municipios` VALUES (3868,'QUELUZITO','MG');
INSERT INTO `municipios` VALUES (3869,'QUERÊNCIA','MT');
INSERT INTO `municipios` VALUES (3870,'QUERÊNCIA DO NORTE','PR');
INSERT INTO `municipios` VALUES (3871,'QUEVEDOS','RS');
INSERT INTO `municipios` VALUES (3872,'QUIJINGUE','BA');
INSERT INTO `municipios` VALUES (3873,'QUILOMBO','SC');
INSERT INTO `municipios` VALUES (3874,'QUINTA DO SOL','PR');
INSERT INTO `municipios` VALUES (3875,'QUINTANA','SP');
INSERT INTO `municipios` VALUES (3876,'QUINZE DE NOVEMBRO','RS');
INSERT INTO `municipios` VALUES (3877,'QUIPAPA','PE');
INSERT INTO `municipios` VALUES (3878,'QUIRINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (3879,'QUISSAMA','RJ');
INSERT INTO `municipios` VALUES (3880,'QUITANDINHA','PR');
INSERT INTO `municipios` VALUES (3881,'QUITERIANÓPOLIS','CE');
INSERT INTO `municipios` VALUES (3882,'QUIXABA','PB');
INSERT INTO `municipios` VALUES (3883,'QUIXABÁ','PE');
INSERT INTO `municipios` VALUES (3884,'QUIXABEIRA','BA');
INSERT INTO `municipios` VALUES (3885,'QUIXADA','CE');
INSERT INTO `municipios` VALUES (3886,'QUIXELO','CE');
INSERT INTO `municipios` VALUES (3887,'QUIXERAMOBIM','CE');
INSERT INTO `municipios` VALUES (3888,'QUIXERÉ','CE');
INSERT INTO `municipios` VALUES (3889,'RAFAEL FERNANDES','RN');
INSERT INTO `municipios` VALUES (3890,'RAFAEL GODEIRO','RN');
INSERT INTO `municipios` VALUES (3891,'RAFAEL JAMBEIRO','BA');
INSERT INTO `municipios` VALUES (3892,'RAFARD','SP');
INSERT INTO `municipios` VALUES (3893,'RAMILÂNDIA','PR');
INSERT INTO `municipios` VALUES (3894,'RANCHARIA','SP');
INSERT INTO `municipios` VALUES (3895,'RANCHO ALEGRE','PR');
INSERT INTO `municipios` VALUES (3896,'RANCHO ALEGRE DO OESTE','PR');
INSERT INTO `municipios` VALUES (3897,'RANCHO QUEIMADO','SC');
INSERT INTO `municipios` VALUES (3898,'RAPOSA','MA');
INSERT INTO `municipios` VALUES (3899,'RAPOSOS','MG');
INSERT INTO `municipios` VALUES (3900,'RAUL SOARES','MG');
INSERT INTO `municipios` VALUES (3901,'REALEZA','PR');
INSERT INTO `municipios` VALUES (3902,'REBOUCAS','PR');
INSERT INTO `municipios` VALUES (3903,'RECIFE','PE');
INSERT INTO `municipios` VALUES (3904,'RECREIO','MG');
INSERT INTO `municipios` VALUES (3905,'RECURSOLÂNDIA','TO');
INSERT INTO `municipios` VALUES (3906,'REDENCÃO','CE');
INSERT INTO `municipios` VALUES (3907,'REDENÇÃO','PA');
INSERT INTO `municipios` VALUES (3908,'REDENCÃO DA SERRA','SP');
INSERT INTO `municipios` VALUES (3909,'REDENCÃO DO GURGUELIA','PI');
INSERT INTO `municipios` VALUES (3910,'REDENTORA','RS');
INSERT INTO `municipios` VALUES (3911,'REGENERACÃO','PI');
INSERT INTO `municipios` VALUES (3912,'REGENTE FEIJO','SP');
INSERT INTO `municipios` VALUES (3913,'REGINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (3914,'REGISTRO','SP');
INSERT INTO `municipios` VALUES (3915,'RELVADO','RS');
INSERT INTO `municipios` VALUES (3916,'REMANSO','BA');
INSERT INTO `municipios` VALUES (3917,'REMÍGIO','PB');
INSERT INTO `municipios` VALUES (3918,'RENASCENÇA','PR');
INSERT INTO `municipios` VALUES (3919,'RERIUTABA','CE');
INSERT INTO `municipios` VALUES (3920,'RESENDE','RJ');
INSERT INTO `municipios` VALUES (3921,'RESERVA','PR');
INSERT INTO `municipios` VALUES (3922,'RESERVA DO CABACAL','MT');
INSERT INTO `municipios` VALUES (3923,'RESPLENDOR','MG');
INSERT INTO `municipios` VALUES (3924,'RESSAQUINHA','MG');
INSERT INTO `municipios` VALUES (3925,'RESTINGA','SP');
INSERT INTO `municipios` VALUES (3926,'RESTINGA SECA','RS');
INSERT INTO `municipios` VALUES (3927,'RETIROLÂNDIA','BA');
INSERT INTO `municipios` VALUES (3928,'REZENDE COSTA','MG');
INSERT INTO `municipios` VALUES (3929,'RIACHAO','MA');
INSERT INTO `municipios` VALUES (3930,'RIACHAO DAS NEVES','BA');
INSERT INTO `municipios` VALUES (3931,'RIACHÃO DO DANTAS','SE');
INSERT INTO `municipios` VALUES (3932,'RIACHAO DO JAÇUIPE','BA');
INSERT INTO `municipios` VALUES (3933,'RIACHAO DO POÇO','PB');
INSERT INTO `municipios` VALUES (3934,'RIACHINHO','MG');
INSERT INTO `municipios` VALUES (3935,'RIACHINHO','TO');
INSERT INTO `municipios` VALUES (3936,'RIACHO DA CRUZ','RN');
INSERT INTO `municipios` VALUES (3937,'RIACHO DAS ALMAS','PE');
INSERT INTO `municipios` VALUES (3938,'RIACHO DE SANTANA','BA');
INSERT INTO `municipios` VALUES (3939,'RIACHO DE SANTO ANTÔNIO','PB');
INSERT INTO `municipios` VALUES (3940,'RIACHO DOS CAVALOS','PB');
INSERT INTO `municipios` VALUES (3941,'RIACHO DOS MACHADOS','MG');
INSERT INTO `municipios` VALUES (3942,'RIACHO FRIO','PI');
INSERT INTO `municipios` VALUES (3943,'RIACHUELO','RN');
INSERT INTO `municipios` VALUES (3944,'RIACHUELO','SE');
INSERT INTO `municipios` VALUES (3945,'RIALMA','GO');
INSERT INTO `municipios` VALUES (3946,'RIANÁPOLIS','GO');
INSERT INTO `municipios` VALUES (3947,'RIBAMAR FIQUENE','MA');
INSERT INTO `municipios` VALUES (3948,'RIBAS DO RIO PARDO','MS');
INSERT INTO `municipios` VALUES (3949,'RIBEIRA','SP');
INSERT INTO `municipios` VALUES (3950,'RIBEIRA DO AMPARO','BA');
INSERT INTO `municipios` VALUES (3951,'RIBEIRA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (3952,'RIBEIRA DO POMBAL','BA');
INSERT INTO `municipios` VALUES (3953,'RIBEIRÃO','PE');
INSERT INTO `municipios` VALUES (3954,'RIBEIRÃO BONITO','SP');
INSERT INTO `municipios` VALUES (3955,'RIBEIRÃO BRANCO','SP');
INSERT INTO `municipios` VALUES (3956,'RIBEIRÃO CASCALHEIRA','MT');
INSERT INTO `municipios` VALUES (3957,'RIBEIRÃO CLARO','PR');
INSERT INTO `municipios` VALUES (3958,'RIBEIRÃO CORRENTE','SP');
INSERT INTO `municipios` VALUES (3959,'RIBEIRÃO DAS NEVES','MG');
INSERT INTO `municipios` VALUES (3960,'RIBEIRÃO DO LARGO','BA');
INSERT INTO `municipios` VALUES (3961,'RIBEIRÃO DO PINHAL','PR');
INSERT INTO `municipios` VALUES (3962,'RIBEIRÃO DO SUL','SP');
INSERT INTO `municipios` VALUES (3963,'RIBEIRÃO DOS ÍNDIOS','SP');
INSERT INTO `municipios` VALUES (3964,'RIBEIRÃO GRANDE','SP');
INSERT INTO `municipios` VALUES (3965,'RIBEIRÃO PIRES','SP');
INSERT INTO `municipios` VALUES (3966,'RIBEIRÃO PRETO','SP');
INSERT INTO `municipios` VALUES (3967,'RIBEIRÃO VERMELHO','MG');
INSERT INTO `municipios` VALUES (3968,'RIBEIRÃOZINHO','MT');
INSERT INTO `municipios` VALUES (3969,'RIBEIRO GONÇALVES','PI');
INSERT INTO `municipios` VALUES (3970,'RIBEIRÓPOLIS','SE');
INSERT INTO `municipios` VALUES (3971,'RIFAINA','SP');
INSERT INTO `municipios` VALUES (3972,'RINCÃO','SP');
INSERT INTO `municipios` VALUES (3973,'RINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (3974,'RIO ACIMA','MG');
INSERT INTO `municipios` VALUES (3975,'RIO AZUL','PR');
INSERT INTO `municipios` VALUES (3976,'RIO BANANAL','ES');
INSERT INTO `municipios` VALUES (3977,'RIO BOM','PR');
INSERT INTO `municipios` VALUES (3978,'RIO BONITO','RJ');
INSERT INTO `municipios` VALUES (3979,'RIO BONITO DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (3980,'RIO BRANCO','AC');
INSERT INTO `municipios` VALUES (3981,'RIO BRANCO DO IVAÍ','PR');
INSERT INTO `municipios` VALUES (3982,'RIO BRANCO DO SUL','PR');
INSERT INTO `municipios` VALUES (3983,'RIO BRILHANTE','MS');
INSERT INTO `municipios` VALUES (3984,'RIO CASCA','MG');
INSERT INTO `municipios` VALUES (3985,'RIO CLARO','RJ');
INSERT INTO `municipios` VALUES (3986,'RIO CRESPO','RO');
INSERT INTO `municipios` VALUES (3987,'RIO DA CONCEIÇÃO','TO');
INSERT INTO `municipios` VALUES (3988,'RIO DAS ANTAS','SC');
INSERT INTO `municipios` VALUES (3989,'RIO DAS FLORES','RJ');
INSERT INTO `municipios` VALUES (3990,'RIO DAS OSTRAS','RJ');
INSERT INTO `municipios` VALUES (3991,'RIO DAS PEDRAS','SP');
INSERT INTO `municipios` VALUES (3992,'RIO DE CONTAS','BA');
INSERT INTO `municipios` VALUES (3993,'RIO DE JANEIRO','RJ');
INSERT INTO `municipios` VALUES (3994,'RIO DO ANTÔNIO','BA');
INSERT INTO `municipios` VALUES (3995,'RIO DO CAMPO','SC');
INSERT INTO `municipios` VALUES (3996,'RIO DO FOGO','RN');
INSERT INTO `municipios` VALUES (3997,'RIO DO OESTE','SC');
INSERT INTO `municipios` VALUES (3998,'RIO DO PIRES','BA');
INSERT INTO `municipios` VALUES (3999,'RIO DO PRADO','MG');
INSERT INTO `municipios` VALUES (4000,'RIO DO SUL','SC');
INSERT INTO `municipios` VALUES (4001,'RIO DOCE','MG');
INSERT INTO `municipios` VALUES (4002,'RIO DOS BOIS','TO');
INSERT INTO `municipios` VALUES (4003,'RIO DOS CEDROS','SC');
INSERT INTO `municipios` VALUES (4004,'RIO DOS ÍNDIOS','RS');
INSERT INTO `municipios` VALUES (4005,'RIO ESPERA','MG');
INSERT INTO `municipios` VALUES (4006,'RIO FORMOSO','PE');
INSERT INTO `municipios` VALUES (4007,'RIO FORTUNA','SC');
INSERT INTO `municipios` VALUES (4008,'RIO GRANDE','RS');
INSERT INTO `municipios` VALUES (4009,'RIO GRANDE DA SERRA','SP');
INSERT INTO `municipios` VALUES (4010,'RIO GRANDE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4011,'RIO LARGO','AL');
INSERT INTO `municipios` VALUES (4012,'RIO MANSO','MG');
INSERT INTO `municipios` VALUES (4013,'RIO MARIA','PA');
INSERT INTO `municipios` VALUES (4014,'RIO NEGRINHO','SC');
INSERT INTO `municipios` VALUES (4015,'RIO NEGRO','MS');
INSERT INTO `municipios` VALUES (4016,'RIO NEGRO','PR');
INSERT INTO `municipios` VALUES (4017,'RIO NOVO','MG');
INSERT INTO `municipios` VALUES (4018,'RIO NOVO DO SUL','ES');
INSERT INTO `municipios` VALUES (4019,'RIO PARANAÍBA','MG');
INSERT INTO `municipios` VALUES (4020,'RIO PARDO','RS');
INSERT INTO `municipios` VALUES (4021,'RIO PARDO DE MINAS','MG');
INSERT INTO `municipios` VALUES (4022,'RIO PIRACICABA','MG');
INSERT INTO `municipios` VALUES (4023,'RIO POMBA','MG');
INSERT INTO `municipios` VALUES (4024,'RIO PRETO','MG');
INSERT INTO `municipios` VALUES (4025,'RIO PRETO DA EVA','AM');
INSERT INTO `municipios` VALUES (4026,'RIO QUENTE','GO');
INSERT INTO `municipios` VALUES (4027,'RIO REAL','BA');
INSERT INTO `municipios` VALUES (4028,'RIO RUFINO','SC');
INSERT INTO `municipios` VALUES (4029,'RIO SONO','TO');
INSERT INTO `municipios` VALUES (4030,'RIO TINTO','PB');
INSERT INTO `municipios` VALUES (4031,'RIO VERDE','GO');
INSERT INTO `municipios` VALUES (4032,'RIO VERDE DE MATO GROSSO','MS');
INSERT INTO `municipios` VALUES (4033,'RIO VERMELHO','MG');
INSERT INTO `municipios` VALUES (4034,'RIOLÂNDIA','SP');
INSERT INTO `municipios` VALUES (4035,'RIOZINHO','RS');
INSERT INTO `municipios` VALUES (4036,'RIQUEZA','SC');
INSERT INTO `municipios` VALUES (4037,'RITAPOLIS','MG');
INSERT INTO `municipios` VALUES (4038,'RIVERSUL','SP');
INSERT INTO `municipios` VALUES (4039,'ROCA SALES','RS');
INSERT INTO `municipios` VALUES (4040,'ROCHEDO','MS');
INSERT INTO `municipios` VALUES (4041,'ROCHEDO DE MINAS','MG');
INSERT INTO `municipios` VALUES (4042,'RODEIO','SC');
INSERT INTO `municipios` VALUES (4043,'RODEIO BONITO','RS');
INSERT INTO `municipios` VALUES (4044,'RODEIRO','MG');
INSERT INTO `municipios` VALUES (4045,'RODELAS','BA');
INSERT INTO `municipios` VALUES (4046,'RODOLFO FERNANDES','RN');
INSERT INTO `municipios` VALUES (4047,'RODRIGUES ALVES','AC');
INSERT INTO `municipios` VALUES (4048,'ROLÂNDIA','PR');
INSERT INTO `municipios` VALUES (4049,'ROLANTE','RS');
INSERT INTO `municipios` VALUES (4050,'ROLIM DE MOURA','RO');
INSERT INTO `municipios` VALUES (4051,'ROMARIA','MG');
INSERT INTO `municipios` VALUES (4052,'ROMELÂNDIA','SC');
INSERT INTO `municipios` VALUES (4053,'RONCADOR','PR');
INSERT INTO `municipios` VALUES (4054,'RONDA ALTA','RS');
INSERT INTO `municipios` VALUES (4055,'RONDINHA','RS');
INSERT INTO `municipios` VALUES (4056,'RONDOLÂNDIA','MT');
INSERT INTO `municipios` VALUES (4057,'RONDON','PR');
INSERT INTO `municipios` VALUES (4058,'RONDON DO PARA','PA');
INSERT INTO `municipios` VALUES (4059,'RONDONÓPOLIS','MT');
INSERT INTO `municipios` VALUES (4060,'ROQUE GONZALES','RS');
INSERT INTO `municipios` VALUES (4061,'RORAINÓPOLIS','RR');
INSERT INTO `municipios` VALUES (4062,'ROSANA','SP');
INSERT INTO `municipios` VALUES (4063,'ROSÁRIO','MA');
INSERT INTO `municipios` VALUES (4064,'ROSARIO DA LIMEIRA','MG');
INSERT INTO `municipios` VALUES (4065,'ROSÁRIO DO CATETE','SE');
INSERT INTO `municipios` VALUES (4066,'ROSÁRIO DO IVAÍ','PR');
INSERT INTO `municipios` VALUES (4067,'ROSARIO DO SUL','RS');
INSERT INTO `municipios` VALUES (4068,'ROSARIO OESTE','MT');
INSERT INTO `municipios` VALUES (4069,'ROSEIRA','SP');
INSERT INTO `municipios` VALUES (4070,'ROTEIRO','AL');
INSERT INTO `municipios` VALUES (4071,'RUBELITA','MG');
INSERT INTO `municipios` VALUES (4072,'RUBIACEA','SP');
INSERT INTO `municipios` VALUES (4073,'RUBIATABA','GO');
INSERT INTO `municipios` VALUES (4074,'RUBIM','MG');
INSERT INTO `municipios` VALUES (4075,'RUBINÉIA','SP');
INSERT INTO `municipios` VALUES (4076,'RURÓPOLIS','PA');
INSERT INTO `municipios` VALUES (4077,'RUSSAS','CE');
INSERT INTO `municipios` VALUES (4078,'RUY BARBOSA','BA');
INSERT INTO `municipios` VALUES (4079,'SÃO DOMINGOS DE POMBAL','PB');
INSERT INTO `municipios` VALUES (4080,'SÃO SEBASTIÃO DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4081,'SABARA','MG');
INSERT INTO `municipios` VALUES (4082,'SABAUDIA','PR');
INSERT INTO `municipios` VALUES (4083,'SABINO','SP');
INSERT INTO `municipios` VALUES (4084,'SABINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (4085,'SABOEIRO','CE');
INSERT INTO `municipios` VALUES (4086,'SACRAMENTO','MG');
INSERT INTO `municipios` VALUES (4087,'SAGRADA FAMILIA','RS');
INSERT INTO `municipios` VALUES (4088,'SAGRES','SP');
INSERT INTO `municipios` VALUES (4089,'SAIRE','PE');
INSERT INTO `municipios` VALUES (4090,'SALDANHA MARINHO','RS');
INSERT INTO `municipios` VALUES (4091,'SALES','SP');
INSERT INTO `municipios` VALUES (4092,'SALES OLIVEIRA','SP');
INSERT INTO `municipios` VALUES (4093,'SALESÓPOLIS','SP');
INSERT INTO `municipios` VALUES (4094,'SALETE','SC');
INSERT INTO `municipios` VALUES (4095,'SALGADINHO','PB');
INSERT INTO `municipios` VALUES (4096,'SALGADO','SE');
INSERT INTO `municipios` VALUES (4097,'SALGADO DE SÃO FELIX','PB');
INSERT INTO `municipios` VALUES (4098,'SALGADO FILHO','PR');
INSERT INTO `municipios` VALUES (4099,'SALGUEIRO','PE');
INSERT INTO `municipios` VALUES (4100,'SALINAS','MG');
INSERT INTO `municipios` VALUES (4101,'SALINAS DA MARGARIDA','BA');
INSERT INTO `municipios` VALUES (4102,'SALINÓPOLIS','PA');
INSERT INTO `municipios` VALUES (4103,'SALITRE','CE');
INSERT INTO `municipios` VALUES (4104,'SALMOURÃO','SP');
INSERT INTO `municipios` VALUES (4105,'SALOÁ','PE');
INSERT INTO `municipios` VALUES (4106,'SALTINHO','SC');
INSERT INTO `municipios` VALUES (4107,'SALTO','SP');
INSERT INTO `municipios` VALUES (4108,'SALTO DA DIVISA','MG');
INSERT INTO `municipios` VALUES (4109,'SALTO DE PIRAPORA','SP');
INSERT INTO `municipios` VALUES (4110,'SALTO DO CÉU','MT');
INSERT INTO `municipios` VALUES (4111,'SALTO DO ITARARE','PR');
INSERT INTO `municipios` VALUES (4112,'SALTO DO JACUÍ','RS');
INSERT INTO `municipios` VALUES (4113,'SALTO DO LONTRA','PR');
INSERT INTO `municipios` VALUES (4114,'SALTO DO VELOSO','SC');
INSERT INTO `municipios` VALUES (4115,'SALTO GRANDE','SP');
INSERT INTO `municipios` VALUES (4116,'SALVADOR','BA');
INSERT INTO `municipios` VALUES (4117,'SALVADOR DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (4118,'SALVADOR DO SUL','RS');
INSERT INTO `municipios` VALUES (4119,'SALVATERRA','PA');
INSERT INTO `municipios` VALUES (4120,'SAMBAIBA','MA');
INSERT INTO `municipios` VALUES (4121,'SAMPAIO','TO');
INSERT INTO `municipios` VALUES (4122,'SANANDUVA','RS');
INSERT INTO `municipios` VALUES (4123,'SANCLERLÂNDIA','GO');
INSERT INTO `municipios` VALUES (4124,'SANDOLÂNDIA','TO');
INSERT INTO `municipios` VALUES (4125,'SANDOVALINA','SP');
INSERT INTO `municipios` VALUES (4126,'SANGAO','SC');
INSERT INTO `municipios` VALUES (4127,'SANHARO','PE');
INSERT INTO `municipios` VALUES (4128,'SANTA CRUZ DE SALINAS','MG');
INSERT INTO `municipios` VALUES (4129,'SANTA ADELIA','SP');
INSERT INTO `municipios` VALUES (4130,'SANTA ALBERTINA','SP');
INSERT INTO `municipios` VALUES (4131,'SANTA AMELIA','PR');
INSERT INTO `municipios` VALUES (4132,'SANTA BÁRBARA','BA');
INSERT INTO `municipios` VALUES (4133,'SANTA BÁRBARA','MG');
INSERT INTO `municipios` VALUES (4134,'SANTA BÁRBARA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4135,'SANTA BÁRBARA DO LESTE','MG');
INSERT INTO `municipios` VALUES (4136,'SANTA BÁRBARA DO M. VERDE','MG');
INSERT INTO `municipios` VALUES (4137,'SANTA BÁRBARA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (4138,'SANTA BÁRBARA DO SUL','RS');
INSERT INTO `municipios` VALUES (4139,'SANTA BÁRBARA DO TUGURIO','MG');
INSERT INTO `municipios` VALUES (4140,'SANTA BÁRBARA DO OESTE','SP');
INSERT INTO `municipios` VALUES (4141,'SANTA BRANCA','SP');
INSERT INTO `municipios` VALUES (4142,'SANTA BRIGIDA','BA');
INSERT INTO `municipios` VALUES (4143,'SANTA CARMEM','MT');
INSERT INTO `municipios` VALUES (4144,'SANTA CECILIA','SC');
INSERT INTO `municipios` VALUES (4145,'SANTA CECILIA DE UMBUZEIRO','PB');
INSERT INTO `municipios` VALUES (4146,'SANTA CECILIA DO PAVAO','PR');
INSERT INTO `municipios` VALUES (4147,'SANTA CLARA DO SUL','RS');
INSERT INTO `municipios` VALUES (4148,'SANTA CLARA DO OESTE','SP');
INSERT INTO `municipios` VALUES (4149,'SANTA CRISTO','RS');
INSERT INTO `municipios` VALUES (4150,'SANTA CRUZ','PB');
INSERT INTO `municipios` VALUES (4151,'SANTA CRUZ DO ESCALVADO','MG');
INSERT INTO `municipios` VALUES (4152,'SANTA CRUZ DA BAIXA VERDE','PE');
INSERT INTO `municipios` VALUES (4153,'SANTA CRUZ DA CABRALIA','BA');
INSERT INTO `municipios` VALUES (4154,'SANTA CRUZ DA CONCEIÇÃO','SP');
INSERT INTO `municipios` VALUES (4155,'SANTA CRUZ DA ESPERANÇA','SP');
INSERT INTO `municipios` VALUES (4156,'SANTA CRUZ DA VITÓRIA','BA');
INSERT INTO `municipios` VALUES (4157,'SANTA CRUZ DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4158,'SANTA CRUZ DO ARARI','PA');
INSERT INTO `municipios` VALUES (4159,'SANTA CRUZ DO CAPIBARIBE','PE');
INSERT INTO `municipios` VALUES (4160,'SANTA CRUZ DO MONTE CASTELO','PR');
INSERT INTO `municipios` VALUES (4161,'SANTA CRUZ DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4162,'SANTA CRUZ DO SUL','BA');
INSERT INTO `municipios` VALUES (4163,'SANTA CRUZ DOS MILAGRES','PI');
INSERT INTO `municipios` VALUES (4164,'SANTA CRUZ DAS PALMEIRAS','SP');
INSERT INTO `municipios` VALUES (4165,'SANTA CRUZ DO RIO PARDO','SP');
INSERT INTO `municipios` VALUES (4166,'SANTA EFIGENIA DE MINAS','MG');
INSERT INTO `municipios` VALUES (4167,'SANTA ERNESTINA','SP');
INSERT INTO `municipios` VALUES (4168,'SANTA FÉ','PR');
INSERT INTO `municipios` VALUES (4169,'SANTA FÉ DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4170,'SANTA FÉ DE MINAS','MG');
INSERT INTO `municipios` VALUES (4171,'SANTA FÉ DO ARÁGUAIA','TO');
INSERT INTO `municipios` VALUES (4172,'SANTA FÉ DO SUL','SP');
INSERT INTO `municipios` VALUES (4173,'SANTA FILOMENA','PE');
INSERT INTO `municipios` VALUES (4174,'SANTA FILOMENA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4175,'SANTA GERTRUDES','SP');
INSERT INTO `municipios` VALUES (4176,'SANTA HELENA','MA');
INSERT INTO `municipios` VALUES (4177,'SANTA HELENA','PB');
INSERT INTO `municipios` VALUES (4178,'SANTA HELENA','PR');
INSERT INTO `municipios` VALUES (4179,'SANTA HELENA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4180,'SANTA INES','BA');
INSERT INTO `municipios` VALUES (4181,'SANTA ISABEL','GO');
INSERT INTO `municipios` VALUES (4182,'SANTA ISABEL DO RIO NEGRO','AM');
INSERT INTO `municipios` VALUES (4183,'SANTA ISABEL DO IVAÍ','PR');
INSERT INTO `municipios` VALUES (4184,'SANTA IZABEL DO OESTE','PR');
INSERT INTO `municipios` VALUES (4185,'SANTA ISABEL DO PARÁ','PA');
INSERT INTO `municipios` VALUES (4186,'SANTA JULIANA','MG');
INSERT INTO `municipios` VALUES (4187,'SANTA LEOPOLDINA','ES');
INSERT INTO `municipios` VALUES (4188,'SANTA LUCIA','PR');
INSERT INTO `municipios` VALUES (4189,'SANTA LUCIA','SP');
INSERT INTO `municipios` VALUES (4190,'SANTA LUZ','BA');
INSERT INTO `municipios` VALUES (4191,'SANTA LUZIA','BA');
INSERT INTO `municipios` VALUES (4192,'SANTA LUZIA','MA');
INSERT INTO `municipios` VALUES (4193,'SANTA LUZIA DO ITANHY','SE');
INSERT INTO `municipios` VALUES (4194,'SANTA LUZIA DO NORTE','AL');
INSERT INTO `municipios` VALUES (4195,'SANTA LUZIA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (4196,'SANTA LUZIA DO OESTE','RO');
INSERT INTO `municipios` VALUES (4197,'SANTA MARGARIDA','MG');
INSERT INTO `municipios` VALUES (4198,'SANTA MARIA','RN');
INSERT INTO `municipios` VALUES (4199,'SANTA MARIA DA BOA VISTA','PE');
INSERT INTO `municipios` VALUES (4200,'SANTA MARIA DA SERRA','SP');
INSERT INTO `municipios` VALUES (4201,'SANTA MARIA DA VITÓRIA','BA');
INSERT INTO `municipios` VALUES (4202,'SANTA MARIA DAS BARREIRAS','PA');
INSERT INTO `municipios` VALUES (4203,'SANTA MARIA DE ITABIRA','MG');
INSERT INTO `municipios` VALUES (4204,'SANTA MARIA DE JETIBÁ','ES');
INSERT INTO `municipios` VALUES (4205,'SANTA MARIA DO CAMBUCA','PE');
INSERT INTO `municipios` VALUES (4206,'SANTA MARIA DO HERVAL','RS');
INSERT INTO `municipios` VALUES (4207,'SANTA MARIA DO OESTE','PR');
INSERT INTO `municipios` VALUES (4208,'SANTA MARIA DO PARÁ','PA');
INSERT INTO `municipios` VALUES (4209,'SANTA MARIA DO SALTO','MG');
INSERT INTO `municipios` VALUES (4210,'SANTA MARIA DO SUAÇUÍ','MG');
INSERT INTO `municipios` VALUES (4211,'SANTA MARIA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4212,'SANTA MARIA MADALENA','RJ');
INSERT INTO `municipios` VALUES (4213,'SANTA MARIANA','PR');
INSERT INTO `municipios` VALUES (4214,'SANTA MERCEDES','SP');
INSERT INTO `municipios` VALUES (4215,'SANTA MÔNICA','PR');
INSERT INTO `municipios` VALUES (4216,'SANTA QUITERIA','CE');
INSERT INTO `municipios` VALUES (4217,'SANTA QUITERIA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4218,'SANTA RITA','MA');
INSERT INTO `municipios` VALUES (4219,'SANTA RITA DE CALDAS','MG');
INSERT INTO `municipios` VALUES (4220,'SANTA RITA DE CASSIA','BA');
INSERT INTO `municipios` VALUES (4221,'SANTA RITA DE JACUTINGA','MG');
INSERT INTO `municipios` VALUES (4222,'SANTA RITA DE MINAS','MG');
INSERT INTO `municipios` VALUES (4223,'SANTA RITA DO ARÁGUAIA','GO');
INSERT INTO `municipios` VALUES (4224,'SANTA RITA DO IBITIPOCA','MG');
INSERT INTO `municipios` VALUES (4225,'SANTA RITA DO ITUETO','MG');
INSERT INTO `municipios` VALUES (4226,'SANTA RITA DO NOVO DESTINO','GO');
INSERT INTO `municipios` VALUES (4227,'SANTA RITA DO PASSA QUATRO','SP');
INSERT INTO `municipios` VALUES (4228,'SANTA RITA DO PRADO','MS');
INSERT INTO `municipios` VALUES (4229,'SANTA RITA DO SAPUCAI','MG');
INSERT INTO `municipios` VALUES (4230,'SANTA RITA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4231,'SANTA RITA DO OESTE','SP');
INSERT INTO `municipios` VALUES (4232,'SANTA ROSA','AC');
INSERT INTO `municipios` VALUES (4233,'SANTA ROSA','RS');
INSERT INTO `municipios` VALUES (4234,'SANTA ROSA DA SERRA','MG');
INSERT INTO `municipios` VALUES (4235,'SANTA ROSA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4236,'SANTA ROSA DE LIMA','SC');
INSERT INTO `municipios` VALUES (4237,'SANTA ROSA DE LIMA','SE');
INSERT INTO `municipios` VALUES (4238,'SANTA ROSA DO VITERBO','SP');
INSERT INTO `municipios` VALUES (4239,'SANTA ROSA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4240,'SANTA ROSA DO SUL','SC');
INSERT INTO `municipios` VALUES (4241,'SANTA ROSA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4242,'SANTA SALETE','SP');
INSERT INTO `municipios` VALUES (4243,'SANTA TERESA','ES');
INSERT INTO `municipios` VALUES (4244,'SANTA TEREZA','RS');
INSERT INTO `municipios` VALUES (4245,'SANTA TEREZA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4246,'SANTA TEREZA DO OESTE','PR');
INSERT INTO `municipios` VALUES (4247,'SANTA TEREZA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4248,'SANTA TEREZINHA','BA');
INSERT INTO `municipios` VALUES (4249,'SANTA TEREZINHA','PB');
INSERT INTO `municipios` VALUES (4250,'SANTA TEREZINHA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4251,'SANTA TEREZINHA DE ITAIPU','PR');
INSERT INTO `municipios` VALUES (4252,'SANTA TEREZINHA DO PROGRESSO','SC');
INSERT INTO `municipios` VALUES (4253,'SANTA TEREZINHA DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4254,'SANTA VITÓRIA','MG');
INSERT INTO `municipios` VALUES (4255,'SANTA VITÓRIA DO PALMAR','RS');
INSERT INTO `municipios` VALUES (4256,'SANTANA','AP');
INSERT INTO `municipios` VALUES (4257,'SANTANA DA BOA VISTA','RS');
INSERT INTO `municipios` VALUES (4258,'SANTANA DA PONTE PENSA','SP');
INSERT INTO `municipios` VALUES (4259,'SANTANA DA VARGEM','MG');
INSERT INTO `municipios` VALUES (4260,'SANTANA DE CATÁGUASES','MG');
INSERT INTO `municipios` VALUES (4261,'SANTANA DE PIRAPAMA','MG');
INSERT INTO `municipios` VALUES (4262,'SANTANA DO ACARAÚ','CE');
INSERT INTO `municipios` VALUES (4263,'SANTANA DO ARAGUAIA','PA');
INSERT INTO `municipios` VALUES (4264,'SANTANA DO CARIRI','CE');
INSERT INTO `municipios` VALUES (4265,'SANTANA DO DESERTO','MG');
INSERT INTO `municipios` VALUES (4266,'SANTANA DO GARAMBEU','MG');
INSERT INTO `municipios` VALUES (4267,'SANTANA DO IPANEMA','AL');
INSERT INTO `municipios` VALUES (4268,'SANTANA DO ITARARÉ','PR');
INSERT INTO `municipios` VALUES (4269,'SANTANA DO JACARÉ','MG');
INSERT INTO `municipios` VALUES (4270,'SANTANA DO LIVRAMENTO','RS');
INSERT INTO `municipios` VALUES (4271,'SANTANA DO MANHUAÇU','MG');
INSERT INTO `municipios` VALUES (4272,'SANTANA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4273,'SANTANA DO MATOS','RN');
INSERT INTO `municipios` VALUES (4274,'SANTANA DO MUNDAU','AL');
INSERT INTO `municipios` VALUES (4275,'SANTANA DO PARAÍSO','MG');
INSERT INTO `municipios` VALUES (4276,'SANTANA DE PARNAÍBA','SP');
INSERT INTO `municipios` VALUES (4277,'SANTANA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4278,'SANTANA DO PIRAPAMA','MG');
INSERT INTO `municipios` VALUES (4279,'SANTANA DO RIACHO','MG');
INSERT INTO `municipios` VALUES (4280,'SANTANA DO SERIDO','RN');
INSERT INTO `municipios` VALUES (4281,'SANTANA DOS GARROTES','PB');
INSERT INTO `municipios` VALUES (4282,'SANTANA DOS MONTES','MG');
INSERT INTO `municipios` VALUES (4283,'SANTANA DO SÃO FRANCISCO','SE');
INSERT INTO `municipios` VALUES (4284,'SANTANÁPOLIS','BA');
INSERT INTO `municipios` VALUES (4285,'SANTAREM','PA');
INSERT INTO `municipios` VALUES (4286,'SANTARÉM NOVO','PA');
INSERT INTO `municipios` VALUES (4287,'SANTIAGO','RS');
INSERT INTO `municipios` VALUES (4288,'SANTO ANTÔNIO DO AVENTUREIRO','MG');
INSERT INTO `municipios` VALUES (4289,'SANTO ANTÔNIO DO RETIRO','MG');
INSERT INTO `municipios` VALUES (4290,'SANTO AFONSO','MT');
INSERT INTO `municipios` VALUES (4291,'SANTO AMARO','BA');
INSERT INTO `municipios` VALUES (4292,'SANTO AMARO DA IMPERATRIZ','SC');
INSERT INTO `municipios` VALUES (4293,'SANTO AMARO DAS BROTAS','SE');
INSERT INTO `municipios` VALUES (4294,'SANTO AMARO DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4295,'SANTO ANASTÁCIO','SP');
INSERT INTO `municipios` VALUES (4296,'SANTO ANDRÉ','SP');
INSERT INTO `municipios` VALUES (4297,'SANTO ANGELO','RS');
INSERT INTO `municipios` VALUES (4298,'SANTO ANTÔNIO','RN');
INSERT INTO `municipios` VALUES (4299,'SANTO ANTÔNIO DO MONTE','MG');
INSERT INTO `municipios` VALUES (4300,'SANTO ANTÔNIO DA ALEGRIA','SP');
INSERT INTO `municipios` VALUES (4301,'SANTO ANTÔNIO DA BARRA','GO');
INSERT INTO `municipios` VALUES (4302,'SANTO ANTÔNIO DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (4303,'SANTO ANTÔNIO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4304,'SANTO ANTÔNIO DE JESUS','BA');
INSERT INTO `municipios` VALUES (4305,'SANTO ANTÔNIO DE PÁDUA','RJ');
INSERT INTO `municipios` VALUES (4306,'SANTO ANTÔNIO DE POSSE','SP');
INSERT INTO `municipios` VALUES (4307,'SANTO ANTÔNIO DESCOBERTO','GO');
INSERT INTO `municipios` VALUES (4308,'SANTO ANTÔNIO DO CAIUA','PR');
INSERT INTO `municipios` VALUES (4309,'SANTO ANTÔNIO DO AMPARO','MG');
INSERT INTO `municipios` VALUES (4310,'SANTO ANTÔNIO DO ARAÇANGUA','SP');
INSERT INTO `municipios` VALUES (4311,'SANTO ANTÔNIO DO GRAMA','MG');
INSERT INTO `municipios` VALUES (4312,'SANTO ANTÔNIO DO ICA','AM');
INSERT INTO `municipios` VALUES (4313,'SANTO ANTÔNIO DO ITAMBÉ','MG');
INSERT INTO `municipios` VALUES (4314,'SANTO ANTÔNIO DO JARDIM','SP');
INSERT INTO `municipios` VALUES (4315,'SANTO ANTÔNIO DO LEVERGER','MT');
INSERT INTO `municipios` VALUES (4316,'SANTO ANTÔNIO DO PALMA','RS');
INSERT INTO `municipios` VALUES (4317,'SANTO ANTÔNIO DO PARAISO','PR');
INSERT INTO `municipios` VALUES (4318,'SANTO ANTÔNIO DO PINHAL','SP');
INSERT INTO `municipios` VALUES (4319,'SANTO ANTÔNIO DO PLANALTO','RS');
INSERT INTO `municipios` VALUES (4320,'SANTO ANTÔNIO DO SUDOESTE','PR');
INSERT INTO `municipios` VALUES (4321,'SANTO ANTÔNIO DO TAUÁ','PA');
INSERT INTO `municipios` VALUES (4322,'SANTO ANTÔNIO DOS LOPES','MA');
INSERT INTO `municipios` VALUES (4323,'SANTO ANTÔNIO DOS MILAGRES','PI');
INSERT INTO `municipios` VALUES (4324,'SANTO ANTÔNIO DO JACINTO','MG');
INSERT INTO `municipios` VALUES (4325,'SANTO ANTÔNIO DE LISBOA','PI');
INSERT INTO `municipios` VALUES (4326,'SANTO ANTÔNIO DA PLATINA','PR');
INSERT INTO `municipios` VALUES (4327,'SANTO ANTÔNIO DO RIO ABAIXO','MG');
INSERT INTO `municipios` VALUES (4328,'SANTO AUGUSTO','RS');
INSERT INTO `municipios` VALUES (4329,'SANTO CRISTO','RS');
INSERT INTO `municipios` VALUES (4330,'SANTO ESTEVAO','BA');
INSERT INTO `municipios` VALUES (4331,'SANTO EXPEDITO','SP');
INSERT INTO `municipios` VALUES (4332,'SANTO EXPEDITO DO SUL','RS');
INSERT INTO `municipios` VALUES (4333,'SANTO HIPOLITO','MG');
INSERT INTO `municipios` VALUES (4334,'SANTO INÁCIO','PR');
INSERT INTO `municipios` VALUES (4335,'SANTO INACIO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4336,'SANTÓPOLIS DO ÁGUAPEI','SP');
INSERT INTO `municipios` VALUES (4337,'SANTOS','SP');
INSERT INTO `municipios` VALUES (4338,'SANTOS DUMONT','MG');
INSERT INTO `municipios` VALUES (4339,'SÃO BENEDITO','CE');
INSERT INTO `municipios` VALUES (4340,'SÃO BENEDITO DO RIO PRETO','MA');
INSERT INTO `municipios` VALUES (4341,'SÃO BENEDITO DO SUL','PE');
INSERT INTO `municipios` VALUES (4342,'SÃO BENTO','MA');
INSERT INTO `municipios` VALUES (4343,'SÃO BENTO','PB');
INSERT INTO `municipios` VALUES (4344,'SÃO BENTO DO ABADE','MG');
INSERT INTO `municipios` VALUES (4345,'SÃO BENTO DO NORTE','RN');
INSERT INTO `municipios` VALUES (4346,'SÃO BENTO DO SAPUCAI','SP');
INSERT INTO `municipios` VALUES (4347,'SÃO BENTO DO SUL','SC');
INSERT INTO `municipios` VALUES (4348,'SÃO BENTO DO TRAIRI','RN');
INSERT INTO `municipios` VALUES (4349,'SÃO BENTO DO UNA','PE');
INSERT INTO `municipios` VALUES (4350,'SÃO BENTO DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4351,'SÃO BERNARDINO','SC');
INSERT INTO `municipios` VALUES (4352,'SÃO BERNARDO','MA');
INSERT INTO `municipios` VALUES (4353,'SÃO BERNARDO DO CAMPO','SP');
INSERT INTO `municipios` VALUES (4354,'SÃO BONIFÁCIO','SC');
INSERT INTO `municipios` VALUES (4355,'SÃO BORJA','RS');
INSERT INTO `municipios` VALUES (4356,'SÃO BRAS','AL');
INSERT INTO `municipios` VALUES (4357,'SÃO BRAS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4358,'SÃO BRAS DO SUAÇUI','MG');
INSERT INTO `municipios` VALUES (4359,'SÃO CAETANO','PE');
INSERT INTO `municipios` VALUES (4360,'SÃO CAETANO DE ODIVELAS','PA');
INSERT INTO `municipios` VALUES (4361,'SÃO CAETANO DO SUL','SP');
INSERT INTO `municipios` VALUES (4362,'SÃO CARLOS','SC');
INSERT INTO `municipios` VALUES (4363,'SÃO CARLOS DO IVAI','PR');
INSERT INTO `municipios` VALUES (4364,'SÃO CRISTOVAO','SE');
INSERT INTO `municipios` VALUES (4365,'SÃO CRISTOVAO DO SUL','SC');
INSERT INTO `municipios` VALUES (4366,'SÃO DESIDERIO','BA');
INSERT INTO `municipios` VALUES (4367,'SÃO DOMINGOS','SC');
INSERT INTO `municipios` VALUES (4368,'SÃO DOMINGOS','SE');
INSERT INTO `municipios` VALUES (4369,'SÃO DOMINGOS DAS DORES','MG');
INSERT INTO `municipios` VALUES (4370,'SÃO DOMINGOS DO ARAGUAIA','PA');
INSERT INTO `municipios` VALUES (4371,'SÃO DOMINGOS DO AZEITÃO','MA');
INSERT INTO `municipios` VALUES (4372,'SÃO DOMINGOS DO CAPIM','PA');
INSERT INTO `municipios` VALUES (4373,'SÃO DOMINGOS DO CARIRI','PB');
INSERT INTO `municipios` VALUES (4374,'SÃO DOMINGOS DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4375,'SÃO DOMINGOS DO NORTE','ES');
INSERT INTO `municipios` VALUES (4376,'SÃO DOMINGOS DO PRATA','MG');
INSERT INTO `municipios` VALUES (4377,'SÃO DOMINGOS DO SUL','RS');
INSERT INTO `municipios` VALUES (4378,'SÃO FELIPE','BA');
INSERT INTO `municipios` VALUES (4379,'SÃO FELIPE DO OESTE','RO');
INSERT INTO `municipios` VALUES (4380,'SÃO FELIX','BA');
INSERT INTO `municipios` VALUES (4381,'SÃO FELIX DE BALSAS','MA');
INSERT INTO `municipios` VALUES (4382,'SÃO FELIX DE MINAS','MG');
INSERT INTO `municipios` VALUES (4383,'SÃO FÉLIX DO ARAGUAIA','MT');
INSERT INTO `municipios` VALUES (4384,'SÃO FELIX DO CORIBE','BA');
INSERT INTO `municipios` VALUES (4385,'SÃO FELIX DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4386,'SÃO FÉLIX DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4387,'SÃO FELIX DO XINGU','PA');
INSERT INTO `municipios` VALUES (4388,'SÃO FERNANDO','RN');
INSERT INTO `municipios` VALUES (4389,'SÃO FIDÉLIS','RJ');
INSERT INTO `municipios` VALUES (4390,'SÃO FRANCISCO','MG');
INSERT INTO `municipios` VALUES (4391,'SÃO FRANCISCO DE ASSIS','RS');
INSERT INTO `municipios` VALUES (4392,'SÃO FRANCISCO DE ASSIS PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4393,'SÃO FRANCISCO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4394,'SÃO FRANCISCO DE PAULA','MG');
INSERT INTO `municipios` VALUES (4395,'SÃO FRANCISCO DE SALES','MG');
INSERT INTO `municipios` VALUES (4396,'SÃO FRANCISCO DO BREJÃO','MA');
INSERT INTO `municipios` VALUES (4397,'SÃO FRANCISCO DO CONDE','BA');
INSERT INTO `municipios` VALUES (4398,'SÃO FRANCISCO DO GLÓRIA','MG');
INSERT INTO `municipios` VALUES (4399,'SÃO FRANCISCO DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4400,'SÃO FRANCISCO DO OESTE','RN');
INSERT INTO `municipios` VALUES (4401,'SÃO FRANCISCO DO PARÁ','PA');
INSERT INTO `municipios` VALUES (4402,'SÃO FRANCISCO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4403,'SÃO FRANCISCO DO SUL','SC');
INSERT INTO `municipios` VALUES (4404,'SÃO FRANCISCO ITABAPOANA','RJ');
INSERT INTO `municipios` VALUES (4405,'SÃO GABRIEL','BA');
INSERT INTO `municipios` VALUES (4406,'SÃO GABRIEL CACHOEIRA','AM');
INSERT INTO `municipios` VALUES (4407,'SÃO GABRIEL DA PALHA','ES');
INSERT INTO `municipios` VALUES (4408,'SÃO GABRIEL D\'OESTE','MS');
INSERT INTO `municipios` VALUES (4409,'SÃO GERALDO','MG');
INSERT INTO `municipios` VALUES (4410,'SÃO GERALDO DA PIEDADE','MG');
INSERT INTO `municipios` VALUES (4411,'SÃO GERALDO DO ARAGUAIA','PA');
INSERT INTO `municipios` VALUES (4412,'SÃO GERALDO DO BAIXO','MG');
INSERT INTO `municipios` VALUES (4413,'SÃO GONCALO','RJ');
INSERT INTO `municipios` VALUES (4414,'SÃO GONCALO AMARANTE','RN');
INSERT INTO `municipios` VALUES (4415,'SÃO GONCALO DO ABAETÉ','MG');
INSERT INTO `municipios` VALUES (4416,'SÃO GONCALO DO AMARANTE','CE');
INSERT INTO `municipios` VALUES (4417,'SÃO GONCALO DO GURGUEIA','PI');
INSERT INTO `municipios` VALUES (4418,'SÃO GONCALO DO PARA','MG');
INSERT INTO `municipios` VALUES (4419,'SÃO GONCALO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4420,'SÃO GONCALO DO RIO PRETO','MG');
INSERT INTO `municipios` VALUES (4421,'SÃO GONCALO DO SAPUCAI','MG');
INSERT INTO `municipios` VALUES (4422,'SÃO GONCALO DOS CAMPOS','BA');
INSERT INTO `municipios` VALUES (4423,'SÃO GONÇALO RIO ABAIXO','MG');
INSERT INTO `municipios` VALUES (4424,'SÃO GOTARDO','MG');
INSERT INTO `municipios` VALUES (4425,'SÃO JERONIMO','RS');
INSERT INTO `municipios` VALUES (4426,'SÃO JERÔNIMO DA SERRA','PR');
INSERT INTO `municipios` VALUES (4427,'SÃO JOÃO','PR');
INSERT INTO `municipios` VALUES (4428,'SÃO JOÃO BATISTA','MA');
INSERT INTO `municipios` VALUES (4429,'SÃO JOÃO BATISTA GLÓRIA','MG');
INSERT INTO `municipios` VALUES (4430,'SÃO JOÃO DA BALIZA','RR');
INSERT INTO `municipios` VALUES (4431,'SÃO JOÃO DA BARRA','RJ');
INSERT INTO `municipios` VALUES (4432,'SÃO JOÃO DA BOA VISTA','SP');
INSERT INTO `municipios` VALUES (4433,'SÃO JOÃO DA CANABRAVA','PI');
INSERT INTO `municipios` VALUES (4434,'SÃO JOÃO DA FRONTEIRA','PI');
INSERT INTO `municipios` VALUES (4435,'SÃO JOÃO DA LAGOA','MG');
INSERT INTO `municipios` VALUES (4436,'SÃO JOÃO DA MATA','MG');
INSERT INTO `municipios` VALUES (4437,'SÃO JOÃO DA PARAUNA','GO');
INSERT INTO `municipios` VALUES (4438,'SÃO JOÃO DA PONTA','PA');
INSERT INTO `municipios` VALUES (4439,'SÃO JOÃO DA PONTE','MG');
INSERT INTO `municipios` VALUES (4440,'SÃO JOÃO DA SERRA','PI');
INSERT INTO `municipios` VALUES (4441,'SÃO JOÃO DA URTIGA','RS');
INSERT INTO `municipios` VALUES (4442,'SÃO JOÃO DA VARJOTA','PI');
INSERT INTO `municipios` VALUES (4443,'SÃO JOÃO D\'ALIANÇA','GO');
INSERT INTO `municipios` VALUES (4444,'SÃO JOÃO DAS DUAS PONTES','SP');
INSERT INTO `municipios` VALUES (4445,'SÃO JOÃO DAS MISSÕES','MG');
INSERT INTO `municipios` VALUES (4446,'SÃO JOÃO DE IRACEMA','SP');
INSERT INTO `municipios` VALUES (4447,'SÃO JOÃO DE MERITI','RJ');
INSERT INTO `municipios` VALUES (4448,'SÃO JOÃO DE PIRABAS','PA');
INSERT INTO `municipios` VALUES (4449,'SÃO JOÃO DEL REI','MG');
INSERT INTO `municipios` VALUES (4450,'SÃO JOÃO DO ARÁGUAIA','PA');
INSERT INTO `municipios` VALUES (4451,'SÃO JOÃO DO ARRAIAL','PI');
INSERT INTO `municipios` VALUES (4452,'SÃO JOÃO DO CAIUA','PR');
INSERT INTO `municipios` VALUES (4453,'SÃO JOÃO DO CARIRI','PB');
INSERT INTO `municipios` VALUES (4454,'SÃO JOÃO DO CARU','MA');
INSERT INTO `municipios` VALUES (4455,'SÃO JOÃO DO ITAPERUI','SC');
INSERT INTO `municipios` VALUES (4456,'SÃO JOÃO DO IVAI','PR');
INSERT INTO `municipios` VALUES (4457,'SÃO JOÃO DO JÁGUARIBE','CE');
INSERT INTO `municipios` VALUES (4458,'SÃO JOÃO DO MANHUAÇU','MG');
INSERT INTO `municipios` VALUES (4459,'SÃO JOÃO DO MANTENINHA','MG');
INSERT INTO `municipios` VALUES (4460,'SÃO JOÃO DO OESTE','SC');
INSERT INTO `municipios` VALUES (4461,'SÃO JOÃO DO ORIENTE','MG');
INSERT INTO `municipios` VALUES (4462,'SÃO JOÃO DO PACUÍ','MG');
INSERT INTO `municipios` VALUES (4463,'SÃO JOÃO DO PARAISO','MA');
INSERT INTO `municipios` VALUES (4464,'SÃO JOÃO DO PAU DE ALHO','SP');
INSERT INTO `municipios` VALUES (4465,'SÃO JOÃO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4466,'SÃO JOÃO DO POLESINE','RS');
INSERT INTO `municipios` VALUES (4467,'SÃO JOÃO DO RIO DO PEIXE','PB');
INSERT INTO `municipios` VALUES (4468,'SÃO JOÃO DO SABUGI','PB');
INSERT INTO `municipios` VALUES (4469,'SÃO JOÃO DO SOTER','MA');
INSERT INTO `municipios` VALUES (4470,'SÃO JOÃO DO SUL','SC');
INSERT INTO `municipios` VALUES (4471,'SÃO JOÃO DO TIGRE','PB');
INSERT INTO `municipios` VALUES (4472,'SÃO JOÃO DO TRIUNFO','PR');
INSERT INTO `municipios` VALUES (4473,'SÃO JOÃO DOS PATOS','MA');
INSERT INTO `municipios` VALUES (4474,'SÃO JOÃO EVANGELISTA','MG');
INSERT INTO `municipios` VALUES (4475,'SÃO JOÃO NEPOMUCENO','MG');
INSERT INTO `municipios` VALUES (4476,'SÃO JOAQUIM','SC');
INSERT INTO `municipios` VALUES (4477,'SÃO JOAQUIM DA BARRA','SP');
INSERT INTO `municipios` VALUES (4478,'SÃO JOAQUIM DO MONTE','PE');
INSERT INTO `municipios` VALUES (4479,'SÃO JORGE','RS');
INSERT INTO `municipios` VALUES (4480,'SÃO JORGE DO IVAI','PR');
INSERT INTO `municipios` VALUES (4481,'SÃO JORGE DO OESTE','PR');
INSERT INTO `municipios` VALUES (4482,'SÃO JORGE DO PATROCÍNIO','PR');
INSERT INTO `municipios` VALUES (4483,'SÃO JOSÉ','SC');
INSERT INTO `municipios` VALUES (4484,'SÃO JOSÉ CAMPESTRE','RN');
INSERT INTO `municipios` VALUES (4485,'SÃO JOSÉ DA BARRA','MG');
INSERT INTO `municipios` VALUES (4486,'SÃO JOSÉ DA BELA VISTA','SP');
INSERT INTO `municipios` VALUES (4487,'SÃO JOSÉ DA BOA VISTA','PR');
INSERT INTO `municipios` VALUES (4488,'SÃO JOSÉ DA COROA GRANDE','PE');
INSERT INTO `municipios` VALUES (4489,'SÃO JOSÉ DA LAJE','AL');
INSERT INTO `municipios` VALUES (4490,'SÃO JOSÉ DA LAGOA TAPADA','PB');
INSERT INTO `municipios` VALUES (4491,'SÃO JOSÉ DA SAFIRA','MG');
INSERT INTO `municipios` VALUES (4492,'SÃO JOSÉ DA TAPERA','AL');
INSERT INTO `municipios` VALUES (4493,'SÃO JOSÉ DA VARGINHA','MG');
INSERT INTO `municipios` VALUES (4494,'SÃO JOSÉ DA VITÓRIA','BA');
INSERT INTO `municipios` VALUES (4495,'SÃO JOSÉ DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (4496,'SÃO JOSÉ DAS PALMEIRAS','PR');
INSERT INTO `municipios` VALUES (4497,'SÃO JOSÉ DE CAIANA','PB');
INSERT INTO `municipios` VALUES (4498,'SÃO JOSÉ DE ESPINHARAS','PB');
INSERT INTO `municipios` VALUES (4499,'SÃO JOSÉ DE MIPIBU','RN');
INSERT INTO `municipios` VALUES (4500,'SÃO JOSÉ DE PIRANHAS','PB');
INSERT INTO `municipios` VALUES (4501,'SÃO JOSÉ DE PRINCESA','PB');
INSERT INTO `municipios` VALUES (4502,'SÃO JOSÉ DE RIBAMAR','MA');
INSERT INTO `municipios` VALUES (4503,'SÃO JOSÉ DE UBA','RJ');
INSERT INTO `municipios` VALUES (4504,'SÃO JOSÉ DO ALEGRE','MG');
INSERT INTO `municipios` VALUES (4505,'SÃO JOSÉ DO BARREIRO','SP');
INSERT INTO `municipios` VALUES (4506,'SÃO JOSÉ DO BELMONTE','PE');
INSERT INTO `municipios` VALUES (4507,'SÃO JOSÉ DO BONFIM','PB');
INSERT INTO `municipios` VALUES (4508,'SÃO JOSÉ DO BREJO DO CRUZ','PB');
INSERT INTO `municipios` VALUES (4509,'SÃO JOSÉ DO CALCADO','ES');
INSERT INTO `municipios` VALUES (4510,'SÃO JOSÉ DO CEDRO','SC');
INSERT INTO `municipios` VALUES (4511,'SÃO JOSÉ DO CERRITO','SC');
INSERT INTO `municipios` VALUES (4512,'SÃO JOSÉ DO EGITO','PE');
INSERT INTO `municipios` VALUES (4513,'SÃO JOSÉ DO GOIABAL','MG');
INSERT INTO `municipios` VALUES (4514,'SÃO JOSÉ DO HERVAL','RS');
INSERT INTO `municipios` VALUES (4515,'SÃO JOSÉ DO HORTENCIO','RS');
INSERT INTO `municipios` VALUES (4516,'SÃO JOSÉ DO INHACORA','RS');
INSERT INTO `municipios` VALUES (4517,'SÃO JOSÉ DO JACURI','MG');
INSERT INTO `municipios` VALUES (4518,'SÃO JOSÉ DO LAPA','MG');
INSERT INTO `municipios` VALUES (4519,'SÃO JOSÉ DO MANTIMENTO','MG');
INSERT INTO `municipios` VALUES (4520,'SÃO JOSÉ DO NORTE','RS');
INSERT INTO `municipios` VALUES (4521,'SÃO JOSÉ DO OURO','RS');
INSERT INTO `municipios` VALUES (4522,'SÃO JOSÉ DO PEIXE','PI');
INSERT INTO `municipios` VALUES (4523,'SÃO JOSÉ DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4524,'SÃO JOSÉ DO POVO','MT');
INSERT INTO `municipios` VALUES (4525,'SÃO JOSÉ DO RIO CLARO','MT');
INSERT INTO `municipios` VALUES (4526,'SÃO JOSÉ DO RIO PARDO','SP');
INSERT INTO `municipios` VALUES (4527,'SÃO JOSÉ DO RIO PRETO','SP');
INSERT INTO `municipios` VALUES (4528,'SÃO JOSÉ DO SABUGI','PB');
INSERT INTO `municipios` VALUES (4529,'SÃO JOSÉ DO XINGU','MT');
INSERT INTO `municipios` VALUES (4530,'SÃO JOSÉ DOS AUSENTES','RS');
INSERT INTO `municipios` VALUES (4531,'SÃO JOSÉ DOS BASILIOS','MA');
INSERT INTO `municipios` VALUES (4532,'SÃO JOSÉ DOS CAMPOS','SP');
INSERT INTO `municipios` VALUES (4533,'SÃO JOSÉ DOS CORDEIROS','PB');
INSERT INTO `municipios` VALUES (4534,'SÃO JOSÉ DOS PINHAIS','PR');
INSERT INTO `municipios` VALUES (4535,'SÃO JOSÉ DOS QUATRO MARCOS','MT');
INSERT INTO `municipios` VALUES (4536,'SÃO JOSÉ DOS RAMOS','PB');
INSERT INTO `municipios` VALUES (4537,'SÃO JOSÉ VALE RIO PRETO','RJ');
INSERT INTO `municipios` VALUES (4538,'SÃO JULIÃO','PI');
INSERT INTO `municipios` VALUES (4539,'SÃO LEOPOLDO','RS');
INSERT INTO `municipios` VALUES (4540,'SÃO LOURENCO','MG');
INSERT INTO `municipios` VALUES (4541,'SÃO LOURENCO DA MATA','PE');
INSERT INTO `municipios` VALUES (4542,'SÃO LOURENCO DA SERRA','SP');
INSERT INTO `municipios` VALUES (4543,'SÃO LOURENCO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4544,'SÃO LOURENCO DO SUL','RS');
INSERT INTO `municipios` VALUES (4545,'SÃO LOURENCO D\'OESTE','SC');
INSERT INTO `municipios` VALUES (4546,'SÃO LUDGERO','SC');
INSERT INTO `municipios` VALUES (4547,'SÃO LUIS','MA');
INSERT INTO `municipios` VALUES (4548,'SÃO LUIS DE MONTES BELOS','GO');
INSERT INTO `municipios` VALUES (4549,'SÃO LUIS DO CURU','CE');
INSERT INTO `municipios` VALUES (4550,'SÃO LUÍS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4551,'SÃO LUIS DO QUITUNDE','AL');
INSERT INTO `municipios` VALUES (4552,'SÃO LUÍS GONZAGA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4553,'SÃO LUIZ','RR');
INSERT INTO `municipios` VALUES (4554,'SÃO LUIZ DO AMAUA','RR');
INSERT INTO `municipios` VALUES (4555,'SÃO LUIZ DO NORTE','GO');
INSERT INTO `municipios` VALUES (4556,'SÃO LUIZ DO PARAITINGA','SP');
INSERT INTO `municipios` VALUES (4557,'SÃO LUIZ GONZAGA','RS');
INSERT INTO `municipios` VALUES (4558,'SÃO MAMEDE','PB');
INSERT INTO `municipios` VALUES (4559,'SÃO MANOEL DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (4560,'SÃO MANUEL','SP');
INSERT INTO `municipios` VALUES (4561,'SÃO MARCOS','RS');
INSERT INTO `municipios` VALUES (4562,'SÃO MARTINHO','RS');
INSERT INTO `municipios` VALUES (4563,'SÃO MARTINHO DA SERRA','RS');
INSERT INTO `municipios` VALUES (4564,'SÃO MATEUS','ES');
INSERT INTO `municipios` VALUES (4565,'SÃO MATEUS DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4566,'SÃO MATEUS DO SUL','PR');
INSERT INTO `municipios` VALUES (4567,'SÃO MIGUEL','RN');
INSERT INTO `municipios` VALUES (4568,'SÃO MIGUEL DO ANTA','MG');
INSERT INTO `municipios` VALUES (4569,'SÃO MIGUEL ARCANJO','SP');
INSERT INTO `municipios` VALUES (4570,'SÃO MIGUEL DA BAIXA GRANDE','PI');
INSERT INTO `municipios` VALUES (4571,'SÃO MIGUEL DA BOA VISTA','SC');
INSERT INTO `municipios` VALUES (4572,'SÃO MIGUEL DAS MATAS','BA');
INSERT INTO `municipios` VALUES (4573,'SÃO MIGUEL DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (4574,'SÃO MIGUEL DE TAIPU','PB');
INSERT INTO `municipios` VALUES (4575,'SÃO MIGUEL DE TOUROS','RN');
INSERT INTO `municipios` VALUES (4576,'SÃO MIGUEL DO ALEIXO','SE');
INSERT INTO `municipios` VALUES (4577,'SÃO MIGUEL DO ARÁGUAIA','GO');
INSERT INTO `municipios` VALUES (4578,'SÃO MIGUEL DO FIDALGO','PI');
INSERT INTO `municipios` VALUES (4579,'SÃO MIGUEL DO GUAMA','PA');
INSERT INTO `municipios` VALUES (4580,'SÃO MIGUEL DO GUAPORÉ','RO');
INSERT INTO `municipios` VALUES (4581,'SÃO MIGUEL DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (4582,'SÃO MIGUEL DO OESTE','SC');
INSERT INTO `municipios` VALUES (4583,'SÃO MIGUEL DO TAPUIO','PI');
INSERT INTO `municipios` VALUES (4584,'SÃO MIGUEL DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4585,'SÃO MIGUEL DOS CAMPOS','AL');
INSERT INTO `municipios` VALUES (4586,'SÃO MIGUEL DOS MILAGRES','AL');
INSERT INTO `municipios` VALUES (4587,'SÃO MIGUEL PASSA QUATRO','GO');
INSERT INTO `municipios` VALUES (4588,'SÃO NICILAU','RS');
INSERT INTO `municipios` VALUES (4589,'SÃO NICOLAU','RS');
INSERT INTO `municipios` VALUES (4590,'SÃO PATRÍCIO','GO');
INSERT INTO `municipios` VALUES (4591,'SÃO PAULO','SP');
INSERT INTO `municipios` VALUES (4592,'SÃO PAULO DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (4593,'SÃO PAULO DE OLIVENCA','AM');
INSERT INTO `municipios` VALUES (4594,'SÃO PAULO DO POTENGI','RN');
INSERT INTO `municipios` VALUES (4595,'SÃO PEDRO','RN');
INSERT INTO `municipios` VALUES (4596,'SÃO PEDRO DA ÁGUA BRANCA','MA');
INSERT INTO `municipios` VALUES (4597,'SÃO PEDRO DA ALDEIA','RJ');
INSERT INTO `municipios` VALUES (4598,'SÃO PEDRO DA CIPA','MT');
INSERT INTO `municipios` VALUES (4599,'SÃO PEDRO DA SERRA','RS');
INSERT INTO `municipios` VALUES (4600,'SÃO PEDRO DA UNIÃO','MG');
INSERT INTO `municipios` VALUES (4601,'SÃO PEDRO DE ALCANTARA','SC');
INSERT INTO `municipios` VALUES (4602,'SÃO PEDRO DO BUTIA','RS');
INSERT INTO `municipios` VALUES (4603,'SÃO PEDRO DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (4604,'SÃO PEDRO DO IVAÍ','PR');
INSERT INTO `municipios` VALUES (4605,'SÃO PEDRO DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (4606,'SÃO PEDRO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4607,'SÃO PEDRO DO SUAÇUI','MG');
INSERT INTO `municipios` VALUES (4608,'SÃO PEDRO DO SUL','RS');
INSERT INTO `municipios` VALUES (4609,'SÃO PEDRO DO TURVO','SP');
INSERT INTO `municipios` VALUES (4610,'SÃO PEDRO DOS CRENTES','MA');
INSERT INTO `municipios` VALUES (4611,'SÃO PEDRO DOS FERROS','MG');
INSERT INTO `municipios` VALUES (4612,'SÃO RAFAEL','RN');
INSERT INTO `municipios` VALUES (4613,'SÃO RAIMUNDO DAS MANGABEIRA','MA');
INSERT INTO `municipios` VALUES (4614,'SÃO RAIMUNDO DOCA BEZERRA','MS');
INSERT INTO `municipios` VALUES (4615,'SÃO RAIMUNDO NONATO','PI');
INSERT INTO `municipios` VALUES (4616,'SÃO ROBERTO','MA');
INSERT INTO `municipios` VALUES (4617,'SÃO ROMAO','MG');
INSERT INTO `municipios` VALUES (4618,'SÃO ROQUE','SP');
INSERT INTO `municipios` VALUES (4619,'SÃO ROQUE DE MINAS','MG');
INSERT INTO `municipios` VALUES (4620,'SÃO ROQUE DO CANAÃ','ES');
INSERT INTO `municipios` VALUES (4621,'SÃO SALVADOR DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4622,'SÃO SEBASTIÃO','AL');
INSERT INTO `municipios` VALUES (4623,'SÃO SEBASTIÃO DO RIO VERDE','MG');
INSERT INTO `municipios` VALUES (4624,'SÃO SEBASTIÃO DA AMOREIRA','PR');
INSERT INTO `municipios` VALUES (4625,'SÃO SEBASTIÃO BELA VISTA','MG');
INSERT INTO `municipios` VALUES (4626,'SÃO SEBASTIÃO DA BOA VISTA','PA');
INSERT INTO `municipios` VALUES (4627,'SÃO SEBASTIÃO DA GRAMA','SP');
INSERT INTO `municipios` VALUES (4628,'SÃO SEBASTIÃO DE LAGOA DE ROCA','PB');
INSERT INTO `municipios` VALUES (4629,'SÃO SEBASTIÃO DO ALTO','RJ');
INSERT INTO `municipios` VALUES (4630,'SÃO SEBASTIÃO DO CAÍ','RS');
INSERT INTO `municipios` VALUES (4631,'SÃO SEBASTIÃO DO MARANHÃO','MG');
INSERT INTO `municipios` VALUES (4632,'SÃO SEBASTIÃO DO OESTE','MG');
INSERT INTO `municipios` VALUES (4633,'SÃO SEBASTIÃO DO PARAÍSO','MG');
INSERT INTO `municipios` VALUES (4634,'SÃO SEBASTIÃO DO PASSÉ','BA');
INSERT INTO `municipios` VALUES (4635,'SÃO SEBASTIÃO DO UATUMA','AM');
INSERT INTO `municipios` VALUES (4636,'SÃO SEBASTIÃO DO UMBUZEIRO','PB');
INSERT INTO `municipios` VALUES (4637,'SÃO SEBASTIÃO DO RIO PRETO','MG');
INSERT INTO `municipios` VALUES (4638,'SÃO SEPE','RS');
INSERT INTO `municipios` VALUES (4639,'SÃO SIMÃO','GO');
INSERT INTO `municipios` VALUES (4640,'SÃO SIMÃO','SP');
INSERT INTO `municipios` VALUES (4641,'SÃO TOME DAS LETRAS','MG');
INSERT INTO `municipios` VALUES (4642,'SÃO TIAGO','MG');
INSERT INTO `municipios` VALUES (4643,'SÃO TOMAS DE AQUINO','MG');
INSERT INTO `municipios` VALUES (4644,'SÃO TOMÉ','PR');
INSERT INTO `municipios` VALUES (4645,'SÃO VALENTIM','RS');
INSERT INTO `municipios` VALUES (4646,'SÃO VALENTIM DO SUL','RS');
INSERT INTO `municipios` VALUES (4647,'SÃO VALERIO DA NATIVIDADE','TO');
INSERT INTO `municipios` VALUES (4648,'SÃO VALERIO DO SUL','RS');
INSERT INTO `municipios` VALUES (4649,'SÃO VENDELINO','RS');
INSERT INTO `municipios` VALUES (4650,'SÃO VICENTE','RN');
INSERT INTO `municipios` VALUES (4651,'SÃO VICENTE DE FERRER','MA');
INSERT INTO `municipios` VALUES (4652,'SÃO VICENTE DE MINAS','MG');
INSERT INTO `municipios` VALUES (4653,'SÃO VICENTE DO SERIDO','PB');
INSERT INTO `municipios` VALUES (4654,'SÃO VICENTE DO SUL','RS');
INSERT INTO `municipios` VALUES (4655,'SÃO VICENTE FERRER','PE');
INSERT INTO `municipios` VALUES (4656,'SAPÉ','PB');
INSERT INTO `municipios` VALUES (4657,'SAPEAÇU','BA');
INSERT INTO `municipios` VALUES (4658,'SAPEZAL','MT');
INSERT INTO `municipios` VALUES (4659,'SAPIRANGA','RS');
INSERT INTO `municipios` VALUES (4660,'SAPOPEMA','PR');
INSERT INTO `municipios` VALUES (4661,'SAPUCAIA','PA');
INSERT INTO `municipios` VALUES (4662,'SAPUCAIA','RJ');
INSERT INTO `municipios` VALUES (4663,'SAPUCAIA DO SUL','RS');
INSERT INTO `municipios` VALUES (4664,'SAPUCAI-MIRIM','MG');
INSERT INTO `municipios` VALUES (4665,'SAQUAREMA','RJ');
INSERT INTO `municipios` VALUES (4666,'SARANDI','PR');
INSERT INTO `municipios` VALUES (4667,'SARANDI','RS');
INSERT INTO `municipios` VALUES (4668,'SARAPUI','SP');
INSERT INTO `municipios` VALUES (4669,'SARDOA','MG');
INSERT INTO `municipios` VALUES (4670,'SARUTAIA','SP');
INSERT INTO `municipios` VALUES (4671,'SARZEDO','MG');
INSERT INTO `municipios` VALUES (4672,'SÁTIRO DIAS','BA');
INSERT INTO `municipios` VALUES (4673,'SATUBINHA','MA');
INSERT INTO `municipios` VALUES (4674,'SAUBARA','BA');
INSERT INTO `municipios` VALUES (4675,'SAUDADE DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (4676,'SAUDADES','SC');
INSERT INTO `municipios` VALUES (4677,'SAÚDE','BA');
INSERT INTO `municipios` VALUES (4678,'SCHROEDER','SC');
INSERT INTO `municipios` VALUES (4679,'SEABRA','BA');
INSERT INTO `municipios` VALUES (4680,'SEARA','SC');
INSERT INTO `municipios` VALUES (4681,'SEBASTIANÓPOLIS DO SUL','SP');
INSERT INTO `municipios` VALUES (4682,'SEBASTIÃO BARROS','PI');
INSERT INTO `municipios` VALUES (4683,'SEBASTIÃO LARANJEIRAS','BA');
INSERT INTO `municipios` VALUES (4684,'SEBASTIÃO LEAL','PI');
INSERT INTO `municipios` VALUES (4685,'SEBERI','RS');
INSERT INTO `municipios` VALUES (4686,'SEDE NOVA','RS');
INSERT INTO `municipios` VALUES (4687,'SEGREDO','RS');
INSERT INTO `municipios` VALUES (4688,'SELBACH','RS');
INSERT INTO `municipios` VALUES (4689,'SELVIRIA','MS');
INSERT INTO `municipios` VALUES (4690,'SENA MADUREIRA','AC');
INSERT INTO `municipios` VALUES (4691,'SENADOR ALEXANDRE COSTA','MA');
INSERT INTO `municipios` VALUES (4692,'SENADOR AMARAL','MG');
INSERT INTO `municipios` VALUES (4693,'SENADOR CANEDO','GO');
INSERT INTO `municipios` VALUES (4694,'SENADOR CORTES','MG');
INSERT INTO `municipios` VALUES (4695,'SENADOR ELOI DE SOUZA','RN');
INSERT INTO `municipios` VALUES (4696,'SENADOR FIRMINO','MG');
INSERT INTO `municipios` VALUES (4697,'SENADOR GEORGINO AVELINO','RN');
INSERT INTO `municipios` VALUES (4698,'SENADOR GUIOMARD','AC');
INSERT INTO `municipios` VALUES (4699,'SENADOR JOSÉ BENTO','MG');
INSERT INTO `municipios` VALUES (4700,'SENADOR JOSÉ PORFIRIO','PA');
INSERT INTO `municipios` VALUES (4701,'SENADOR LA  ROCQUE','MA');
INSERT INTO `municipios` VALUES (4702,'SENADOR MODESTINO GONÇALVES','MG');
INSERT INTO `municipios` VALUES (4703,'SENADOR POMPEU','CE');
INSERT INTO `municipios` VALUES (4704,'SENADOR RUI PALMEIRA','AL');
INSERT INTO `municipios` VALUES (4705,'SENADOR SA','CE');
INSERT INTO `municipios` VALUES (4706,'SENADOR SALGADO FILHO','RS');
INSERT INTO `municipios` VALUES (4707,'SENGES','PR');
INSERT INTO `municipios` VALUES (4708,'SENHOR DO BONFIM','BA');
INSERT INTO `municipios` VALUES (4709,'SENHORA DE OLIVEIRA','MG');
INSERT INTO `municipios` VALUES (4710,'SENHORA DO PORTO','MG');
INSERT INTO `municipios` VALUES (4711,'SENHORA DOS REMÉDIOS','MG');
INSERT INTO `municipios` VALUES (4712,'SENTINELA DO SUL','RS');
INSERT INTO `municipios` VALUES (4713,'SENTO SE','BA');
INSERT INTO `municipios` VALUES (4714,'SERAFINA CORRÊA','RS');
INSERT INTO `municipios` VALUES (4715,'SERICITA','MG');
INSERT INTO `municipios` VALUES (4716,'SERIDO','PB');
INSERT INTO `municipios` VALUES (4717,'SERINGUEIRAS','RO');
INSERT INTO `municipios` VALUES (4718,'SERIO','RS');
INSERT INTO `municipios` VALUES (4719,'SERITINGA','MG');
INSERT INTO `municipios` VALUES (4720,'SEROPEDICA','RJ');
INSERT INTO `municipios` VALUES (4721,'SERRA','ES');
INSERT INTO `municipios` VALUES (4722,'SERRA ALTA','SC');
INSERT INTO `municipios` VALUES (4723,'SERRA AZUL','SP');
INSERT INTO `municipios` VALUES (4724,'SERRA AZUL DE MINAS','MG');
INSERT INTO `municipios` VALUES (4725,'SERRA BRANCA','PB');
INSERT INTO `municipios` VALUES (4726,'SERRA CAIADA','RN');
INSERT INTO `municipios` VALUES (4727,'SERRA DA RAIZ','PB');
INSERT INTO `municipios` VALUES (4728,'SERRA DA SAUDADE','MG');
INSERT INTO `municipios` VALUES (4729,'SERRA DE SÃO BENTO','RN');
INSERT INTO `municipios` VALUES (4730,'SERRA DO MEL','RN');
INSERT INTO `municipios` VALUES (4731,'SERRA DO NAVIO','AP');
INSERT INTO `municipios` VALUES (4732,'SERRA DO RAMALHO','BA');
INSERT INTO `municipios` VALUES (4733,'SERRA DO SALITRE','MG');
INSERT INTO `municipios` VALUES (4734,'SERRA DOS AIMORES','MG');
INSERT INTO `municipios` VALUES (4735,'SERRA DOURADA','BA');
INSERT INTO `municipios` VALUES (4736,'SERRA GRANDE','PB');
INSERT INTO `municipios` VALUES (4737,'SERRA NEGRA','SP');
INSERT INTO `municipios` VALUES (4738,'SERRA NEGRA DO NORTE','RN');
INSERT INTO `municipios` VALUES (4739,'SERRA PRETA','BA');
INSERT INTO `municipios` VALUES (4740,'SERRA REDONDA','PB');
INSERT INTO `municipios` VALUES (4741,'SERRA TALHADA','PE');
INSERT INTO `municipios` VALUES (4742,'SERRANA','SP');
INSERT INTO `municipios` VALUES (4743,'SERRANIA','MG');
INSERT INTO `municipios` VALUES (4744,'SERRANO DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (4745,'SERRANÓPOLIS','GO');
INSERT INTO `municipios` VALUES (4746,'SERRANÓPOLIS DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (4747,'SERRANOS','MG');
INSERT INTO `municipios` VALUES (4748,'SERRARIA','PB');
INSERT INTO `municipios` VALUES (4749,'SERRINHA','BA');
INSERT INTO `municipios` VALUES (4750,'SERRINHA DOS PINTOS','RN');
INSERT INTO `municipios` VALUES (4751,'SERRITA','PE');
INSERT INTO `municipios` VALUES (4752,'SERRO','MG');
INSERT INTO `municipios` VALUES (4753,'SERROLÂNDIA','BA');
INSERT INTO `municipios` VALUES (4754,'SERTANEJA','PR');
INSERT INTO `municipios` VALUES (4755,'SERTANIA','PE');
INSERT INTO `municipios` VALUES (4756,'SERTANÓPOLIS','PR');
INSERT INTO `municipios` VALUES (4757,'SERTÃO','RS');
INSERT INTO `municipios` VALUES (4758,'SERTÃO SANTANA','RS');
INSERT INTO `municipios` VALUES (4759,'SERTÃOZINHO','PB');
INSERT INTO `municipios` VALUES (4760,'SETE BARRAS','SP');
INSERT INTO `municipios` VALUES (4761,'SETE DE SETEMBRO','RS');
INSERT INTO `municipios` VALUES (4762,'SETE LAGOAS','MG');
INSERT INTO `municipios` VALUES (4763,'SETE QUEDAS','MS');
INSERT INTO `municipios` VALUES (4764,'SETUBINHA','MG');
INSERT INTO `municipios` VALUES (4765,'SEVERIANO DE ALMEIDA','RS');
INSERT INTO `municipios` VALUES (4766,'SEVERIANO MELO','RN');
INSERT INTO `municipios` VALUES (4767,'SEVERINIA','SP');
INSERT INTO `municipios` VALUES (4768,'SIDERÓPOLIS','SC');
INSERT INTO `municipios` VALUES (4769,'SIDROLÂNDIA','MS');
INSERT INTO `municipios` VALUES (4770,'SIGEFREDO PACHECO','PI');
INSERT INTO `municipios` VALUES (4771,'SILVA JARDIM','RJ');
INSERT INTO `municipios` VALUES (4772,'SILVANIA','GO');
INSERT INTO `municipios` VALUES (4773,'SILVANÓPOLIS','TO');
INSERT INTO `municipios` VALUES (4774,'SILVEIRA MARTINS','RS');
INSERT INTO `municipios` VALUES (4775,'SILVEIRAS','SP');
INSERT INTO `municipios` VALUES (4776,'SILVEIRÂNIA','MG');
INSERT INTO `municipios` VALUES (4777,'SILVES','AM');
INSERT INTO `municipios` VALUES (4778,'SILVIANÓPOLIS','MG');
INSERT INTO `municipios` VALUES (4779,'SIMÃO DIAS','SE');
INSERT INTO `municipios` VALUES (4780,'SIMÃO PEREIRA','MG');
INSERT INTO `municipios` VALUES (4781,'SIMÕES','PI');
INSERT INTO `municipios` VALUES (4782,'SIMÕES FILHO','BA');
INSERT INTO `municipios` VALUES (4783,'SIMOLÂNDIA','GO');
INSERT INTO `municipios` VALUES (4784,'SIMONÉSIA','MG');
INSERT INTO `municipios` VALUES (4785,'SIMPLÍCIO MENDES','PI');
INSERT INTO `municipios` VALUES (4786,'SINOP','MT');
INSERT INTO `municipios` VALUES (4787,'SIQUEIRA CAMPOS','PR');
INSERT INTO `municipios` VALUES (4788,'SIRINHAÉM','PE');
INSERT INTO `municipios` VALUES (4789,'SIRIRI','SE');
INSERT INTO `municipios` VALUES (4790,'SITIO D\'ABADIA','GO');
INSERT INTO `municipios` VALUES (4791,'SITIO DO MATO','BA');
INSERT INTO `municipios` VALUES (4792,'SITIO DO QUINTO','BA');
INSERT INTO `municipios` VALUES (4793,'SITIO NOVO','MA');
INSERT INTO `municipios` VALUES (4794,'SITIO NOVO DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (4795,'SOBRADINHO','BA');
INSERT INTO `municipios` VALUES (4796,'SOBRADINHO','RS');
INSERT INTO `municipios` VALUES (4797,'SOBRADO','PB');
INSERT INTO `municipios` VALUES (4798,'SOBRAL','CE');
INSERT INTO `municipios` VALUES (4799,'SOBRALIA','MG');
INSERT INTO `municipios` VALUES (4800,'SOCORRO','SP');
INSERT INTO `municipios` VALUES (4801,'SOCORRO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4802,'SOLANEA','PB');
INSERT INTO `municipios` VALUES (4803,'SOLEDADE','PB');
INSERT INTO `municipios` VALUES (4804,'SOLEDADE DE MINAS','MG');
INSERT INTO `municipios` VALUES (4805,'SOLIDÃO','PE');
INSERT INTO `municipios` VALUES (4806,'SOLONOPOLE','CE');
INSERT INTO `municipios` VALUES (4807,'SOMBRIO','SC');
INSERT INTO `municipios` VALUES (4808,'SONORA','MS');
INSERT INTO `municipios` VALUES (4809,'SOORETAMA','ES');
INSERT INTO `municipios` VALUES (4810,'SOROCABA','SP');
INSERT INTO `municipios` VALUES (4811,'SORRISO','MT');
INSERT INTO `municipios` VALUES (4812,'SOSSEGO','PB');
INSERT INTO `municipios` VALUES (4813,'SOURE','PA');
INSERT INTO `municipios` VALUES (4814,'SOUSA','PB');
INSERT INTO `municipios` VALUES (4815,'SOUTO SOARES','BA');
INSERT INTO `municipios` VALUES (4816,'SUCUPIRA','TO');
INSERT INTO `municipios` VALUES (4817,'SUCUPIRA DO NORTE','MA');
INSERT INTO `municipios` VALUES (4818,'SUCUPIRA DO RIACHÃO','MA');
INSERT INTO `municipios` VALUES (4819,'SUD MENNUCCI','SP');
INSERT INTO `municipios` VALUES (4820,'SUL BRASIL','SC');
INSERT INTO `municipios` VALUES (4821,'SULINA','PR');
INSERT INTO `municipios` VALUES (4822,'SUMARE','SP');
INSERT INTO `municipios` VALUES (4823,'SUMÉ','PB');
INSERT INTO `municipios` VALUES (4824,'SUMIDOURO','RJ');
INSERT INTO `municipios` VALUES (4825,'SURUBIM','PE');
INSERT INTO `municipios` VALUES (4826,'SUSSUAPARA','PI');
INSERT INTO `municipios` VALUES (4827,'SUZANÁPOLIS','SP');
INSERT INTO `municipios` VALUES (4828,'SUZANO','SP');
INSERT INTO `municipios` VALUES (4829,'TABAI','RS');
INSERT INTO `municipios` VALUES (4830,'TABAPORÃ','MT');
INSERT INTO `municipios` VALUES (4831,'TABAPUA','SP');
INSERT INTO `municipios` VALUES (4832,'TABATINGA','AM');
INSERT INTO `municipios` VALUES (4833,'TABIRA','PE');
INSERT INTO `municipios` VALUES (4834,'TABOAO DA SERRA','SP');
INSERT INTO `municipios` VALUES (4835,'TABOCAS DO BREJO VELHO','BA');
INSERT INTO `municipios` VALUES (4836,'TABOLEIRO GRANDE','RN');
INSERT INTO `municipios` VALUES (4837,'TABULEIRO','MG');
INSERT INTO `municipios` VALUES (4838,'TABULEIRO DO NORTE','CE');
INSERT INTO `municipios` VALUES (4839,'TACAIMBO','PE');
INSERT INTO `municipios` VALUES (4840,'TACARATU','PE');
INSERT INTO `municipios` VALUES (4841,'TACIBA','SP');
INSERT INTO `municipios` VALUES (4842,'TACIMA','PB');
INSERT INTO `municipios` VALUES (4843,'TACURU','MS');
INSERT INTO `municipios` VALUES (4844,'TÁGUAI','SP');
INSERT INTO `municipios` VALUES (4845,'TÁGUATINGA','TO');
INSERT INTO `municipios` VALUES (4846,'TAIAÇU','SP');
INSERT INTO `municipios` VALUES (4847,'TAILÂNDIA','PA');
INSERT INTO `municipios` VALUES (4848,'TAIO','SC');
INSERT INTO `municipios` VALUES (4849,'TAIOBEIRAS','MG');
INSERT INTO `municipios` VALUES (4850,'TAIPAS','TO');
INSERT INTO `municipios` VALUES (4851,'TAIPU','RN');
INSERT INTO `municipios` VALUES (4852,'TAIUVA','SP');
INSERT INTO `municipios` VALUES (4853,'TALISMA','TO');
INSERT INTO `municipios` VALUES (4854,'TAMANDARÉ','PE');
INSERT INTO `municipios` VALUES (4855,'TAMARANA','PR');
INSERT INTO `municipios` VALUES (4856,'TAMBAU','SP');
INSERT INTO `municipios` VALUES (4857,'TAMBOARA','PR');
INSERT INTO `municipios` VALUES (4858,'TAMBORIL','CE');
INSERT INTO `municipios` VALUES (4859,'TAMBORIL DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4860,'TAMMAÇU','BA');
INSERT INTO `municipios` VALUES (4861,'TANABI','SP');
INSERT INTO `municipios` VALUES (4862,'TANGARA','RN');
INSERT INTO `municipios` VALUES (4863,'TANGARA DA SERRA','MT');
INSERT INTO `municipios` VALUES (4864,'TANGUÁ','RJ');
INSERT INTO `municipios` VALUES (4865,'TANQUE D\'ARCA','AL');
INSERT INTO `municipios` VALUES (4866,'TANQUE DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (4867,'TANQUE NOVO','BA');
INSERT INTO `municipios` VALUES (4868,'TANQUINHO','BA');
INSERT INTO `municipios` VALUES (4869,'TAPARUBA','MG');
INSERT INTO `municipios` VALUES (4870,'TAPAUA','AM');
INSERT INTO `municipios` VALUES (4871,'TAPEJARA','PR');
INSERT INTO `municipios` VALUES (4872,'TAPERA','RS');
INSERT INTO `municipios` VALUES (4873,'TAPEROA','BA');
INSERT INTO `municipios` VALUES (4874,'TAPES','RS');
INSERT INTO `municipios` VALUES (4875,'TAPIRA','MG');
INSERT INTO `municipios` VALUES (4876,'TAPIRAÍ','MG');
INSERT INTO `municipios` VALUES (4877,'TAPIRAMUTA','BA');
INSERT INTO `municipios` VALUES (4878,'TAPIRATIBA','SP');
INSERT INTO `municipios` VALUES (4879,'TAPURAII','MT');
INSERT INTO `municipios` VALUES (4880,'TAQUARA','RS');
INSERT INTO `municipios` VALUES (4881,'TAQUARAÇU DE MINAS','MG');
INSERT INTO `municipios` VALUES (4882,'TAQUARAL','SP');
INSERT INTO `municipios` VALUES (4883,'TAQUARAL DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4884,'TAQUARI','RS');
INSERT INTO `municipios` VALUES (4885,'TAQUARITINGA','SP');
INSERT INTO `municipios` VALUES (4886,'TAQUARITINGA DO NORTE','PE');
INSERT INTO `municipios` VALUES (4887,'TAQUARITUBA','SP');
INSERT INTO `municipios` VALUES (4888,'TAQUARIVAÍ','SP');
INSERT INTO `municipios` VALUES (4889,'TAQUARUÇU DO SUL','RS');
INSERT INTO `municipios` VALUES (4890,'TAQUARUSSU','MS');
INSERT INTO `municipios` VALUES (4891,'TARABAI','SP');
INSERT INTO `municipios` VALUES (4892,'TARAUAÇA','AC');
INSERT INTO `municipios` VALUES (4893,'TARRAFAS','CE');
INSERT INTO `municipios` VALUES (4894,'TARTARUGALZINHO','AP');
INSERT INTO `municipios` VALUES (4895,'TARUMA','SP');
INSERT INTO `municipios` VALUES (4896,'TARUMIRIM','MG');
INSERT INTO `municipios` VALUES (4897,'TASSO FRAGOSO','MA');
INSERT INTO `municipios` VALUES (4898,'TATUI','SP');
INSERT INTO `municipios` VALUES (4899,'TAUA','CE');
INSERT INTO `municipios` VALUES (4900,'TAUBATE','SP');
INSERT INTO `municipios` VALUES (4901,'TAVARES','PB');
INSERT INTO `municipios` VALUES (4902,'TAVARES','RS');
INSERT INTO `municipios` VALUES (4903,'TEFÉ','AM');
INSERT INTO `municipios` VALUES (4904,'TEIXEIRA','PB');
INSERT INTO `municipios` VALUES (4905,'TEIXEIRA DE FREITAS','BA');
INSERT INTO `municipios` VALUES (4906,'TEIXEIRA SOARES','PR');
INSERT INTO `municipios` VALUES (4907,'TEIXEIRAS','MG');
INSERT INTO `municipios` VALUES (4908,'TEJUCUOCA','CE');
INSERT INTO `municipios` VALUES (4909,'TEJUPA','SP');
INSERT INTO `municipios` VALUES (4910,'TELEMACO BORBA','PR');
INSERT INTO `municipios` VALUES (4911,'TELHA','SE');
INSERT INTO `municipios` VALUES (4912,'TENENTE ANANIAS','RN');
INSERT INTO `municipios` VALUES (4913,'TENENTE LAURENTINO CRUZ','RN');
INSERT INTO `municipios` VALUES (4914,'TENENTE PORTELA','RS');
INSERT INTO `municipios` VALUES (4915,'TENÓRIO','PB');
INSERT INTO `municipios` VALUES (4916,'TEODORO SAMPAIO','BA');
INSERT INTO `municipios` VALUES (4917,'TEOFILÂNDIA','BA');
INSERT INTO `municipios` VALUES (4918,'TEOFILO OTONI','MG');
INSERT INTO `municipios` VALUES (4919,'TEOLÂNDIA','BA');
INSERT INTO `municipios` VALUES (4920,'TEOTÔNIO VILELA','AL');
INSERT INTO `municipios` VALUES (4921,'TERENOS','MS');
INSERT INTO `municipios` VALUES (4922,'TERESINA','PI');
INSERT INTO `municipios` VALUES (4923,'TERESINA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4924,'TERESÓPOLIS','RJ');
INSERT INTO `municipios` VALUES (4925,'TEREZINHA','PE');
INSERT INTO `municipios` VALUES (4926,'TEREZÓPOLIS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (4927,'TERRA ALTA','PA');
INSERT INTO `municipios` VALUES (4928,'TERRA BOA','PR');
INSERT INTO `municipios` VALUES (4929,'TERRA DE AREIA','RS');
INSERT INTO `municipios` VALUES (4930,'TERRA NOVA','BA');
INSERT INTO `municipios` VALUES (4931,'TERRA NOVA DO NORTE','MT');
INSERT INTO `municipios` VALUES (4932,'TERRA RICA','PR');
INSERT INTO `municipios` VALUES (4933,'TERRA ROXA','PR');
INSERT INTO `municipios` VALUES (4934,'TERRA SANTA','PA');
INSERT INTO `municipios` VALUES (4935,'TESOURO','MT');
INSERT INTO `municipios` VALUES (4936,'TEUTÔNIA','RS');
INSERT INTO `municipios` VALUES (4937,'THEOBROMA','RO');
INSERT INTO `municipios` VALUES (4938,'TIANGUA','CE');
INSERT INTO `municipios` VALUES (4939,'TIBAGI','PR');
INSERT INTO `municipios` VALUES (4940,'TIBAU','RN');
INSERT INTO `municipios` VALUES (4941,'TIBAU DO SUL','RN');
INSERT INTO `municipios` VALUES (4942,'TIETÊ','SP');
INSERT INTO `municipios` VALUES (4943,'TIGRINHOS','SC');
INSERT INTO `municipios` VALUES (4944,'TIJUCAS','SC');
INSERT INTO `municipios` VALUES (4945,'TIJUCAS DO SUL','PR');
INSERT INTO `municipios` VALUES (4946,'TIMBAUBA','PE');
INSERT INTO `municipios` VALUES (4947,'TIMBAUBA BATISTAS','RN');
INSERT INTO `municipios` VALUES (4948,'TIMBÉ DO SUL','SC');
INSERT INTO `municipios` VALUES (4949,'TIMBIRAS','MA');
INSERT INTO `municipios` VALUES (4950,'TIMBO','SC');
INSERT INTO `municipios` VALUES (4951,'TIMBO GRANDE','SC');
INSERT INTO `municipios` VALUES (4952,'TIMBURI','SP');
INSERT INTO `municipios` VALUES (4953,'TIMON','MA');
INSERT INTO `municipios` VALUES (4954,'TIMOTEO','MG');
INSERT INTO `municipios` VALUES (4955,'TIRADENTES','MG');
INSERT INTO `municipios` VALUES (4956,'TIRADENTES DO SUL','RS');
INSERT INTO `municipios` VALUES (4957,'TIROS','MG');
INSERT INTO `municipios` VALUES (4958,'TOBIAS BARRETO','SE');
INSERT INTO `municipios` VALUES (4959,'TOCANTINIA','TO');
INSERT INTO `municipios` VALUES (4960,'TOCANTINÓPOLIS','TO');
INSERT INTO `municipios` VALUES (4961,'TOCANTINS','MG');
INSERT INTO `municipios` VALUES (4962,'TOLEDO','MG');
INSERT INTO `municipios` VALUES (4963,'TOMAR DO GERU','SE');
INSERT INTO `municipios` VALUES (4964,'TOMAZINA','PR');
INSERT INTO `municipios` VALUES (4965,'TOMBOS','MG');
INSERT INTO `municipios` VALUES (4966,'TOMÉ-AÇU','PA');
INSERT INTO `municipios` VALUES (4967,'TONANTINS','AM');
INSERT INTO `municipios` VALUES (4968,'TORITAMA','PE');
INSERT INTO `municipios` VALUES (4969,'TORIXORÉU','MT');
INSERT INTO `municipios` VALUES (4970,'TOROPI','RS');
INSERT INTO `municipios` VALUES (4971,'TORRE DE PEDRA','SP');
INSERT INTO `municipios` VALUES (4972,'TORRES','RS');
INSERT INTO `municipios` VALUES (4973,'TORRINHA','SP');
INSERT INTO `municipios` VALUES (4974,'TOUROS','RN');
INSERT INTO `municipios` VALUES (4975,'TRABIJU','SP');
INSERT INTO `municipios` VALUES (4976,'TRACUATEUA','PA');
INSERT INTO `municipios` VALUES (4977,'TRAÇUNHAEM','PE');
INSERT INTO `municipios` VALUES (4978,'TRAIPU','AL');
INSERT INTO `municipios` VALUES (4979,'TRAIRÃO','PA');
INSERT INTO `municipios` VALUES (4980,'TRAIRI','CE');
INSERT INTO `municipios` VALUES (4981,'TRAJANO DE MORAES','RJ');
INSERT INTO `municipios` VALUES (4982,'TRAMANDAI','RS');
INSERT INTO `municipios` VALUES (4983,'TRAVESSEIRO','RS');
INSERT INTO `municipios` VALUES (4984,'TREMEDAL','BA');
INSERT INTO `municipios` VALUES (4985,'TREMEMBÉ','SP');
INSERT INTO `municipios` VALUES (4986,'TRÊS ARROIOS','RS');
INSERT INTO `municipios` VALUES (4987,'TRÊS BARRAS','SC');
INSERT INTO `municipios` VALUES (4988,'TRÊS BARRAS DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (4989,'TRÊS CACHOEIRAS','RS');
INSERT INTO `municipios` VALUES (4990,'TRÊS CORAÇÕES','MG');
INSERT INTO `municipios` VALUES (4991,'TRÊS COROAS','RS');
INSERT INTO `municipios` VALUES (4992,'TRÊS DE MAIO','RS');
INSERT INTO `municipios` VALUES (4993,'TRÊS FORQUILHAS','RS');
INSERT INTO `municipios` VALUES (4994,'TRÊS FRONTEIRAS','SP');
INSERT INTO `municipios` VALUES (4995,'TRÊS LAGOAS','MS');
INSERT INTO `municipios` VALUES (4996,'TRÊS MARIAS','MG');
INSERT INTO `municipios` VALUES (4997,'TRÊS PALMEIRAS','RS');
INSERT INTO `municipios` VALUES (4998,'TRÊS PASSOS','RS');
INSERT INTO `municipios` VALUES (4999,'TRÊS PONTAS','MG');
INSERT INTO `municipios` VALUES (5000,'TRÊS RANCHOS','GO');
INSERT INTO `municipios` VALUES (5001,'TRÊS RIOS','RJ');
INSERT INTO `municipios` VALUES (5002,'TREVISO','SC');
INSERT INTO `municipios` VALUES (5003,'TREZE DE MAIO','SC');
INSERT INTO `municipios` VALUES (5004,'TREZE TILIAS','SC');
INSERT INTO `municipios` VALUES (5005,'TRINDADE','GO');
INSERT INTO `municipios` VALUES (5006,'TRINDADE DO SUL','RS');
INSERT INTO `municipios` VALUES (5007,'TRIUNFO','PB');
INSERT INTO `municipios` VALUES (5008,'TRIUNFO POTIGUAR','RN');
INSERT INTO `municipios` VALUES (5009,'TRIZIDELA DO VALE','MA');
INSERT INTO `municipios` VALUES (5010,'TROMBAS','GO');
INSERT INTO `municipios` VALUES (5011,'TROMBUDO CENTRAL','SC');
INSERT INTO `municipios` VALUES (5012,'TUBARÃO','SC');
INSERT INTO `municipios` VALUES (5013,'TUCANO','BA');
INSERT INTO `municipios` VALUES (5014,'TUCUMA','PA');
INSERT INTO `municipios` VALUES (5015,'TUCUNDUVA','RS');
INSERT INTO `municipios` VALUES (5016,'TUCURUÍ','PA');
INSERT INTO `municipios` VALUES (5017,'TUFILÂNDIA','MA');
INSERT INTO `municipios` VALUES (5018,'TUIUTI','SP');
INSERT INTO `municipios` VALUES (5019,'TUMIRITINGA','MG');
INSERT INTO `municipios` VALUES (5020,'TUNÁPOLIS','SC');
INSERT INTO `municipios` VALUES (5021,'TUNAS','RS');
INSERT INTO `municipios` VALUES (5022,'TUNAS DO PARANÁ','PR');
INSERT INTO `municipios` VALUES (5023,'TUNEIRAS DO OESTE','PR');
INSERT INTO `municipios` VALUES (5024,'TUNTUM','MA');
INSERT INTO `municipios` VALUES (5025,'TUPA','SP');
INSERT INTO `municipios` VALUES (5026,'TUPACIGUARA','MG');
INSERT INTO `municipios` VALUES (5027,'TUPANATINGA','PE');
INSERT INTO `municipios` VALUES (5028,'TUPANCI DO SUL','RS');
INSERT INTO `municipios` VALUES (5029,'TUPANCIRETÃ','RS');
INSERT INTO `municipios` VALUES (5030,'TUPANDI','RS');
INSERT INTO `municipios` VALUES (5031,'TUPARENDI','RS');
INSERT INTO `municipios` VALUES (5032,'TUPARETAMA','PE');
INSERT INTO `municipios` VALUES (5033,'TUPASSI','PR');
INSERT INTO `municipios` VALUES (5034,'TUPI PAULISTA','SP');
INSERT INTO `municipios` VALUES (5035,'TUPIRAMA','TO');
INSERT INTO `municipios` VALUES (5036,'TUPIRATINS','TO');
INSERT INTO `municipios` VALUES (5037,'TURIAÇU','MA');
INSERT INTO `municipios` VALUES (5038,'TURILÂNDIA','MA');
INSERT INTO `municipios` VALUES (5039,'TURIÚBA','SP');
INSERT INTO `municipios` VALUES (5040,'TURMALINA','MG');
INSERT INTO `municipios` VALUES (5041,'TURMALINA','SP');
INSERT INTO `municipios` VALUES (5042,'TURUÇU','RS');
INSERT INTO `municipios` VALUES (5043,'TURURU','CE');
INSERT INTO `municipios` VALUES (5044,'TURVANIA','GO');
INSERT INTO `municipios` VALUES (5045,'TURVELÂNDIA','GO');
INSERT INTO `municipios` VALUES (5046,'TURVO','PR');
INSERT INTO `municipios` VALUES (5047,'TURVO','SC');
INSERT INTO `municipios` VALUES (5048,'TURVOLÂNDIA','MG');
INSERT INTO `municipios` VALUES (5049,'TUTOIA','MA');
INSERT INTO `municipios` VALUES (5050,'UARINI','AM');
INSERT INTO `municipios` VALUES (5051,'UAUÁ','BA');
INSERT INTO `municipios` VALUES (5052,'UBA','MG');
INSERT INTO `municipios` VALUES (5053,'UBAÍ','MG');
INSERT INTO `municipios` VALUES (5054,'UBAIRA','BA');
INSERT INTO `municipios` VALUES (5055,'UBAITABA','BA');
INSERT INTO `municipios` VALUES (5056,'UBAJARA','CE');
INSERT INTO `municipios` VALUES (5057,'UBAPORANGA','MG');
INSERT INTO `municipios` VALUES (5058,'UBARANA','SP');
INSERT INTO `municipios` VALUES (5059,'UBATÃ','BA');
INSERT INTO `municipios` VALUES (5060,'UBATUBA','SP');
INSERT INTO `municipios` VALUES (5061,'UBERABA','MG');
INSERT INTO `municipios` VALUES (5062,'UBERLÂNDIA','MG');
INSERT INTO `municipios` VALUES (5063,'UBIRAJARA','SP');
INSERT INTO `municipios` VALUES (5064,'UBIRATA','PR');
INSERT INTO `municipios` VALUES (5065,'UCHOA','SP');
INSERT INTO `municipios` VALUES (5066,'UIBAI','BA');
INSERT INTO `municipios` VALUES (5067,'UIRAPURU','GO');
INSERT INTO `municipios` VALUES (5068,'UIRAUNA','PB');
INSERT INTO `municipios` VALUES (5069,'ULIANÓPOLIS','PA');
INSERT INTO `municipios` VALUES (5070,'UMARI','CE');
INSERT INTO `municipios` VALUES (5071,'UMARIZAL','RN');
INSERT INTO `municipios` VALUES (5072,'UMBAUBA','SE');
INSERT INTO `municipios` VALUES (5073,'UMBURANAS','BA');
INSERT INTO `municipios` VALUES (5074,'UMBURATIBA','MG');
INSERT INTO `municipios` VALUES (5075,'UMBUZEIRO','PB');
INSERT INTO `municipios` VALUES (5076,'UMIRIM','CE');
INSERT INTO `municipios` VALUES (5077,'UMUARAMA','PR');
INSERT INTO `municipios` VALUES (5078,'UNA','BA');
INSERT INTO `municipios` VALUES (5079,'UNAI','MG');
INSERT INTO `municipios` VALUES (5080,'UNIÃO','PI');
INSERT INTO `municipios` VALUES (5081,'UNIÃO DA SERRA','RS');
INSERT INTO `municipios` VALUES (5082,'UNIÃO DA VITÓRIA','PR');
INSERT INTO `municipios` VALUES (5083,'UNIÃO DE MINAS','MG');
INSERT INTO `municipios` VALUES (5084,'UNIÃO DO OESTE','SC');
INSERT INTO `municipios` VALUES (5085,'UNIÃO DO SUL','MT');
INSERT INTO `municipios` VALUES (5086,'UNIÃO DOS PALMARES','AL');
INSERT INTO `municipios` VALUES (5087,'UNIÃO PAULISTA','SP');
INSERT INTO `municipios` VALUES (5088,'UNIFLOR','PR');
INSERT INTO `municipios` VALUES (5089,'UPANEMA','RN');
INSERT INTO `municipios` VALUES (5090,'URAI','PR');
INSERT INTO `municipios` VALUES (5091,'URANDI','BA');
INSERT INTO `municipios` VALUES (5092,'URANIA','SP');
INSERT INTO `municipios` VALUES (5093,'URBANO SANTOS','MA');
INSERT INTO `municipios` VALUES (5094,'URU','SP');
INSERT INTO `municipios` VALUES (5095,'URUAÇU','GO');
INSERT INTO `municipios` VALUES (5096,'URUANA','GO');
INSERT INTO `municipios` VALUES (5097,'URUANA DE MINAS','MG');
INSERT INTO `municipios` VALUES (5098,'URUARA','PA');
INSERT INTO `municipios` VALUES (5099,'URUBICI','SC');
INSERT INTO `municipios` VALUES (5100,'URUBURETAMA','CE');
INSERT INTO `municipios` VALUES (5101,'URUCÂNIA','MG');
INSERT INTO `municipios` VALUES (5102,'URUCARA','AM');
INSERT INTO `municipios` VALUES (5103,'URUÇUCA','BA');
INSERT INTO `municipios` VALUES (5104,'URUÇUÍ','PI');
INSERT INTO `municipios` VALUES (5105,'URUCUIA','MG');
INSERT INTO `municipios` VALUES (5106,'URUCURITUBA','AM');
INSERT INTO `municipios` VALUES (5107,'URUGUAIANA','RS');
INSERT INTO `municipios` VALUES (5108,'URUOCA','CE');
INSERT INTO `municipios` VALUES (5109,'URUPA','RO');
INSERT INTO `municipios` VALUES (5110,'URUPEMA','SC');
INSERT INTO `municipios` VALUES (5111,'URUPÊS','SP');
INSERT INTO `municipios` VALUES (5112,'URUSSANGA','SC');
INSERT INTO `municipios` VALUES (5113,'URUTAI','GO');
INSERT INTO `municipios` VALUES (5114,'UTINGA','BA');
INSERT INTO `municipios` VALUES (5115,'VACARIA','RS');
INSERT INTO `municipios` VALUES (5116,'VALE DO PARAISO','RO');
INSERT INTO `municipios` VALUES (5117,'VALE DO SOL','RS');
INSERT INTO `municipios` VALUES (5118,'VALE REAL','RS');
INSERT INTO `municipios` VALUES (5119,'VALE VERDE','RS');
INSERT INTO `municipios` VALUES (5120,'VALENCA','BA');
INSERT INTO `municipios` VALUES (5121,'VALENÇA','RJ');
INSERT INTO `municipios` VALUES (5122,'VALENCA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (5123,'VALENTE','BA');
INSERT INTO `municipios` VALUES (5124,'VALENTIM GENTIL','SP');
INSERT INTO `municipios` VALUES (5125,'VALINHOS','SP');
INSERT INTO `municipios` VALUES (5126,'VALPARAISO','GO');
INSERT INTO `municipios` VALUES (5127,'VANINI','RS');
INSERT INTO `municipios` VALUES (5128,'VARGEÃO','SC');
INSERT INTO `municipios` VALUES (5129,'VARGEM','SC');
INSERT INTO `municipios` VALUES (5130,'VARGEM','SP');
INSERT INTO `municipios` VALUES (5131,'VARGEM ALTA','ES');
INSERT INTO `municipios` VALUES (5132,'VARGEM BONITA','MG');
INSERT INTO `municipios` VALUES (5133,'VARGEM BONITA','SC');
INSERT INTO `municipios` VALUES (5134,'VARGEM GRANDE','MA');
INSERT INTO `municipios` VALUES (5135,'VARGEM GRANDE DO SUL','SP');
INSERT INTO `municipios` VALUES (5136,'VARGEM GRANDE PAULISTA','SP');
INSERT INTO `municipios` VALUES (5137,'VARGINHA','MG');
INSERT INTO `municipios` VALUES (5138,'VARJÃO','GO');
INSERT INTO `municipios` VALUES (5139,'VARJÃO DE MINAS','MG');
INSERT INTO `municipios` VALUES (5140,'VARJOTA','CE');
INSERT INTO `municipios` VALUES (5141,'VARRE-SAI','RJ');
INSERT INTO `municipios` VALUES (5142,'VÁRZEA','PB');
INSERT INTO `municipios` VALUES (5143,'VARZEA ALEGRE','CE');
INSERT INTO `municipios` VALUES (5144,'VARZEA BRANCA','PI');
INSERT INTO `municipios` VALUES (5145,'VÁRZEA DA PALMA','MG');
INSERT INTO `municipios` VALUES (5146,'VÁRZEA DA ROÇA','BA');
INSERT INTO `municipios` VALUES (5147,'VARZEA DO POÇO','BA');
INSERT INTO `municipios` VALUES (5148,'VARZEA GRANDE','MT');
INSERT INTO `municipios` VALUES (5149,'VARZEA NOVA','BA');
INSERT INTO `municipios` VALUES (5150,'VARZEA PAULISTA','SP');
INSERT INTO `municipios` VALUES (5151,'VARZEDO','BA');
INSERT INTO `municipios` VALUES (5152,'VARZELÂNDIA','MG');
INSERT INTO `municipios` VALUES (5153,'VASSOURAS','RJ');
INSERT INTO `municipios` VALUES (5154,'VAZANTE','MG');
INSERT INTO `municipios` VALUES (5155,'VENÂNCIO AIRES','RS');
INSERT INTO `municipios` VALUES (5156,'VENDA NOVA DO IMIGRANTE','ES');
INSERT INTO `municipios` VALUES (5157,'VENHA VER','RN');
INSERT INTO `municipios` VALUES (5158,'VENTANIA','PR');
INSERT INTO `municipios` VALUES (5159,'VENTUROSA','PE');
INSERT INTO `municipios` VALUES (5160,'VERA','MT');
INSERT INTO `municipios` VALUES (5161,'VERA CRUZ','BA');
INSERT INTO `municipios` VALUES (5162,'VERA CRUZ DO OESTE','PR');
INSERT INTO `municipios` VALUES (5163,'VERA MENDES','PI');
INSERT INTO `municipios` VALUES (5164,'VERANÓPOLIS','RS');
INSERT INTO `municipios` VALUES (5165,'VERDEJANTE','PE');
INSERT INTO `municipios` VALUES (5166,'VERDELÂNDIA','MG');
INSERT INTO `municipios` VALUES (5167,'VERE','PR');
INSERT INTO `municipios` VALUES (5168,'VEREDA','BA');
INSERT INTO `municipios` VALUES (5169,'VEREDINHA','MG');
INSERT INTO `municipios` VALUES (5170,'VERÍSSIMO','MG');
INSERT INTO `municipios` VALUES (5171,'VERTENTE DO LÉRIO','PE');
INSERT INTO `municipios` VALUES (5172,'VERTENTES','PE');
INSERT INTO `municipios` VALUES (5173,'VESPASIANO','MG');
INSERT INTO `municipios` VALUES (5174,'VESPASIANO CORREA','RS');
INSERT INTO `municipios` VALUES (5175,'VIADUTOS','RS');
INSERT INTO `municipios` VALUES (5176,'VIAMÃO','RS');
INSERT INTO `municipios` VALUES (5177,'VIANA','ES');
INSERT INTO `municipios` VALUES (5178,'VIANÓPOLIS','GO');
INSERT INTO `municipios` VALUES (5179,'VICENCIA','PE');
INSERT INTO `municipios` VALUES (5180,'VICENTE DUTRA','RS');
INSERT INTO `municipios` VALUES (5181,'VICENTINA','MS');
INSERT INTO `municipios` VALUES (5182,'VICENTINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (5183,'VICOSA','AL');
INSERT INTO `municipios` VALUES (5184,'VIÇOSA','MG');
INSERT INTO `municipios` VALUES (5185,'VICOSA DO CEARÁ','CE');
INSERT INTO `municipios` VALUES (5186,'VICTOR GRAEFF','RS');
INSERT INTO `municipios` VALUES (5187,'VIDAL RAMOS','SC');
INSERT INTO `municipios` VALUES (5188,'VIDEIRA','SC');
INSERT INTO `municipios` VALUES (5189,'VIEIRAS','MG');
INSERT INTO `municipios` VALUES (5190,'VIEIRÓPOLIS','PB');
INSERT INTO `municipios` VALUES (5191,'VIGIA','PA');
INSERT INTO `municipios` VALUES (5192,'ALTO PARAÍSO','PR');
INSERT INTO `municipios` VALUES (5193,'VILA BELA SS. TRINDADE','MT');
INSERT INTO `municipios` VALUES (5194,'VILA BOA','GO');
INSERT INTO `municipios` VALUES (5195,'VILA FLOR','RN');
INSERT INTO `municipios` VALUES (5196,'VILA FLORES','RS');
INSERT INTO `municipios` VALUES (5197,'VILA LANGARO','RS');
INSERT INTO `municipios` VALUES (5198,'VILA MARIA','RS');
INSERT INTO `municipios` VALUES (5199,'VILA NEWTON BELLO','MA');
INSERT INTO `municipios` VALUES (5200,'VILA NOVA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (5201,'VILA NOVA DO SUL','RS');
INSERT INTO `municipios` VALUES (5202,'VILA NOVA DOS MARTIRIOS','MA');
INSERT INTO `municipios` VALUES (5203,'VILA PAULINO NEVES','MA');
INSERT INTO `municipios` VALUES (5204,'VILA PAVAO','ES');
INSERT INTO `municipios` VALUES (5205,'VILA PROPICIO','GO');
INSERT INTO `municipios` VALUES (5206,'VILA RICA','MT');
INSERT INTO `municipios` VALUES (5207,'VILA VALERIO','ES');
INSERT INTO `municipios` VALUES (5208,'VILA VELHA','ES');
INSERT INTO `municipios` VALUES (5209,'VILHENA','RO');
INSERT INTO `municipios` VALUES (5210,'VINHEDO','SP');
INSERT INTO `municipios` VALUES (5211,'VIRADOURO','SP');
INSERT INTO `municipios` VALUES (5212,'VIRGEM DA LAPA','MG');
INSERT INTO `municipios` VALUES (5213,'VIRGINIA','MG');
INSERT INTO `municipios` VALUES (5214,'VIRGINÓPOLIS','MG');
INSERT INTO `municipios` VALUES (5215,'VIRGOLÂNDIA','MG');
INSERT INTO `municipios` VALUES (5216,'VIRMOND','PR');
INSERT INTO `municipios` VALUES (5217,'VISCONDE DO RIO BRANCO','MG');
INSERT INTO `municipios` VALUES (5218,'VISEU','PA');
INSERT INTO `municipios` VALUES (5219,'VISTA ALEGRE','RS');
INSERT INTO `municipios` VALUES (5220,'VISTA ALEGRE DO ALTO','SP');
INSERT INTO `municipios` VALUES (5221,'VISTA ALEGRE DO PRATA','RS');
INSERT INTO `municipios` VALUES (5222,'VISTA ALEGRE DO PRETA','RS');
INSERT INTO `municipios` VALUES (5223,'VISTA GAÚCHA','RS');
INSERT INTO `municipios` VALUES (5224,'VISTA SERRANA','PB');
INSERT INTO `municipios` VALUES (5225,'VITOR MEIRELES','SC');
INSERT INTO `municipios` VALUES (5226,'VITÓRIA','ES');
INSERT INTO `municipios` VALUES (5227,'VITÓRIA BRASIL','SP');
INSERT INTO `municipios` VALUES (5228,'VITÓRIA DA CONQUISTA','BA');
INSERT INTO `municipios` VALUES (5229,'VITÓRIA DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (5230,'VITÓRIA DE SANTO ANTÃO','PE');
INSERT INTO `municipios` VALUES (5231,'VITÓRIA DO JARI','AP');
INSERT INTO `municipios` VALUES (5232,'VITÓRIA DO MEARIM','MA');
INSERT INTO `municipios` VALUES (5233,'VITÓRIA DO XINGU','PA');
INSERT INTO `municipios` VALUES (5234,'VITORINO','PR');
INSERT INTO `municipios` VALUES (5235,'VITORINO FREIRE','MA');
INSERT INTO `municipios` VALUES (5236,'VOLTA GRANDE','MG');
INSERT INTO `municipios` VALUES (5237,'VOLTA REDONDA','RJ');
INSERT INTO `municipios` VALUES (5238,'VOTORANTIM','SP');
INSERT INTO `municipios` VALUES (5239,'VOTUPORANGA','SP');
INSERT INTO `municipios` VALUES (5240,'WAGNER','BA');
INSERT INTO `municipios` VALUES (5241,'WALL FERRAZ','PI');
INSERT INTO `municipios` VALUES (5242,'WANDERLÂNDIA','TO');
INSERT INTO `municipios` VALUES (5243,'WANDERLEY','BA');
INSERT INTO `municipios` VALUES (5244,'WENCESLAU BRAS','PR');
INSERT INTO `municipios` VALUES (5245,'WENCESLAU BRAZ','MG');
INSERT INTO `municipios` VALUES (5246,'WENCESLAU GUIMARAES','BA');
INSERT INTO `municipios` VALUES (5247,'WITMARSUN','SC');
INSERT INTO `municipios` VALUES (5248,'XAMBIOA','TO');
INSERT INTO `municipios` VALUES (5249,'XAMBRÊ','PR');
INSERT INTO `municipios` VALUES (5250,'XANGRI-LA','RS');
INSERT INTO `municipios` VALUES (5251,'XANXERÊ','SC');
INSERT INTO `municipios` VALUES (5252,'XAPURI','AC');
INSERT INTO `municipios` VALUES (5253,'XAVANTINA','SC');
INSERT INTO `municipios` VALUES (5254,'XAXIM','SC');
INSERT INTO `municipios` VALUES (5255,'XEXEU','PE');
INSERT INTO `municipios` VALUES (5256,'XINGUARA','PA');
INSERT INTO `municipios` VALUES (5257,'XIQUE XIQUE','BA');
INSERT INTO `municipios` VALUES (5258,'ZABELE','PB');
INSERT INTO `municipios` VALUES (5259,'ZACARIAS','SP');
INSERT INTO `municipios` VALUES (5260,'ZE DOCA','MA');
INSERT INTO `municipios` VALUES (5261,'ZORTÉA','SC');
INSERT INTO `municipios` VALUES (5262,'SÍTIO NOVO','RN');
INSERT INTO `municipios` VALUES (5263,'ALTO ALEGRE DO PINDARÉ','MA');
INSERT INTO `municipios` VALUES (5264,'VARGEM ALEGRE','MG');
INSERT INTO `municipios` VALUES (5265,'SANTANA','BA');
INSERT INTO `municipios` VALUES (5266,'TRINDADE','PE');
INSERT INTO `municipios` VALUES (5267,'BONITO DE MINAS','MG');
INSERT INTO `municipios` VALUES (5268,'JUVENÍLIA','MG');
INSERT INTO `municipios` VALUES (5269,'NOVA NAZARÉ','MT');
INSERT INTO `municipios` VALUES (5270,'ITAOCARA','RJ');
INSERT INTO `municipios` VALUES (5271,'CUJUBIM','RO');
INSERT INTO `municipios` VALUES (5272,'ARARUNA','PB');
INSERT INTO `municipios` VALUES (5273,'SÃO FRANCISCO','PB');
INSERT INTO `municipios` VALUES (5274,'MACURURÉ','BA');
INSERT INTO `municipios` VALUES (5275,'SÃO BENTINHO','PB');
INSERT INTO `municipios` VALUES (5276,'BARCARENA','PA');
INSERT INTO `municipios` VALUES (5277,'ITAJÁ','RN');
INSERT INTO `municipios` VALUES (5278,'MONTEVIDIO DO NORTE','GO');
INSERT INTO `municipios` VALUES (5279,'ENTRE RIOS','SC');
INSERT INTO `municipios` VALUES (5280,'SERRINHA','RN');
INSERT INTO `municipios` VALUES (5281,'IRATI ','SC');
INSERT INTO `municipios` VALUES (5282,'PALMEIRINA','PE');
INSERT INTO `municipios` VALUES (5283,'VALE DE SÃO DOMINGOS','MT');
INSERT INTO `municipios` VALUES (5284,'NOVO HORIZONTE','SC');
INSERT INTO `municipios` VALUES (5285,'ARAGUAINHA','MT');
INSERT INTO `municipios` VALUES (5286,'ACRELÂNDIA','AC');
INSERT INTO `municipios` VALUES (5287,'BOM JARDIM','PE');
INSERT INTO `municipios` VALUES (5288,'SÃO SEBASTIÃO DA VARGEM ALEGRE','MG');
INSERT INTO `municipios` VALUES (5289,'SANTA LUZIA DO PARUÁ','MA');
INSERT INTO `municipios` VALUES (5290,'SERRA NOVA DOURADA','MT');
INSERT INTO `municipios` VALUES (5291,'SANTA RITA DO TRIVELATO','MT');
INSERT INTO `municipios` VALUES (5292,'TAPEROÁ','PB');
INSERT INTO `municipios` VALUES (5293,'JACUÍPE','AL');
INSERT INTO `municipios` VALUES (5294,'BONITO','PE');
INSERT INTO `municipios` VALUES (5295,'SALGADINHO','PE');
INSERT INTO `municipios` VALUES (5296,'TAPURAH','MT');
INSERT INTO `municipios` VALUES (5297,'PARAGUAÇU','SP');
INSERT INTO `municipios` VALUES (5298,'SANTA TEREZINHA','PE');
INSERT INTO `municipios` VALUES (5299,'ALTO ALEGRE DO PARECIS','RO');
INSERT INTO `municipios` VALUES (5300,'PIÇARRA','PA');
INSERT INTO `municipios` VALUES (5301,'INDAIABIRA','MG');
INSERT INTO `municipios` VALUES (5302,'ABADIA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (5303,'IGRAPIÚNA','BA');
INSERT INTO `municipios` VALUES (5304,'IGRAPIÚNA','BA');
INSERT INTO `municipios` VALUES (5305,'VALE DO ANARI','RO');
INSERT INTO `municipios` VALUES (5306,'BOM JESUS DO ARAGUAIA','MT');
INSERT INTO `municipios` VALUES (5307,'VIÇOSA','AL');
INSERT INTO `municipios` VALUES (5308,'SATUBA','AL');
INSERT INTO `municipios` VALUES (5309,'FÁTIMA','TO');
INSERT INTO `municipios` VALUES (5310,'ÁGUA BRANCA','PI');
INSERT INTO `municipios` VALUES (5311,'ALTO ALEGRE','RR');
INSERT INTO `municipios` VALUES (5312,'RIACHÃO','PB');
INSERT INTO `municipios` VALUES (5313,'PENDÊNCIAS','RN');
INSERT INTO `municipios` VALUES (5314,'BARRA DE ALCÂNTARA','PI');
INSERT INTO `municipios` VALUES (5315,'SÃO DOMINGOS','GO');
INSERT INTO `municipios` VALUES (5316,'ESTÂNCIA TURÍSTICA DE JOANÓPOLIS','SP');
INSERT INTO `municipios` VALUES (5317,'RESERVA DO IGUAÇU','PR');
INSERT INTO `municipios` VALUES (5318,'IBOTIRAMA','BA');
INSERT INTO `municipios` VALUES (5319,'CAFELÂNDIA','SP');
INSERT INTO `municipios` VALUES (5320,'SANTA CRUZ DO XINGU','MT');
INSERT INTO `municipios` VALUES (5321,'BANDEIRANTE','SC');
INSERT INTO `municipios` VALUES (5322,'CANTAGALO','MG');
INSERT INTO `municipios` VALUES (5323,'ARAGUAIANA','MT');
INSERT INTO `municipios` VALUES (5324,'CAPINZAL DO NORTE','MA');
INSERT INTO `municipios` VALUES (5325,'MOREILÂNDIA','PE');
INSERT INTO `municipios` VALUES (5326,'LAGOA DO ITAENGA','PE');
INSERT INTO `municipios` VALUES (5327,'TEIXEIRÓPOLIS','RO');
INSERT INTO `municipios` VALUES (5328,'CARAÚBAS','RN');
INSERT INTO `municipios` VALUES (5329,'PAÇO DO LUMIAR','MA');
INSERT INTO `municipios` VALUES (5330,'BOM JESUS','PI');
INSERT INTO `municipios` VALUES (5331,'CARACOL ','PI');
INSERT INTO `municipios` VALUES (5332,'JAGUAPITÃ','PR');
INSERT INTO `municipios` VALUES (5333,'BELA VISTA DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (5334,'SANTANA DE MANGUEIRA','PB');
INSERT INTO `municipios` VALUES (5335,'BOA ESPERANÇA','MG');
INSERT INTO `municipios` VALUES (5336,'CANÁPOLIS','MG');
INSERT INTO `municipios` VALUES (5337,'ALAGOA','MG');
INSERT INTO `municipios` VALUES (5338,'CONCEIÇÃO DA APARECIDA','MG');
INSERT INTO `municipios` VALUES (5339,'CONGONHAS','MG');
INSERT INTO `municipios` VALUES (5340,'OURO BRANCO','MG');
INSERT INTO `municipios` VALUES (5341,'PINTÓPOLIS','MG');
INSERT INTO `municipios` VALUES (5342,'RESENDE COSTA','MG');
INSERT INTO `municipios` VALUES (5343,'SÃO JOSÉ DA LAPA','MG');
INSERT INTO `municipios` VALUES (5344,'SÃO JOSÉ DO DIVINO','MG');
INSERT INTO `municipios` VALUES (5345,'SAO CARLOS','SP');
INSERT INTO `municipios` VALUES (5346,'ANCHIETA','SC');
INSERT INTO `municipios` VALUES (5347,'IRAQUARA','BA');
INSERT INTO `municipios` VALUES (5348,'CRUZEIRO DO SUL','PR');
INSERT INTO `municipios` VALUES (5349,'ITAMBÉ','PR');
INSERT INTO `municipios` VALUES (5350,'SANTA INÊS','PR');
INSERT INTO `municipios` VALUES (5351,'MUNICÍPIO','RS');
INSERT INTO `municipios` VALUES (5354,'NOVA SANTA RITA','RS');
INSERT INTO `municipios` VALUES (5355,'LAGES','SC');
INSERT INTO `municipios` VALUES (5356,'SANTA MARIA','RS');
INSERT INTO `municipios` VALUES (5357,'MARECHAL THAUMATURGO','AC');
INSERT INTO `municipios` VALUES (5358,'SANTA ROSA DO PURUS','AC');
INSERT INTO `municipios` VALUES (5359,'ÁGUA BRANCA','AL');
INSERT INTO `municipios` VALUES (5360,'COLÔNIA LEOPOLDINA','AL');
INSERT INTO `municipios` VALUES (5361,'DELMIRO GOUVEIA','AL');
INSERT INTO `municipios` VALUES (5362,'IGACI','AL');
INSERT INTO `municipios` VALUES (5363,'JEQUIÁ DA PRAIA','AL');
INSERT INTO `municipios` VALUES (5364,'MAR VERMELHO','AL');
INSERT INTO `municipios` VALUES (5365,'MONTEIRÓPOLIS','AL');
INSERT INTO `municipios` VALUES (5366,'OLHO D\'ÁGUA GRANDE','AL');
INSERT INTO `municipios` VALUES (5367,'PINDOBA','AL');
INSERT INTO `municipios` VALUES (5368,'TAQUARANA','AL');
INSERT INTO `municipios` VALUES (5369,'CAREIRO','AM');
INSERT INTO `municipios` VALUES (5370,'GUAJARÁ','AM');
INSERT INTO `municipios` VALUES (5371,'SÃO GABRIEL DA CACHOEIRA','AM');
INSERT INTO `municipios` VALUES (5372,'AP','AP');
INSERT INTO `municipios` VALUES (5373,'CUTIAS','AP');
INSERT INTO `municipios` VALUES (5374,'BARROCAS','BA');
INSERT INTO `municipios` VALUES (5375,'CANDEAL','BA');
INSERT INTO `municipios` VALUES (5376,'CANDIBA','BA');
INSERT INTO `municipios` VALUES (5377,'ELÍSIO MEDRADO','BA');
INSERT INTO `municipios` VALUES (5378,'ENTRE RIOS','BA');
INSERT INTO `municipios` VALUES (5379,'GANDU','BA');
INSERT INTO `municipios` VALUES (5380,'GUANAMBI','BA');
INSERT INTO `municipios` VALUES (5381,'IBITITÁ','BA');
INSERT INTO `municipios` VALUES (5382,'JAGUARIPE','BA');
INSERT INTO `municipios` VALUES (5383,'JITAÚNA','BA');
INSERT INTO `municipios` VALUES (5384,'JUSSARA','BA');
INSERT INTO `municipios` VALUES (5385,'LAJE','BA');
INSERT INTO `municipios` VALUES (5386,'LIVRAMENTO DE NOSSA SENHORA','BA');
INSERT INTO `municipios` VALUES (5387,'LUÍS EDUARDO MAGALHÃES','BA');
INSERT INTO `municipios` VALUES (5388,'MARAGOGIPE','BA');
INSERT INTO `municipios` VALUES (5389,'MUQUÉM DE SÃO FRANCISCO','BA');
INSERT INTO `municipios` VALUES (5390,'PINDAÍ','BA');
INSERT INTO `municipios` VALUES (5391,'PIRITIBA','BA');
INSERT INTO `municipios` VALUES (5392,'SANTA CRUZ CABRÁLIA','BA');
INSERT INTO `municipios` VALUES (5393,'SANTALUZ','BA');
INSERT INTO `municipios` VALUES (5394,'SANTANÓPOLIS','BA');
INSERT INTO `municipios` VALUES (5395,'SANTA TERESINHA','BA');
INSERT INTO `municipios` VALUES (5396,'SÃO DOMINGOS','BA');
INSERT INTO `municipios` VALUES (5397,'SÃO JOSÉ DO JACUÍPE','BA');
INSERT INTO `municipios` VALUES (5398,'TANHAÇU','BA');
INSERT INTO `municipios` VALUES (5399,'XIQUE-XIQUE','BA');
INSERT INTO `municipios` VALUES (5400,'CAPISTRANO','CE');
INSERT INTO `municipios` VALUES (5401,'IBICUITINGA','CE');
INSERT INTO `municipios` VALUES (5402,'ITAPAGÉ','CE');
INSERT INTO `municipios` VALUES (5403,'JIJOCA DE JERICOACOARA','CE');
INSERT INTO `municipios` VALUES (5404,'MILAGRES','CE');
INSERT INTO `municipios` VALUES (5405,'CACHOEIRO DE ITAPEMIRIM','ES');
INSERT INTO `municipios` VALUES (5406,'CASTELO','ES');
INSERT INTO `municipios` VALUES (5407,'DIVINO DE SÃO LOURENÇO','ES');
INSERT INTO `municipios` VALUES (5408,'GOVERNADOR LINDENBERG','ES');
INSERT INTO `municipios` VALUES (5409,'PINHEIROS','ES');
INSERT INTO `municipios` VALUES (5410,'ABADIA DE GOI','GO');
INSERT INTO `municipios` VALUES (5411,'ABADIÂNIA','GO');
INSERT INTO `municipios` VALUES (5412,'ÁGUAS LINDAS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (5413,'BARRO ALTO','GO');
INSERT INTO `municipios` VALUES (5414,'CAMPOS BELOS','GO');
INSERT INTO `municipios` VALUES (5415,'DAVINÓPOLIS','GO');
INSERT INTO `municipios` VALUES (5416,'GAMELEIRA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (5417,'DIVINÓPOLIS DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (5418,'HIDROLÂNDIA','GO');
INSERT INTO `municipios` VALUES (5419,'IPIRANGA DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (5420,'LAGOA SANTA','GO');
INSERT INTO `municipios` VALUES (5421,'MORRINHOS','GO');
INSERT INTO `municipios` VALUES (5422,'MUNDO NOVO','GO');
INSERT INTO `municipios` VALUES (5423,'PIRANHAS','GO');
INSERT INTO `municipios` VALUES (5424,'SANTO ANTÔNIO DO DESCOBERTO','GO');
INSERT INTO `municipios` VALUES (5425,'SÃO MIGUEL DO PASSA QUATRO','GO');
INSERT INTO `municipios` VALUES (5426,'VALPARAÍSO DE GOIÁS','GO');
INSERT INTO `municipios` VALUES (5427,'AP DO MARANHÃO','MA');
INSERT INTO `municipios` VALUES (5428,'APICUM-AÇU','MA');
INSERT INTO `municipios` VALUES (5429,'ARARI','MA');
INSERT INTO `municipios` VALUES (5430,'BACABEIRA','MA');
INSERT INTO `municipios` VALUES (5431,'BARÃO DE GRAJAÚ','MA');
INSERT INTO `municipios` VALUES (5432,'BERNARDO DO MEARIM','MA');
INSERT INTO `municipios` VALUES (5433,'CONCEIÇÃO DO LAGO-AÇU','MA');
INSERT INTO `municipios` VALUES (5434,'GOVERNADOR EDISON LOBÃO','MA');
INSERT INTO `municipios` VALUES (5435,'GOVERNADOR LUIZ ROCHA','MA');
INSERT INTO `municipios` VALUES (5436,'GOVERNADOR NEWTON BELLO','MA');
INSERT INTO `municipios` VALUES (5437,'ITAPECURU MIRIM','MA');
INSERT INTO `municipios` VALUES (5438,'LAGOA DO MATO','MA');
INSERT INTO `municipios` VALUES (5439,'PERI MIRIM','MA');
INSERT INTO `municipios` VALUES (5440,'PINDARÉ-MIRIM','MA');
INSERT INTO `municipios` VALUES (5441,'PRESIDENTE DUTRA','MA');
INSERT INTO `municipios` VALUES (5442,'SANTA INÊS','MA');
INSERT INTO `municipios` VALUES (5443,'SÃO RAIMUNDO DAS MANGABEIRAS','MA');
INSERT INTO `municipios` VALUES (5444,'SÃO RAIMUNDO DO DOCA BEZERRA','MA');
INSERT INTO `municipios` VALUES (5445,'SÃO VICENTE FERRER','MA');
INSERT INTO `municipios` VALUES (5446,'SENADOR LA ROCQUE','MA');
INSERT INTO `municipios` VALUES (5447,'VIANA','MA');
INSERT INTO `municipios` VALUES (5448,'ABADIA DOS DOURADOS','MG');
INSERT INTO `municipios` VALUES (5449,'AMPARO DO SERRA','MG');
INSERT INTO `municipios` VALUES (5450,'CACHOEIRA DE PAJEÚ','MG');
INSERT INTO `municipios` VALUES (5451,'CACHOEIRA DOURADA','MG');
INSERT INTO `municipios` VALUES (5452,'CAMPESTRE','MG');
INSERT INTO `municipios` VALUES (5453,'CAMPO AZUL','MG');
INSERT INTO `municipios` VALUES (5454,'CANDEIAS','MG');
INSERT INTO `municipios` VALUES (5455,'CONCEIÇÃO DA BARRA DE MINAS','MG');
INSERT INTO `municipios` VALUES (5456,'CATAS ALTAS DA NORUEGA','MG');
INSERT INTO `municipios` VALUES (5457,'CÔNEGO MARINHO','MG');
INSERT INTO `municipios` VALUES (5458,'CÓRREGO FUNDO','MG');
INSERT INTO `municipios` VALUES (5459,'COUTO DE MAGALHÃES DE MINAS','MG');
INSERT INTO `municipios` VALUES (5460,'DONA EUSÉBIA','MG');
INSERT INTO `municipios` VALUES (5461,'FELISBURGO','MG');
INSERT INTO `municipios` VALUES (5462,'FORMOSO','MG');
INSERT INTO `municipios` VALUES (5463,'FREI LAGONEGRO','MG');
INSERT INTO `municipios` VALUES (5464,'FRUTA DE LEITE','MG');
INSERT INTO `municipios` VALUES (5465,'GOIABEIRA','MG');
INSERT INTO `municipios` VALUES (5466,'IGARAPÉ','MG');
INSERT INTO `municipios` VALUES (5467,'IMBÉ DE MINAS','MG');
INSERT INTO `municipios` VALUES (5468,'INDIANÓPOLIS','MG');
INSERT INTO `municipios` VALUES (5469,'ITABIRINHA','MG');
INSERT INTO `municipios` VALUES (5470,'JAPONVAR','MG');
INSERT INTO `municipios` VALUES (5471,'LUISBURGO','MG');
INSERT INTO `municipios` VALUES (5472,'LUISLÂNDIA','MG');
INSERT INTO `municipios` VALUES (5473,'NACIP RAYDAN','MG');
INSERT INTO `municipios` VALUES (5474,'NOVORIZONTE','MG');
INSERT INTO `municipios` VALUES (5475,'OLHOS-D\'ÁGUA','MG');
INSERT INTO `municipios` VALUES (5476,'ONÇA DE PITANGUI','MG');
INSERT INTO `municipios` VALUES (5477,'ORIZÂNIA','MG');
INSERT INTO `municipios` VALUES (5478,'PASSA-VINTE','MG');
INSERT INTO `municipios` VALUES (5479,'PATIS','MG');
INSERT INTO `municipios` VALUES (5480,'PATROCÍNIO DO MURIAÉ','MG');
INSERT INTO `municipios` VALUES (5481,'PEDRA BONITA','MG');
INSERT INTO `municipios` VALUES (5482,'PINGO-D\'ÁGUA','MG');
INSERT INTO `municipios` VALUES (5483,'PIUMHI','MG');
INSERT INTO `municipios` VALUES (5484,'PRESIDENTE JUSCELINO','MG');
INSERT INTO `municipios` VALUES (5485,'REDUTO','MG');
INSERT INTO `municipios` VALUES (5486,'SANTA BÁRBARA DO MONTE VERDE','MG');
INSERT INTO `municipios` VALUES (5487,'SANTA CRUZ DE MINAS','MG');
INSERT INTO `municipios` VALUES (5488,'SANTA HELENA DE MINAS','MG');
INSERT INTO `municipios` VALUES (5489,'SANTA LUZIA','MG');
INSERT INTO `municipios` VALUES (5490,'SANTA RITA DE IBITIPOCA','MG');
INSERT INTO `municipios` VALUES (5491,'SÃO BENTO ABADE','MG');
INSERT INTO `municipios` VALUES (5492,'SÃO GERALDO DO BAIXIO','MG');
INSERT INTO `municipios` VALUES (5493,'SÃO GONÇALO DO RIO ABAIXO','MG');
INSERT INTO `municipios` VALUES (5494,'SÃO JOÃO BATISTA DO GLÓRIA','MG');
INSERT INTO `municipios` VALUES (5495,'SÃO JOÃO DO PARAÍSO','MG');
INSERT INTO `municipios` VALUES (5496,'SÃO JOAQUIM DE BICAS','MG');
INSERT INTO `municipios` VALUES (5497,'SÃO SEBASTIÃO DA BELA VISTA','MG');
INSERT INTO `municipios` VALUES (5498,'SÃO SEBASTIÃO DO ANTA','MG');
INSERT INTO `municipios` VALUES (5499,'SÃO THOMÉ DAS LETRAS','MG');
INSERT INTO `municipios` VALUES (5500,'SEM-PEIXE','MG');
INSERT INTO `municipios` VALUES (5501,'SERRANÓPOLIS DE MINAS','MG');
INSERT INTO `municipios` VALUES (5502,'TOCOS DO MOJI','MG');
INSERT INTO `municipios` VALUES (5503,'VARGEM GRANDE DO RIO PARDO','MG');
INSERT INTO `municipios` VALUES (5504,'VERMELHO NOVO','MG');
INSERT INTO `municipios` VALUES (5505,'BATAYPORÃ','MS');
INSERT INTO `municipios` VALUES (5506,'BONITO','MS');
INSERT INTO `municipios` VALUES (5507,'DOURADINA','MS');
INSERT INTO `municipios` VALUES (5508,'FIGUEIRÃO','MS');
INSERT INTO `municipios` VALUES (5509,'JARDIM','MS');
INSERT INTO `municipios` VALUES (5510,'MUNDO NOVO','MS');
INSERT INTO `municipios` VALUES (5511,'SANTA RITA DO PARDO','MS');
INSERT INTO `municipios` VALUES (5512,'SÃO GABRIEL DO OESTE','MS');
INSERT INTO `municipios` VALUES (5513,'CANABRAVA DO NORTE','MT');
INSERT INTO `municipios` VALUES (5514,'CANARANA','MT');
INSERT INTO `municipios` VALUES (5515,'COLNIZA','MT');
INSERT INTO `municipios` VALUES (5516,'CONQUISTA D\'OESTE','MT');
INSERT INTO `municipios` VALUES (5517,'CURVELÂNDIA','MT');
INSERT INTO `municipios` VALUES (5518,'FIGUEIRÓPOLIS D\'OESTE','MT');
INSERT INTO `municipios` VALUES (5519,'IPIRANGA DO NORTE','MT');
INSERT INTO `municipios` VALUES (5520,'ITANHANGÁ','MT');
INSERT INTO `municipios` VALUES (5521,'LAMBARI D\'OESTE','MT');
INSERT INTO `municipios` VALUES (5522,'VILA BELA DA SANTÍSSIMA TRINDADE','MT');
INSERT INTO `municipios` VALUES (5523,'NOVA BANDEIRANTES','MT');
INSERT INTO `municipios` VALUES (5524,'NOVA SANTA HELENA','MT');
INSERT INTO `municipios` VALUES (5525,'NOVA UBIRATÃ','MT');
INSERT INTO `municipios` VALUES (5526,'NOVO SANTO ANTÔNIO','MT');
INSERT INTO `municipios` VALUES (5527,'RIO BRANCO','MT');
INSERT INTO `municipios` VALUES (5528,'SANTA TEREZINHA','MT');
INSERT INTO `municipios` VALUES (5529,'SANTO ANTÔNIO DO LESTE','MT');
INSERT INTO `municipios` VALUES (5530,'BONITO','PA');
INSERT INTO `municipios` VALUES (5531,'CONCEIÇÃO DO ARAGUAIA','PA');
INSERT INTO `municipios` VALUES (5532,'IGARAPÉ-MIRI','PA');
INSERT INTO `municipios` VALUES (5533,'ORIXIMINÁ','PA');
INSERT INTO `municipios` VALUES (5534,'BARRA DE SÃO MIGUEL','PB');
INSERT INTO `municipios` VALUES (5535,'CONDE','PB');
INSERT INTO `municipios` VALUES (5536,'MÃE D\'ÁGUA','PB');
INSERT INTO `municipios` VALUES (5537,'MULUNGU','PB');
INSERT INTO `municipios` VALUES (5538,'NOVA OLINDA','PB');
INSERT INTO `municipios` VALUES (5539,'PEDRA BRANCA','PB');
INSERT INTO `municipios` VALUES (5540,'PRATA','PB');
INSERT INTO `municipios` VALUES (5541,'QUEIMADAS','PB');
INSERT INTO `municipios` VALUES (5542,'RIACHÃO DO BACAMARTE','PB');
INSERT INTO `municipios` VALUES (5543,'SANTA CECÍLIA','PB');
INSERT INTO `municipios` VALUES (5544,'SANTA INÊS','PB');
INSERT INTO `municipios` VALUES (5545,'SANTA LUZIA','PB');
INSERT INTO `municipios` VALUES (5546,'SANTARÉM','PB');
INSERT INTO `municipios` VALUES (5547,'SANTA RITA','PB');
INSERT INTO `municipios` VALUES (5548,'SANTA TERESINHA','PB');
INSERT INTO `municipios` VALUES (5549,'SANTO ANDRÉ','PB');
INSERT INTO `municipios` VALUES (5550,'SÃO DOMINGOS','PB');
INSERT INTO `municipios` VALUES (5551,'CAMPO DE SANTANA','PB');
INSERT INTO `municipios` VALUES (5552,'BELÉM DO SÃO FRANCISCO','PE');
INSERT INTO `municipios` VALUES (5553,'CEDRO','PE');
INSERT INTO `municipios` VALUES (5554,'CONDADO','PE');
INSERT INTO `municipios` VALUES (5555,'FEIRA NOVA','PE');
INSERT INTO `municipios` VALUES (5556,'FERNANDO DE NORONHA','PE');
INSERT INTO `municipios` VALUES (5557,'GOIANA','PE');
INSERT INTO `municipios` VALUES (5558,'ITAMBÉ','PE');
INSERT INTO `municipios` VALUES (5559,'JATOBÁ','PE');
INSERT INTO `municipios` VALUES (5560,'LAGOA GRANDE','PE');
INSERT INTO `municipios` VALUES (5561,'PAULISTA','PE');
INSERT INTO `municipios` VALUES (5562,'SANTA CRUZ','PE');
INSERT INTO `municipios` VALUES (5563,'SÃO JOÃO','PE');
INSERT INTO `municipios` VALUES (5564,'TERRA NOVA','PE');
INSERT INTO `municipios` VALUES (5565,'TRIUNFO','PE');
INSERT INTO `municipios` VALUES (5566,'ALVORADA DO GURGUÉIA','PI');
INSERT INTO `municipios` VALUES (5567,'AROEIRAS DO ITAIM','PI');
INSERT INTO `municipios` VALUES (5568,'BARRA D\'ALCÂNTARA','PI');
INSERT INTO `municipios` VALUES (5569,'BATALHA','PI');
INSERT INTO `municipios` VALUES (5570,'CAPITÃO GERVÁSIO OLIVEIRA','PI');
INSERT INTO `municipios` VALUES (5571,'JARDIM DO MULATO','PI');
INSERT INTO `municipios` VALUES (5572,'JUREMA','PI');
INSERT INTO `municipios` VALUES (5573,'LAGOA DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (5574,'LUÍS CORREIA','PI');
INSERT INTO `municipios` VALUES (5575,'MURICI DOS PORTELAS','PI');
INSERT INTO `municipios` VALUES (5576,'NAZÁRIA','PI');
INSERT INTO `municipios` VALUES (5577,'PAU D\'ARCO DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (5578,'REDENÇÃO DO GURGUÉIA','PI');
INSERT INTO `municipios` VALUES (5579,'SANTA FILOMENA','PI');
INSERT INTO `municipios` VALUES (5580,'SANTA LUZ','PI');
INSERT INTO `municipios` VALUES (5581,'SÃO BRAZ DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (5582,'SÃO FRANCISCO DE ASSIS DO PIAUÍ','PI');
INSERT INTO `municipios` VALUES (5583,'SÃO JOSÉ DO DIVINO','PI');
INSERT INTO `municipios` VALUES (5584,'VÁRZEA GRANDE','PI');
INSERT INTO `municipios` VALUES (5585,'AGUDOS DO SUL','PR');
INSERT INTO `municipios` VALUES (5586,'ARAPUÃ','PR');
INSERT INTO `municipios` VALUES (5587,'BANDEIRANTES','PR');
INSERT INTO `municipios` VALUES (5588,'BOM JESUS DO SUL','PR');
INSERT INTO `municipios` VALUES (5589,'BOM SUCESSO DO SUL','PR');
INSERT INTO `municipios` VALUES (5590,'CAPANEMA','PR');
INSERT INTO `municipios` VALUES (5591,'CERRO AZUL','PR');
INSERT INTO `municipios` VALUES (5592,'DOUTOR CAMARGO','PR');
INSERT INTO `municipios` VALUES (5593,'FERNANDES PINHEIRO','PR');
INSERT INTO `municipios` VALUES (5594,'GENERAL CARNEIRO','PR');
INSERT INTO `municipios` VALUES (5595,'IGUATU','PR');
INSERT INTO `municipios` VALUES (5596,'IPORÃ','PR');
INSERT INTO `municipios` VALUES (5597,'ITAPEJARA D\'OESTE','PR');
INSERT INTO `municipios` VALUES (5598,'JAPURÁ','PR');
INSERT INTO `municipios` VALUES (5599,'LARANJAL','PR');
INSERT INTO `municipios` VALUES (5600,'LARANJEIRAS DO SUL','PR');
INSERT INTO `municipios` VALUES (5601,'NOVA AURORA','PR');
INSERT INTO `municipios` VALUES (5602,'NOVA FÁTIMA','PR');
INSERT INTO `municipios` VALUES (5603,'PÉROLA D\'OESTE','PR');
INSERT INTO `municipios` VALUES (5604,'PLANALTO','PR');
INSERT INTO `municipios` VALUES (5605,'RANCHO ALEGRE D\'OESTE','PR');
INSERT INTO `municipios` VALUES (5606,'SANTA CRUZ DE MONTE CASTELO','PR');
INSERT INTO `municipios` VALUES (5607,'SÃO JORGE D\'OESTE','PR');
INSERT INTO `municipios` VALUES (5608,'TAPIRA','PR');
INSERT INTO `municipios` VALUES (5609,'TOLEDO','PR');
INSERT INTO `municipios` VALUES (5610,'WENCESLAU BRAZ','PR');
INSERT INTO `municipios` VALUES (5611,'ARMAÇÃO DOS BÚZIOS','RJ');
INSERT INTO `municipios` VALUES (5612,'BOM JARDIM','RJ');
INSERT INTO `municipios` VALUES (5613,'BOM JESUS DO ITABAPOANA','RJ');
INSERT INTO `municipios` VALUES (5614,'ENGENHEIRO PAULO DE FRONTIN','RJ');
INSERT INTO `municipios` VALUES (5615,'MESQUITA','RJ');
INSERT INTO `municipios` VALUES (5616,'NOVA IGUAÇU','RJ');
INSERT INTO `municipios` VALUES (5617,'PB DO SUL','RJ');
INSERT INTO `municipios` VALUES (5618,'SÃO FRANCISCO DE ITABAPOANA','RJ');
INSERT INTO `municipios` VALUES (5619,'SÃO JOSÉ DO VALE DO RIO PRETO','RJ');
INSERT INTO `municipios` VALUES (5620,'AUGUSTO SEVERO','RN');
INSERT INTO `municipios` VALUES (5621,'BARAÚNA','RN');
INSERT INTO `municipios` VALUES (5622,'BOM JESUS','RN');
INSERT INTO `municipios` VALUES (5623,'BREJINHO','RN');
INSERT INTO `municipios` VALUES (5624,'CEARÁ-MIRIM','RN');
INSERT INTO `municipios` VALUES (5625,'PARNAMIRIM','RN');
INSERT INTO `municipios` VALUES (5626,'JANDAÍRA','RN');
INSERT INTO `municipios` VALUES (5627,'JANUÁRIO CICCO','RN');
INSERT INTO `municipios` VALUES (5628,'JARDIM DO SERIDÓ','RN');
INSERT INTO `municipios` VALUES (5629,'JUNDIÁ','RN');
INSERT INTO `municipios` VALUES (5630,'LAJES','RN');
INSERT INTO `municipios` VALUES (5631,'MONTE ALEGRE','RN');
INSERT INTO `municipios` VALUES (5632,'OLHO-D\'ÁGUA DO BORGES','RN');
INSERT INTO `municipios` VALUES (5633,'PEDRA PRETA','RN');
INSERT INTO `municipios` VALUES (5634,'PRESIDENTE JUSCELINO','RN');
INSERT INTO `municipios` VALUES (5635,'RIACHO DE SANTANA','RN');
INSERT INTO `municipios` VALUES (5636,'RUY BARBOSA','RN');
INSERT INTO `municipios` VALUES (5637,'SANTA CRUZ','RN');
INSERT INTO `municipios` VALUES (5638,'SÃO GONÇALO DO AMARANTE','RN');
INSERT INTO `municipios` VALUES (5639,'SÃO JOÃO DO SABUGI','RN');
INSERT INTO `municipios` VALUES (5640,'SÃO JOSÉ DO CAMPESTRE','RN');
INSERT INTO `municipios` VALUES (5641,'SÃO JOSÉ DO SERIDÓ','RN');
INSERT INTO `municipios` VALUES (5642,'SÃO MIGUEL DO GOSTOSO','RN');
INSERT INTO `municipios` VALUES (5643,'SÃO TOMÉ','RN');
INSERT INTO `municipios` VALUES (5644,'TIMBAÚBA DOS BATISTAS','RN');
INSERT INTO `municipios` VALUES (5645,'VÁRZEA','RN');
INSERT INTO `municipios` VALUES (5646,'VENHA-VER','RN');
INSERT INTO `municipios` VALUES (5647,'VERA CRUZ','RN');
INSERT INTO `municipios` VALUES (5648,'VIÇOSA','RN');
INSERT INTO `municipios` VALUES (5649,'ALTA FLORESTA D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5650,'CABIXI','RO');
INSERT INTO `municipios` VALUES (5651,'COLORADO DO OESTE','RO');
INSERT INTO `municipios` VALUES (5652,'ESPIGÃO D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5653,'MACHADINHO D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5654,'NOVA BRASILÂNDIA D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5655,'PRESIDENTE MÉDICI','RO');
INSERT INTO `municipios` VALUES (5656,'SANTA LUZIA D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5657,'ALVORADA D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5658,'ALTO ALEGRE DOS PARECIS','RO');
INSERT INTO `municipios` VALUES (5659,'GOVERNADOR JORGE TEIXEIRA','RO');
INSERT INTO `municipios` VALUES (5660,'ITAPUÃ DO OESTE','RO');
INSERT INTO `municipios` VALUES (5661,'MONTE NEGRO','RO');
INSERT INTO `municipios` VALUES (5662,'NOVA UNIÃO','RO');
INSERT INTO `municipios` VALUES (5663,'SÃO FELIPE D\'OESTE','RO');
INSERT INTO `municipios` VALUES (5664,'SÃO FRANCISCO DO GUAPORÉ','RO');
INSERT INTO `municipios` VALUES (5665,'UIRAMUTÃ','RR');
INSERT INTO `municipios` VALUES (5666,'ALMIRANTE TAMANDARÉ DO SUL','RS');
INSERT INTO `municipios` VALUES (5667,'BOA VISTA DO CADEADO','RS');
INSERT INTO `municipios` VALUES (5668,'BOA VISTA DO INCRA','RS');
INSERT INTO `municipios` VALUES (5669,'BOM JESUS','RS');
INSERT INTO `municipios` VALUES (5670,'BOZANO','RS');
INSERT INTO `municipios` VALUES (5671,'CAPÃO BONITO DO SUL','RS');
INSERT INTO `municipios` VALUES (5672,'CAPÃO DO CIPÓ','RS');
INSERT INTO `municipios` VALUES (5673,'COLINAS','RS');
INSERT INTO `municipios` VALUES (5674,'COLORADO','RS');
INSERT INTO `municipios` VALUES (5675,'CRUZALTENSE','RS');
INSERT INTO `municipios` VALUES (5676,'CRUZEIRO DO SUL','RS');
INSERT INTO `municipios` VALUES (5677,'ENTRE-IJUÍS','RS');
INSERT INTO `municipios` VALUES (5678,'FAZENDA VILANOVA','RS');
INSERT INTO `municipios` VALUES (5679,'FORQUETINHA','RS');
INSERT INTO `municipios` VALUES (5680,'HUMAITÁ','RS');
INSERT INTO `municipios` VALUES (5681,'INDEPENDÊNCIA','RS');
INSERT INTO `municipios` VALUES (5682,'ITATI','RS');
INSERT INTO `municipios` VALUES (5683,'JACUIZINHO','RS');
INSERT INTO `municipios` VALUES (5684,'LAGOA BONITA DO SUL','RS');
INSERT INTO `municipios` VALUES (5685,'MARAU','RS');
INSERT INTO `municipios` VALUES (5686,'MATO QUEIMADO','RS');
INSERT INTO `municipios` VALUES (5687,'NÃO-ME-TOQUE','RS');
INSERT INTO `municipios` VALUES (5688,'PAULO BENTO','RS');
INSERT INTO `municipios` VALUES (5689,'PEDRAS ALTAS','RS');
INSERT INTO `municipios` VALUES (5690,'PLANALTO','RS');
INSERT INTO `municipios` VALUES (5691,'QUATRO IRMÃOS','RS');
INSERT INTO `municipios` VALUES (5692,'ROLADOR','RS');
INSERT INTO `municipios` VALUES (5693,'SANTA CECÍLIA DO SUL','RS');
INSERT INTO `municipios` VALUES (5694,'SANTA CRUZ DO SUL','RS');
INSERT INTO `municipios` VALUES (5695,'SANTA MARGARIDA DO SUL','RS');
INSERT INTO `municipios` VALUES (5696,'SANT\'ANA DO LIVRAMENTO','RS');
INSERT INTO `municipios` VALUES (5697,'SANTO ANTÔNIO DA PATRULHA','RS');
INSERT INTO `municipios` VALUES (5698,'SÃO FRANCISCO DE PAULA','RS');
INSERT INTO `municipios` VALUES (5699,'SÃO GABRIEL','RS');
INSERT INTO `municipios` VALUES (5700,'SÃO JOSÉ DO SUL','RS');
INSERT INTO `municipios` VALUES (5701,'SP DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (5702,'SÃO PEDRO DAS MISSÕES','RS');
INSERT INTO `municipios` VALUES (5703,'SINIMBU','RS');
INSERT INTO `municipios` VALUES (5704,'SOLEDADE','RS');
INSERT INTO `municipios` VALUES (5705,'TAPEJARA','RS');
INSERT INTO `municipios` VALUES (5706,'TIO HUGO','RS');
INSERT INTO `municipios` VALUES (5707,'TRIUNFO','RS');
INSERT INTO `municipios` VALUES (5708,'UBIRETAMA','RS');
INSERT INTO `municipios` VALUES (5709,'UNISTALDA','RS');
INSERT INTO `municipios` VALUES (5710,'VERA CRUZ','RS');
INSERT INTO `municipios` VALUES (5711,'WESTFALIA','RS');
INSERT INTO `municipios` VALUES (5712,'ANTÔNIO CARLOS','SC');
INSERT INTO `municipios` VALUES (5713,'BALNEÁRIO ARROIO DO SILVA','SC');
INSERT INTO `municipios` VALUES (5714,'BELMONTE','SC');
INSERT INTO `municipios` VALUES (5715,'CAMPO ALEGRE','SC');
INSERT INTO `municipios` VALUES (5716,'CATANDUVAS','SC');
INSERT INTO `municipios` VALUES (5717,'CUNHA PORÃ','SC');
INSERT INTO `municipios` VALUES (5718,'FREI ROGÉRIO','SC');
INSERT INTO `municipios` VALUES (5719,'GRÃO PARÁ','SC');
INSERT INTO `municipios` VALUES (5720,'GUARACIABA','SC');
INSERT INTO `municipios` VALUES (5721,'IÇARA','SC');
INSERT INTO `municipios` VALUES (5722,'IPIRA','SC');
INSERT INTO `municipios` VALUES (5723,'ITAPIRANGA','SC');
INSERT INTO `municipios` VALUES (5724,'LUIZ ALVES','SC');
INSERT INTO `municipios` VALUES (5725,'MARAVILHA','SC');
INSERT INTO `municipios` VALUES (5726,'NOVA VENEZA','SC');
INSERT INTO `municipios` VALUES (5727,'OURO VERDE','SC');
INSERT INTO `municipios` VALUES (5728,'PALMEIRA','SC');
INSERT INTO `municipios` VALUES (5729,'PETROLÂNDIA','SC');
INSERT INTO `municipios` VALUES (5730,'BALNEÁRIO PIÇARRAS','SC');
INSERT INTO `municipios` VALUES (5731,'PINHALZINHO','SC');
INSERT INTO `municipios` VALUES (5732,'PRESIDENTE CASTELLO BRANCO','SC');
INSERT INTO `municipios` VALUES (5733,'SALTO VELOSO','SC');
INSERT INTO `municipios` VALUES (5734,'SANTA HELENA','SC');
INSERT INTO `municipios` VALUES (5735,'SANTA TEREZINHA','SC');
INSERT INTO `municipios` VALUES (5736,'SANTIAGO DO SUL','SC');
INSERT INTO `municipios` VALUES (5737,'SÃO JOÃO BATISTA','SC');
INSERT INTO `municipios` VALUES (5738,'SÃO JOÃO DO ITAPERIÚ','SC');
INSERT INTO `municipios` VALUES (5739,'SÃO LOURENÇO DO OESTE','SC');
INSERT INTO `municipios` VALUES (5740,'SÃO MARTINHO','SC');
INSERT INTO `municipios` VALUES (5741,'TANGARÁ','SC');
INSERT INTO `municipios` VALUES (5742,'WITMARSUM','SC');
INSERT INTO `municipios` VALUES (5743,'CANINDÉ DE SÃO FRANCISCO','SE');
INSERT INTO `municipios` VALUES (5744,'CAPELA','SE');
INSERT INTO `municipios` VALUES (5745,'CEDRO DE SÃO JOÃO','SE');
INSERT INTO `municipios` VALUES (5746,'GRACHO CARDOSO','SE');
INSERT INTO `municipios` VALUES (5747,'MONTE ALEGRE DE SERGIPE','SE');
INSERT INTO `municipios` VALUES (5748,'PACATUBA','SE');
INSERT INTO `municipios` VALUES (5749,'SÃO FRANCISCO','SE');
INSERT INTO `municipios` VALUES (5750,'ALTO ALEGRE','SP');
INSERT INTO `municipios` VALUES (5751,'APARECIDA D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5752,'ARCO-ÍRIS','SP');
INSERT INTO `municipios` VALUES (5753,'BARRA BONITA','SP');
INSERT INTO `municipios` VALUES (5754,'BOCAINA','SP');
INSERT INTO `municipios` VALUES (5755,'BORBOREMA','SP');
INSERT INTO `municipios` VALUES (5756,'CEDRAL','SP');
INSERT INTO `municipios` VALUES (5757,'ELDORADO','SP');
INSERT INTO `municipios` VALUES (5758,'ESTRELA D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5759,'ESTRELA DO NORTE','SP');
INSERT INTO `municipios` VALUES (5760,'FLORÍNIA','SP');
INSERT INTO `municipios` VALUES (5761,'GUAÍRA','SP');
INSERT INTO `municipios` VALUES (5762,'GUARACI','SP');
INSERT INTO `municipios` VALUES (5763,'GUARANI D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5764,'JABORANDI','SP');
INSERT INTO `municipios` VALUES (5765,'JARDINÓPOLIS','SP');
INSERT INTO `municipios` VALUES (5766,'JAÚ','SP');
INSERT INTO `municipios` VALUES (5767,'LUÍS ANTÔNIO','SP');
INSERT INTO `municipios` VALUES (5768,'LUIZIÂNIA','SP');
INSERT INTO `municipios` VALUES (5769,'MOJI MIRIM','SP');
INSERT INTO `municipios` VALUES (5770,'MONTE CASTELO','SP');
INSERT INTO `municipios` VALUES (5771,'PALMEIRA D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5772,'PALMITAL','SP');
INSERT INTO `municipios` VALUES (5773,'PITANGUEIRAS','SP');
INSERT INTO `municipios` VALUES (5774,'PLANALTO','SP');
INSERT INTO `municipios` VALUES (5775,'PRAIA GRANDE','SP');
INSERT INTO `municipios` VALUES (5776,'RIO CLARO','SP');
INSERT INTO `municipios` VALUES (5777,'SALTINHO','SP');
INSERT INTO `municipios` VALUES (5778,'SANTA BÁRBARA D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5779,'SANTA CLARA D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5780,'SANTA ISABEL','SP');
INSERT INTO `municipios` VALUES (5781,'SANTA RITA D\'OESTE','SP');
INSERT INTO `municipios` VALUES (5782,'SANTA ROSA DE VITERBO','SP');
INSERT INTO `municipios` VALUES (5783,'SÃO FRANCISCO','SP');
INSERT INTO `municipios` VALUES (5784,'SÃO JOÃO DO PAU D\'ALHO','SP');
INSERT INTO `municipios` VALUES (5785,'SÃO LUÍS DO PARAITINGA','SP');
INSERT INTO `municipios` VALUES (5786,'SÃO PEDRO','SP');
INSERT INTO `municipios` VALUES (5787,'SÃO SEBASTIÃO','SP');
INSERT INTO `municipios` VALUES (5788,'SÃO VICENTE','SP');
INSERT INTO `municipios` VALUES (5789,'SERTÃOZINHO','SP');
INSERT INTO `municipios` VALUES (5790,'TABATINGA','SP');
INSERT INTO `municipios` VALUES (5791,'TAPIRAÍ','SP');
INSERT INTO `municipios` VALUES (5792,'TEODORO SAMPAIO','SP');
INSERT INTO `municipios` VALUES (5793,'TERRA ROXA','SP');
INSERT INTO `municipios` VALUES (5794,'VALPARAÍSO','SP');
INSERT INTO `municipios` VALUES (5795,'VERA CRUZ','SP');
INSERT INTO `municipios` VALUES (5796,'ALVORADA','TO');
INSERT INTO `municipios` VALUES (5797,'ARAGUANÃ','TO');
INSERT INTO `municipios` VALUES (5798,'BANDEIRANTES DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (5799,'BOM JESUS DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (5800,'CACHOEIRINHA','TO');
INSERT INTO `municipios` VALUES (5801,'CENTENÁRIO','TO');
INSERT INTO `municipios` VALUES (5802,'CHAPADA DE AREIA','TO');
INSERT INTO `municipios` VALUES (5803,'CRISTALÂNDIA','TO');
INSERT INTO `municipios` VALUES (5804,'ESPERANTINA','TO');
INSERT INTO `municipios` VALUES (5805,'FILADÉLFIA','TO');
INSERT INTO `municipios` VALUES (5806,'IPUEIRAS','TO');
INSERT INTO `municipios` VALUES (5807,'LAJEADO','TO');
INSERT INTO `municipios` VALUES (5808,'MONTE SANTO DO TOCANTINS','TO');
INSERT INTO `municipios` VALUES (5809,'NATIVIDADE','TO');
INSERT INTO `municipios` VALUES (5810,'NAZARÉ','TO');
INSERT INTO `municipios` VALUES (5811,'NOVA OLINDA','TO');
INSERT INTO `municipios` VALUES (5812,'PARANÃ','TO');
INSERT INTO `municipios` VALUES (5813,'PAU D\'ARCO','TO');
INSERT INTO `municipios` VALUES (5814,'SÃO VALÉRIO','TO');
INSERT INTO `municipios` VALUES (5815,'TAIPAS DO TOCANTINS','TO');
/*!40000 ALTER TABLE `municipios` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table nfe_creditos
#

CREATE TABLE `nfe_creditos` (
  `codigo` int(11) NOT NULL auto_increment,
  `credito` float(5,2) default '0.00',
  `tipopessoa` varchar(4) default 'PFPJ',
  `issretido` varchar(3) default 'N',
  `valor` float(10,2) default '0.00',
  `estado` char(1) default 'A',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
INSERT INTO `nfe_creditos` VALUES (17,25,'PF','N',100000000,'A');
INSERT INTO `nfe_creditos` VALUES (18,25,'PF','S',100000000,'A');
INSERT INTO `nfe_creditos` VALUES (19,10,'PJ','S',100000000,'A');
INSERT INTO `nfe_creditos` VALUES (20,10,'PJ','N',100000000,'A');
/*!40000 ALTER TABLE `nfe_creditos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table notas
#

CREATE TABLE `notas` (
  `codigo` bigint(20) NOT NULL auto_increment,
  `numero` int(10) default NULL,
  `codverificacao` varchar(9) default NULL,
  `datahoraemissao` datetime default NULL,
  `codemissor` int(10) default NULL,
  `codtomador` int(11) default NULL,
  `rps_numero` varchar(20) default NULL,
  `rps_data` date default NULL,
  `tomador_nome` varchar(100) NOT NULL default '',
  `tomador_cnpjcpf` varchar(18) NOT NULL default '',
  `tomador_inscrmunicipal` varchar(20) default NULL,
  `tomador_inscrestadual` varchar(255) default NULL,
  `tomador_endereco` varchar(100) default NULL,
  `tomador_logradouro` varchar(80) default NULL,
  `tomador_numero` int(11) default NULL,
  `tomador_complemento` varchar(80) default NULL,
  `tomador_bairro` varchar(80) default NULL,
  `tomador_cep` varchar(9) default NULL,
  `tomador_municipio` varchar(100) default NULL,
  `tomador_uf` char(2) default NULL,
  `tomador_email` varchar(100) default NULL,
  `discriminacao` varchar(400) default NULL,
  `observacao` text,
  `valortotal` float(10,2) default NULL,
  `valordeducoes` float(10,2) default NULL,
  `valoracrescimos` float(10,2) default NULL,
  `basecalculo` float(10,2) default NULL,
  `valoriss` float(10,2) default NULL,
  `issretido` float(10,2) default NULL COMMENT 'Valor do iss retido',
  `valorinss` float(10,2) default NULL,
  `cofins` decimal(10,2) default NULL,
  `contribuicaosocial` decimal(10,2) default NULL,
  `aliqinss` float(10,2) default NULL,
  `valorirrf` float(10,2) default NULL,
  `aliqirrf` float(10,2) default NULL,
  `deducao_irrf` float(11,2) default NULL,
  `total_retencao` float(11,2) default NULL,
  `credito` float(10,2) default NULL,
  `pispasep` float(10,2) default NULL,
  `estado` varchar(20) default NULL COMMENT 'Estado da nfe, valores N  para normal, B boleto gerado, E nota escriturada',
  `tipoemissao` varchar(10) default 'online' COMMENT 'Tipo da nfe emitida, "online" ou "importada"',
  `motivo_cancelamento` text character set utf8,
  `aliq_percentual` float(10,2) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `emissor` (`codemissor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table notas_servicos
#

CREATE TABLE `notas_servicos` (
  `codigo` int(11) NOT NULL auto_increment,
  `codnota` int(11) default NULL,
  `codservico` bigint(11) default NULL,
  `basecalculo` float(10,2) default NULL,
  `issretido` float(10,2) default NULL,
  `iss` float(10,2) default NULL,
  `discriminacao` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `notas_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table notas_tomadas
#

CREATE TABLE `notas_tomadas` (
  `codigo` int(11) NOT NULL auto_increment,
  `numero` int(11) default NULL,
  `data` date default NULL,
  `codtomador` int(11) default NULL,
  `codprestador` int(11) default NULL,
  `codverificacao` varchar(10) default NULL,
  `total` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `issretido` decimal(10,2) default NULL,
  `estado` char(1) default 'N' COMMENT 'N = para normal e C = para cancelado',
  `motivo_cancelamento` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `notas_tomadas` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table notas_tomadas_servicos
#

CREATE TABLE `notas_tomadas_servicos` (
  `codigo` int(11) NOT NULL auto_increment,
  `codnota_tomada` int(11) default NULL,
  `codservico` bigint(20) default NULL,
  `basecalculo` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `issretido` decimal(10,2) default NULL,
  `discriminacao` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `notas_tomadas_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table noticias
#

CREATE TABLE `noticias` (
  `codigo` int(11) NOT NULL auto_increment,
  `titulo` varchar(100) default '',
  `texto` varchar(500) default NULL,
  `data` date default NULL,
  `sistema` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `noticias` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table obras
#

CREATE TABLE `obras` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `obra` varchar(100) default NULL,
  `alvara` varchar(20) default NULL,
  `iptu` varchar(20) default NULL,
  `endereco` varchar(100) default NULL,
  `proprietario` varchar(100) default NULL,
  `proprietario_cnpjcpf` char(18) default NULL,
  `dataini` date default NULL,
  `datafim` date default NULL,
  `listamateriais` text,
  `valormateriais` decimal(10,2) default NULL,
  `estado` char(1) default 'A' COMMENT 'A para aberto e C para concluido',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `obras` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table operadoras_creditos
#

CREATE TABLE `operadoras_creditos` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `codbanco` int(11) default NULL,
  `agencia` varchar(20) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `operadoras_creditos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table orgaospublicos
#

CREATE TABLE `orgaospublicos` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL COMMENT 'codigo do orgao publico',
  `admpublica` char(1) default NULL COMMENT 'D direta ou I indireta',
  `nivel` char(1) default NULL COMMENT 'M municipal, E estadual, F federal',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `orgaospublicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais
#

CREATE TABLE `processosfiscais` (
  `codigo` int(11) NOT NULL auto_increment,
  `codemissor` int(11) default NULL,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` char(4) default NULL,
  `abertura` char(1) default NULL COMMENT 'I para individual e G para geral',
  `data_abertura` date default NULL,
  `data_inicial` date default NULL,
  `data_final` date default NULL,
  `observacoes` text,
  `intimacao` char(1) default 'S' COMMENT 'N para não e S para Sim',
  `situacao` char(1) default 'A' COMMENT 'A para aberto e C para concluido',
  `cancelado` char(1) default 'N' COMMENT 'S para sim N para não',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_apreensoes
#

CREATE TABLE `processosfiscais_apreensoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` char(4) default NULL,
  `nroapreensao` int(11) default NULL,
  `anoapreensao` char(4) default NULL,
  `dataemissao` date default NULL,
  `observacoes` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_apreensoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_apreensoes_docs
#

CREATE TABLE `processosfiscais_apreensoes_docs` (
  `codigo` int(11) NOT NULL auto_increment,
  `codapreensao` varchar(11) default NULL,
  `coddoc` varchar(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_apreensoes_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_autuacoes
#

CREATE TABLE `processosfiscais_autuacoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `nroautuacao` int(11) default NULL,
  `anoautuacao` varchar(4) default NULL,
  `nroprocesso` varchar(10) default NULL,
  `anoprocesso` varchar(4) default NULL,
  `codinfracao` int(11) default NULL,
  `titulo` varchar(50) default NULL,
  `tiposervico` char(1) default 'P' COMMENT 'P para prestado e T para tomado',
  `historico` text,
  `obrigacao` char(1) default 'P' COMMENT 'P para principal e A para acessória',
  `reincidencia` char(1) default NULL COMMENT 'S ="sim, tem reicidencia" N ="nao tem reincidencia"',
  `quantidade` int(8) default NULL COMMENT 'quantidade de reincidencia',
  `multa` decimal(10,2) default NULL COMMENT 'porcentagem de multa',
  `valor` decimal(10,2) default '0.00',
  `nroparcelas` int(11) NOT NULL default '1' COMMENT 'Quantidade de parcelas',
  `situacao` char(1) default 'E' COMMENT 'E para emitido e N para não emitido',
  `cancelado` char(1) default 'A' COMMENT 'A para aberto C para cancelado',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Quantidade de parcelas';
/*!40000 ALTER TABLE `processosfiscais_autuacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_autuacoes_docs
#

CREATE TABLE `processosfiscais_autuacoes_docs` (
  `codigo` int(11) NOT NULL auto_increment,
  `codautuacao` varchar(10) default NULL,
  `coddoc` varchar(10) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_autuacoes_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_ciente_vencimento
#

CREATE TABLE `processosfiscais_ciente_vencimento` (
  `codigo` int(11) NOT NULL auto_increment,
  `codautuacao` int(11) default NULL,
  `dataciente` date default NULL,
  `datavencimento` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `processosfiscais_ciente_vencimento` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_competencias
#

CREATE TABLE `processosfiscais_competencias` (
  `codigo` int(11) NOT NULL auto_increment,
  `codautuacao` int(11) default NULL,
  `competencia` varchar(7) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='competencias sao as contas vencidas e nao pagas';
/*!40000 ALTER TABLE `processosfiscais_competencias` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_dividaativa
#

CREATE TABLE `processosfiscais_dividaativa` (
  `codigo` int(11) NOT NULL auto_increment,
  `codautuacao` varchar(11) default NULL,
  `nrodivida` int(11) default NULL,
  `anodivida` char(4) default NULL,
  `datainscricao` date default NULL,
  `datalimite` date default NULL,
  `observacoes` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_dividaativa` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_docs
#

CREATE TABLE `processosfiscais_docs` (
  `codigo` int(10) NOT NULL auto_increment,
  `nrodoc` varchar(50) default NULL,
  `descricao` varchar(200) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_fiscais
#

CREATE TABLE `processosfiscais_fiscais` (
  `codigo` int(11) NOT NULL auto_increment,
  `codprocesso` int(11) default NULL,
  `codfiscal` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `processosfiscais_fiscais` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_fundamentacaolegal
#

CREATE TABLE `processosfiscais_fundamentacaolegal` (
  `codigo` int(11) NOT NULL auto_increment,
  `incidencia` text,
  `dispositivoinfringido` text,
  `atualizacaomonetaria` text,
  `juros` text,
  `multa` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_fundamentacaolegal` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_guias
#

CREATE TABLE `processosfiscais_guias` (
  `codigo` int(11) NOT NULL auto_increment,
  `codautuacao` int(11) default NULL,
  `numero` int(11) default NULL,
  `valor` decimal(10,2) default NULL,
  `vencimento` date default NULL,
  `datacientificacao` date default NULL,
  `valorpago` decimal(10,2) default NULL,
  `situacao` char(1) default NULL COMMENT 'A para aberta e P para paga',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `processosfiscais_guias` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_homologacao
#

CREATE TABLE `processosfiscais_homologacao` (
  `codigo` int(11) NOT NULL auto_increment,
  `codservico` varchar(11) default NULL,
  `nrodoc` varchar(11) default NULL,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` char(4) default NULL,
  `situacao_tributo` char(1) default NULL COMMENT 'P para pago e N para nao pago',
  `valortotal` decimal(10,2) default NULL,
  `iss` decimal(10,2) default NULL,
  `issretido` decimal(10,2) default NULL,
  `deducao` decimal(10,2) default NULL,
  `lps` varchar(100) default NULL COMMENT 'Local da Prestacao de Servico',
  `competencia` date default NULL,
  `cpfcnpjtomador` varchar(25) default NULL,
  `cpfcnpjprestador` varchar(25) default NULL COMMENT 'informacao necessaria para os servicos tomados',
  `tipo` char(1) default NULL COMMENT 'P para servicos prestados e T para servicos tomados',
  `homologado` char(1) default 'N' COMMENT 'S para sim e N para nao',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_homologacao` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_infracoes
#

CREATE TABLE `processosfiscais_infracoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `nroinfracao` varchar(8) default NULL,
  `anoinfracao` int(4) default NULL,
  `tituloinfracao` text,
  `descricao` text,
  `fundamentacaolegal` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_infracoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_infracoes_fundamentacaolegal
#

CREATE TABLE `processosfiscais_infracoes_fundamentacaolegal` (
  `codigo` int(11) NOT NULL auto_increment,
  `codinfracoes` int(11) default NULL,
  `codfundamentacaolegal` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `processosfiscais_infracoes_fundamentacaolegal` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_intimacoes
#

CREATE TABLE `processosfiscais_intimacoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` varchar(4) default NULL,
  `nrointimacao` int(11) default NULL,
  `anointimacao` varchar(4) default NULL,
  `dataemissao` date default NULL,
  `prazo` int(3) default NULL,
  `situacao` char(1) default 'A' COMMENT 'A para aberto e C para concluido',
  `observacoes` text,
  `codlegislacao` int(11) default NULL,
  `cancelado` char(1) default 'N' COMMENT 'S para cancelado N para nao cancelado',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_intimacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_intimacoes_docs
#

CREATE TABLE `processosfiscais_intimacoes_docs` (
  `codigo` int(11) NOT NULL auto_increment,
  `codintimacao` int(11) default NULL,
  `coddoc` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `processosfiscais_intimacoes_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_prorrogacao
#

CREATE TABLE `processosfiscais_prorrogacao` (
  `codigo` int(11) NOT NULL auto_increment,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` char(4) default NULL,
  `nroprorrogacao` int(11) default NULL,
  `anoprorrogacao` char(4) default NULL,
  `dataemissao` date default NULL,
  `diasprorrogacao` char(3) default NULL,
  `dataprorrogada` date default NULL,
  `observacoes` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_prorrogacao` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_ted
#

CREATE TABLE `processosfiscais_ted` (
  `codigo` int(11) NOT NULL auto_increment,
  `nroted` int(11) default NULL,
  `anoted` char(4) default NULL,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` int(11) default NULL,
  `dataemissao` date default NULL,
  `observacoes` text,
  `situacao` char(1) default 'A' COMMENT 'A para aberto e C para concluido',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabela de registros do Termo de Entrega de Documentos';
/*!40000 ALTER TABLE `processosfiscais_ted` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_ted_docs
#

CREATE TABLE `processosfiscais_ted_docs` (
  `codigo` int(11) NOT NULL auto_increment,
  `codted` varchar(11) default NULL,
  `coddoc` varchar(11) default NULL,
  `estado` char(1) default 'P' COMMENT 'E para enviado e P para pendente e T para temporario',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `processosfiscais_ted_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_tif
#

CREATE TABLE `processosfiscais_tif` (
  `codigo` int(10) NOT NULL auto_increment,
  `codlegislacao` int(11) default NULL,
  `nrotif` int(11) default NULL,
  `anotif` varchar(4) default NULL,
  `nroprocesso` int(11) default NULL,
  `anoprocesso` varchar(4) default NULL,
  `codemissor` int(10) default NULL,
  `datainicial` date default NULL,
  `datafinal` date default NULL,
  `dias` int(5) default NULL,
  `observacoes` text,
  `intimacao` char(1) default 'S',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabela de registros do Termo de Inicio de Fiscalizacao';
/*!40000 ALTER TABLE `processosfiscais_tif` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table processosfiscais_tif_docs
#

CREATE TABLE `processosfiscais_tif_docs` (
  `codigo` int(10) NOT NULL auto_increment,
  `codtif` int(10) default NULL,
  `coddoc` int(10) default NULL,
  `estado` char(1) default 'E' COMMENT 'E para enviado e P para pendente',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
/*!40000 ALTER TABLE `processosfiscais_tif_docs` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table reclamacoes
#

CREATE TABLE `reclamacoes` (
  `codigo` int(10) NOT NULL auto_increment,
  `assunto` varchar(100) default NULL,
  `descricao` text,
  `especificacao` varchar(200) default '',
  `tomador_cnpj` varchar(20) default NULL,
  `tomador_email` varchar(200) default NULL,
  `rps_numero` varchar(100) default NULL,
  `rps_data` date default NULL,
  `rps_valor` float(10,2) default NULL,
  `emissor_cnpjcpf` varchar(200) default NULL,
  `datareclamacao` date default NULL,
  `estado` varchar(10) default NULL,
  `responsavel` varchar(100) default NULL,
  `dataatendimento` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40000 ALTER TABLE `reclamacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table rps_controle
#

CREATE TABLE `rps_controle` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `ultimorps` int(11) default '0',
  `limite` int(11) default '0',
  `ultimo_limite` int(11) default '0',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `rps_controle` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table rps_solicitacoes
#

CREATE TABLE `rps_solicitacoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `data` date default NULL,
  `estado` char(1) default NULL COMMENT 'A = aguardando, L = liberado, e R = recusado',
  `comunicado` char(1) default 'N' COMMENT 'N = para não e S = para sim',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
INSERT INTO `rps_solicitacoes` VALUES (1,1,'2011-11-28','C','N');
INSERT INTO `rps_solicitacoes` VALUES (2,1,'2011-11-28','A','N');
INSERT INTO `rps_solicitacoes` VALUES (3,2,'2011-11-28','A','N');
/*!40000 ALTER TABLE `rps_solicitacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table servicos
#

CREATE TABLE `servicos` (
  `codigo` bigint(11) NOT NULL auto_increment COMMENT 'Codigo do banco de dados para servicos',
  `codcategoria` int(11) default NULL,
  `codservico` varchar(200) default NULL COMMENT 'Codigo do servico pela prefeitura municipal',
  `descricao` text COMMENT 'Descricao do servico',
  `tipopessoa` varchar(10) default NULL COMMENT 'Tipo de pessoa PJ Pessoa Juridica PF Pessoa Fisica',
  `aliquota` float(10,2) default '0.00' COMMENT 'Porcentagem de aliquota para servicos',
  `aliquotair` float(10,2) default '0.00' COMMENT 'Porcentagem de aliquota para servicos com iss retido',
  `aliquotainss` float(10,2) default '0.00' COMMENT 'Porcentagem de aliquota de INSS',
  `aliquotairrf` float(10,2) default '0.00' COMMENT 'Porcentagem de aliq. Imposto de Renda Retido na Fonte',
  `basecalculo` float(10,2) default '0.00' COMMENT 'Base de calculo para ISS 0 igual ao preco servico',
  `incidencia` varchar(50) default 'mensal' COMMENT 'incidencia do periodo do iss padrao eh mensal',
  `valor_rpa` float(10,2) default '0.00',
  `datavenc` int(2) default NULL COMMENT 'Data de vencimento do iss por dia',
  `docfiscal` varchar(50) default NULL COMMENT 'Documento fiscal exigido',
  `estado` char(3) default NULL COMMENT 'Estado do servico, valores A ou I',
  PRIMARY KEY  (`codigo`),
  KEY `fkcategoria` (`codcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=10140096005 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
INSERT INTO `servicos` VALUES (10100010001,1,'10100010001','Outros','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010002,1,'10100010002','ADMINISTRADOR DE IMOVEIS','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010003,1,'10100010003','ADMINISTRADOR DE SEGUROS','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010004,1,'10100010004','ADVOGADO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010005,1,'10100010005','AEROFOTOGRAMETRIA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010006,1,'10100010006','ACUPUNTURISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010007,1,'10100010007','AGENTE DA PROPRIEDADE  ARTISTICA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010008,1,'10100010008','AGENTE DA  PROPRIEDADE  INDUSTRIAL','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010010,1,'10100010010','AGENTE DE EMPREGO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010012,1,'10100010012','AGENTE DE PUBLICIDADE','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010013,1,'10100010013','AGENTE DE TITULOS DE VALORES','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010014,1,'10100010014','AGENCIA DE TURISMO E VIAGEM','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010015,1,'10100010015','AGRIMENSOR','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010016,1,'10100010016','AGRONOMO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010017,1,'10100010017','ALFAIATE','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010018,1,'10100010018','AMESTRADOR, TRATADOR  DE ANIMAIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010019,1,'10100010019','AMOLADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010021,1,'10100010021','ARQUITETO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010022,1,'10100010022','ARTESAO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010023,1,'10100010023','ARTISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010024,1,'10100010024','ASSESSOR CADASTRAL','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010025,1,'10100010025','ASSESSOR DE MARKETING','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010026,1,'10100010026','ASSISTENTE SOCIAL','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010027,1,'10100010027','ASSISTENTE TECNICO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010029,1,'10100010029','ATUARIO CIA DE SEGUROS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010030,1,'10100010030','AUXILIAR DE ENFERMAGEM','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010031,1,'10100010031','AUXILIAR DE ESCRITORIO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010033,1,'10100010033','AVALIADOR','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010036,1,'10100010036','ASSESSOR ADMINISTRATIVO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010042,1,'10100010042','ATIVIDADE ESPORTIVA - FUTEBOL SETE','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010050,1,'10100010050','BAILARINO PROFISSIONAL','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010051,1,'10100010051','BARBEIRO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010052,1,'10100010052','BIBLIOTECONOMISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010053,1,'10100010053','BORDADEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010054,1,'10100010054','BORRACHEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010057,1,'10100010057','CALCETEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010058,1,'10100010058','CHAVEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010059,1,'10100010059','CABELEIREIRO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010060,1,'10100010060','CABELEIREIRA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010061,1,'10100010061','CARPINTEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010062,1,'10100010062','CARREGADOR (caixas,aves,animais,frutas)','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010063,1,'10100010063','COLETADOR DE MATERIAIS DE RECICLAGEM','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010064,1,'10100010064','CHAPEADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010065,1,'10100010065','CIRURGIAO DENTISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010066,1,'10100010066','COBRADOR COMISSIONADO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010067,1,'10100010067','ASSESSOR JORNALISTICO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010068,1,'10100010068','COLOCADOR DE AZULEJOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010069,1,'10100010069','COLOCADOR DE PARQUET','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010070,1,'10100010070','COLOCADOR DE PERSIANAS E ESQUADRIAS.','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010071,1,'10100010071','COLOCADOR DE VIDROS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010072,1,'10100010072','COLOCADOR E CONSERTADOR DE CORTINAS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010075,1,'10100010075','CONSERTADOR  DE APARELHO ELETRONICO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010076,1,'10100010076','CONSERTADOR DE BATERIAS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010077,1,'10100010077','CONSERTADOR DE BICICLETAS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010078,1,'10100010078','CONSERTADOR DE SAPATOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010079,1,'10100010079','CONSERTADOR DE ELETRODOMESTICOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010080,1,'10100010080','CONSERTADOR DE INSTRUMENTOS MUSICAIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010081,1,'10100010081','CONSERTADOR DE RELOGIOS/JOIAS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010082,1,'10100010082','CONSERTADOR DE MAQUINAS/PE€AS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010083,1,'10100010083','CONSERTADOR DE MOVEIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010084,1,'10100010084','CONSERTADOR DE OBJETOS DIVERSOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010085,1,'10100010085','CONSERTADOR DE RADIOS E TVs','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010086,1,'10100010086','CONSTRUTOR','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010087,1,'10100010087','CONTADOR','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010088,1,'10100010088','CORRETOR OFICIAL','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010089,1,'10100010089','CORRETOR DE IMOVEIS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010090,1,'10100010090','CORRETOR DE SEGUROS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010091,1,'10100010091','CORRETOR DE TITULOS IMOBILIARIOS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010092,1,'10100010092','CORRETOR DE VEICULOS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010094,1,'10100010094','COSTUREIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010096,1,'10100010096','CROCHETEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010097,1,'10100010097','CROMADOR NIQUELADOR','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010100,1,'10100010100','DATILOGRAFO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010101,1,'10100010101','DECORADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010102,1,'10100010102','DEPILADORA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010103,1,'10100010103','DESENHISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010104,1,'10100010104','DEDETIZADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010105,1,'10100010105','DESPACHANTE','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010106,1,'10100010106','DETETIVE','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010107,1,'10100010107','DISTRIBUIDOR DE GAS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010108,1,'10100010108','DISTRIBUIDOR DE JORNAIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010109,1,'10100010109','DOCEIRA/CONFEITEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010114,1,'10100010114','ELETRICISTA AUTOMOBILISTICO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010115,1,'10100010115','ECONOMISTA - ASSES. ECONOMICA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010116,1,'10100010116','ELETRICISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010117,1,'10100010117','ELETROTECNICO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010118,1,'10100010118','EMPREITEIRO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010119,1,'10100010119','ELETROMECANICA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010120,1,'10100010120','ENCADERNADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010121,1,'10100010121','ENCANADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010122,1,'10100010122','ENFERMEIRO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010123,1,'10100010123','ENGENHEIRO CIVIL','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010124,1,'10100010124','ENGENHEIRO ELETRICISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010125,1,'10100010125','ENGENHEIRO FLORESTAL','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010126,1,'10100010126','ENGENHEIRO MECANICO ELETRONICO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010127,1,'10100010127','ENGRAXATE','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010128,1,'10100010128','ENTREGADOR DE ENCOMENDA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010130,1,'10100010130','ESCULTOR','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010132,1,'10100010132','ESTATISTICO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010133,1,'10100010133','ESTENOGRAFO - TAQUIGRAFO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010134,1,'10100010134','ESTETICISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010135,1,'10100010135','ESTOFADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010136,1,'10100010136','ENCARREGADO DE OBRAS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010140,1,'10100010140','FARMACEUTICO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010141,1,'10100010141','DOMESTICA/FAXINEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010142,1,'10100010142','FERREIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010143,1,'10100010143','FIGURINISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010144,1,'10100010144','FISIOTERAPEUTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010145,1,'10100010145','FLORISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010146,1,'10100010146','FONOAUDIOLOGO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010147,1,'10100010147','FOTOCOPISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010148,1,'10100010148','FOTOGRAFO E FILMADOR','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010149,1,'10100010149','FUNILEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010150,1,'10100010150','FRETEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010159,1,'10100010159','GUINCHO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010160,1,'10100010160','GARCON','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010161,1,'10100010161','GEOGRAFO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010162,1,'10100010162','GEOLOGO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010163,1,'10100010163','QUIROPRAXIA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010164,1,'10100010164','GUIA DE TURISMO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010181,1,'10100010181','INSEMINADOR ARTIFICIAL','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010182,1,'10100010182','INSPETOR DE MAQUINAS E MOTORES','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010183,1,'10100010183','INSTALADOR DE ANTENAS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010184,1,'10100010184','INSTALADOR HIDRAULICO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010185,1,'10100010185','INSTRUTOR DE TRANSITO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010186,1,'10100010186','INSTRUTOR DE DEFESA PESSOAL','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010190,1,'10100010190','JARDINEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010192,1,'10100010192','JORNALEIRO, REVISTAS, LIVROS, PERIODICOS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010193,1,'10100010193','JORNALISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010194,1,'10100010194','JUIZ DE FUTEBOL','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010202,1,'10100010202','LAVADEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010203,1,'10100010203','LAVADOR DE VEICULOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010204,1,'10100010204','LEILOEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010205,1,'10100010205','LINOTIPISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010207,1,'10100010207','LIXADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010208,1,'10100010208','Locutor/Radialista','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010209,1,'10100010209','LUBRIFICADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010210,1,'10100010210','LUSTRADOR DE MOVEIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010220,1,'10100010220','MANEQUIN','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010221,1,'10100010221','MANICURE - PEDICURE','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010222,1,'10100010222','MAQUIADORA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010223,1,'10100010223','MARCENEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010224,1,'10100010224','MASSAGISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010226,1,'10100010226','MECANICO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010227,1,'10100010227','MEDICO','PJPF',0,0,0,0,409,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010229,1,'10100010229','MOTORISTA DE ONIBUS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010230,1,'10100010230','MOTORISTA DE CAMINHAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010231,1,'10100010231','MOTORISTA DE TAXI','PJPF',0,0,0,0,216,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010232,1,'10100010232','MUSICO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010233,1,'10100010233','MONTADOR DE MOVEIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010240,1,'10100010240','NUTRICIONISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010244,1,'10100010244','ODONTOLOGO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010247,1,'10100010247','OURIVES','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010248,1,'10100010248','ORIENTADOR DE GINASTICA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010250,1,'10100010250','PADEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010251,1,'10100010251','PARTEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010252,1,'10100010252','PEDREIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010253,1,'10100010253','PERFURADOR DE PO€OS ARTESIANOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010254,1,'10100010254','PERITO AVALIADOR','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010255,1,'10100010255','PESCADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010257,1,'10100010257','PINTOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010258,1,'10100010258','PINTOR  LETRISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010259,1,'10100010259','PINTOR DE VEICULOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010260,1,'10100010260','POLIDOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010262,1,'10100010262','PRODUTOR DE FILMES','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010263,1,'10100010263','PROFESSOR DE ATIV.  INSTITUTO BELEZA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010264,1,'10100010264','PROFESSOR','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010265,1,'10100010265','PROFESSOR DE CULINARIA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010266,1,'10100010266','PROFESSOR DE ARTESANATO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010267,1,'10100010267','PROFESSOR  CORTE E COSTURA E BORDADO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010268,1,'10100010268','PROFESSOR DE DANCAS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010269,1,'10100010269','PROFESSOR DE DATILOGRAFIA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010270,1,'10100010270','PROFESSOR DE EDUCACAO FISICA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010271,1,'10100010271','PROFESSOR DE IOGA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010272,1,'10100010272','PROFESSOR DE MAGIA PREDIGISTACAO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010273,1,'10100010273','PROFESSOR DE MUSICA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010274,1,'10100010274','PROGRAMADOR/TECNICO INFORMATICA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010275,1,'10100010275','PROJETOR DE FILMES SLAIDES','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010276,1,'10100010276','PROTETICO ODONTOLOGICO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010277,1,'10100010277','PSICOLOGO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010278,1,'10100010278','PUBLICISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010279,1,'10100010279','PROMOTOR DE EVENTOS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010280,1,'10100010280','PSICOPEDAGOGA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010290,1,'10100010290','QUIMICO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010300,1,'10100010300','RADIOLOGISTA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010302,1,'10100010302','RELACOES PUBLICAS','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010304,1,'10100010304','REPRESENTANTE COMERCIAL','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010305,1,'10100010305','SAPATEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010310,1,'10100010310','SECRETARIO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010311,1,'10100010311','SERIGRAFISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010312,1,'10100010312','SERRALHEIRO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010313,1,'10100010313','SOCIOLOGO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010316,1,'10100010316','SERRADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010317,1,'10100010317','SERVICOS GERAIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010319,1,'10100010319','SONORIZADOR E INSTALADOR DE SOM','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010320,1,'10100010320','TAXIDERMISTA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010321,1,'10100010321','TECNICO ELETRECISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010322,1,'10100010322','TATUADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010323,1,'10100010323','TECNICO EM CONTABILIDADE','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010325,1,'10100010325','TECNICO EM QUIMICA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010326,1,'10100010326','TECNICO EM RADIO E TV','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010327,1,'10100010327','TERAPIAS DE QUALQUER  ESPECIE','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010328,1,'10100010328','TERAPIA OCUPACIONAL','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010330,1,'10100010330','TOPOGRAFO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010331,1,'10100010331','TORNEIRO MECANICO','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010332,1,'10100010332','TRADUTOR INTERPRETE','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010333,1,'10100010333','TRANSPORTADOR MUNICIPAL','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010334,1,'10100010334','TRICOTEIRA','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010336,1,'10100010336','TECNICO AGRICOLA','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010338,1,'10100010338','TRATAMENTO E BANHO ESTETICOS DE ANIMAIS','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010340,1,'10100010340','URBANISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010344,1,'10100010344','VENDEDOR PLANOS DE SAUDE/PREVIDENCIARIO','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010345,1,'10100010345','VENDEDOR AUTONOMO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010346,1,'10100010346','VENDEDOR DE BILHETES/SAUDE/PREVIDENCI','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010348,1,'10100010348','VETERINARIO','PJPF',0,0,0,0,339,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010349,1,'10100010349','VIGILANTE','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010350,1,'10100010350','VITRINISTA','PJPF',0,0,0,0,244,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010351,1,'10100010351','VULCANIZADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100010355,1,'10100010355','ZELADOR','PJPF',0,0,0,0,150,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020001,1,'10100020001','ACONDICION.DE OPER. SIMIL. OBJ. DIVERSOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020002,1,'10100020002','ADMINISTRACAO DE BENS OU NEGOCIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020003,1,'10100020003','AEROFOTOGRAMETRIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020004,1,'10100020004','AGENCIA DE PUBLICIDADE CINEMATOGRAFICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020005,1,'10100020005','AGENCIA DE TURISMO E PASSEIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020006,1,'10100020006','AGENCIA LOTERICA','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020007,1,'10100020007','AGENCIA DE PROPRIEDADE  ARTISTICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020008,1,'10100020008','AGENCIA DE PROPRIEDADE  INDUSTRIAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020009,1,'10100020009','AGENCIAMENTO DE EMPREGOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020010,1,'10100020010','AGENCIAMENTO DE NAVIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020013,1,'10100020013','AGENCIA DE TITULOS DE VALORES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020014,1,'10100020014','ALFAIATARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020015,1,'10100020015','AMBULATORIO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020016,1,'10100020016','BANHO, TOSA E GUARDA DE  ANIMAIS','PJPF',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100020017,1,'10100020017','ARMAZENS FRIGORIFICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020019,1,'10100020019','ARMAZENS GERAIS E SILOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020020,1,'10100020020','SERV. CARGA E DESCARGA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020021,1,'10100020021','ASSISTENCIA AGRO-PECUARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020022,1,'10100020022','ASSISTENCIA TECNICA A SEGURADOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020023,1,'10100020023','ASSISTENCIA TECNICA, COMERCIAL E IND.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020024,1,'10100020024','ATELIER DE COSTURA DE CALCADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020025,1,'10100020025','AUDITORIA TECNICA, COMERCIAL E CONTABIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020026,1,'10100020026','ASSESSORIA E PLANEJAMENTO RURAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020027,1,'10100020027','SERVICOS  FOTOGRAFICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020028,1,'10100020028','ASSISTENCIA TECNICA EM MAQUINAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020029,1,'10100020029','ASSESSORIA E CONSULTORIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020030,1,'10100020030','ATELIER  DE COSTURA DE ART.VESTUARIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020031,1,'10100020031','CHAVEIRO E PRESTACAO DE CHAVEIRO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020039,1,'10100020039','BORRACHARIA, ALINHAMENTO E BALANCEAMENTO','PJ',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100020040,1,'10100020040','BANCO DE SANGUE','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020041,1,'10100020041','BANCOS (FINANCEIROS)','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020042,1,'10100020042','BARBEARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020043,1,'10100020043','BENEFICIAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020048,1,'10100020048','CRECHE COM OU SEM ALIMENTACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020049,1,'10100020049','COOPERATIVA DE PROFISSIONAIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020050,1,'10100020050','CAPTACAO INC.FISCAIS REFLORESTAMEN.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020051,1,'10100020051','CASA RECUPERACAO SOB ORIENTACAO MEDICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020052,1,'10100020052','CASA DE SAUDE E REPOUSO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020054,1,'10100020054','COLOCACAO E CONSERTO DE TAPETES, CORTINA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020055,1,'10100020055','AJARDINAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020056,1,'10100020056','COMPOSICAO GRAFICA, CLICHERIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020057,1,'10100020057','PRODUCAO MUSICAL','PJPF',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100020058,1,'10100020058','CONSTRUCAO CIVIL, SUBEMPREITEIRA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020059,1,'10100020059','CONSERTO E RESTAURACAO DE OBJETOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020060,1,'10100020060','CONSERVACAO, REP., EDIFICIO, ESTR.,PONTE','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020061,1,'10100020061','COPIAS DE DOCUMENTOS E PAPEIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020062,1,'10100020062','CORRETAGEM DE BENS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020063,1,'10100020063','CORRETAGEM DE SEGUROS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020064,1,'10100020064','CORRETAGEM INTERMEDICAO CAM.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020065,1,'10100020065','CURSO DE INFORMATICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020066,1,'10100020066','CONSTRUCAO DE JAZIGOS,TUMULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020067,1,'10100020067','CLINICA FISIOTERAPEUTA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020068,1,'10100020068','CORREIOS E TELEGRAFOS','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020069,1,'10100020069','CLINICA ODONTOLOGICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020070,1,'10100020070','PAISAGISMO E DECORACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020071,1,'10100020071','DEPOSITO DE QUALQUER NATUREZA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020072,1,'10100020072','DESINFECCAO,HIGIENIZACAO,DESRATIZACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020073,1,'10100020073','DISTRIBUIDORA  PRODUTOS FARMACEUTICO','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020074,1,'10100020074','DISTRIBUIDORA FILMES CINEMATOGRAFICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020075,1,'10100020075','DISTRIB.  E VENDA DE BILHETES E JOQUEI','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020076,1,'10100020076','DIVERSOES ELETRONICAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020077,1,'10100020077','DIVULGACAO DE EVENTOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020078,1,'10100020078','EDIFICACOES(RESIDENCIAIS,INDUSTRIAIS,COM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020079,1,'10100020079','ESTACAO RODOVIARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020080,1,'10100020080','ELABORACAO DESENHO ,TEXTO MAT.PUBLIC.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020081,1,'10100020081','EMPRESA DE FINANCIAMENTO E INVESTIM.','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020082,1,'10100020082','EMPRESA FUNERARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020083,1,'10100020083','ENCADERNACAO DE LIVROS, REVISTAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020084,1,'10100020084','ENGRAXATERIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020085,1,'10100020085','ENSINO DE QUALQUER NATUREZA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020086,1,'10100020086','EMPRESAS C/PARTICIPAÇÕES SOCIETARIAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020087,1,'10100020087','DESPACHANTE,ESCRITORIO DE  DESENHO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020088,1,'10100020088','ESTACIONAMENTO DE VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020089,1,'10100020089','ESTUDIO CINEMATOGRAFICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020090,1,'10100020090','ESTUDIO DE GRAVACAO VIDEO TAPES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020091,1,'10100020091','ESTUDIO FONOGRAFICO, SONS,DUBLAGEM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020092,1,'10100020092','EXPL.SERV.SANITARIO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020093,1,'10100020093','EXPOSICAO DE ARTES PLASTICAS,GALERIAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020095,1,'10100020095','EMPREITEIRA, LOCACAO DE MAO DE OBRA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020096,1,'10100020096','ESCRITORIO DE COBRANCAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020097,1,'10100020097','CONTADOR','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020098,1,'10100020098','ENGENHARIA-ARQUITETURA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020099,1,'10100020099','FISIOTERAPIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020100,1,'10100020100','FLORESTAMENTO/REFLORESTAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020103,1,'10100020103','ESCRITORIO P/REUNIAO','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020110,1,'10100020110','GALVANOPLASTIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020111,1,'10100020111','GINASTICA/DUCHAS/SAUNAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020113,1,'10100020113','GUARDA DE BENS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020114,1,'10100020114','GARAGEM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020117,1,'10100020117','CLINICA MEDICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020118,1,'10100020118','SERVICOS DE ENFERMAGEM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020119,1,'10100020119','SERVICOS MEDICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020120,1,'10100020120','COOPERATIVA MEDICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020121,1,'10100020121','HOTEIS E PENSOES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020122,1,'10100020122','SERVIÇOS DE FONOAUDIOLOGIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020123,1,'10100020123','SERVICOS DE NUTRICAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020124,1,'10100020124','SERV. LEVANTAMENTO IMOBILIARIO/CADASTRAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020125,1,'10100020125','SERVICO DE INSTRUCAO CONDUCAO VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020126,1,'10100020126','SERVICO DE CURSOS DE DANCAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020129,1,'10100020129','INCORPORADORA CONSTRUTORA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020130,1,'10100020130','INFORMACAO CONFIDENCIAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020131,1,'10100020131','EXTRACAO DE SAIBRO, ARENITO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020132,1,'10100020132','INSTALACAO E MONTAGEM DE APARELHOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020133,1,'10100020133','INSTITUTO DE BELEZA - ESTETICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020134,1,'10100020134','IMOBILIARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020135,1,'10100020135','SERVICOS DE ENSINO E TREINAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020136,1,'10100020136','SERVICOS DE MONTAGEM DE MOVEIS E MUDANCAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020140,1,'10100020140','PROMOCAO DE EVENTOS, FESTAS E DIVERSOES PUBLICAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020143,1,'10100020143','LOCADORA DE VIDEO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020144,1,'10100020144','LIMPEZA FOSSAS, ESGOTO, DEDETIZACAO...','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020145,1,'10100020145','LABORATORIO DE ANALISE CLINICA OTICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020146,1,'10100020146','LAVANDERIA E TINTURARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020147,1,'10100020147','LEILOEIRO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020148,1,'10100020148','LIMPEZA DE IMOVEIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020150,1,'10100020150','LUBRIFICACAO, LIMPEZA E REVISAO MAQUIN.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020151,1,'10100020151','LIXACAO E LUSTR. DE ASSOALHOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020152,1,'10100020152','LAVAGEM DE VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020154,1,'10100020154','LOCACAO DE BENS MOVEIS','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020155,1,'10100020155','ORGANIZACAO DE FESTAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020157,1,'10100020157','ORGANIZACAO DE FEIRAS E CONGRESSOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020158,1,'10100020158','CONSERTO DE RADIOS E ELETRODOMESTICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020159,1,'10100020159','PERFURACAO DE POCOS ARTESIANOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020160,1,'10100020160','PERITAGEM DE SINISTROS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020161,1,'10100020161','PINTURA DE OBJETOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020162,1,'10100020162','PINTURA  EM  GERAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020163,1,'10100020163','PRESTACAO ASSISTENCIA SOCIAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020164,1,'10100020164','PRESTACAO SERVICOS FIANCA ,AVAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020165,1,'10100020165','DISTRIBUIDORA DE ENERGIA ELETRICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020166,1,'10100020166','GUINCHO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020168,1,'10100020168','PRESTACAO SERVICOS TORNEARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020170,1,'10100020170','PROJETOS,CALCULOS,MAQUETES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020171,1,'10100020171','PROMOCAO E DIVULGACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020172,1,'10100020172','OFICINA DE PROTESES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020173,1,'10100020173','PAVIMENTACAO E CALCAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020174,1,'10100020174','PULVERIZACAO AGRICOLA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020176,1,'10100020176','LEITURA MEDIDOR ENERGIA ELETRICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020177,1,'10100020177','RADIOLOGIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020178,1,'10100020178','LIMPEZA E CONS PREDIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020179,1,'10100020179','ELETRICIDADE VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020181,1,'10100020181','RECAUCHUTAGEM PNEUS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020182,1,'10100020182','OFICINA MECANICA / CHAPEACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020183,1,'10100020183','RELACOES PUBLICAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020184,1,'10100020184','REPRESENTACAO COMERCIAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020185,1,'10100020185','OF.MEC.MAQUIN.E MOTORES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020186,1,'10100020186','SALAO DE BAILE','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020187,1,'10100020187','SAUNA E MUSCULACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020188,1,'10100020188','SERIGRAFIA ESTAMPARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020189,1,'10100020189','SERV. INFORMATICA E INTERNET','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020190,1,'10100020190','SALVAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020191,1,'10100020191','SANATORIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020192,1,'10100020192','ASSESSORAMENTO IMPRENSA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020193,1,'10100020193','ANODIZACAO ALUMINIO METAIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020194,1,'10100020194','SERVICOS REGIS. PUBL.CARTOR.E NOTARIAIS','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020195,1,'10100020195','INSEMINACAO ARTIFICIAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020196,1,'10100020196','SERVICOS TEC DE AVALIACA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020197,1,'10100020197','SINALIZACAO DE TRANSITO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020198,1,'10100020198','SERVICOS DE RADIOFUSAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020199,1,'10100020199','SERVICOS ADVOCATICIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020200,1,'10100020200','TRADUCOES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020201,1,'10100020201','SINDICATO SERVIDORES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020202,1,'10100020202','SERV. SAUDE PUBLICA/HOSPITALAR E  AMBULA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020203,1,'10100020203','TREINAMENTO E SELECAO DE PESSOAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020204,1,'10100020204','TRANSPORTE DE CARGAS INTERMUNICIPAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020205,1,'10100020205','TRANSPORTE DE PASSAGEIRO','PJPF',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100020206,1,'10100020206','SERVICOS MANEJO ANIMAIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020207,1,'10100020207','TEATRO,MUSICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020208,1,'10100020208','TERRAPLANAGEM,ESCAVACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020209,1,'10100020209','ULTRASONOGRAFIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020210,1,'10100020210','URBANIZACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020211,1,'10100020211','TREINAMENTO DE INFORMATICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020212,1,'10100020212','TELECOMUNICACOES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020213,1,'10100020213','TRANSPORTE CARGAS MUNICIPAIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100020215,1,'10100020215','VIGILANCIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100021069,1,'10100021069','SOCIEDADE CIVIL DE DENTISTAS','PJPF',0,0,0,0,663,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100021097,1,'10100021097','SOCIEDADE CIVIL CONTABILIDADE','PJPF',0,0,0,0,663,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100021118,1,'10100021118','SOCIEDADE CIVIL ENFERMAGEM','PJPF',0,0,0,0,663,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100021119,1,'10100021119','SOCIEDADE CIVIL MEDICOS','PJPF',0,0,0,0,663,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100021199,1,'10100021199','SOCIEDADE CIVIL DE ADVOGADOS','PJPF',0,0,0,0,663,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022003,1,'10100022003','AEROFOTOGRAMETRIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022055,1,'10100022055','AJARDINAMENTO - CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022058,1,'10100022058','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022066,1,'10100022066','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022070,1,'10100022070','PAISAGISMO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022078,1,'10100022078','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022095,1,'10100022095','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022098,1,'10100022098','ENGENHARIA,ARQUITETURA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022129,1,'10100022129','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022159,1,'10100022159','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022170,1,'10100022170','PROJETOS,MAQUETES,DESEN','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022173,1,'10100022173','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022204,1,'10100022204','LOCACAO MAQ.CAMINHAO,TERRAPLENAGE','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100022208,1,'10100022208','SERVICOS CONSTRUCAO CIVIL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100023041,1,'10100023041','BANCOS(LEASING)','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100023111,1,'10100023111','EXPLORACAO DE FLIPERAMAS E JOGOS ELETRON','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100023129,1,'10100023129','INCORPORADORA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024001,1,'10100024001','SERV. PROVENIENTE EXTERIOR','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024002,1,'10100024002','ANDAIMES,PALCOS,COBERTURAS','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024003,1,'10100024003','CONSTRUCAO CIVIL -  ITEM 7.02','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024004,1,'10100024004','ENGENHARIA,ARQUITETURA,URBANISMO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024005,1,'10100024005','DEMOLICAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024006,1,'10100024006','REPARACAO,CONSERVACAO,REFORMA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024007,1,'10100024007','LIXO - VARRICAO,COLETA,DESTINACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024008,1,'10100024008','LIMPEZA, MANUTENCAO, CONSERVACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024009,1,'10100024009','DECORACAO E JARDINAGEM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024010,1,'10100024010','CONTROLE E TRATAM.DO AFLUENTE','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024011,1,'10100024011','FLORESTAM.,REFLOREST.,SEMEADURA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024012,1,'10100024012','ESCORAMENTO, CONTENCAO ENCOSTAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024013,1,'10100024013','LIMPEZA E DRAGAGEM DE RIOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024014,1,'10100024014','GUARDA  ESTACIONAMENTO DE VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024015,1,'10100024015','VIGIA, SEGURANCA E MONITORAMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024016,1,'10100024016','ARMAZENAMENTO,DEPOSITO,CARGA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024017,1,'10100024017','DIVERSAO, LAZER E ENTRETENIMENTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024018,1,'10100024018','TRANSPORTE DE NATUREZA MUNICIPAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024019,1,'10100024019','FORNECIMENTO DE MAO-DE-OBRA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100024020,1,'10100024020','FEIRA, EXPOSICAO, CONGRESSO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030001,1,'10100030001','ACOUGUE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030002,1,'10100030002','APICULTURA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030003,1,'10100030003','ARMAZEM','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030004,1,'10100030004','ARTESANATO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030005,1,'10100030005','COM. ATAC. GERAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030006,1,'10100030006','ABATEDOURO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030007,1,'10100030007','COM. DE ANTENAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030008,1,'10100030008','BAR NOTURNO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030009,1,'10100030009','BAR','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030010,1,'10100030010','BAR, LANCHERIA, SORVETERIA','PJPF',0,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100030011,1,'10100030011','BAZAR','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030012,1,'10100030012','BAR E RESTAURANTE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030013,1,'10100030013','BOMBONIERE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030014,1,'10100030014','BRIC A BRAC','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030015,1,'10100030015','COM. EM GERAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030016,1,'10100030016','COM. DE ACESS. E COMPLEMENTOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030017,1,'10100030017','COM. DE ART. DESPORTIVO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030018,1,'10100030018','LANCHERIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030019,1,'10100030019','PIZZARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030020,1,'10100030020','CHURRASCARIA LANCHERIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030021,1,'10100030021','COM. DE ACO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030022,1,'10100030022','COM. DE ACO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030023,1,'10100030023','COM. DE APAR. DE PRECISAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030024,1,'10100030024','COM. DE APAR. E MAT. DE OTICA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030025,1,'10100030025','COM. DE APAR. ELETRICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030026,1,'10100030026','COM. DE APAR. INST. CIRURGICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030027,1,'10100030027','COM. DE ARMARINHO E MIU','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030028,1,'10100030028','COM. DE ARMAS E MUNICOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030029,1,'10100030029','COM. DE ART. DE FERRO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030030,1,'10100030030','COM. DE ART. DE GESSO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030031,1,'10100030031','COM. DE ART. DE PLASTICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030032,1,'10100030032','COM. DE ART. DE BORRACH','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030033,1,'10100030033','COM. DE ART. DE CACA E PESCA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030034,1,'10100030034','COM. DE ART. DE COURO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030035,1,'10100030035','COM. DE ART. DO VESTUARIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030036,1,'10100030036','COM. DE PROD. ELETRO. AUTOMOTIVOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030037,1,'10100030037','COM. DE ART. PARA DECOR. FLORES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030038,1,'10100030038','COM. DE ART. PRESENTES DECOR.','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030039,1,'10100030039','COM. DE AVES E OVOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030040,1,'10100030040','COM. DE ATAUDES AR FUNE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030041,1,'10100030041','COM. DE ART. DE TORNO SOLDA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030042,1,'10100030042','COM. DE ART. RELIG. UMBANDA E ESOTERICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030043,1,'10100030043','COM. DE ANIMAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030044,1,'10100030044','COM. DE ART. DE ESTOFARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030045,1,'10100030045','COM. DE ART. USADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030046,1,'10100030046','COM. DE APARELHOS ORTOPEDICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030047,1,'10100030047','COM. DE AREIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030048,1,'10100030048','COM. ATAC. DE COSMET. PERFUM.','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030049,1,'10100030049','COM. DE APARELHOS DE SOM','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030050,1,'10100030050','COM. DE BALAS, DOCES, PROD. ALIMEN.','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030051,1,'10100030051','COM. DE BATERIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030052,1,'10100030052','COM. DE BEBIDAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030053,1,'10100030053','COM. DE BICICLETAS E PECAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030054,1,'10100030054','COM. DE BIJOUTERIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030055,1,'10100030055','COM. DE BRINQUEDOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030056,1,'10100030056','COM. DE BILHETES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030057,1,'10100030057','COM. DE ART. PARA MOTOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030058,1,'10100030058','BAR E DANCETERIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030059,1,'10100030059','COM. DE CHAVES E FECHADURA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030060,1,'10100030060','COM. DE CALCADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030061,1,'10100030061','COM. DE CARVAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030062,1,'10100030062','COM. DE CEREAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030063,1,'10100030063','COM. DE COMBUST.LUBRIF','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030064,1,'10100030064','COM. DE CONFECCOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030065,1,'10100030065','COM. DE COURO/LAS ARTEF','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030066,1,'10100030066','COM. DE CHAPAS GALVANIZADA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030067,1,'10100030067','COM. DE COLCHOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030068,1,'10100030068','COM. DE ROUPAS, CONFECCOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030069,1,'10100030069','COM. DE CON. CAL. BIJ. COSM. ESPO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030070,1,'10100030070','COM. DE DISCOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030071,1,'10100030071','COM. DE CIGARROS,CHARUTOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030072,1,'10100030072','COM. DE AGUA MINERAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030073,1,'10100030073','COM. DE EMBALAGENS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030074,1,'10100030074','COM. DE EQUIP. ELETRONICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030075,1,'10100030075','COM. DE ERVA MATE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030076,1,'10100030076','COM. DE MAT. ESPORTVO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030077,1,'10100030077','COM. DE ESQUADRIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030078,1,'10100030078','COM. DE EXPLOSIVOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030079,1,'10100030079','COM. DE ELETRODOMESTICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030080,1,'10100030080','COM. DE FERRAMENTAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030081,1,'10100030081','COM. DE MAT. P/IND. E CONSTRUCOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030082,1,'10100030082','COM. DE FERRO VELHO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030083,1,'10100030083','COM. DE FERTILIZANTE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030084,1,'10100030084','FLORICULTURA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030085,1,'10100030085','COM. DE FORRAGENS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030086,1,'10100030086','COM. DE FRUTAS E VERDURAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030087,1,'10100030087','COM. DE FITAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030090,1,'10100030090','COM. DE GAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030091,1,'10100030091','COM. DE GEN. ALIMENTICIOS SUPE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030092,1,'10100030092','COM. DE GADO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030095,1,'10100030095','COM. DE INSTRUMENTOS MUSICAI','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030096,1,'10100030096','COM. DE IMPLEMENTOS AGRICOLAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030097,1,'10100030097','COM. DE JOIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030098,1,'10100030098','COM. DE FRALDAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030099,1,'10100030099','COMERCIO AMBULANTE DE ALIMENTOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030100,1,'10100030100','COM. DE LA E LINHA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030101,1,'10100030101','COM. DE GEN. ALIMENTICIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030102,1,'10100030102','COM. DE LENHA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030103,1,'10100030103','COM. DE LIVROS, JORNAIS, REVISTAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030104,1,'10100030104','COM. DE LINGERIE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030109,1,'10100030109','COM. DE ART. ESCOL., MAT. ESCRITORIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030110,1,'10100030110','COM. DE MADEIRAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030111,1,'10100030111','COM. DE MAQUINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030112,1,'10100030112','COM. DE MAQUINAS AGRICOLAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030113,1,'10100030113','COM. DE MAT. CONTRA INCENDIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030114,1,'10100030114','COM. DE MAT. ODONTOLOGICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030115,1,'10100030115','COM. DE MAT. ELETRICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030116,1,'10100030116','COM. DE MAT. FOTOGRAF. CINEMATOG.','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030117,1,'10100030117','COM. DE MAT. HIDRAULICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030118,1,'10100030118','COM. DE MAT. CONSTRUCAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030119,1,'10100030119','COM. DE MAT. ESCRITORIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030120,1,'10100030120','COM. DE METAIS NOBRES/METALUR','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030121,1,'10100030121','COM. DE MOLAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030122,1,'10100030122','COM. DE MOTORES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030123,1,'10100030123','COM. DE MOVEIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030124,1,'10100030124','COM. DE MAT. P/ SORVETE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030125,1,'10100030125','COM. DE MALHAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030126,1,'10100030126','COM. DE PROD. NAO ESPECIFICADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030127,1,'10100030127','COM. DE PROD. ALIM. (INDUS.)','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030128,1,'10100030128','COM. DE PEDRAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030129,1,'10100030129','COM. DE PAPEIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030130,1,'10100030130','COM. DE PECAS E ACESSORIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030131,1,'10100030131','COM. DE PEIXES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030132,1,'10100030132','COM. DE PERFUMARIAS COSMETICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030133,1,'10100030133','COM. DE PLANTAS MEDICINAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030134,1,'10100030134','COM. DE PNEUS CAMARAS DE AR','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030135,1,'10100030135','COM. DE PROD. AGROPECUARIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030136,1,'10100030136','COM. DE PROD. AVICOLAS COLONIAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030137,1,'10100030137','COM. DE PROD. FARMACEUTICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030138,1,'10100030138','COM. DE PROD. QUIMICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030139,1,'10100030139','COM. DE PROD. VETERINARIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030140,1,'10100030140','COM. DE PERSIANA MAT. P/CORTINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030141,1,'10100030141','COMERCIO VAR. PRODUTOS NATURAIS, LANCHER','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030142,1,'10100030142','COM. DE QUADROS E ESTATUETAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030143,1,'10100030143','COM. DE PROD. DE LIMPEZA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030144,1,'10100030144','COM. DE RACOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030145,1,'10100030145','COM. DE REFEICOES EMB. TERM.','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030146,1,'10100030146','COM. DE RELOGIOS, JOIAS, OCULOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030147,1,'10100030147','COM. DE ROUPAS USADAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030148,1,'10100030148','COM. DE RESIDUOS DE CEVADA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030149,1,'10100030149','COMERCIO , IMPORTACAO EXPORTACAO DE PRO','PJPF',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100030152,1,'10100030152','COM. DE EQUIPAMENTOS DE INFORMATICA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030153,1,'10100030153','COM. DE SUPRIMENTOS DE INFORMATICA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030154,1,'10100030154','COM. DE SEMENTES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030155,1,'10100030155','SERVICOS DE RADIOFUSAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030156,1,'10100030156','COM. DE SORVETES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030159,1,'10100030159','COM. DE TABACO EM FOLHA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030160,1,'10100030160','COM. DE TAPETES E CORTINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030161,1,'10100030161','COM. DE TECIDOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030162,1,'10100030162','COM. DE TINTAS E OLEOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030163,1,'10100030163','COM. DE RADIOS E TELEVORES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030164,1,'10100030164','REFEITORIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030167,1,'10100030167','COM. DE UTILIDADES DOMESTICAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030168,1,'10100030168','COOPERATIVA DE PRODUCAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030169,1,'10100030169','COM. DE VASSOURAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030170,1,'10100030170','COM. DE VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030171,1,'10100030171','COM. DE VIDROS E MOLDUR','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030172,1,'10100030172','CONFEITARIA E PADARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030173,1,'10100030173','COOPERATIVA DE CONSUMO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030174,1,'10100030174','CRIACAO E COM. COELHOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030175,1,'10100030175','DEPOSITO FECHADO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030176,1,'10100030176','DROGARIA - FARMACIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030177,1,'10100030177','MERCEARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030178,1,'10100030178','RESTAURANTE E LANCHERIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030179,1,'10100030179','RESTAURANTE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030180,1,'10100030180','TABACARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030181,1,'10100030181','MIMI-MERCADO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100030305,1,'10100030305','COMERCIO DE PRODUTOS DE FONOAUDIOLOGIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032005,1,'10100032005','COM. ATAC. EM GERAL C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032006,1,'10100032006','MATADOURO C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032009,1,'10100032009','BAR C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032010,1,'10100032010','SORVETERIA E FLIPERAMA C/ SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032012,1,'10100032012','RESTAURANTE, HOTEL, BAR, LANCHERIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032013,1,'10100032013','BOMBONIERE','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032017,1,'10100032017','COM. DE ART. DESPORTIVO C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032018,1,'10100032018','LANCHERIA C/ SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032020,1,'10100032020','CHURRASCARIA E HOTEL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032025,1,'10100032025','COM. DE APARELHOS ELETRONICOS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032030,1,'10100032030','COM. DE CONCRETO E SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032035,1,'10100032035','COM. DE VESTUARIO E REPRESENTACAO COM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032036,1,'10100032036','COM. DE ART. P/VEIC. C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032038,1,'10100032038','COM.DE VEICULOS,AGENCIAMENTO','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032040,1,'10100032040','COM. DE ART. FUNERARIO C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032042,1,'10100032042','COM. DE ART. RELIGIOSOS DE UMBANDA E ES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032043,1,'10100032043','COMERCIO DE ANIMAIS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032048,1,'10100032048','COM. DE COSMETICOS C/CABELEIREIRO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032052,1,'10100032052','COM. ATAC. DE BEBIDAS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032053,1,'10100032053','COM. DE BICICLETA C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032056,1,'10100032056','COM. DE BILHETES C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032060,1,'10100032060','COM. DE CALCADOS C/SERV','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032062,1,'10100032062','COM. DE CEREAISC/SERV','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032063,1,'10100032063','COM. DE COMBUSTIVEL E LUBRIFIC. C/SERV.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032064,1,'10100032064','COM. DE CONFECCOES C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032068,1,'10100032068','COM. DE ROUPAS, CONFECÇÕES E CONSERTOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032070,1,'10100032070','COM. DE DISCOS C/SERVIC','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032074,1,'10100032074','COM. DE EQUIP. ELETRONICO C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032076,1,'10100032076','COMERCIO VAREJ. ARTIGOS ESPORTIVOS E SERVICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032079,1,'10100032079','COM. DE ELETRODOMESTICOS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032084,1,'10100032084','COM.SEMENTES, FLORES E PLANTASC/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032086,1,'10100032086','COM. E PRODUCAO DE HORTIGRA TRAN','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032088,1,'10100032088','COM. DE VEICULO C/  REPRESENTACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032090,1,'10100032090','COM. DE GAS COM SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032091,1,'10100032091','COM. E PROD. AL. REP COM','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032094,1,'10100032094','IMP. E EXPO. ACESS\\\'','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032095,1,'10100032095','COM. DE INSTR. MUSICAIS E SERV. SONORIZA','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032097,1,'10100032097','COM. DE JOIAS E CONSER','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032100,1,'10100032100','COM. DE LAS, LINHAS E SERVICOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032101,1,'10100032101','COM. DE GEN.ALIMENTICIOS/REPRE/TRANS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032103,1,'10100032103','COM. DE LIVROS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032109,1,'10100032109','COM. DE MAT. ESCOLAR C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032111,1,'10100032111','COM. DE MAQUINAS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032112,1,'10100032112','COM. DE MAQUINAS AGRIC. C/ SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032113,1,'10100032113','COM. DE EXTINTORES E RECARGA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032115,1,'10100032115','COM. DE MAT. ELETRICO C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032116,1,'10100032116','COM. DE MAT. FOTOGRAFICO C/ SERV.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032117,1,'10100032117','COM. MATERIAL HIDRAULICO E PRESTACAO DE','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032118,1,'10100032118','COM. DE MAT. DE CONSTR. C/SERV','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032119,1,'10100032119','COM. DE MAT. P/ESCRITORIO C/SERV.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032123,1,'10100032123','COM. DE MOVEIS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032127,1,'10100032127','COM. DE PROD. ALIMENTICIOS C/SERV.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032128,1,'10100032128','COM. DE PEDRAS C/SERV','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032129,1,'10100032129','COM. DE PAPEIS C/ SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032130,1,'10100032130','COM. DE PECAS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032132,1,'10100032132','COM. DE PERF. C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032134,1,'10100032134','COM. DE PNEUS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032135,1,'10100032135','COM. DE PROD. AGROPECUARIOS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032137,1,'10100032137','ASSISTENCIA MEDICA, AMBULATORIAL E HOSPI','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032139,1,'10100032139','COM. DE PROD. VETERINARIOS C/SERV','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032143,1,'10100032143','LIMPEZA URBANA, ESGOTO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032144,1,'10100032144','COMERCIO DE RACOES E PETSHOP','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032145,1,'10100032145','COM. DE JOIAS, OTICA E LOCACAO DE FITAS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032146,1,'10100032146','OTICA, COM. DE JOAIS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032152,1,'10100032152','COM. DE EQUIP. DE INFORMATICA C/SERV.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032153,1,'10100032153','COM. DE SUPRIM. DE INFORMATICA C/SERV.','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032167,1,'10100032167','C.UTILIDADES DOMESTICAS C/SERVICO DE INT','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032170,1,'10100032170','COM. DE VEICULOS COM SERVICOS','PJPF',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100032171,1,'10100032171','COM. DE VIDROS C/SERVIC','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032172,1,'10100032172','CONFEITARIA E PADARIA C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032176,1,'10100032176','FARMACIA C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032178,1,'10100032178','RESTAURANTE E HOTEL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032179,1,'10100032179','RESTAURANTE E HOTEL C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100032181,1,'10100032181','MINI-MERCADO C/ PREST. SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033006,1,'10100033006','MATADOURO, ACOUGUE E REPRESENTACAO COMER','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033043,1,'10100033043','COMERCIO DE ANIMAIS','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033060,1,'10100033060','SERVICOS DE COBRANCA BANCARIA','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033074,1,'10100033074','COM. DE EQUIPAMENTOS ELETRONICOS C/SERVI','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033118,1,'10100033118','COM.MAT.CONST.E REPRESENTACAO COMERCIAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033119,1,'10100033119','COM.MAT.ESCRIT.C/REPRESENTACAO COMERCIAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033130,1,'10100033130','COM.PECAS C/SERV. E REPRESENTACAO COMERC','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033132,1,'10100033132','COM. DE PERF.C/REPRESENTACAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033134,1,'10100033134','COM.PNEUSC/SERV.E REPRESENTACAO COMERCIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033135,1,'10100033135','COM.PROD.AGROP.FERT.C/REPRESENTACAO COME','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033139,1,'10100033139','COM.PROD.VETERINARIOS E REPRESENTACAO CO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033167,1,'10100033167','INTERMEDIACAO FINANCEIRA','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033170,1,'10100033170','COM.VEICULOS, INTERMEDIARIO C/VEICULOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100033176,1,'10100033176','SERVICOS DE COBRANCA BANCARIA','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040001,1,'10100040001','IND. DE ABAJURES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040002,1,'10100040002','IND. DE ACOLCHOADOS E CORTINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040003,1,'10100040003','IND. DE ADUBOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040004,1,'10100040004','IND. DE AEROMOLDES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040005,1,'10100040005','IND. DE APARELHOS DE GAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040006,1,'10100040006','IND. DE APARELHOS ELETRICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040007,1,'10100040007','IND. DE APARELHOS ORTOPEDICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040008,1,'10100040008','IND. DE ARMAS E MUNICOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040009,1,'10100040009','IND. DE ARAME','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040010,1,'10100040010','IND. DE BORRACHA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040011,1,'10100040011','IND. DE COURO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040012,1,'10100040012','IND. DE ARTEFATO DE CIMENTO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040013,1,'10100040013','IND. DE MADEIRA E VIME','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040014,1,'10100040014','IND. DE MADEIRA PLASTICA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040015,1,'10100040015','IND. DE METAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040016,1,'10100040016','IND. DE LONA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040017,1,'10100040017','IND. DE VESTUARIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040018,1,'10100040018','IND. DE ARGAMASSA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040019,1,'10100040019','IND. DE BONECAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040020,1,'10100040020','IND. DE BALANCAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040021,1,'10100040021','IND. DE BARRIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040022,1,'10100040022','IND. DE BATERIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040023,1,'10100040023','IND. DE BEBIDAS-ENGARRA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040024,1,'10100040024','IND. DE BENEFICIAMENTO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040025,1,'10100040025','IND. DE BICICLETAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040026,1,'10100040026','IND. DE BIJOUTERIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040027,1,'10100040027','IND. DE BENEF. DE MADEIRA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040028,1,'10100040028','IND. DE BRINQUEDOS ELETRONICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040029,1,'10100040029','IND. DE CARNE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040030,1,'10100040030','IND. DE CALCADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040031,1,'10100040031','IND. DE CAMISAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040032,1,'10100040032','IND. DE CARIMBOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040033,1,'10100040033','IND. DE CARROCA - TRACAO ANIMAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040034,1,'10100040034','IND. DE CARROCERIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040035,1,'10100040035','IND. DE CARVAO SUBPRODU','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040036,1,'10100040036','IND. DE CELULOSE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040037,1,'10100040037','IND. DE CERAMICA - OLARIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040038,1,'10100040038','IND. DE CERAS PASTAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040039,1,'10100040039','IND. DE CHAPEUS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040040,1,'10100040040','IND. DE CIGARROS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040041,1,'10100040041','IND. DE CONDICIONADORES E CLIMATIZADORES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040042,1,'10100040042','IND. DE COLA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040043,1,'10100040043','IND. DE COLCHOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040044,1,'10100040044','IND. DE CONSERVAS E GEN. ALIMENTICIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040045,1,'10100040045','IND. DE CORRENTES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040046,1,'10100040046','IND. DE CURTIMNETO DE COURO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040047,1,'10100040047','IND. DE CHOCOLATE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040048,1,'10100040048','IND. DE CEREAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040049,1,'10100040049','IND. DE ARTIGOS FUNERARIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040050,1,'10100040050','IND. DE DERIVADOS DE PETROLEO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040051,1,'10100040051','IND. DE DESODORANTE E DETERGENTES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040052,1,'10100040052','IND. DE DOCES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040053,1,'10100040053','IND. DE BENEF. DE LEITE E DERIVADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040054,1,'10100040054','IND. DE CABINES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040055,1,'10100040055','IND. DE ELASTICOS E FITAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040056,1,'10100040056','IND. DE ENFEITES DE NATAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040057,1,'10100040057','IND. DE EQUIP. DE SEGURANCA INDUSTRIAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040058,1,'10100040058','IND. DE EQUIP. ELETRONICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040059,1,'10100040059','IND. DE EQUIP. DE TURISMO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040060,1,'10100040060','IND. DE EQUIP. SOLARES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040061,1,'10100040061','IND. DE ERVA MATE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040062,1,'10100040062','IND. DE ESMERIS, LIXAS, POLIMENTOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040063,1,'10100040063','IND. DE MOVEIS E ESQUADRIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040064,1,'10100040064','IND. DE ART. FUNERARIOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040065,1,'10100040065','IND. DE ESTOFADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040066,1,'10100040066','IND. DE ELETRODOMESTICOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040067,1,'10100040067','IND. DE EMBALAGENS MADEIRA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040068,1,'10100040068','FUNILARIA E SERRALHERIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040069,1,'10100040069','FERRARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040070,1,'10100040070','IND. DE FECHADURAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040071,1,'10100040071','IND. DE FILTROS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040072,1,'10100040072','IND. DE FERMENTOS, TEMPEROS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040073,1,'10100040073','IND. DE FERTILIZANTES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040074,1,'10100040074','IND. DE TECELAGEM','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040075,1,'10100040075','IND. DE FLAMULAS/BANDEIRAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040076,1,'10100040076','IND. DE FLORA MEDICINAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040077,1,'10100040077','IND. DE FLORES ARTIFICIAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040078,1,'10100040078','IND. DE FOGOES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040079,1,'10100040079','IND. DE FOSFORO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040080,1,'10100040080','IND. DE FRALDAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040081,1,'10100040081','SERRARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040082,1,'10100040082','IND. DE PALETES E CAIXAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040083,1,'10100040083','IND. DE BENEF. HORTIFRUTIGRANJEIROS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040084,1,'10100040084','IND. DE ESTRUT. PRE-MOLDADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040085,1,'10100040085','IND. GRAFICA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040086,1,'10100040086','IND. DE GRANITOS E PEDRAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040087,1,'10100040087','IND. DE FRALDAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040088,1,'10100040088','INDUSTRIA DE GELO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040089,1,'10100040089','IND. EQUIPAMENTOS ETETRONICOS GERAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040090,1,'10100040090','IND. DE INSETICIDAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040091,1,'10100040091','IND. DE INSTRUMENTOS MUSICAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040092,1,'10100040092','IND. DE INSUMOS P/AGRICULTURA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040095,1,'10100040095','IND. DE JOIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040096,1,'10100040096','IND. ACESSORIOS P/BICICLETAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040100,1,'10100040100','IND. DE LOUCAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040103,1,'10100040103','IND. DE ROUPAS INTIMAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040105,1,'10100040105','IND. DE MAQUINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040106,1,'10100040106','IND. DE MASSAS ALIMENTICIAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040107,1,'10100040107','IND. DE MATERIAL CONSTRUCAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040108,1,'10100040108','IND. DE MATRIZES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040109,1,'10100040109','IND. DE MOLDURAS QUADRO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040110,1,'10100040110','IND. DE MOTORES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040111,1,'10100040111','IND. DE MOVEIS, MARCENARIA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040112,1,'10100040112','IND. DE MOVEIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040113,1,'10100040113','IND. DE MALHAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040114,1,'10100040114','INDUSTRIA DE VEICULOS AUTOMOTORES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040115,1,'10100040115','IND. DE OLEOS VEGETAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040116,1,'10100040116','IND. DE PLASTICOS E RESINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040117,1,'10100040117','IND. DE PECAS E ACESS. P/ VEICULOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040118,1,'10100040118','IND. DE PLACAS PARA VEICULOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040119,1,'10100040119','IND. DE PEDRAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040120,1,'10100040120','IND. DE PANIFICACAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040121,1,'10100040121','IND. DE PAPELAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040122,1,'10100040122','IND. DE PARAFUSOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040123,1,'10100040123','IND. DE VESTUARIO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040124,1,'10100040124','IND. DE PELES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040125,1,'10100040125','IND. DE PERFUMES','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040126,1,'10100040126','IND. DE PLACAS, PAINEIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040127,1,'10100040127','IND. DE SAIS MINERAIS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100040128,1,'10100040128','IND. DE SORVETES E CONGELADOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042010,1,'10100042010','FABRICACAO DE ARTIGOS DE ESPUMA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042012,1,'10100042012','IND. DE ARTEFATOS DE CIMENTO C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042015,1,'10100042015','INDUSTRIA METALURGICA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042023,1,'10100042023','IND. DE BEBIDAS E PREST. SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042028,1,'10100042028','IND. DE BRINQUEDOS ELETRON. C/SERVICO','PJPF',5,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042029,1,'10100042029','INDUSTRIA DE CARNES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042030,1,'10100042030','IND. DE COSTURA C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042034,1,'10100042034','IND. DE CARROCERIAS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042037,1,'10100042037','INDUSTRIA DE CERAMICA -OLARIA C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042048,1,'10100042048','IND. E COM. DE CEREAIS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042054,1,'10100042054','IND. DE CABINES, CHAPEACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042058,1,'10100042058','IND. E COM. DE ALARMES C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042062,1,'10100042062','IND. ESMERIS, LIXAS, POLIMENTOS C/SERV','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042063,1,'10100042063','IND. DE ESQUADRIAS C/SERVICO','PJPF',3,0,0,0,0,'mensal',0,0,'NF','A');
INSERT INTO `servicos` VALUES (10100042065,1,'10100042065','IND. E REF. ESTOFADOS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042068,1,'10100042068','FUNILARIA E SERRALHERIA C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042069,1,'10100042069','FERRARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042076,1,'10100042076','FARMACIA DE MANIPULACAO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042081,1,'10100042081','SERRARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042085,1,'10100042085','GRAFICA C/ SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042086,1,'10100042086','IND. E COM. FRUTA E VERDURAS C/SER','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042087,1,'10100042087','IND. DE FRALDAS DESCARTÁVEIS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042089,1,'10100042089','IND.EQUIPAMENTO ELETRONICOS GERAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042093,1,'10100042093','IND. DE VIDROS COM SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042103,1,'10100042103','IND. COST. CALCADOS/ROUPAS INTIMAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042105,1,'10100042105','IND. E COM. MAQUINAS C/SERVICO','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042111,1,'10100042111','MARCENARIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100042123,1,'10100042123','IND. DE VESTUARIO C/SER','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100043089,1,'10100043089','IND.EQUIPAMNETOSELETRONICOS GERAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100043123,1,'10100043123','IND. VESTUARIO  C/SERV. E REPRESENTACAO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050001,1,'10100050001','ACAO SOCIAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050002,1,'10100050002','ASSOC. DE CLASSE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050003,1,'10100050003','ASSOC. IND. E COM. SERVICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050004,1,'10100050004','ASSOC. CULTURAL E EDUCACIONAL','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050005,1,'10100050005','ENTIDADE FILANTROPICA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050006,1,'10100050006','ENTIDADE RELIGIOSA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050007,1,'10100050007','ESCOLA MUNICIPAL E ESTADUAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050008,1,'10100050008','SOCIEDADE CIVIL S/FINS LUCRATIVOS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050009,1,'10100050009','ASSOC. RECREATIVA E ESPORTIVA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050010,1,'10100050010','CLUBE AQUATICO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050011,1,'10100050011','CIRCULO DE MAQUINAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050012,1,'10100050012','APAE','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050013,1,'10100050013','CORREIOS E TELEGRAFOS','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050014,1,'10100050014','SERV. TELECOMUNICACOES','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050015,1,'10100050015','ESCOLA PARTICULAR','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050016,1,'10100050016','HOSPITAL MUNICIPAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050017,1,'10100050017','AMBULATORIO MUNICIPAL','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050018,1,'10100050018','ASSOCIACAO CORPO DE BOMBEIROS VOL. FELIZ','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050019,1,'10100050019','CIA RIOGRANDENSE DE SANEAMENTO - CORSAN','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100050084,1,'10100050084','OUTRAS ATIVIDADES ASSOCIATIVAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100060000,1,'10100060000','IMPOSTO DE RENDA','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100061000,1,'10100061000','TITULO EXECUTIVO','PJPF',0,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10100062001,1,'10100062001','INDUSTRIA ELETRICA E ELETROCIA','PJPF',3,0,0,0,0,'',0,0,'0','A');
INSERT INTO `servicos` VALUES (10140096001,1,'10140096001','IND. DE ACESSORIOS P/MOTOCICLETAS','PJPF',0,0,0,0,0,'',0,0,'0','A');
/*!40000 ALTER TABLE `servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table servicos_categorias
#

CREATE TABLE `servicos_categorias` (
  `codigo` int(11) NOT NULL auto_increment,
  `nome` text,
  `tipo` varchar(10) default NULL COMMENT 'tipos: CNAE e LC116',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `servicos_categorias` VALUES (1,'Outros','Mid');
/*!40000 ALTER TABLE `servicos_categorias` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table servicos_discriminacoes
#

CREATE TABLE `servicos_discriminacoes` (
  `codigo` int(11) NOT NULL auto_increment,
  `codcadastro` int(11) default NULL,
  `codservico` bigint(20) default NULL,
  `discriminacao` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40000 ALTER TABLE `servicos_discriminacoes` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table simples_des
#

CREATE TABLE `simples_des` (
  `codigo` int(11) NOT NULL auto_increment,
  `codemissor` int(11) default NULL,
  `competencia` date default NULL,
  `data_gerado` date default NULL,
  `total` decimal(10,2) default NULL,
  `tomador` char(1) default 'N',
  `codverificacao` char(9) default NULL,
  `estado` char(1) default 'N' COMMENT 'N normal C cancelada B boleto E escriturada',
  `motivo_cancelamento` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `simples_des` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table simples_des_servicos
#

CREATE TABLE `simples_des_servicos` (
  `codigo` int(10) NOT NULL auto_increment,
  `codsimples_des` int(10) default NULL,
  `codservico` bigint(11) default NULL,
  `basedecalculo` float(10,2) default NULL,
  `tomador_cnpjcpf` varchar(20) default NULL,
  `nota_nro` int(11) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `simples_des_servicos` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table submenus_prefeitura
#

CREATE TABLE `submenus_prefeitura` (
  `codigo` int(11) NOT NULL auto_increment,
  `menu` varchar(100) default NULL,
  `link` varchar(100) default NULL,
  `nivel_1` char(1) default 'M' COMMENT 'A para alto ,M para medio e B para baixo',
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `submenus_prefeitura` VALUES (1,'Cadastro','cadastro.php','B');
INSERT INTO `submenus_prefeitura` VALUES (3,'Processos','processos.php','M');
INSERT INTO `submenus_prefeitura` VALUES (4,'Fiscais','fiscais.php','M');
INSERT INTO `submenus_prefeitura` VALUES (5,'Categoria','categoria.php','B');
INSERT INTO `submenus_prefeitura` VALUES (6,'Liberações','liberar.php','M');
INSERT INTO `submenus_prefeitura` VALUES (8,'Prest/Serv','des.php','M');
INSERT INTO `submenus_prefeitura` VALUES (10,'Manuais','manuais.php','B');
INSERT INTO `submenus_prefeitura` VALUES (11,'Consulta nfe','consulta.php','M');
INSERT INTO `submenus_prefeitura` VALUES (12,'Prestadores','prestadores/cadastro.php','M');
INSERT INTO `submenus_prefeitura` VALUES (13,'ISS Retido','issretido.php','M');
INSERT INTO `submenus_prefeitura` VALUES (14,'Inst Financeira','dif.php','M');
INSERT INTO `submenus_prefeitura` VALUES (15,'Op de Credito','doc.php','M');
INSERT INTO `submenus_prefeitura` VALUES (16,'AIDF','aidf.php','B');
INSERT INTO `submenus_prefeitura` VALUES (17,'AIDFe','aidfe.php','M');
INSERT INTO `submenus_prefeitura` VALUES (20,'Configurações','configuracoes.php','M');
INSERT INTO `submenus_prefeitura` VALUES (21,'Logs','logs.php','M');
INSERT INTO `submenus_prefeitura` VALUES (22,'Legislação','legislacao.php','M');
INSERT INTO `submenus_prefeitura` VALUES (23,'Usuários','usuarios.php','M');
INSERT INTO `submenus_prefeitura` VALUES (24,'Notícias','noticias.php','M');
INSERT INTO `submenus_prefeitura` VALUES (26,'Ouvidoria','ouvidoria.php','M');
INSERT INTO `submenus_prefeitura` VALUES (27,'Cartorios','dec.php','M');
INSERT INTO `submenus_prefeitura` VALUES (28,'Orgaos Publicos','dop.php','M');
INSERT INTO `submenus_prefeitura` VALUES (29,'Chat','chat.php','M');
INSERT INTO `submenus_prefeitura` VALUES (30,'Fórum','forum.php','M');
INSERT INTO `submenus_prefeitura` VALUES (31,'Auditoria','auditoria.php','M');
INSERT INTO `submenus_prefeitura` VALUES (33,'Consulta Guia','guia.php','M');
INSERT INTO `submenus_prefeitura` VALUES (36,'Tomadores','tomadores/cadastro.php','B');
INSERT INTO `submenus_prefeitura` VALUES (37,'Auto de Infração','infracao.php','M');
INSERT INTO `submenus_prefeitura` VALUES (38,'Empreiteiras','decc.php','M');
INSERT INTO `submenus_prefeitura` VALUES (39,'Escriturações','escrituracoes.php','M');
INSERT INTO `submenus_prefeitura` VALUES (40,'Serviço','servico.php','M');
INSERT INTO `submenus_prefeitura` VALUES (41,'Nfe','nfe.php','M');
INSERT INTO `submenus_prefeitura` VALUES (42,'Sobre','sobre.php','B');
INSERT INTO `submenus_prefeitura` VALUES (43,'Serviços','servicos.php','M');
INSERT INTO `submenus_prefeitura` VALUES (44,'Regras de Crédito','regras_credito.php','M');
INSERT INTO `submenus_prefeitura` VALUES (45,'Simples','simples.php','M');
INSERT INTO `submenus_prefeitura` VALUES (46,'Prestador x Contador','prestadores/cadastro_contador.php','M');
INSERT INTO `submenus_prefeitura` VALUES (47,'Cartório - Serviços','cartorio_cadastro.php','M');
INSERT INTO `submenus_prefeitura` VALUES (48,'Cartório - Categorias','cartorio_categoria.php','M');
INSERT INTO `submenus_prefeitura` VALUES (49,'Inst. Financeira','if_cadastro.php','M');
INSERT INTO `submenus_prefeitura` VALUES (50,'Op. de Créditos','oc_cadastro.php','A');
INSERT INTO `submenus_prefeitura` VALUES (51,'Obras','obras.php','M');
INSERT INTO `submenus_prefeitura` VALUES (52,'Prestadores','prestadores.php','M');
INSERT INTO `submenus_prefeitura` VALUES (53,'Serviços','servicos.php','M');
INSERT INTO `submenus_prefeitura` VALUES (54,'MEI','mei.php','M');
INSERT INTO `submenus_prefeitura` VALUES (55,'Regras de Multa','regras/regra_multa.php','M');
INSERT INTO `submenus_prefeitura` VALUES (56,'Escrituração','escrituracoes_nfe.php','M');
INSERT INTO `submenus_prefeitura` VALUES (57,'Notas Escrituradas','notas_escrituradas.php','M');
INSERT INTO `submenus_prefeitura` VALUES (59,'Consultar','sep_consultar.php','M');
INSERT INTO `submenus_prefeitura` VALUES (60,'Gerar','sep_gerar.php','M');
INSERT INTO `submenus_prefeitura` VALUES (61,'Atualizar','sep_atualizar.php','M');
INSERT INTO `submenus_prefeitura` VALUES (62,'Div. Publicas','ddp.php','M');
INSERT INTO `submenus_prefeitura` VALUES (63,'Movimentação de Serviços','movimentacao.php','B');
INSERT INTO `submenus_prefeitura` VALUES (64,'Valores','movimentacao_valor_arrecadado.php','B');
INSERT INTO `submenus_prefeitura` VALUES (65,'RPS','rps.php','M');
INSERT INTO `submenus_prefeitura` VALUES (66,'Dados Divergentes','inconsistencias.php','M');
INSERT INTO `submenus_prefeitura` VALUES (67,'Guias','guias.php','M');
INSERT INTO `submenus_prefeitura` VALUES (68,'Inconsistências','dados_divirgentes.php','M');
INSERT INTO `submenus_prefeitura` VALUES (69,'Movimentação de Prestadores','movimentacao_prestadores.php','M');
INSERT INTO `submenus_prefeitura` VALUES (70,'Movimentação de Tomadores','movimentacao_tomadores.php','M');
INSERT INTO `submenus_prefeitura` VALUES (71,'Regras de Juros','regras/regra_juros.php','M');
INSERT INTO `submenus_prefeitura` VALUES (72,'Nota Avulsa','nota_avulsa.php','M');
INSERT INTO `submenus_prefeitura` VALUES (73,'Validação','validacao.php','M');
INSERT INTO `submenus_prefeitura` VALUES (74,'ISSQN Retido','issqn_retido.php','M');
INSERT INTO `submenus_prefeitura` VALUES (75,'DAF 607 x ISS devido','daf607_iss_devido.php','M');
INSERT INTO `submenus_prefeitura` VALUES (76,'Alíquotas Simples','aliquotas_simples.php','M');
INSERT INTO `submenus_prefeitura` VALUES (77,'Inadimplências','inadimplencia.php','M');
INSERT INTO `submenus_prefeitura` VALUES (78,'Movimentação Geral','movimentacao_geral.php','M');
INSERT INTO `submenus_prefeitura` VALUES (79,'Estimativa ISSQN','estimativa_issqn.php','M');
INSERT INTO `submenus_prefeitura` VALUES (80,'Ranking Empresas','ranking_empresas.php','M');
INSERT INTO `submenus_prefeitura` VALUES (81,'Ranking Atividades','ranking_atividades.php','M');
INSERT INTO `submenus_prefeitura` VALUES (82,'Acompanhamento ISSQN','acompanhamento_issqn.php','M');
INSERT INTO `submenus_prefeitura` VALUES (83,'Créditos','creditos.php','M');
INSERT INTO `submenus_prefeitura` VALUES (84,'Simples Nacional','simples_nacional.php','M');
/*!40000 ALTER TABLE `submenus_prefeitura` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table tipo
#

CREATE TABLE `tipo` (
  `codigo` int(11) NOT NULL auto_increment,
  `tipo` varchar(30) default NULL,
  `nome` varchar(255) default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
INSERT INTO `tipo` VALUES (1,'prestador','Prestador');
INSERT INTO `tipo` VALUES (3,'simples','Simples Nacional');
INSERT INTO `tipo` VALUES (4,'empreiteira','Empreiteira');
INSERT INTO `tipo` VALUES (5,'orgao_publico','Orgão Público');
INSERT INTO `tipo` VALUES (6,'instituicao_financeira','Instituição Financeira');
INSERT INTO `tipo` VALUES (7,'cartorio','Cartório');
INSERT INTO `tipo` VALUES (8,'operadora_credito','Operadora de Crédito');
INSERT INTO `tipo` VALUES (9,'grafica','Gráfica');
INSERT INTO `tipo` VALUES (10,'contador','Contador');
INSERT INTO `tipo` VALUES (11,'tomador','Tomador');
INSERT INTO `tipo` VALUES (12,'diversao','Diversão Pública');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table tomadores_pagamento
#

CREATE TABLE `tomadores_pagamento` (
  `codigo` int(11) NOT NULL auto_increment,
  `codnota` varchar(11) default NULL,
  `cpfcnpj` varchar(200) default NULL,
  `estado` char(1) default NULL,
  `nropagamento` bigint(20) default NULL,
  `data` varchar(255) default NULL,
  `dadosconfirmacao` text,
  PRIMARY KEY  (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40000 ALTER TABLE `tomadores_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table usuarios
#

CREATE TABLE `usuarios` (
  `codigo` int(11) NOT NULL auto_increment,
  `nome` varchar(100) default NULL,
  `login` varchar(100) default NULL,
  `senha` varchar(255) default NULL,
  `tipo` varchar(50) default NULL,
  `ultlogin` datetime default NULL,
  `nivel` char(1) default 'A',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
INSERT INTO `usuarios` VALUES (1,'Prefeitura','prefeitura','202cb962ac59075b964b07152d234b70','prefeitura','2011-12-12 15:36:59','A');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
