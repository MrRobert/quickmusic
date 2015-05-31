<?php
class ModelAppUrl extends Model {
    public function insert($data){
        $query = $this->db->query("INSERT INTO ". DB_PREFIX ."url_alias SET
                keyword='". $this->db->escape($data['keyword']) . "',
                title='". $this->db->escape($data['title']) . "',
                img_src='". $this->db->escape($data['img_src']) . "',
                artis='". $this->db->escape($data['artis']) . "',
                query='". $this->db->escape($data['query']) ."'");
        return $this->db->getLastId();
    }
    public function update($data){
        $query = $this->db->query("UPDATE ". DB_PREFIX . "url_alias SET keyword = '". $this->db->escape($data['keyword']) . "', query='". $this->db->escape($data['query']) ."' WHERE url_alias_id = " . $data['id']);
    }

    public function getQueryById($id){
        $query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE url_alias_id = ". $id);
        return $query->row['query'];
    }

    public function getAliasByKey($key){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '". $this->db->escape($key) . "'");
        return $query->row;
    }

    public function getAliasByLink($link){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = '". $this->db->escape($link) . "'");
        return $query->row;
    }

    public function insertData($data){
        $alias = $this->getAliasByLink($data['query']);
        if(isset($alias['keyword'])){
            return $alias['keyword'];
        }else{
            $id = $this->insert($data);
            $data['keyword'] = base64_encode($id);
            $data['id'] = $id;
            $this->update($data);
            return base64_encode($id);
        }
    }
}