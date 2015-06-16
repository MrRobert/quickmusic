<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppPlaylist extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }
        $playlist_id = 0;
        if(isset($this->request->get['pl_id'])){
            $playlist_id = (int) base64_decode($this->request->get['pl_id']);
        }
        $data = array();
        $this->load->model('app/playlist');
        $quickTool = new QuickTool();

        $playlist = $this->model_app_playlist->getPlaylistSongsByPlaylistId($playlist_id, 1 , 100);
        if(isset($playlist) && sizeof($playlist) > 0){
            foreach($playlist as $song){
                $link = base64_decode($song['query']);
                $title = $song['title'];
                $artis = $song['artis'];
                $img_src = $song['img_src'];

                $result = $quickTool->crawl_single_songv2_withlyric($link);
                $data['songs'][] = array(
                    'linkSong' => base64_encode($this->getLink($result['linkSong'])),
                    'title' => $title,
                    'artis' => $artis,
                    'img_src' => $img_src,
                    'spl_id' => $song['song_playlist_id'],
                    'lyric' => mb_convert_encoding($result['lyric'], 'html-entities', 'utf-8')
                );
            }
        }else{
            $data['playlist_theme'] = STATIC_PATH . 'image/playlist/playlist_'. rand(1, 5) .'.jpg';
        }

        $this->load->model('app/home');
        $promotionData = $this->model_app_home->getPromotionContent();
        if(isset($promotionData['promotion_albums']) && isset($promotionData['promotion_song'])){
            $data['promotion_albums'] = html_entity_decode($promotionData['promotion_albums']);
            $data['promotion_song'] = html_entity_decode($promotionData['promotion_song']);
        }

        $this->response->setOutput($this->load->view('default/template/app/playlist.tpl', $data));
    }

    private function getLink($link){
        $index1 = strpos($link, 'decodeURIComponent') + strlen('decodeURIComponent') + 2;
        $index2 = strrpos($link, ')') - 1;
        if(!empty($index1) && $index1 > 0 && !empty($index2) && $index2 > 0){
            return substr($link, $index1, $index2 - $index1);
        }
        return $link;
    }

    public function insert(){
        header('Content-Type: application/json');
        $this->load->model('app/playlist');
        $result = array();

        $quickTool = new QuickTool();
        $data['mac_address'] = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
        if(isset($this->request->post['playlist_name'])){
            $data['playlist_name'] = $this->request->post['playlist_name'];
        }else{
            $result['status'] = 'Error no playlist name';
            $this->response->setOutput(json_encode($result));
            return;
        }

        $result['status'] = "OK";
        $result['playlist_id'] = $this->model_app_playlist->insertData($data);
        $result['playlist_name'] = $data['playlist_name'];
        $this->response->setOutput(json_encode($result));
    }
}