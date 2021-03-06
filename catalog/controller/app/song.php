<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppSong extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));
        $data = array();

        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }
        $link = ""; $keyword = ''; $title = ''; $img_src = ''; $artis = '';
        $this->load->model('app/url');

        if(isset($this->request->post['title'])){
            $title = $this->request->post['title'];
        }
        if(isset($this->request->post['img_src'])){
            $img_src = base64_decode($this->request->post['img_src']);
        }
        if(isset($this->request->post['artis'])){
            $artis = $this->request->post['artis'];
        }
        if(isset($this->request->post['link'])){
            $link = $this->request->post['link'];
            if(is_array($link)){
                $link = $link['mp3'];
            }
            if(strpos($link, HTTP_SERVER) === 0){
                $link = substr($link, strpos($link, HTTP_SERVER) + strlen(HTTP_SERVER));
            }
            $object['query'] = $link;
            $object['keyword'] = '';
            $object['title'] = $title;
            $object['img_src'] = $img_src;
            $object['artis'] = $artis;
            $keyword = $this->model_app_url->insertData($object);
        }
        if(empty($link)){
            if(isset($this->request->get['keyword'])){
                $keyword = $this->request->get['keyword'];
                $alias = $this->model_app_url->getAliasByKey($keyword);
                if(isset($alias)){
                    $link = $alias['query'];
                    $title = $alias['title'];
                    $img_src = $alias['img_src'];
                    if(!isset($img_src) || empty($img_src)){
                        $img_src = STATIC_PATH . 'image/default-song.jpg';
                    }
                    $artis = $alias['artis'];
                }
            }
        }
        $data['orginLink'] = $link;
        $link = base64_decode($link);
        $quickTool = new QuickTool();
        $result = $quickTool->crawl_single_song($link);
        $songs = array();
        foreach($result as $song){
            $songs[] = array(
                'linkSong' => base64_encode($this->getLink($song['link']))
            );
        }
        $data['title'] = $title;
        $data['img_src'] = $img_src;
        $data['artis'] = $artis;
        $data['link'] = $songs[0]['linkSong'];
        $data['key'] = $keyword;
        $data['currentLink'] = HTTP_SERVER . '?route=app/song/'. $keyword;

        $this->load->model('app/playlist');
        $macAddress = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
        $tmpData = $this->model_app_playlist->getPlaylistByMacAddressPlusCount($macAddress);
        if(isset($tmpData) && sizeof($tmpData) > 0){
            foreach($tmpData as $playlist){
                $data['playlists'][] = array(
                    'playlist_id' => $playlist['playlist_id'],
                    'playlist_name' => $playlist['playlist_name'],
                    'count' => $playlist['count']
                );
            }
        }
        $this->response->setOutput($this->load->view('default/template/app/song.tpl', $data));
    }

    public function fetchsong(){
        $link = '';
        if(isset($this->request->post['link'])){
            $link = base64_decode($this->request->post['link']);
            if(is_array($link)){
                $link = $link['mp3'];
            }
            if(strpos($link, HTTP_SERVER) === 0){
                $link = substr($link, strpos($link, HTTP_SERVER) + strlen(HTTP_SERVER));
            }
        }
        $quickTool = new QuickTool();
        $result = $quickTool->crawl_single_song($link);
        $songs = array();
        foreach($result as $song){
            $songs[] = array(
                'linkSong' => base64_encode($this->getLink($song['link']))
            );
        }
        $data['linkSong'] = $songs[0]['linkSong'];
        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($data));
    }

    public function gotosong(){
        $link = ""; $key = ''; $title = ''; $img_src = ''; $artis = '';
        $this->load->model('app/url');

        if(isset($this->request->post['title'])){
            $title = $this->request->post['title'];
        }
        if(isset($this->request->post['img_src'])){
            $img_src = base64_decode($this->request->post['img_src']);
        }
        if(isset($this->request->post['artis'])){
            $artis = $this->request->post['artis'];
        }
        if(isset($this->request->post['link'])){
            $link = $this->request->post['link'];
            if(is_array($link)){
                $link = $link['mp3'];
            }
            if(strpos($link, HTTP_SERVER) === 0){
                $link = substr($link, strpos($link, HTTP_SERVER) + strlen(HTTP_SERVER));
            }
            $object['query'] = $link;
            $object['keyword'] = '';
            $object['title'] = $title;
            $object['img_src'] = $img_src;
            $object['artis'] = $artis;
            $key = $this->model_app_url->insertData($object);
        }
        $data['keyword'] = $key;
        $data['rootUrl'] = HTTP_SERVER;
        $data['title'] = $title;
        $data['artis'] = $artis;
        $data['currentLink'] = HTTP_SERVER . '?route=app/song/'. $key;

        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($data));
    }

    private function getLink($link){
        $index1 = strpos($link, 'decodeURIComponent') + strlen('decodeURIComponent') + 2;
        $index2 = strrpos($link, ')') - 1;
        if(!empty($index1) && $index1 > 0 && !empty($index2) && $index2 > 0){
            return substr($link, $index1, $index2 - $index1);
        }
        return $link;
    }

    /*
     * Another part of a song
     */
    public function infosong(){
        $link = '';
        if(isset($this->request->get['link'])){
            $link = base64_decode($this->request->get['link']);
        }
        $quickTool = new QuickTool();
        $result = $quickTool->loadAnotherPartSong($link);
        $data = array();

        $data['lyric'] = $this->load->view('default/template/app/lyric.tpl', $result);
        $data['related'] = $this->load->view('default/template/app/related.tpl', $result);
        $data['relatedAlbums'] = $this->load->view('default/template/app/tileInterestedAlbum.tpl', $result);
        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($data));
    }

    public function getsongv2(){
        $link = ""; $key = ''; $title = ''; $img_src = ''; $artis = '';
        $this->load->model('app/url');

        if(isset($this->request->post['title'])){
            $title = $this->request->post['title'];
        }
        if(isset($this->request->post['img_src'])){
            $img_src = base64_decode($this->request->post['img_src']);
        }
        if(isset($this->request->post['artis'])){
            $artis = $this->request->post['artis'];
        }
        if(isset($this->request->post['link'])){
            $link = $this->request->post['link'];
            if(is_array($link)){
                $link = $link['mp3'];
            }
            if(strpos($link, HTTP_SERVER) === 0){
                $link = substr($link, strpos($link, HTTP_SERVER) + strlen(HTTP_SERVER));
            }
            $object['query'] = $link;
            $object['keyword'] = '';
            $object['title'] = $title;
            $object['img_src'] = $img_src;
            $object['artis'] = $artis;
            $key = $this->model_app_url->insertData($object);
        }
        if(empty($link)){
            if(isset($this->request->get['keyword'])){
                $keyword = $this->request->get['keyword'];
                $alias = $this->model_app_url->getAliasByKey($keyword);
                if(isset($alias)){
                    $link = $alias['query'];
                    $title = $alias['title'];
                    $img_src = $alias['img_src'];
                    $artis = $alias['artis'];
                }
            }
        }
        $data['orginLink'] = $link;
        $link = base64_decode($link);
        $this->quickTool = new QuickTool();
        $result = $this->quickTool->crawl_single_songv2($link);
        $inputData = array();
        $inputData['title'] = $title;
        $inputData['img_src'] = $img_src;
        $inputData['artis'] = $artis;
        $inputData['link'] = base64_encode($this->getLink($result['linkSong']));
        $this->load->model('app/playlist');
        $quickTool = new QuickTool();
        $macAddress = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
        $tmpData = $this->model_app_playlist->getPlaylistByMacAddressPlusCount($macAddress);
        if(isset($tmpData) && sizeof($tmpData) > 0){
            foreach($tmpData as $playlist){
                $inputData['playlists'][] = array(
                    'playlist_id' => $playlist['playlist_id'],
                    'playlist_name' => $playlist['playlist_name'],
                    'count' => $playlist['count']
                );
            }
        }
        $data['keyword'] = $key;
        $data['currentLink'] = HTTP_SERVER . '?route=app/song/' . $key;
        $data['lyric'] = $this->load->view('default/template/app/lyric.tpl', $result);
        $data['tileSong'] = $this->load->view('default/template/app/tileSong.tpl', $inputData);
        $data['tileImg'] = $this->load->view('default/template/app/tileImg.tpl', $inputData);
        $data['relatedAlbums'] = $this->load->view('default/template/app/tileInterestedAlbum.tpl', $result);

        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($data));
    }

    public function addfavorite(){
        $keyword ='';
        if(isset($this->request->get['keyword'])){
            $keyword = $this->request->get['keyword'];
        }
        if(!empty($keyword)){
            $this->load->model('app/favorite');

            $ipAddress=$_SERVER['REMOTE_ADDR'];
            $data['mac_address'] = QuickTool::getMacAddressClient($ipAddress);
            $data['keyword'] = $keyword;
            $this->model_app_favorite->insertData($data);

            header('Content-Type: application/json');
            $this->response->setOutput(json_encode("OK"));
        }
    }
}