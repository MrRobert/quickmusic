<nav id="column-left">
    <ul id="menu">
        <li class="li-menu"><a href="#music" ><i class="fa fa-music"></i><span>Music</span></a></li>
        <li class="li-menu"><a href="#video"><i class="fa fa-youtube-play"></i><span>Video</span></a></li>
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
            <li class="li-menu">
                <a href="javascript:void(0);" onclick="gotoPlaylist('<?= $index; ?>', '<?= $collection['name']?>')"><i class="fa fa-list-ul"></i>
                    <b class="badge pull-right"><?= $collection['count'];?></b>
                    <span><?= $collection['name']?></span>
                </a>
                <input type="hidden" id="playlist_<?=$index?>" value="<?= $collection['playlist_id']; ?>"/>
            </li>
            <?php $index++;}?>
        <?php }else { ?>
            <li class="li-menu">
                <a href="javascript:void(0);" onclick="createNewPlayList();">
                    <span><i class="fa fa-plus-circle"></i> Add new</span>
                </a>
            </li>
        <?php } ?>
    </ul>
    <footer id="nav-footer" class="footer bg-dark" style="background-color: #232c32;">
        <div class="hidden-xs">
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                <span class="thumb-sm avatar pull-left m-l-xs">
                    <img style="height: 47px; width: 50px;" alt="John.Smith" class="img-circle" src="https://graph.facebook.com/819276394825557/picture?width=47">
                    <i class="on b-black"></i>
                </span>
                <span class="hidden-span clear">
                    <span>
                        <strong class="font-bold text-lt">Robert Duy</strong>
                    </span><br>
                    <span class="text-muted text-xs">Developer</span>
                </span>
            </a>
        </div>
    </footer>
</nav>