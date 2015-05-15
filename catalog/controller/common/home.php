<?php
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

        $url = urldecode("http://hobodave.com");
        $this->crawl_page($url, 1);

        $this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
	}

    function crawl_page($url, $depth = 5){
        static $seen = array();
        if (isset($seen[$url]) || $depth === 0) {
            return;
        }
        $seen[$url] = true;

        $dom = new DOMDocument('1.0');
        @$dom->loadHTMLFile($url);

        $anchors = $dom->getElementsByTagName('a');
        foreach ($anchors as $element) {
            $href = $element->getAttribute('href');
            if (0 !== strpos($href, 'http')) {
                $path = '/' . ltrim($href, '/');
                if (extension_loaded('http')) {
                    $href = http_build_url($url, array('path' => $path));
                } else {
                    $parts = parse_url($url);
                    $href = $parts['scheme'] . '://';
                    if (isset($parts['user']) && isset($parts['pass'])) {
                        $href .= $parts['user'] . ':' . $parts['pass'] . '@';
                    }
                    $href .= $parts['host'];
                    if (isset($parts['port'])) {
                        $href .= ':' . $parts['port'];
                    }
                    $href .= $path;
                }
            }
            $this->crawl_page($href, $depth - 1);
        }
        echo "URL:",$url,PHP_EOL,"CONTENT:",PHP_EOL,$dom->saveHTML(),PHP_EOL,PHP_EOL;
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
}