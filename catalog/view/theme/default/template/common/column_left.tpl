<nav id="column-left">
    <ul id="menu">
        <li class="li-menu"><a href="#music" ><i class="fa fa-music"></i><span>Music</span></a></li>
        <li class="li-menu li-hover">
            <a href="#video" class="parent">
                <i class="fa fa-youtube-play"></i><span>Video</span>
            </a>
            <ul class="collapse">
                <?php foreach($video_channel as $channel){ ?>
                <li id="liChannel<?= $channel['video_channel_id'];?>">
                    <a href="#search/video/<?= $channel['channel_name']?>" class="col-left-context" data-channel="<?= $channel['video_channel_id']?>">
                        <img style="width:35px;" class="img-circle" src="<?= $channel['image']?>" />
                        <span id="channelName<?= $channel['video_channel_id']; ?>"><?= $channel['channel_name']?></span>
                    </a>
                </li>
                <?php } ?>
                <li id="customChannelAddLi" style="display: none;"></li>
                <li>
                    <a href="javascript:;" onclick="openChannelDialog();">
                        <i class="fa fa-plus-circle"></i>
                        Add Channel
                    </a>
                </li>
            </ul>
        </li>
        <li class="li-menu"><a href="#film"><i class="fa fa-film"></i><span>Movie</span></a></li>
        <li class="li-menu"><a href="#favorite"><i class="fa fa-heart"></i><span>Favorite</span></a></li>

        <li class="hidden-li li-menu text-xs text-muted" style="padding: 10px 0px 0px 14px; line-height: 4;">
            Playlist
            <span class="pull-right">
                <a style="padding-top: 0;" href="javascript:void(0);">
                    <!-- <i class="fa fa-plus-circle"></i> -->
                </a>
            </span>
        </li>
        <?php $index = 0; ?>
        <?php if(isset($playlist) && sizeof($playlist) > 0) { ?>
            <?php foreach($playlist as $collection){ ?>
            <li class="li-menu playlist-menu" id="liPlaylist<?=$index;?>">
                <a style="display: inline-block" href="javascript:void(0);" onclick="gotoPlaylist('<?= $index; ?>', '<?= $collection['playlist_name']?>')"><i class="fa fa-list-ul"></i>
                    <b class="badge pull-left" id="numb<?= $collection['playlist_id'];?>"><?= $collection['count'];?></b>
                    <span><?= $collection['playlist_name']?></span>
                </a>
                <a style="display: inline" class="pull-right col-hide" onclick="openConfirmModal('<?=$collection['playlist_id'];?>', '<h4>Are you sure to delete this playlist?</h4>', removePlaylist, '<?=$index;?>');">
                    <span><i class="fa fa-trash pull-right hidden-sm" style="padding:5px"></i></span>
                </a>
                <input type="hidden" id="playlist_<?=$index?>" value="<?= $collection['playlist_id']; ?>"/>
            </li>
            <?php $index++;}?>
        <?php } ?>
        <li class="li-menu" id="addNewParentLi">
            <a href="javascript:void(0);" onclick="createNewPlayList($(this), $('#addNewParentLi'));">
                <span class="pull-right" id="spinnerHidden" style="display: none;"><i class="fa fa-spinner"></i></span>
                <span id="spanAddNew"><i class="fa fa-plus-circle"></i> Add new</span>
                <input id="inputAddNew" style="display: none; width: 130px;" type="text" class="form-control"/>
            </a>
        </li>
    </ul>
    <footer id="nav-footer" class="footer bg-dark" style="background-color: #232c32;">
        <div class="hidden-xs">
            <a data-toggle="dropdown" class="dropdown-toggle" href="javascript:;">
                <span class="thumb-sm avatar pull-left m-l-xs">
                    <img style="height: 47px; width: 50px;" alt="John.Smith" class="img-circle"
                         src="<?php echo STATIC_PATH . 'image/user.png'?>">
                    <i class="on b-black"></i>
                </span>
                <span class="hidden-span clear">
                    <span>
                        <strong class="font-bold text-lt">Anonymous</strong>
                    </span><br>
                    <span class="text-muted text-xs">Standard user</span>
                </span>
            </a>
        </div>
    </footer>
</nav>