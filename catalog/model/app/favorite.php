<?php
class ModelAppFavorite extends Model {
    public function insert($data){
        $user_id = 0;
        if(isset($data['user_id'])){
            $user_id = (int)$data['user_id'];
        }
        $this->db->query("INSERT INTO ". DB_PREFIX ."favorite SET
                user_id = ". $user_id . ",
                mac_address='". $this->db->escape($data['mac_address']) ."'");
        return $this->db->getLastId();
    }
    public function update($data){
        $user_id = 0;
        if(isset($data['user_id'])){
            $user_id = (int)$data['user_id'];
        }
        $this->db->query("UPDATE ". DB_PREFIX . "favorite SET
        user_id = ". $user_id . ",
        mac_address='". $this->db->escape($data['mac_address']) ."'
        WHERE favorite_id = " . $data['favorite_id']);
    }

    // ============ Favorite songs ===============================================
    public function getFavoriteSongs($id, $page, $limit){
        $start = $page * $limit;
        $end = $start + $limit;
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias p LEFT JOIN ". DB_PREFIX ."favorite f
        ON p.favorite_id=f.favorite_id WHERE p.favorite_id = ". $id ." LIMIT ". $start .",". $end);
        return $query->rows;
    }

    public function getFavoriteSongsByMacAddress($macAddress, $page, $limit){
        $data['mac_address'] = $macAddress;
        $id = $this->insertData($data);
        $start = $page * $limit;
        $end = $start + $limit;

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias p LEFT JOIN ". DB_PREFIX ."favorite f
        ON p.favorite_id=f.favorite_id WHERE p.favorite_id = ". $id ." LIMIT ". $start .",". $end);
        return $query->rows;
    }

    // Favorite OBJECT =============================================================
    public function getFavoriteObjectByMacAddress($mac_address){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "favorite WHERE
        mac_address = '". $this->db->escape($mac_address) . "'");
        return $query->row;
    }

    public function insertData($data){
        $favorite = $this->getFavoriteObjectByMacAddress($data['mac_address']);
        if(isset($favorite['favorite_id'])){
            $this->load->model('app/url');
            $alias = $this->model_app_url->getAliasById(base64_decode($data['keyword']));
            if(isset($alias['url_alias_id'])){
                $id = $alias['url_alias_id'];
                $data['id'] = $id;
                $data['favorite_id'] = $favorite['favorite_id'];
                $this->model_app_url->update($data);
            }
            return $favorite['favorite_id'];
        }else{
            $id = $this->insert($data);
            $this->load->model('app/url');
            $data['favorite_id'] = $id;
            $data['id'] = base64_decode($data['keyword']);
            $this->model_app_url->update($data);
            return $id;
        }
    }
}