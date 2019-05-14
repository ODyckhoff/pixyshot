<?php
class SQLQuery {
    protected $_dbHandle;
    protected $_querystr;
    protected $_result;

    function connect($address, $account, $password, $name) {
        $dsn = 'mysql:dbname=' . $name . ';host=' . $address;
        try {
            $this->_dbHandle = new PDO($dsn, $account, $password);
        }
        catch(PDOException $ex) {
            echo "Database Error: " . $ex->getMessage();
        }
    }

    function disconnect() {
        $this->_dbHandle = NULL;
    }

    function handle() {
        return $this->_dbHandle;
    }

    function selectAll($table) {
        $this->_querystr = 'SELECT * FROM `' . $table . '`';
        return $this;
    }

    function select($items, $table) {
        if(!is_array($items)) {
            $items = array($items);
        }
        $this->_querystr = 'SELECT ' . implode(',', $items) . ' FROM `' . $table . '`'; 
        return $this;
    }

    function insert($table, $values) {
        if(!is_array($values)) {
            $values = array($values);
        }
        $this->_querystr = 'INSERT INTO '  . $table . ' VALUES(' . implode(', ', $values) . ');';
        return $this;
    }

    function update($table) {
        $this->_querystr = 'UPDATE ' . $table;
        return $this;
    }
    
    function deleteFrom($table) {
        $this->_querystr = 'DELETE FROM ' . $table;
        return $this;
    }

    function set($clause) {
        $this->_querystr .= ' SET ' . $clause;
        return $this;
    }

    function where($clause) {
        $this->_querystr .= ' WHERE ' . $clause;
        return $this;
    }

    function opengroup() {
        $this->_querystr .= '(';
        return $this;
    }

    function closegroup() {
        $this->_querystr .= ')';
        return $this;
    }

    function _and($clause) {
        $this->_querystr .= ' AND ' . $clause;
        return $this;
    }

    function _or($clause) {
        $this->_querystr .= ' OR ' . $clause;
        return $this;
    }

    function _join($type, $table, $on) {
        $this->_querystr .= ' ' . strtoupper($type) . ' JOIN ' . $table . ' ON ' . $on;
        return $this;
    }

    function order($col, $type = 'asc') {
        $this->_querystr .= ' order by ' . $col . ' ' . $type;
        return $this;
    }

    function _end() {
        $this->_querystr .= ';';
        return $this;
    }

    function prepare() {
        $this->_query = $this->_dbHandle->prepare($this->_querystr);
    }

    function bindParam($param, $value) {
        $this->_query->bindParam($param, $value);
    }

    function execute() {
        return $this->_query->execute();
    }

    function getResult() {
        return $this->_query->fetch(PDO::FETCH_ASSOC);
    }

    function getAll($style = PDO::FETCH_ASSOC) {
        return $this->_query->fetchAll($style);
    }

    function getErr() {
        return "(" . $this->_query->errorCode() . ") : " . implode(', ', $this->_query->errorInfo());
    }
}

