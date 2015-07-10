<?php
class ControllerAppFilm extends Controller {
    public function index() {
        $data = array();
        $this->response->setOutput($this->load->view('default/template/app/film.tpl', $data));
    }
}