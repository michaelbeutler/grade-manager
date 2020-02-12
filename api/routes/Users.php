<?php
class Users
{
    public function __construct(Database $db)
    {
        $this->db = $db;
        $this->table = "users";
    }

    public function get($id = false, $url_params = [])
    {
        if (isset($url_params["limit"])) {
            $limit = intval($url_params["limit"]);
        }
        $limit = isset($url_params["limit"]) ? intval($url_params["limit"]) : 1000;


        // return sql result in json format
        if ($id) {
            $this->db->findFirst($this->table, ["conditions" => ["id=$id"]]);
            echo json_encode($this->db->results(), JSON_THROW_ON_ERROR | JSON_PRETTY_PRINT);
        } else {
            $this->db->find($this->table, ["limit" => $limit]);
            echo json_encode($this->db->results(), JSON_THROW_ON_ERROR | JSON_PRETTY_PRINT);
        }
    }
    public function post($params, $url_params = [])
    {
        if ($this->db->insert($this->table, $url_params)) {
            http_response_code(201);
        } else {
            http_response_code(400);
        }
    }
    public function put($id = false, $url_params = [])
    {
        if ($id) {
            if ($this->db->findFirst($this->table, ["conditions" => ["id=$id"]])) {
                if ($this->db->update($this->table, $id, $url_params)) {
                    http_response_code(201);
                } else {
                    http_response_code(204);
                }
            } else {
                http_response_code(404);
            }
        }
    }
}
