<?php
// HTTP
define('APP_NAME' , 'quickmusic');
define('DIR_APP' , '/var/www/html/' . APP_NAME);
define('DOMAIN', 'localhost');

define('HTTP_SERVER', 'http://'. DOMAIN .'/'. APP_NAME . '/');
define('STATIC_PATH' , HTTP_SERVER . 'catalog/view/theme/default/');
// HTTPS
define('HTTPS_SERVER', 'http://'. DOMAIN .'/'. APP_NAME .'/');

// DIR
define('DIR_APPLICATION', DIR_APP . '/catalog/');
define('DIR_SYSTEM', DIR_APP . '/system/');
define('DIR_LANGUAGE', DIR_APP . '/catalog/language/');
define('DIR_TEMPLATE', DIR_APP . '/catalog/view/theme/');
define('DIR_CONFIG', DIR_APP . '/system/config/');
define('DIR_IMAGE', DIR_APP . '/image/');
define('DIR_CACHE', DIR_APP . '/system/cache/');
define('DIR_DOWNLOAD', DIR_APP . '/system/download/');
define('DIR_UPLOAD', DIR_APP . '/system/upload/');
define('DIR_MODIFICATION', DIR_APP . '/system/modification/');
define('DIR_LOGS', DIR_APP . '/system/logs/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'root');
define('DB_DATABASE', 'quickmusic');
define('DB_PREFIX', '');
