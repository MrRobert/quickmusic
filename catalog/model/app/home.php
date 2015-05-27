<?php
class ModelAppHome extends Model {
    public function insert($data){
        $query = $this->db->query("INSERT INTO ". DB_PREFIX ."home SET content='". $this->db->escape($data['content']) . "', date = NOW()");
    }
    public function update($data){
        $query = $this->db->query("UPDATE ". DB_PREFIX . "home SET content = '". $this->db->escape($data['content']) . "'");
    }

    public function count(){
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "home");
        return $query->row['total'];
    }

    public function insertOrUpdate($data){
        if($this->count() > 0){
            $this->update($data);
        }else{
            $this->insert($data);
        }
    }
}