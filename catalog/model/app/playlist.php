<?php
class ModelAppPlaylist extends Model {
    public function insert($data){
        $user_id = 0;
        if(isset($data['user_id'])){
            $user_id = (int)$data['user_id'];
        }
        $this->db->query("INSERT INTO ". DB_PREFIX ."playlist SET
                playlist_name = '". $this->db->escape($data['playlist_name']) . "',
                user_id = ". $user_id . ",
                mac_address='". $this->db->escape($data['mac_address']) ."',
                createDate = NOW()");
        return $this->db->getLastId();
    }

    public function count($data){
        $query = $this->db->query("SELECT count(*) FROM playlist WHERE mac_address='" . $this->db->escape($data['mac_address']) . "'");
        return $query->row['count(*)'];
    }

    public function update($data){
        $user_id = 0;
        if(isset($data['user_id'])){
            $user_id = (int)$data['user_id'];
        }
        $sql = "UPDATE ". DB_PREFIX . "playlist SET user_id =". $user_id;
        if(isset($data['playlist_name'])){
            $sql .= ", playlist_name = '". $this->db->escape($data['playlist_name']) ."'";
        }
        if(isset($data['mac_address'])){
            $sql .= ", mac_address = '". $this->db->escape($data['mac_address']) . "'";
        }
        $sql .= " WHERE playlist_id = ". $data['playlist_id'];

        $this->db->query($sql);
    }

    public function removePlaylist($data){
        if(isset($data['playlist_id'])){
            $this->db->query("DELETE FROM playlist WHERE mac_address = '". $this->db->escape($data['mac_address']) ."' AND playlist_id = ". (int) $data['playlist_id']);
            $this->db->query("DELETE FROM song_playlist WHERE playlist_id = ". (int) $data['playlist_id']);
        }
    }

    public function insertSongToPlaylist($songId ,$playlistId, $user_id){
        if(isset($user_id) && !empty($user_id)){
            $query =  $this->db->query("SELECT * from song_playlist WHERE url_alias_id = ". (int)$songId . " AND playlist_id = ". (int)$playlistId . " AND user_id = ". (int)$user_id);
            $result = $query->row;
        }else{
            $query =  $this->db->query("SELECT * from song_playlist WHERE url_alias_id = ". (int)$songId . " AND playlist_id = ". (int)$playlistId);
            $result = $query->row;
        }
        if(!isset($result) || empty($result['song_playlist_id'])){
            if(isset($user_id) && !empty($user_id)){
                $this->db->query("INSERT INTO song_playlist SET
                            url_alias_id = ". (int)$songId . ",
                            playlist_id = ".(int)$playlistId . ",
                            user_id = ".(int)$user_id);
            }else{
                $this->db->query("INSERT INTO song_playlist SET
                            url_alias_id = ". (int)$songId . ",
                            playlist_id = ".(int)$playlistId);
            }
            return "OK";
        }
        return "Duplicate";
    }

    public function removeSongPlaylist($song_playlist_id, $macAddress, $playlist_id){
        // CHECKING DELETE IS LEGAL ?
        $message = "It seem you're trying to delete a song of another. Plz stop it.";
        $querySf = $this->db->query("SELECT * from song_playlist WHERE song_playlist_id = ". (int)$song_playlist_id);
        $resultSf = $querySf->row;

        $queryF = $this->db->query("SELECT * from playlist WHERE mac_address = '". $this->db->escape($macAddress) . "', playlist_id = ".(int)$playlist_id);
        $resultF = $queryF->row;

        if(!isset($resultSf) || !isset($resultF)){
            return $message;
        }
        if($resultSf['playlist_id'] !== $resultF['playlist_id']){
            return $message;
        }
        $this->db->query("DELETE FROM song_playlist WHERE song_playlist_id =". (int)$song_playlist_id);
        return "OK";
    }

    // ============ Playlist songs ===============================================
    public function getPlaylistSongsByMacAddress($macAddress, $page, $limit){
        $data['mac_address'] = $macAddress;
        $id = 0; $result = array();
        $start = $page * $limit;
        $end = $start + $limit;

        $playlists = $this->getPlaylistByMacAddress($data['mac_address']);
        foreach($playlists as $playlist){
            if(isset($playlist['playlist_id'])){
                $id = $playlist['playlist_id'];
            }
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias p
                LEFT JOIN ". DB_PREFIX ."song_playlist f ON p.url_alias_id = f.url_alias_id
                WHERE f.playlist_id = ". (int)$id ." LIMIT ". (int)$start .",". (int)$end);
            $tmpData = $query->rows;
            if(isset($tmpData) && sizeof($tmpData) >0){
                $result['playlist'][] = array(
                    'playlist_id' => $playlist['playlist_id'],
                    'playlist_name' => mb_convert_encoding($playlist['playlist_name'], 'html-entities', 'utf-8'),
                    'playlist_count' => sizeof($tmpData),
                    'playlist_data' => $tmpData
                );
            }
        }
        return $result;
    }

    public function getPlaylistSongsByPlaylistId($playlist_id, $page, $limit){
        $start = $page * $limit;
        $end = $start + $limit;
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias p
                LEFT JOIN ". DB_PREFIX ."song_playlist f ON p.url_alias_id = f.url_alias_id
                WHERE f.playlist_id = ". (int)$playlist_id ." LIMIT ". (int)$start .",". (int)$end);
        return $query->rows;
    }


    // Favorite OBJECT =============================================================
    public function getPlaylistByMacAddress($mac_address){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "playlist WHERE
        mac_address = '". $this->db->escape($mac_address) . "'");
        return $query->rows;
    }

    public function getPlaylistByMacAddressPlusCount($mac_address){
        $query = $this->db->query("SELECT *,
                                    (select count(*) from song_playlist p LEFT JOIN playlist f ON p.playlist_id = f.playlist_id
                                        WHERE f.mac_address = '". $this->db->escape($mac_address) ."' AND f.playlist_id = pl.playlist_id) as count
                                    FROM " . DB_PREFIX . "playlist pl
                                    WHERE pl.mac_address = '". $this->db->escape($mac_address) . "'");
        return $query->rows;
    }

    public function getPlaylistById($id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "playlist WHERE
        playlist_id =". (int)$id);
        return $query->row;
    }

    public function insertData($data){
        $playlist_name = '';
        if(isset($data['playlist_name']) && !empty($data['playlist_name'])){
            $playlist_name = $data['playlist_name'];
        }
        $playlists = $this->getPlaylistByMacAddress($data['mac_address']);
        if(isset($playlists) && sizeof($playlists) > 0){
            foreach($playlists as $playlist){
                if(isset($playlist)){
                    if($playlist['playlist_name'] === $playlist_name){
                        // UPDATE SECTION =============================================
                        if(isset($data['keyword'])){
                            $songId = base64_decode($data['keyword']);
                            $playlistId = $playlist['playlist_id'];
                            // TODO : NOT HANDLE LOGIN YET
                            $user_id = null;
                            $this->insertSongToPlaylist($songId,$playlistId, $user_id);
                            return $playlist['playlist_id'];
                        }
                    }
                }
            }
        }
        // INSERT SESCTION ======== if update not run
        $playlistId = $this->insert($data);
        if(isset($data['keyword'])){
            $songId = base64_decode($data['keyword']);
            // TODO : NOT HANDLE LOGIN YET
            $user_id = null;
            $this->insertSongToPlaylist($songId, $playlistId, $user_id);
        }
        return $playlistId;
    }
}