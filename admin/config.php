<?php

define('APP_NAME' , 'quickmusic');
define('DIR_APP' , '/var/www/html/' . APP_NAME);

// HTTP
define('HTTP_SERVER', 'http://localhost/'. APP_NAME .'/admin/');
define('HTTP_CATALOG', 'http://localhost/'. APP_NAME .'/');

// HTTPS
define('HTTPS_SERVER', 'http://localhost/'. APP_NAME .'/admin/');
define('HTTPS_CATALOG', 'http://localhost/'. APP_NAME .'/');

// DIR
define('DIR_APPLICATION', DIR_APP .'/admin/');
define('DIR_SYSTEM', DIR_APP .'/system/');
define('DIR_LANGUAGE', DIR_APP .'/admin/language/');
define('DIR_TEMPLATE', DIR_APP .'/admin/view/template/');
define('DIR_CONFIG', DIR_APP .'/system/config/');
define('DIR_IMAGE', DIR_APP .'/image/');
define('DIR_CACHE', DIR_APP .'/system/cache/');
define('DIR_DOWNLOAD', DIR_APP .'/system/download/');
define('DIR_UPLOAD', DIR_APP .'/system/upload/');
define('DIR_LOGS', DIR_APP .'/system/logs/');
define('DIR_MODIFICATION', DIR_APP .'/system/modification/');
define('DIR_CATALOG', DIR_APP .'/catalog/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'root');
define('DB_DATABASE', 'quickmusic');
define('DB_PREFIX', '');
