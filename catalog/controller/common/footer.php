<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerCommonFooter extends Controller {
	public function index() {
		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}

        $data = array();
        $this->load->model('app/playlist');

        $quickTool = new QuickTool();
        $macAddress = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
        $tmpData = $this->model_app_playlist->getPlaylistByMacAddressPlusCount($macAddress);
        if(isset($tmpData) && sizeof($tmpData) > 0){
            foreach($tmpData as $playlist){
                $data['playlist'][] = array(
                    'playlist_id' => $playlist['playlist_id'],
                    'playlist_name' => $playlist['playlist_name'],
                    'count' => $playlist['count']
                );
            }
        }
        return $this->load->view('default/template/common/footer.tpl', $data);
	}
}