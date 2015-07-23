<?php
class ModelAppVideoChannel extends Model {
    public function insert($data){
        $channelName = '';
        $channelImage = STATIC_PATH . 'image/youtube-channel.png';
        if(isset($data['channel_name'])){
            $channelName = $data['channel_name'];
        }
        if(isset($data['image'])){
            $channelImage = $data['image'];
        }
        if(!isset($data['mac_address'])){
            return;
        }
        $this->db->query("INSERT INTO ". DB_PREFIX ."video_channel SET
                channel_name ='". $this->db->escape($channelName) . "',
                image='". $this->db->escape($channelImage) . "',
                mac_address='". $data['mac_address'] ."',
                date = NOW()");
        return $this->db->getLastId();
    }
    public function update($data){
        $channelImage = STATIC_PATH . 'image/youtube-channel.png';
        if(isset($data['channel_name'])){
            $channelName = $data['channel_name'];
        }else return;
        if(isset($data['image'])){
            $channelImage = $data['image'];
        }
        if(isset($data['video_channel_id'])){
            $this->db->query("UPDATE ". DB_PREFIX . "video_channel SET
            channel_name = '". $this->db->escape($channelName) . "',
            image = '". $this->db->escape($channelImage) . "'
            WHERE video_channel_id = ". (int) $data['video_channel_id'] ." AND mac_address ='". $this->db->escape($data['mac_address']) . "'");
        }
    }

    public function remove($data){
        if(isset($data['video_channel_id'])){
            $this->db->query("DELETE FROM video_channel WHERE mac_address = '". $this->db->escape($data['mac_address']) ."' AND video_channel_id = ". (int) $data['video_channel_id']);
        }
    }

    public function getListChannel($mac_address){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "video_channel WHERE mac_address = '". $this->db->escape($mac_address) . "'");
        return $query->rows;
    }
}