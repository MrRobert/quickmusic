<li class="list-group-item active" id="firstSongLi">
    <div class="pull-right m-l">
        <a href="javascript:void(0);" class="m-r-sm"><i class="fa fa-repeat"></i></a>
        <a href="javascript:void(0);" onclick="addToFavoriteSingle($(this));" class="m-r-sm"><i class="fa fa-heart-o"></i></i></a>
        <a data-toggle="dropdown" class="dropdown-toggle bg clear" href="javascript:;">
            <i class="fa fa-plus-circle"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
            <li>
                <a href="javascript:void(0);" id="plus_0" onclick="plusSong('index.php?route=app/search/playsong&src=\'<?php echo $link;?>\'', '<?=$title;?>','<?= $artis; ?>', 0)" class="plus-song pull-right">
                    <i class="fa fa-link"></i>Add song to main player
                </a>
                <a href="javascript:void(0);" id="plused_0" class="hidden pull-left"><i class="fa fa-check"></i>Add to main player</a>
            </li>
            <?php foreach($playlists as $playlist){ ?>
            <li><a href="javascript:;" onclick="beginAddSongToPlaylist('<?= $playlist['playlist_id'];?>', '0', 'sg')"><i class="fa fa-link"></i><?= $playlist['playlist_name']; ?></a></li>
            <?php }?>
            <li style="display: none" id="hiddenSongPlaylistLi"></li>
        </ul>
        <input type="hidden" id="title_sg0" value="<?= $title;?>" />
        <input type="hidden" id="artis_sg0" value="<?= $artis;?>" />
        <input type="hidden" id="image_sg0" value="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($img_src));?>" />
        <input type="hidden" id="song_sg0" value="<?= $orginLink; ?>" />
    </div>
    <a href="javascript:void(0);" class="jp-play-me m-r-sm pull-left active" onclick="playSong('<?php echo $link;?>', $(this))">
        <i class="fa fa-play text" id="play_icon"></i>
        <i class="fa fa-pause text-active hidden" id="pause_icon"></i>
    </a>
    <div class="clear text-ellipsis"><span style="color: #666666"><?= $title;?></span>
        <span class="text-muted"> -- 04:35</span>
    </div>
</li>