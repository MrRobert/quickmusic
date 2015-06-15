<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerCommonColumnLeft extends Controller {
    public function index() {
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
        return $this->load->view('default/template/common/column_left.tpl', $data);
    }
}