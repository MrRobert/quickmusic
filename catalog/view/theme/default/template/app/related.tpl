<?php if(!isset($sameSinger)){ ?>
<?php $sameSinger = $hotSongVN; ?>
<?php } ?>

<?php if(!isset($sameType)){ ?>
<?php $sameType = $hotSongUK; ?>
<?php } ?>

<div class="col-sm-4 no-padder bg">
    <div class="vbox">
        <div id="mainHeight" class="scrollable hover" style="width: 100%">
            <ul class="list-group bg-white list-group-lg no-bg m-t-n-xxs">
                <?php $index= 0;?>
                <?php foreach($sameSinger as $song){ ?>
                    <li class="list-group-item clearfix">
                        <a href="javascript:void(0);" onclick="gotoSongV2('<?= $song['href']?>', '<?=$index?>', 'ss');" class="jp-play-me pull-right m-t-sm m-l text-md">
                            <i class="fa fa-play"></i>
                        </a>
                        <a class="clear mysong" href="javascript:void(0);" onclick="gotoSongV2('<?= $song['href']?>', '<?=$index?>', 'ss');" data-index="ss<?= $index; ?>">
                            <span class="block text-ellipsis" id="title_ss<?=$index;?>"><?php echo $song['title']?></span>
                            <small class="text-muted" id="artis_ss<?=$index;?>"><?php echo $song['artis']?></small>
                        </a>
                        <input type="hidden" id="imgSrc_ss<?=$index;?>" value="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>">
                        <input type="hidden" id="songss<?= $index; ?>" value="<?= $song['href'];?>"/>
                    </li>
                <?php $index++; } ?>
            </ul>
            <h4 style="margin-left:2%">Related Songs</h4>
            <ul class="list-group bg-white list-group-lg no-bg m-t-n-xxs">
                <?php $index= 0;?>
                <?php foreach($sameType as $song){ ?>
                <li class="list-group-item clearfix">
                    <a href="javascript:void(0);" onclick="gotoSongV2('<?= $song['href']?>', '<?=$index?>', 'sr');" class="jp-play-me pull-right m-t-sm m-l text-md">
                        <i class="fa fa-play"></i>
                    </a>
                    <a href="javascript:void(0);" class="pull-left thumb-sm m-r" onclick="gotoSongV2('<?= $song['href']?>', '<?=$index?>', 'sr');">
                        <img class="img-circle img-with-small" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>">
                    </a>
                    <a class="clear mysong" href="javascript:void(0);" class="pull-left thumb-sm m-r" onclick="gotoSongV2('<?= $song['href']?>', '<?=$index?>', 'sr');" data-index="sr<?=$index;?>">
                        <span class="block text-ellipsis" id="title_sr<?=$index;?>"><?php echo $song['title']?></span>
                        <small class="text-muted" id="artis_sr<?=$index;?>"><?php echo $song['artis']?></small>
                    </a>
                    <input type="hidden" id="imgSrc_sr<?=$index;?>" value="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>">
                    <input type="hidden" id="songsr<?= $index; ?>" value="<?= $song['href'];?>"/>
                </li>
                <?php $index++; } ?>
            </ul>
        </div>
    </div>
</div>