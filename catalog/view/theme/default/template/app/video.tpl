<div class="main-video">
    <video id="video_background" preload="auto" autoplay="false" volume="80">
        <source src="<?= STATIC_PATH . 'video/Daleri-Bonjour[Tasty].webm' ?>" type="video/webm">
        <source src="<?= STATIC_PATH . 'video/Daleri-Bonjour[Tasty].mp4' ?>" type="video/mp4">
        Video not supported
    </video>
    <div class="cover black" data-color="black"></div>
    <div class="container">
        <h1 class="logo cursive" style="font-family: 'Grand Hotel',cursive; font-size: 82px;">
            BONJOUR
        </h1>
        <div class="content">
            <h4 class="motto">Really awesome collections from lots of resources.</h4>
            <div class="subscribe">
                <h5 class="info-text">
                    We still collect hot & cool videos. Always free from <a href="http://youtube.com" target="_blank"><strong>Youtube</strong></a>
                </h5>
                <div class="row">
                    <div class="col-md-4 col-md-offset-4 col-sm6-6 col-sm-offset-3 ">
                        <form class="form-inline" role="form">
                            <div class="form-group">
                                <input style="height: 45px;" type="text" id="searchVideoInput" class="form-control transparent" placeholder="Search video...">
                            </div>
                            <button type="submit" id="searchVideoBtn" class="btn btn-warning btn-fill">Search</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="" style="margin-top: 45%; margin-left: 15%; display: none;" id="rootDivSearchResult">
    <div class="w-f-md">
        <div class="hbox stretch bg-black dker">
            <!-- side content -->
            <aside class="col-sm-10 no-padder" id="sidebar">
                <div class="vbox animated fadeInUp">
                    <div style="width: 100%">
                        <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto" id="ulSearchResult">
                        </ul>
                    </div>
                </div>
            </aside>
            <!-- / side content -->
            <div class="col-sm-2 no-padder bg my-indicator">
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
       if($('#column-left').hasClass('active')){
           $('#button-menu').click();
       }
    });
    bindSearchVideo();
</script>