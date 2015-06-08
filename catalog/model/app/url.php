<?php
class ModelAppUrl extends Model {
    public function insert($data){
        $this->db->query("INSERT INTO ". DB_PREFIX ."url_alias SET
                keyword='". $this->db->escape($data['keyword']) . "',
                title='". $this->db->escape($data['title']) . "',
                img_src='". $this->db->escape($data['img_src']) . "',
                artis='". $this->db->escape($data['artis']) . "',
                query='". $this->db->escape($data['query']) ."'");
        return $this->db->getLastId();
    }
    public function update($data){
        $title = ''; $img_src = ''; $artis = '';
        if(isset($data['title'])){
            $title = $data['title'];
        }
        if(isset($data['img_src'])){
            $img_src = $data['img_src'];
        }
        if(isset($data['artis'])){
            $artis = $data['artis'];
        }
        $sql = "UPDATE ". DB_PREFIX . "url_alias SET ";
        if(isset($data['keyword']) && !empty($data['keyword'])){
            $sql .= "keyword = '". $this->db->escape($data['keyword']) . "' ";
        }
        if(isset($data['query']) && !empty($data['query'])){
            $sql .= ",query = '". $this->db->escape($data['query']) . "' ";
        }
        if(!empty($title)){
            $sql .= ",title = '". $title . "' ";
        }
        if(!empty($img_src)){
            $sql .= ",img_src = '". $img_src . "' ";
        }
        if(!empty($artis)){
            $sql .= ",artis = '". $artis . "' ";
        }
        $sql .= "WHERE url_alias_id = " . (int)$data['id'];

        $this->db->query($sql);
    }

    public function getQueryById($id){
        $query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE url_alias_id = ". $id);
        return $query->row['query'];
    }

    public function getAliasById($id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE url_alias_id = ". $id);
        return $query->row;
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