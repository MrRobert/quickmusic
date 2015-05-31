<li class="list-group-item active" id="firstSongLi">
    <div class="pull-right m-l">
        <a href="#" class="m-r-sm"><i class="fa fa-repeat"></i></a>
        <a href="#" class="m-r-sm"><i class="fa fa-heart-o"></i></i></a>
        <a href="javascript:void(0);" style="color: #9badb9;" id="plus_0" onclick="plusSong('index.php?route=app/search/playsong&src=\'<?php echo $link;?>\'', '<?=$title;?>','<?= $artis; ?>', 0)" class="plus-song pull-right"> <i class="fa fa-plus-circle"></i> </a>
        <a href="javascript:void(0);" style="color: #9badb9;" id="plused_0" class="hidden pull-right"><i class="fa fa-check"></i></a>
    </div>
    <a href="javascript:void(0);" class="jp-play-me m-r-sm pull-left active" onclick="playSong('<?php echo $link;?>', $(this))">
        <i class="fa fa-play text" id="play_icon"></i>
        <i class="fa fa-pause text-active hidden" id="pause_icon"></i>
    </a>
    <div class="clear text-ellipsis"><span style="color: #666666"><?= $title;?></span>
        <span class="text-muted"> -- 04:35</span>
    </div>
</li>