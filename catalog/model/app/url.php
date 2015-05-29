<?php
class ModelAppUrl extends Model {
    public function insert($data){
        $query = $this->db->query("INSERT INTO ". DB_PREFIX ."url_alias SET keyword='". $this->db->escape($data['keyword']) . "', query='". $this->db->escape($data['query']) ."'");
        return mysql_insert_id();
    }
    public function update($data){
        $query = $this->db->query("UPDATE ". DB_PREFIX . "url_alias SET keyword = '". $this->db->escape($data['keyword']) . "', query='". $this->db->escape($data['query']) ."'");
    }

    public function getQueryById($id){
        $query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE url_alias_id = ". $id);
        return $query->row['query'];
    }

    public function getQueryByKey($key){
        $query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE keyword = ". $key);
        return $query->row['query'];
    }

    public function insertOrUpdate($data){
        $query = $this->getQueryById($data['id']);
        if(isset($query) && !empty($query)){
            $this->update($data);
        }else{
            $this->insert($data);
        }
    }
}