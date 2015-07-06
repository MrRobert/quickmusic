<div class="vbox">
    <div class="w-f-md">
        <div class="hbox stretch bg-black dker">
            <!-- side content -->
            <aside class="col-sm-7 no-padder" id="sidebar">
                <div class="vbox animated fadeInUp">
                    <div class="scrollable" style="width: 100%; text-align: center; color: #000000" id="videoContainer">
                        <div class="m-t-n-xxs item-song pos-rlt">
                           <iframe width="100%" height="580px" src="https://www.youtube.com/embed/<?= $videoId; ?>" frameborder="0" allowfullscreen></iframe>
                        </div>
                        <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto">
                            <li class="list-group-item active" id="firstSongLi">
                                <div class="row" style="color: #666666">
                                    <h1>
                                        <span class="pull-left" id="videoTitle"></span>
                                        <!--<span class="pull-right">10.000</span> -->
                                    </h1>
                                </div>
                            </li>
                        </ul>
                        <div>
                            <div class="fb-comments" data-width="400" data-href="<?= $currentLink; ?>" data-numposts="10" data-colorscheme="light"></div>
                        </div>
                    </div>
                </div>
            </aside>
            <div class="col-sm-5 no-padder lt">
                <div class="vbox">
                    <div id="divHeight" class="scrollable hover" style="width: 100%">
                        <div class="m-t-n-xxs" id="videoListContainer">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('#content').css('padding-top', '9%');
    $('#container').css('height', '927px');
    <?php if(isset($videoId)) { ?>
        loadRelatedVideoById('<?= $videoId; ?>');
        loadDetailVideo('<?= $videoId;?>');
    <?php } ?>
</script>