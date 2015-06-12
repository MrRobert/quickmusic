<?php if(!isset($relatedAlbums) && isset($albumUKs)){ ?>
<?php $relatedAlbums = $albumUKs; ?>
<?php } ?>

<div style="margin-left: 3%" id="interestedAlbum">
    <?php if(isset($relatedAlbums) && sizeof($relatedAlbums) > 0){ ?>
        <h4 class="font-thin">Interested albums</h4>
        <div class="row row-sm">
            <?php $index=0; ?>
            <?php foreach($relatedAlbums as $album){ ?>
            <div class="col-xs-6 col-sm-6">
                <div class="item-song">
                    <div class="pos-relative">
                        <div class="item-overlay opacity r r-2x bg-black">
                            <div class="center text-center m-t-n">
                                <a href="javascript:void(0);"><i class="fa fa-play-circle fa-2x"></i></a>
                            </div>
                        </div>
                        <a href="javascript:void(0);">
                            <img class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($album['img_src']));?>">
                            <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                        </a>
                    </div>
                    <div class="padder-v"><a class="text-ellipsis" href="#"><?= $album['title']?></a>
                        <a class="text-ellipsis text-xs text-muted" href="#"><?= $album['artis'];?></a>
                    </div>
                </div>
            </div>
            <?php $index++;}?>
        </div>
    <?php } ?>
</div>