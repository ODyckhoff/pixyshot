<?php

class User {
    protected $userid;
    protected $username;
    protected $realname;
    protected $displayreal;
    protected $loggedin;
    protected $userlevel;

    function __construct($userid, $username, $realname, $displayreal, $loggedin, $userlevel) {
        $this->userid = $userid;
        $this->username = $username;
        $this->realname = $realname;
        $this->displayreal = $displayreal;
        $this->loggedin = $loggedin;
        $this->userlevel = $userlevel;
    }
}
