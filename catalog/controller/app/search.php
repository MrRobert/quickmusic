<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppSearch extends Controller {
    public function index() {
        $search_name = '';
        if(isset($this->request->get['search_name'])){
            $search_name = $this->request->get['search_name'];
        }

        $quickTool = new QuickTool();
        $data = $quickTool->crawl_song_album($search_name);

        $this->response->setOutput($this->load->view('default/template/app/search.tpl', $data));
    }
}