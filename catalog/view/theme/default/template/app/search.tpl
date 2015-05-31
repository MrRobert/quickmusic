<div class="page-header">
<div id="LoadingDiv" style="display:none;"></div>
<div class="container-fluid">
<section id="bjax-target" class="scrollable padder-lg w-f-md">
<a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
    <i id="refresh" class="icon-refresh i-lg inline"></i>
</a>
<h2 class="font-thin m-b">Songs & Videos
                    <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                        <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                        <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                        <span class="bar5 a5 bg-danger dker"></span>
                    </span>
</h2>
<div class="row row-sm">
    <?php $index = 0; ?>
    <?php foreach($lstResult as $song){ ?>
        <?php if($index < 24){ ?>
        <?php if($index + 1 % 2 == 0) { ?>
            <div class="clearfix visible-xs"></div>
        <?php }else{ ?>
            <div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
                <div class="item-song">
                    <div class="pos-relative">
                        <div class="bottom"><!-- <span class="badge m-l-sm m-b-sm" style="background-color: #4cb6cb; color: #eaf6f9">03:20</span> --></div>
                        <div class="item-overlay opacity r r-2x bg-black">
                            <div class="text-info padder m-t-sm text-sm">
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star-o text-muted"></i></a>
                            </div>
                            <div class="center text-center m-t-n">
                                <a onclick="gotoSong('<?php echo base64_encode($song['href'])?>', '<?= $index?>', '');" href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                            </div>
                            <div class="bottom_2 padder m-b-sm">
                                <a href="javascript:void(0);" style="color: #9badb9;" id="plus_<?=$index;?>" onclick="plusSong('<?= base64_encode($song['href'])?>','<?= $song['title']?>', '<?= $song['artis']?>', <?= $index ?>)" class="plus-song pull-right"> <i class="fa fa-plus-circle"></i> </a>
                                <a href="javascript:void(0);" style="color: #9badb9;" id="plused_<?=$index;?>" class="hidden pull-right"><i class="fa fa-check"></i></a>
                            </div>
                            <div class="bottom padder m-b-sm">
                                <a class="pull-right" href="#" id="favorite_<?=$index;?>"> <i class="fa fa-heart-o"></i> </a>
                            </div>
                        </div>
                        <a href="javascript:void(0);">
                            <img class="r r-2x img-full" alt="" id="img_<?=$index;?>" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>">
                            <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                        </a>
                        <input type="hidden" id="song_<?php echo $index;?>" value="<?php echo $index; ?>">
                    </div>
                    <div class="padder-v"><a class="text-ellipsis" href="#" id="title_<?=$index;?>"><?php echo $song['title']; ?></a>
                        <a class="text-ellipsis text-xs text-muted" href="#" id="artis_<?=$index;?>"><?php echo $song['artis']; ?></a>
                    </div>
                </div>
            </div>
        <?php } ?>
    <?php $index++; ?>
    <?php } ?>
    <?php } ?>
</div>
</section>

<!-- SESSION UK -->
<section id="bjax-target" class="scrollable padder-lg w-f-md">
<a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
    <i id="refresh" class="icon-refresh i-lg inline"></i>
</a>
<h2 class="font-thin m-b">Albums
                    <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                        <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                        <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                        <span class="bar5 a5 bg-danger dker"></span>
                    </span>
</h2>
    <div class="row row-sm">

        <?php $alIndex = 0; ?>
        <?php foreach($lstAlbums as $album){ ?>
        <?php if($alIndex + 1 % 2 == 0) { ?>
            <div class="clearfix visible-xs"></div>
        <?php }else{ ?>
            <div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
                <div class="item-song">
                    <div class="pos-relative">
                        <div class="bottom"></div>
                        <div class="item-overlay opacity r r-2x bg-black">
                            <div class="text-info padder m-t-sm text-sm">
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            </div>
                            <div class="center text-center m-t-n">
                                <a href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                            </div>
                            <div class="bottom padder m-b-sm">
                                <a class="pull-right" href="#"> <i class="fa fa-heart-o"></i> </a>
                            </div>
                        </div>
                        <a href="javascript:void(0);">
                            <img class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($album['imgSrc']));?>">
                            <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                        </a>
                    </div>
                    <div class="padder-v"><a class="text-ellipsis" href="#"><?php echo $album['title'];?></a></div>
                </div>
            </div>
        <?php } ?>
        <?php $alIndex ++; } ?>
    </div>
</section>
</div>
</div>
<div class="container-fluid text-center">
</div>
<script type="text/javascript">
    $('#content').css('padding-top', '');
    $('#container').css('height','');
    isLoadHas = false;
</script>