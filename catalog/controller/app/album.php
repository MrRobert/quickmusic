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
            $artis = base64_decode($this->request->get['artis']);
        }else return;
        if(isset($this->request->get['title'])){
            $title = base64_decode($this->request->get['title']);
        }else return;

        $quickTool = new QuickTool();
        $listLinkSong = $quickTool->getImageAndLinkAlbumSongs($albumLink);
        $data = array();
        if(isset($listLinkSong) && sizeof($listLinkSong) > 0){
            foreach($listLinkSong['links'] as $linkSong){
                $dataTmp = $quickTool->crawl_single_song_detail($linkSong);
                $lyric = (isset($dataTmp['lyric']))? $dataTmp['lyric'] : '';
                $title = (isset($dataTmp['title']))? $dataTmp['title'] : '';
                $img_src = (isset($dataTmp['img_src']))? $dataTmp['img_src'] : '';
                $artis = (isset($dataTmp['artis']))? $dataTmp['artis'] : '';
                $data['songs'][] = array(
                    'linkSong'  => base64_encode($this->getLink($dataTmp['linkSong'])),
                    'href' => base64_encode($quickTool->musicDomain. "/" . $linkSong),
                    'lyric' => $lyric,
                    'title' => $title,
                    'img_src' => $img_src,
                    'artis' => $artis,
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
            $data['albumId'] = $this->model_app_album->insertData($dataInsert);

            $dataTmp = $quickTool->loadAnotherPartSong($listLinkSong['links'][0]);
            $data['promotion_song'] = $this->load->view('default/template/app/related.tpl', $dataTmp);
            $data['promotion_albums'] = $this->load->view('default/template/app/tileInterestedAlbum.tpl', $dataTmp);
        }
        $data['currentLink'] = HTTP_SERVER ."?route=app/album/" . $albumLink;
        $this->response->setOutput($this->load->view('default/template/app/album.tpl', $data));
    }

    public function getAlbum(){
        if(isset($this->request->get['albumId'])){
            $album_id = (int) $this->request->get['albumId'];
        }else return;

        $this->load->model('app/album');
        $albumObject = $this->model_app_album->getAlbumById($album_id);
        if(isset($albumObject) && !empty($albumObject['album_id'])){
            $quickTool = new QuickTool();
            $originalLink = base64_decode($albumObject['query']);
            $listLinkSong = $quickTool->getImageAndLinkAlbumSongs($originalLink);
            $data = array();
            if(isset($listLinkSong) && sizeof($listLinkSong) > 0){
                foreach($listLinkSong['links'] as $linkSong){
                    $dataTmp = $quickTool->crawl_single_song_detail($linkSong);
                    $lyric = (isset($dataTmp['lyric']))? $dataTmp['lyric'] : '';
                    $title = (isset($dataTmp['title']))? $dataTmp['title'] : '';
                    $img_src = (isset($dataTmp['img_src']))? $dataTmp['img_src'] : '';
                    $artis = (isset($dataTmp['artis']))? $dataTmp['artis'] : '';
                    $data['songs'][] = array(
                        'linkSong'  => base64_encode($this->getLink($dataTmp['linkSong'])),
                        'href' => base64_encode($quickTool->musicDomain. "/" . $linkSong),
                        'lyric' => $lyric,
                        'title' => $title,
                        'img_src' => $img_src,
                        'artis' => $artis,
                        'albums' => $dataTmp['relatedAlbums']
                    );
                }
            }
            if(sizeof($data) > 0){
                $dataTmp = $quickTool->loadAnotherPartSong($listLinkSong['links'][0]);
                $data['promotion_song'] = $this->load->view('default/template/app/related.tpl', $dataTmp);
                $data['promotion_albums'] = $this->load->view('default/template/app/tileInterestedAlbum.tpl', $dataTmp);
            }
            $data['currentLink'] = HTTP_SERVER ."?route=app/album/" . $albumObject['query'];
            $this->response->setOutput($this->load->view('default/template/app/album.tpl', $data));
        }
    }

    private function getLink($link){
        $index1 = strpos($link, 'decodeURIComponent') + strlen('decodeURIComponent') + 2;
        $index2 = strrpos($link, ')') - 1;
        if(!empty($index1) && $index1 > 0 && !empty($index2) && $index2 > 0){
            return substr($link, $index1, $index2 - $index1);
        }
        return $link;
    }
}