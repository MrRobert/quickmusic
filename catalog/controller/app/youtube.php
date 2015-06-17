<?php
class ControllerAppYoutube extends Controller {
    public function index() {
        $this->response->setOutput($this->load->view('default/template/app/testYoutube.tpl'));
    }
}