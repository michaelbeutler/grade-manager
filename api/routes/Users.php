<?php
class Users
{
    public function __construct($table, $columns) {
        $this->table = $table;
        $this->columns = $columns;
    }

    public function get($id = false) {
        // return sql result in json format
        if ($id) {
            echo "GET USER WITH ID: $id";
        } else {
            echo "GET USERS";
        }
    }
}
