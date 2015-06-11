<?php
class ModelAppHome extends Model {
    public function insert($data){
        $promotionAlbums = '';
        $promotionSong = '';
        $music_vn = ''; $music_uk = '';
        if(isset($data['promotion_albums'])){
            $promotionAlbums = $data['promotion_albums'];
        }
        if(isset($data['promotion_song'])){
            $promotionSong = $data['promotion_song'];
        }
        if(isset($data['music_vn'])){
            $music_vn = $data['music_vn'];
        }
        if(isset($data['music_uk'])){
            $music_uk = $data['music_uk'];
        }
        $this->db->query("INSERT INTO ". DB_PREFIX ."home SET
                content='". $this->db->escape($data['content']) . "',
                promotion_albums='". $this->db->escape($promotionAlbums) . "',
                promotion_song='". $this->db->escape($promotionSong) . "',
                music_vn='". $this->db->escape($music_vn) . "',
                music_uk='". $this->db->escape($music_uk) . "',
                date = NOW()");
    }
    public function update($data){
        $promotionAlbums = '';
        $promotionSong = '';
        $music_vn = ''; $music_uk = '';
        if(isset($data['promotion_albums'])){
            $promotionAlbums = $data['promotion_albums'];
        }
        if(isset($data['promotion_song'])){
            $promotionSong = $data['promotion_song'];
        }
        if(isset($data['music_vn'])){
            $music_vn = $data['music_vn'];
        }
        if(isset($data['music_uk'])){
            $music_uk = $data['music_uk'];
        }
        $this->db->query("UPDATE ". DB_PREFIX . "home SET
        content = '". $this->db->escape($data['content']) . "',
        promotion_albums = '". $this->db->escape($promotionAlbums) . "',
        promotion_song = '". $this->db->escape($promotionSong). "',
        music_vn='". $this->db->escape($music_vn) . "',
        music_uk='". $this->db->escape($music_uk) . "'
        WHERE home_id > 0");
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
    public function getMusicTabContent(){
        $query = $this->db->query("SELECT music_vn, music_uk FROM home WHERE home_id > 0");
        return $query->row;
    }
    public function insertPromotion($data){
        if($this->count() > 0){
            $this->update($data);
        }
    }
}