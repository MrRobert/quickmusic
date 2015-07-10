<div class="vbox">
    <div class="w-f-md">
        <div class="hbox stretch bg-black dker">
            <!-- side content -->
            <aside class="col-sm-12 no-padder">
                <div class="vbox animated fadeInUp">
                    <div class="scrollable" style="width: 100%">
                        <div class="m-t-n-xxs item-song pos-rlt">
                            <!--<img style="height: 320px;" id="mainImg" class="img-full" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($img_src));?>" alt="">-->
                            <div style="width: 100%; height: 100%;">
                                <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="800" height="450" id="ActionScript3 example" align="middle">
                                    <param name="movie" value="film.swf" />
                                    <param name="quality" value="high" />
                                    <param name="bgcolor" value="#ffffff" />
                                    <param name="play" value="true" />
                                    <param name="loop" value="true" />
                                    <param name="wmode" value="window" />
                                    <param name="scale" value="showall" />
                                    <param name="menu" value="true" />
                                    <param name="devicefont" value="false" />
                                    <param name="salign" value="" />
                                    <param name="allowScriptAccess" value="sameDomain" />
                                    <param name="allowFullScreen" value="true">
                                    <!--[if !IE]>-->
                                    <object type="application/x-shockwave-flash" data="film.swf" width="800" height="450">
                                        <param name="movie" value="film.swf" />
                                        <param name="quality" value="high" />
                                        <param name="bgcolor" value="#ffffff" />
                                        <param name="play" value="true" />
                                        <param name="loop" value="true" />
                                        <param name="wmode" value="window" />
                                        <param name="scale" value="showall" />
                                        <param name="menu" value="true" />
                                        <param name="devicefont" value="false" />
                                        <param name="salign" value="" />
                                        <param name="allowScriptAccess" value="sameDomain" />
                                        <param name="allowFullScreen" value="true">
                                        <!--<![endif]-->
                                        <a href="http://www.adobe.com/go/getflash">
                                            <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
                                        </a>
                                        <!--[if !IE]>-->
                                    </object>
                                    <!--<![endif]-->
                                </object>
                            </div>
                        </div>
                        <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto">
                            <li id="liFacebookComment">
                                <div class="fb-comments" data-width="400" data-href="<?= $currentLink; ?>" data-numposts="10" data-colorscheme="light">
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </aside>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('#content').css('padding-top', '9%');
    $('#container').css('height', '927px');
</script>