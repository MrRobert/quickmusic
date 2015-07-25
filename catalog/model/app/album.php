<?php
class ModelAppAlbum extends Model {
    public function insertData($data){
        $album_img = STATIC_PATH . 'image/default-album.png';
        if(isset($data['img_src'])){
            $album_img = $data['img_src'];
        }
        if(isset($data['title'])){
            $title = $data['title'];
        }else return 0;
        if(isset($data['artis'])){
            $artis = $data['artis'];
        }else return 0;
        if(isset($data['query'])){
            $query = $data['query'];
        }else return 0;
        $checkData = $this->getAlbumByQuery($query);
        if(isset($checkData) && sizeof($checkData)> 0 && $checkData['album_id'] > 0){
           return $checkData['album_id'];   // already exited !!!
        }
        $this->db->query("INSERT INTO ". DB_PREFIX ."album SET
                title ='". $this->db->escape($title) . "',
                img_src ='". $this->db->escape($album_img) . "',
                artis ='". $this->db->escape($artis) . "',
                query ='". $this->db->escape($query) . "'");
        return $this->db->getLastId();
    }

    public function getAlbumById($album_id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "album WHERE album_id = ". (int)$album_id);
        return $query->row;
    }

    public function getAlbumByQuery($query){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "album WHERE query = '". $this->db->escape($query) . "'");
        return $query->row;
    }
}