<?php
class ControllerCommonColumnLeft extends Controller {
    public function index() {
        $data = array();
        return $this->load->view('default/template/common/column_left.tpl', $data);
    }
}