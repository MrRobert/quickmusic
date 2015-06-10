<?php
class ModelAppHome extends Model {
    public function insert($data){
        $query = $this->db->query("INSERT INTO ". DB_PREFIX ."home SET content='". $this->db->escape($data['content']) . "', date = NOW()");
    }
    public function update($data){
        $query = $this->db->query("UPDATE ". DB_PREFIX . "home SET
        content = '". $this->db->escape($data['content']) . "',
        promotion_albums = '". $this->db->escape($data['promotion_albums']) . "',
        promotion_song = '". $this->db->escape($data['promotion_song']). "' WHERE home_id > 0");
    }

    public function count(){
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "home");
        return $query->row['total'];
    }

    public function getHomeContent(){
        $query = $this->db->query("SELECT content FROM " . DB_PREFIX . "home WHERE home_id > 0");
        return $query->row['content'];
    }

    public function insertOrUpdate($data){
        if($this->count() > 0){
            $this->update($data);
        }else{
            $this->insert($data);
        }
    }
    public function getPromotionContent(){
        $query = $this->db->query("SELECT promotion_albums, promotion_song FROM home WHERE home_id > 0");
        return $query->row;
    }
    public function insertPromotion($data){
        if($this->count() > 0){
            $this->update($data);
        }
    }
}