<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        /*
        $this->load->model('app/home');
        $data['main'] = html_entity_decode($this->model_app_home->getHomeContent());
        if(!isset($data['main']) || empty($data['main'])){
            $data['main'] = "Review your model !!!";
        }
        */

        // Test Patch ==============
        $quickTool = new QuickTool();
        $data['main'] = $quickTool->constructHomePage();


        $this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
	}
}