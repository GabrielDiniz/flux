
INSERT INTO `basemodelo`.`menus_prefeitura` SET `menu`='Guia de Pagamento', `ordem`=7, `link`='guia';

INSERT INTO `basemodelo`.`menus_prefeitura_submenus` SET `codmenu`=33, `codsubmenu`=33, `visivel`='S', `ordem`=7;

INSERT INTO `basemodelo`.`submenus_prefeitura` SET `menu`='Consulta Guia', `link`='guia.php';

UPDATE `basemodelo`.`menus_prefeitura_submenus` SET `iss`='S', `nfe`='S' WHERE `codigo`=136;

