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

    public function insertSongToFavorite($songId ,$favoriteId, $user_id){
        if(isset($user_id) && !empty($user_id)){
            $query =  $this->db->query("SELECT * from song_favorite WHERE url_alias_id = ". (int)$songId . " AND favorite_id = ". (int)$favoriteId . " AND user_id = ". (int)$user_id);
            $result = $query->row;
        }else{
            $query =  $this->db->query("SELECT * from song_favorite WHERE url_alias_id = ". (int)$songId . " AND favorite_id = ". (int)$favoriteId);
            $result = $query->row;
        }
        if(!isset($result) || empty($result['song_favorite_id'])){
            if(isset($user_id) && !empty($user_id)){
                $this->db->query("INSERT INTO song_favorite SET
                            url_alias_id = ". (int)$songId . ",
                            favorite_id = ".(int)$favoriteId . ",
                            user_id = ".(int)$user_id);
            }else{
                $this->db->query("INSERT INTO song_favorite SET
                            url_alias_id = ". (int)$songId . ",
                            favorite_id = ".(int)$favoriteId);
            }
        }
    }

    public function removeSongFavorite($song_favorite_id, $macAddress){
        // CHECKING DELETE IS LEGAL ?
        $message = "It seem you're trying to delete a song of another. Plz stop it.";
        $querySf = $this->db->query("SELECT * from song_favorite WHERE song_favorite_id = ". (int)$song_favorite_id);
        $resultSf = $querySf->row;

        $queryF = $this->db->query("SELECT * from favorite WHERE mac_address = '". $this->db->escape($macAddress) . "'");
        $resultF = $queryF->row;

        if(!isset($resultSf) || !isset($resultF)){
            return $message;
        }
        if($resultSf['favorite_id'] !== $resultF['favorite_id']){
            return $message;
        }
        $this->db->query("DELETE FROM song_favorite WHERE song_favorite_id =". (int)$song_favorite_id);
        return "OK";
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
        $id = 0;
        $favorite = $this->getFavoriteObjectByMacAddress($data['mac_address']);
        if(isset($favorite['favorite_id'])){
            $id = $favorite['favorite_id'];
        }

        $start = $page * $limit;
        $end = $start + $limit;

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias p
        LEFT JOIN ". DB_PREFIX ."song_favorite f ON p.url_alias_id = f.url_alias_id
        WHERE f.favorite_id = ". (int)$id ." LIMIT ". (int)$start .",". (int)$end);
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
            $songId = base64_decode($data['keyword']);
            $favoriteId = $favorite['favorite_id'];
            // TODO : NOT HANDLE LOGIN YET
            $user_id = null;
            $this->insertSongToFavorite($songId,$favoriteId, $user_id);
            return $favorite['favorite_id'];
        }else{
            $favoriteId = $this->insert($data);
            $songId = base64_decode($data['keyword']);
            // TODO : NOT HANDLE LOGIN YET
            $user_id = null;
            $this->insertSongToFavorite($songId, $favoriteId, $user_id);
            return $favoriteId;
        }
    }
}