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
        var_dump($aliasSong);
        if(isset($aliasSong) && sizeof($aliasSong) > 0){
            foreach($aliasSong as $song){
                $link = $song['query'];
                $title = $song['title'];
                $artis = $song['artis'];
                $img_src = $song['img_src'];

                $result = $quickTool->crawl_single_song($link);
                $data['songs'][] = array(
                    'linkSong' => base64_encode($this->getLink($result['song'][0]['link'])),
                    'title' => $title,
                    'artis' => $artis,
                    'img_src' => $img_src
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
}