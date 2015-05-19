<?php
class QuickTool {
    private $musicSources = "http://search.chiasenhac.com/search.php?s=";
    private $musicDomain = "http://chiasenhac.com";
    private $searchArray = array();

    function crawler($url){
        $result = array();
        static $seen = array();
        if (isset($seen[$url])) {
            return;
        }
        $seen[$url] = true;

        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($url);
        $finder = new DomXPath($dom);
        $classname = "tbtable";
        $nodes = $finder->query("//div[@class='bod']//table[@class='$classname']//div[@class='tenbh']");

        foreach($nodes as $node){
            $index = 0; $title = ''; $artis = ''; $href = '';

            foreach($node->getElementsByTagName('p') as $child){
                if($index == 0){
                    $nodeA = $child->getElementsByTagName('a')->item(0);
                    $href = $nodeA->getAttribute('href');
                    $title = $child->nodeValue;
                }else{
                    $artis = $child->nodeValue;
                }
                $index++;
            }
            // fetch images ...
            $img_url = $this->musicDomain. "/". $href;
            $img_dom = new DOMDocument('1.0');
            @$img_dom->loadHTMLFile($img_url);
            $img_finder = new DOMXPath($img_dom);
            $lyric_Object = $img_finder->query("//div[@id='fulllyric']//img");
            $imgSrc = STATIC_PATH . '/image/default-song.jpg';

            foreach($lyric_Object as $lyric){
                if($lyric->getAttribute('align') == 'right'){
                    $imgSrc = $lyric->getAttribute('src');
                }
                break;
            }

            $result['lstResult'][] = array(
                'title' => $title,
                'artis' => $artis,
                'href' => $href,
                'img_src' => $imgSrc
            );
        }

        $nodeAlbums = $finder->query("//div[@class='bod']//span[@class='genmed']//a");
        $albumIndex = 0;
        foreach($nodeAlbums as $nodeAlbum){
            $href = $nodeAlbum->getAttribute('href');
            $imgObject = $nodeAlbum->getElementsByTagName('img')->item(0);
            $imgSrc = $imgObject->getAttribute('src');

            $titleObject = $finder->query("//div[@class='bod']//span[@class='gen']//a")->item($albumIndex);
            $title = $titleObject->getAttribute('title');
            $result['lstAlbums'][] = array(
              'title'  => $title,
              'href' => $href,
              'imgSrc' => $imgSrc
            );
            $albumIndex ++;
        }

        $this->searchArray = $result;
        return $result;
    }

    function crawl_single_song($link){
        $href = $this->musicDomain . "/" . $link;

        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($href);
        $finder = new DomXPath($dom);
        $nodeScript = $finder->query("//div[contains(@class,'pl-cl')]//script");
        $textScript = null;
        foreach($nodeScript as $script){
            $attr = $script->getAttribute('src');
            if(isset($attr) || empty($attr)){
                $textScript = $script->nodeValue;
            }
        }
        $link = null;
        if($textScript != null){
            $index1 = strpos($textScript, 'decodeURIComponent');
            $index2 = strpos($textScript, '"provider":') - 1;
            $link = substr($textScript, $index1, $index2 - $index1);
            $lastComma = strrpos($link, ",");
            $link = substr($link, 0, $lastComma);
        }
        $result['song'] = array(
            'link' => $link
        );
        return $result;
    }

    function crawl_song_album($search_name){
        $search_name = str_replace(" ", "+", $search_name);
        $url = $this->musicSources. $search_name;
        return $this->crawler($url);
    }

    function urlExists($url=NULL) {
        if($url == NULL) {
            $url = urldecode("http%3A%2F%2Fdata18.chiasenhac.com%2Fdownloads%2F1062%2F5%2F1061057-3f99fbeb%2F320%2FNocturne%2520Da%2520Khuc_%2520-%2520Chau%2520Kiet%2520Luan.mp3");
        }
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_exec($ch);
        $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        if($httpcode >= 200 && $httpcode < 300){
            return true;
        } else {
            return false;
        }
    }

    function downloadFile(){
        set_time_limit(0);
        $fp = fopen (dirname(__FILE__) . '/temp.mp3', 'w+');//This is the file where we save the    information
        $ch = curl_init(urldecode("http%3A%2F%2Fdata18.chiasenhac.com%2Fdownloads%2F1062%2F5%2F1061057-3f99fbeb%2F320%2FNocturne%2520Da%2520Khuc_%2520-%2520Chau%2520Kiet%2520Luan.mp3"));//Here is the file we are downloading, replace spaces with %20
        curl_setopt($ch, CURLOPT_TIMEOUT, 50);
        curl_setopt($ch, CURLOPT_FILE, $fp); // write curl response to file
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_exec($ch); // get curl response
        curl_close($ch);
        fclose($fp);
    }

    function getCurrentSearchResult(){
        return $this->searchArray;
    }
}