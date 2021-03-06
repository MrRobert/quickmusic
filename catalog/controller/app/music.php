<?php
class ControllerAppMusic extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }
        $this->load->model('app/home');
        $data = $this->model_app_home->getMusicTabContent();

        $this->response->setOutput($this->load->view('default/template/app/music.tpl', $data));
    }
}