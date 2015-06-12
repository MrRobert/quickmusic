<div class="main-video">
    <video id="video_background" preload="auto" autoplay="true" loop="loop" volume="100">
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
                                <label class="sr-only" for="exampleInputEmail2">Email address</label>
                                <input style="height: 45px;" type="email" class="form-control transparent" placeholder="Search video...">
                            </div>
                            <button type="submit" class="btn btn-warning btn-fill">Search</button>
                        </form>
                    </div>
                </div>
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
</script>