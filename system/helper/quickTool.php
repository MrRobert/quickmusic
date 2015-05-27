<?php
class QuickTool {
    private $musicSources = "http://search.chiasenhac.com/search.php?s=";
    private $musicDomain = "http://chiasenhac.com";
    private $hotSongVN = "http://chiasenhac.com/mp3/vietnam/";
    private $hotSongUK = "http://chiasenhac.com/mp3/us-uk/";

    private $hotSongVNPreDomain = "http://chiasenhac.com/mp3/vietnam/v-pop";
    private $hotSongUKPreDomain = "http://chiasenhac.com/mp3/us-uk/u-pop";

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

    function constructHomePage(){
        $result = array();
        // get hot song VN ======================================================
        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($this->hotSongVN);
        $finder = new DomXPath($dom);
        $nodes = $finder->query("//div[@class='h-main4']//div[@class='text2 text2x']");
        foreach($nodes as $node){
            $nodeA = $node->getElementsByTagName('a')->item(0);
            $nodeP = $node->getElementsByTagName('p')->item(0);

            $title = mb_convert_encoding($nodeA->nodeValue, 'html-entities', 'utf-8');
            $href = $nodeA->getAttribute('href');
            $artis = mb_convert_encoding($nodeP->nodeValue, 'html-entities', 'utf-8');

            if(strrpos($href, "/")){
                $href = $this->hotSongVNPreDomain . substr($href, strrpos($href, "/"));
            }
            // fetch images ...
            $img_url = $href;
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
            $result['hotSongVN'][] = array(
                'title' => $title,
                'artis' => $artis,
                'href' => $href,
                'img_src' => $imgSrc
            );
        }
        // get hot songs UK =======================================================
        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($this->hotSongUK);
        $finder = new DomXPath($dom);
        $nodes = $finder->query("//div[@class='h-main4']//div[@class='text2 text2x']");
        foreach($nodes as $node){
            $nodeA = $node->getElementsByTagName('a')->item(0);
            $nodeP = $node->getElementsByTagName('p')->item(0);

            $title = mb_convert_encoding($nodeA->nodeValue, 'html-entities', 'utf-8');
            $href = $nodeA->getAttribute('href');
            $artis = mb_convert_encoding($nodeP->nodeValue, 'html-entities', 'utf-8');

            if(strrpos($href, "/")){
                $href = $this->hotSongUKPreDomain . substr($href, strrpos($href, "/"));
            }
            // fetch images ...
            $img_url = $href;
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
            $result['hotSongUK'][] = array(
                'title' => $title,
                'artis' => $artis,
                'href' => $href,
                'img_src' => $imgSrc
            );
        }

        // Construct Album collection ================================================
        // Album collection VN
        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($this->hotSongVN);
        $finder = new DomXPath($dom);
        $nodes = $finder->query("//div[@class='bod']//table[@class='tbtable']//tr");
        $index = 0;
        foreach($nodes as $node){
            $title1 = ''; $href1 = ''; $artis1 = ''; $imgSrc1 = STATIC_PATH . '/image/default-song.jpg';
            $title2 = ''; $href2 = ''; $artis2 = ''; $imgSrc2 = STATIC_PATH . '/image/default-song.jpg';
            if($index > 0){
                $firstTd = $node->getElementsByTagName('td')->item(0);
                if(isset($firstTd) && !empty($firstTd) && $firstTd->getAttribute('valign') == 'top'){ // second line ==========
                    $nodeA1 = $node->getElementsByTagName('a')->item(0);
                    $nodeA2 = $node->getElementsByTagName('a')->item(1);
                    $title1 = mb_convert_encoding($nodeA1->nodeValue, 'html-entities', 'utf-8');
                    $artis1 = '';
                    $title2 = mb_convert_encoding($nodeA2->nodeValue, 'html-entities', 'utf-8');
                    $artis2 = '';
                }else{ // first line ====================
                    $nodeA1 = $node->getElementsByTagName('a')->item(0);
                    $nodeA2 = $node->getElementsByTagName('a')->item(1);

                    $href1 = $nodeA1->getAttribute('href');
                    $nodeImgSrc1 = $nodeA1->getElementsByTagName('img')->item(0);
                    $imgSrc1 = $nodeImgSrc1->getAttribute('src');

                    $href2 = $nodeA2->getAttribute('href');
                    $nodeImgSrc2 = $nodeA2->getElementsByTagName('img')->item(0);
                    $imgSrc2 = $nodeImgSrc2->getAttribute('src');
                }
                $result['albumVNs'][] = array(
                    'title' => $title1,
                    'artis' => $artis1,
                    'href'=> $href1,
                    'img_src' => $imgSrc1
                );
                $result['albumVNs'][] = array(
                    'title' => $title2,
                    'artis' => $artis2,
                    'href'=> $href2,
                    'img_src' => $imgSrc2
                );
            }
            $index++;
        }

        // Album collection UK
        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($this->hotSongUK);
        $finder = new DomXPath($dom);
        $nodes = $finder->query("//div[@class='bod']//table[@class='tbtable']//tr");
        $index = 0;
        foreach($nodes as $node){
            $title1 = ''; $href1 = ''; $artis1 = ''; $imgSrc1 = STATIC_PATH . '/image/default-song.jpg';
            $title2 = ''; $href2 = ''; $artis2 = ''; $imgSrc2 = STATIC_PATH . '/image/default-song.jpg';
            $firstTd = $node->getElementsByTagName('td')->item(0);
            if($index > 0){
                if(isset($firstTd) && !empty($firstTd) &&  $firstTd->getAttribute('valign') == 'top'){ // second line ==========
                    $nodeA1 = $node->getElementsByTagName('a')->item(0);
                    $nodeA2 = $node->getElementsByTagName('a')->item(1);
                    $title1 = mb_convert_encoding($nodeA1->nodeValue, 'html-entities', 'utf-8');
                    $artis1 = '';
                    $title2 = mb_convert_encoding($nodeA2->nodeValue, 'html-entities', 'utf-8');
                    $artis2 = '';
                }else{ // first line ====================
                    $nodeA1 = $node->getElementsByTagName('a')->item(0);
                    $nodeA2 = $node->getElementsByTagName('a')->item(1);

                    $href1 = $nodeA1->getAttribute('href');
                    $nodeImgSrc1 = $nodeA1->getElementsByTagName('img')->item(0);
                    $imgSrc1 = $nodeImgSrc1->getAttribute('src');

                    $href2 = $nodeA2->getAttribute('href');
                    $nodeImgSrc2 = $nodeA2->getElementsByTagName('img')->item(0);
                    $imgSrc2 = $nodeImgSrc2->getAttribute('src');
                }
                $result['albumUKs'][] = array(
                    'title' => $title1,
                    'artis' => $artis1,
                    'href'=> $href1,
                    'img_src' => $imgSrc1
                );
                $result['albumUKs'][] = array(
                    'title' => $title2,
                    'artis' => $artis2,
                    'href'=> $href2,
                    'img_src' => $imgSrc2
                );
            }
            $index++;
        }

        $file = DIR_TEMPLATE . 'default/template/app/home.tpl';
        if (file_exists($file)) {
            extract($result);
            ob_start();
            require($file);
            $output = ob_get_contents();
            ob_end_clean();
            return $output;
        } else {
            trigger_error('Error: Could not load template ' . $file . '!');
            exit();
        }
    }
}