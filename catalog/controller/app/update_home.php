<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppUpdateHome extends Controller {
    public function index() {
        header('Content-Type: application/json');
        $this->load->model('app/home');
        try{
            $quickTool = new QuickTool();
            $data = $quickTool->constructHomePage();
            $this->model_app_home->insertOrUpdate($data);
            $status = 'OK';
        }catch(Exception $e){
            $status = 'NOT OK!!!' . $e->getMessage();
        }
        $this->response->setOutput(json_encode($status));
    }
}