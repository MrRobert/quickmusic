<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppFavorite extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->et['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }
        $data = array();

        $this->load->model('app/favorite');
        $quickTool = new QuickTool();
        $aliasSong = $this->model_app_favorite->getFavoriteSongsByMacAddress($quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']), 0, 5);
        if(isset($aliasSong) && sizeof($aliasSong) > 0){
            foreach($aliasSong as $song){
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
                    'fs_id' => $song['song_favorite_id'],
                    'lyric' => mb_convert_encoding($result['lyric'], 'html-entities', 'utf-8')
                );
            }
        }
        $this->response->setOutput($this->load->view('default/template/app/favorite.tpl', $data));
    }

    public function loadsong(){

    }

    private function getLink($link){
        $index1 = strpos($link, 'decodeURIComponent') + strlen('decodeURIComponent') + 2;
        $index2 = strrpos($link, ')') - 1;
        if(!empty($index1) && $index1 > 0 && !empty($index2) && $index2 > 0){
            return substr($link, $index1, $index2 - $index1);
        }
        return $link;
    }

    public function remove(){
        $song_favorite_id = 0;
        if(isset($this->request->get['fs_id'])){
            $song_favorite_id = (int)$this->request->get['fs_id'];
        }
        $quickTool = new QuickTool();
        $macAddress = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);

        $this->load->model('app/favorite');
        $message = $this->model_app_favorite->removeSongFavorite($song_favorite_id, $macAddress);
        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($message));
    }
}