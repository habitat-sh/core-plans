<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '{{bind.database.first.sys.ip}}';
$CFG->dbname    = '{{cfg.dbname}}';
$CFG->dbuser    = '{{bind.database.first.cfg.username}}';
$CFG->dbpass    = '{{bind.database.first.cfg.password}}';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => {{bind.database.first.cfg.port}},
  'dbsocket' => 'false',
  'dbcollation' => 'utf8mb4_unicode_ci',
);

if (empty($ip)):
  $ip=$_SERVER['SERVER_NAME'];
endif;
if (empty($ip)):
  $ip='localhost';
endif;
$CFG->wwwroot   = "http://" . $ip;
$CFG->dataroot  = '/hab/svc/moodle/data/dataroot';
$CFG->admin     = '{{cfg.adminuser}}';

$CFG->directorypermissions = 02777;

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// // it is intentional because it prevents trailing whitespace problems!
