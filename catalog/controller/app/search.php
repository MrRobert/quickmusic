<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppSearch extends Controller {
    private $quickTool;

    public function index() {
        $search_name = '';
        if(isset($this->request->get['search_name'])){
            $search_name = $this->request->get['search_name'];
        }

        $this->quickTool = new QuickTool();
        $data = $this->quickTool->crawl_song_album($search_name);

        $this->response->setOutput($this->load->view('default/template/app/search.tpl', $data));
    }

    public function getsong(){
        $link = '';
        if(isset($this->request->get['link'])){
            $link = $this->request->get['link'];
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
        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($songs));
    }
    public function playsong(){
        $src =  '';
        if(isset($this->request->get['src'])){
            $src = $this->request->get['src'];
        }
        $src = base64_decode($src);
        $src = urldecode($src);

        header('Content-Type: audio/m4a, audio/mp3');
        $this->response->setOutput(readfile($src));
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