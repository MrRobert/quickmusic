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
        }
        $this->quickTool = new QuickTool();
        $result = $this->quickTool->crawl_single_song($link);
        header('Content-Type: application/json');
        $this->response->setOutput(json_encode($result));
    }
}