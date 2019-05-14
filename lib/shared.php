<?php

    function verifyURL() {
        if(isset($_SERVER['HTTPS']) && (PROTOCOL == 'http' || PROTOCOL == 'http://')) {
            header('Location:' . PROTOCOL . BASE_URI . $_SERVER['REQUEST_URI']);
        }
        elseif(!isset($_SERVER['HTTPS']) && (PROTOCOL == 'https' || PROTOCOL == 'https://')) {
            header('Location:' . PROTOCOL . BASE_URI . $_SERVER['REQUEST_URI']);
        }
    }

    function setReporting() {
        if(defined('DEV_ENV') && DEV_ENV == true) {
            error_reporting(E_ALL);
            ini_set('display_errors', '1');
        }
        else {
            error_reporting(E_ALL);
            ini_set('display_errors', 'Off');
            ini_set('log_errors', 'On');
            ini_set('error_log', ROOT . DS . 'var' . DS . 'log ' . DS . 'error.log');
        }
    }

    function stripSlashesDeep($value) {
        $value = is_array($value) ? array_map('stripSlashesDeep', $value) : stripslashes($value);
        return $value;
    }

    function removeMagicQuotes() {
        if(get_magic_quotes_gpc()) {
            $_GET = stripSlashesDeep($_GET);
            $_POST = stripSlashesDeep($_POST);
            $_COOKIE = stripSlashesDeep($_COOKIE);
        }
    }

    function unregisterGlobals() {
        if(ini_get('register_globals')) {
            $array = array('_SESSION', '_POST', '_GET', '_COOKIE', '_REQUEST', '_SERVER', '_ENV', '_FILES');
            foreach($array as $value) {
                foreach($GLOBALS[$value] as $key => $var) {
                    if($var === $GLOBALS[$key]) {
                        unset($GLOBALS[$key]);
                    }
                }
            }
        }
    }

    function endswith($string, $test) {
        $strlen = strlen($string);
        $testlen = strlen($test);
        if ($testlen > $strlen) return false;
        return substr_compare($string, $test, $strlen - $testlen, $testlen) === 0;
    }
    
    function human_filesize($bytes, $decimals = 2) {
        $sz = 'BKMGTP';
        $factor = floor((strlen($bytes) - 1) / 3);
        return sprintf("%.{$decimals}f", $bytes / pow(1024, $factor)) . @$sz[$factor];
    }

    spl_autoload_register(function($name) {
        include LIB . 'classes/' . strtolower($name) . '.class.php';
    });

    verifyURL();
    setReporting();
    removeMagicQuotes();
    unregisterGlobals();

