<?php
class Exams
{
    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function get($id = false)
    {
        // return sql result in json format
        if ($id) {
            $this->db->findFirst("exames", ["conditions" => ["id=$id"]]);
            echo json_encode($this->db->results(), JSON_THROW_ON_ERROR | JSON_PRETTY_PRINT);
        } else {
            $this->db->query("SELECT * FROM `exames`;", []);
            echo json_encode($this->db->results(), JSON_THROW_ON_ERROR | JSON_PRETTY_PRINT);
        }
    }
    public function post($params)
    {
        $this->db->insert("exames", $params);
    }
}
