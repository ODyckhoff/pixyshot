<?php

    /* define user levels */
    define( 'LVL_DEVELOPER', 0 );
    define( 'LVL_ADMIN',     1 );
    define( 'LVL_PREMIUM',   2 );
    define( 'LVL_USER',      3 );
    define( 'LVL_VISITOR',   4 );

    require_once(CFG . 'config.php');
    require_once(LIB . 'shared.php');

    $hw = new HelloWorld();

    $hw->hello_world();
