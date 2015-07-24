<?php
require_once DIR_SYSTEM . "helper/quickTool.php";
class ControllerAppAlbum extends Controller {
    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }
        if(isset($this->request->get['link'])){
            $albumLink = base64_decode($this->request->get['link']);
        }else return;
        if(isset($this->request->get['artis'])){
            $artis = base64_decode($this->request->get['link']);
        }else return;
        if(isset($this->request->get['title'])){
            $title = base64_decode($this->request->get['link']);
        }else return;

        $quickTool = new QuickTool();
        $listLinkSong = $quickTool->getImageAndLinkAlbumSongs($albumLink);
        $data = array();
        if(isset($listLinkSong) && sizeof($listLinkSong) > 0){
            foreach($listLinkSong['links'] as $linkSong){
                $dataTmp = $quickTool->crawl_single_song_detail($linkSong);
                $data['songs'][] = array(
                    'link'  => $dataTmp['linkSong'],
                    'lyric' => $dataTmp['lyric'],
                    'title' => $dataTmp['title'],
                    'img_src' => $dataTmp['img_src'],
                    'artis' => $dataTmp['artis'],
                    'albums' => $dataTmp['relatedAlbums']
                );
            }
        }
        if(sizeof($data) > 0){
            $this->load->model('app/album');
            $dataInsert['query'] = base64_encode($albumLink);
            $dataInsert['img_src'] = $listLinkSong['img_src'];
            $dataInsert['artis'] = $artis;
            $dataInsert['title'] = $title;
            $data['$albumId'] = $this->model_app_album->insertData($dataInsert);

            $dataTmp = $quickTool->loadAnotherPartSong($listLinkSong[0]);
            $data['promotion_song'] = $this->load->view('default/template/app/related.tpl', $dataTmp);
            $data['promotion_albums'] = $this->load->view('default/template/app/tileInterestedAlbum.tpl', $dataTmp);
        }
        $data['currentLink'] = HTTP_SERVER ."?route=app/album/" . $albumLink;
        $this->response->setOutput($this->load->view('default/template/app/album.tpl', $data));
    }
}