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
        $quickTool = new QuickTool();
        $this->load->model('app/video_channel');
        $mac_address = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
        $channels = $this->model_app_video_channel->getListChannel($mac_address);
        if(!isset($channels) || sizeof($channels) <= 0){
            $dataChannel['channel_name'] = 'DuaLeo';
            $dataChannel['mac_address'] = $mac_address;
            $dataChannel['image'] = 'https://lh3.googleusercontent.com/-GdM-VboFuwA/AAAAAAAAAAI/AAAAAAAAAAA/-OUPTkEO1i4/photo.jpg';
            $this->model_app_video_channel->insert($dataChannel);

            $dataChannel['channel_name'] = 'Vitamin K';
            $dataChannel['mac_address'] = $mac_address;
            $dataChannel['image'] = STATIC_PATH . 'image/vitamink.jpg';
            $this->model_app_video_channel->insert($dataChannel);
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->load->model('app/home');
        $data['main'] = html_entity_decode($this->model_app_home->getHomeContent());
        if(!isset($data['main']) || empty($data['main'])){
            $data['main'] = "Review your model !!!";
        }
        $this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
	}
}