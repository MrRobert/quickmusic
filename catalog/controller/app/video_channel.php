<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppVideoChannel extends Controller {
    public function index() {
        header('Content-Type: application/json');
        $this->load->model('app/video_channel');

        $quickTool = new QuickTool();
        $input['mac_address'] = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
        $data = $this->model_app_video_channel->getListChannel($input);
        $result = array();
        if(isset($data)){
            foreach($data as $channel){
                $result['lstChannel'][] = array(
                    'video_channel_id' => $channel['video_channel_id'],
                    'channel_name' => $channel['channel_name']
                );
            }
        }
        $this->response->setOutput(json_encode($result));
    }

    public function insert(){
        header('Content-Type: application/json');
        $this->load->model('app/video_channel');
        $result['status'] = "OK";
        $result['imageLink'] = STATIC_PATH . 'image/youtube-channel.png';
        try{
            $quickTool = new QuickTool();
            $this->request->post['mac_address'] = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
            $result['channelId'] = $this->model_app_video_channel->insert($this->request->post);
        }catch (Exception $e){
            $result['status'] = 'NOT OK!!!' . $e->getMessage();
        }
        $this->response->setOutput(json_encode($result));
    }

    public function update(){
        header('Content-Type: application/json');
        $this->load->model('app/video_channel');
        $status = "OK";
        try{
            $quickTool = new QuickTool();
            $this->request->post['mac_address'] = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
            $this->model_app_video_channel->update($this->request->post);
        }catch (Exception $e){
            $status = 'NOT OK!!!' . $e->getMessage();
        }
        $this->response->setOutput(json_encode($status));
    }

    public function delete(){
        header('Content-Type: application/json');
        $this->load->model('app/video_channel');
        $status = "OK";
        try{
            $quickTool = new QuickTool();
            $this->request->post['mac_address'] = $quickTool->getMacAddressClient($_SERVER['REMOTE_ADDR']);
            $this->model_app_video_channel->remove($this->request->post);
        }catch (Exception $e){
            $status = 'NOT OK!!!' . $e->getMessage();
        }
        $this->response->setOutput(json_encode($status));
    }
}