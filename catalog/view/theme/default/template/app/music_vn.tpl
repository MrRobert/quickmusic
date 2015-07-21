<div class="row row-sm">
    <?php $index = 0; ?>
    <?php foreach($hotSongVN as $song){ ?>
    <?php if($index + 1 % 2 == 0) { ?>
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
                            <a href="javascript:void(0);"><i class="fa fa-star-o text-muted"></i></a>
                        </div>
                        <div class="center text-center m-t-n">
                            <a onclick="gotoSong('<?php echo $song['href']; ?>', '<?= $index?>', 'vn');" href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                        </div>
                        <div class="bottom_2 padder m-b-sm">
                            <a href="javascript:void(0);" style="color: #9badb9;" id="plus_vn<?=$index;?>" onclick="plusSong('<?= $song['href']; ?>','<?= $song['title']?>', '<?= $song['artis']?>', 'vn'<?= $index ?>)" class="plus-song pull-right"> <i class="fa fa-plus-circle"></i> </a>
                            <a href="javascript:void(0);" style="color: #9badb9;" id="plused_vn<?=$index;?>" class="hidden pull-right"><i class="fa fa-check"></i></a>
                        </div>
                        <div class="bottom padder m-b-sm">
                            <a class="pull-right" href="javascript:void(0);" id="favorite_vn<?=$index;?>"> <i class="fa fa-heart-o"></i> </a>
                        </div>
                    </div>
                    <a href="javascript:void(0);">
                        <img class="r r-2x img-full" alt="" id="img_vn<?=$index;?>" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>">
                        <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                    </a>
                    <input type="hidden" id="song_vn<?php echo $index;?>" value="<?php echo $index; ?>">
                </div>
                <div class="padder-v"><a class="text-ellipsis" href="javascript:void(0);" id="title_vn<?=$index;?>"><?php echo $song['title']; ?></a>
                    <a class="text-ellipsis text-xs text-muted" href="javascript:void(0);" id="artis_vn<?=$index;?>"><?php echo $song['artis']; ?></a>
                </div>
            </div>
        </div>
    <?php } ?>
    <?php $index++;} ?>
</div>