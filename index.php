<?php

require_once 'vendor/autoload.php';
require_once 'config.php';
$request = array_filter(explode('/', trim($_SERVER['REQUEST_URI'])));
$base = basename(CORE_DIRECTORY);
$page = array_filter($request, function($c) use (&$base)
{
	if ($base != $c && !strstr($c, '?') && !strstr($c, '&'))
    {
		return $c;
	}
});

define('IS_ADMIN', current($page) == 'admin' ? true : false);
$page = current($page) == 'watch' ? 'watch' : end($page);

global $database;
$limbs = new Limbs($database);
$mail = new Mail();
$main->send('brisklimbs@gmail.com', 'Frank Castle', 'Oye zinda', 'This freaking shit');
exit;

$users = new Users();
$limbs->stretch($page);
