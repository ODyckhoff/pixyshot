<?php
class Session {
    function __construct() {
        if(session_status() == PHP_SESSION_NONE) {
            session_start();
        }
    }

    function sessionAdd($key,$value) {
        $_SESSION[$key] = $value;
    }

    function sessionIsSet($key) {
        return isset($_SESSION[$key]);
    }

    function sessionGet($key) {
        if($this->sessionIsSet($key)) {
            return $_SESSION[$key];
        }
        return NULL;
    }

    function sessionRemove($key) {
        unset($_SESSION[$key]);
    }

    function sessionDestroy() {
        session_destroy();
    }
}

