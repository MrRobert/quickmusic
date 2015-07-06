<?php
class ControllerAppVideo extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }

        $data = array();
        $this->response->setOutput($this->load->view('default/template/app/video.tpl', $data));
    }

    public function playlist(){
        $videoId = '';
        if(isset($this->request->get['videoId'])){
            $videoId = $this->request->get['videoId'];
        }
        $data = array();
        $data['videoId'] = $videoId;
        $this->response->setOutput($this->load->view('default/template/app/video_playlist.tpl', $data));
    }
}