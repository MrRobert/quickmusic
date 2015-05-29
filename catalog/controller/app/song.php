<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppSong extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }
        $link = ''; $title = ''; $img_src = ''; $artis = '';

        $this->load->model('app/url');
        $requestUri = $_SERVER['REQUEST_URI'];
        ///#song/aaaaa

        $link = "";
        if(isset($requestUri)){
            $lstPath = substr($requestUri, strrpos($requestUri, "/"));
            $key = base64_decode(substr($lstPath, strpos($lstPath, "_")));
            $link = $this->model_app_url->getQueryByKey($key);
        }
        // TODO : more code here

        if(isset($this->request->post['link'])){
            $link = $this->request->post['link'];
            if(is_array($link)){
                $link = $link['mp3'];
            }
            if(strpos($link, HTTP_SERVER) === 0){
                $link = substr($link, strpos($link, HTTP_SERVER) + strlen(HTTP_SERVER));
            }
        }
        $link = base64_decode($link);
        $this->quickTool = new QuickTool();
        $result = $this->quickTool->crawl_single_song($link);
        $songs = array();
        foreach($result as $song){
            $songs[] = array(
                'linkSong' => base64_encode($this->getLink($song['link']))
            );
        }
        // TODO : just a demo code must edit new Function to QuickTool
        if(isset($this->request->post['title'])){
            $title = $this->request->post['title'];
        }
        if(isset($this->request->post['img_src'])){
            $img_src = base64_decode($this->request->post['img_src']);
        }
        if(isset($this->request->post['artis'])){
            $artis = $this->request->post['artis'];
        }
        $data = array();
        $data['title'] = $title;
        $data['img_src'] = $img_src;
        $data['artis'] = $artis;
        $data['link'] = $songs[0]['linkSong'];
        $data['currentLink'] = HTTP_SERVER . '?route=app/song';

        $this->response->setOutput($this->load->view('default/template/app/song.tpl', $data));
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