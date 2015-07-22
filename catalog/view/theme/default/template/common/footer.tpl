<footer id="footer" class="footer bg-dark">
    <div id="jp_second" class="hide">
        <div class="jp-type-playlist">
            <div class="jp-jplayer hide" id="second-jplayer"></div>
        </div>
    </div>

    <!-- Main Playlist -->
    <div id="jp_container_N" class="jp-video-270p">
        <div class="jp-type-playlist">
            <div class="jp-jplayer hide" id="jplayer_N"></div>
            <div class="jp-gui">
                <div class="jp-video-play hide" style="display: none;">
                    <a class="jp-video-play-icon">play</a>
                </div>
                <div class="jp-interface">
                    <div class="jp-controls">
                        <div class="pre-controls">
                            <a class="jp-previous"><i class="fa fa-backward fa-2x"></i></i></a>
                        </div>
                        <div class="pre-controls">
                            <a class="jp-play" style="display: inline-block;"><i class="fa fa-play fa-2x"></i></a>
                            <a class="jp-pause hid" style="display: none;"><i class="fa fa-pause fa-2x"></i></a>
                        </div class="pre-controls">
                        <div class="pre-controls">
                            <a class="jp-next"><i class="fa fa-forward fa-2x"></i></a>
                        </div>
                        <div class="pre-controls">
                            <a data-target="#playlist" data-toggle="dropdown" class=""><i class="fa fa-list-ul fa-2x"></i></a>
                        </div>
                        <div class="jp-progress hidden-xs">
                            <div class="jp-seek-bar" style="width: 100%;">
                                <div class="jp-play-bar bg-info" style="width: 0.195231%;"> </div>
                                <div class="jp-title text-lt" style="display: none;"></div>
                            </div>
                        </div>
                        <div class="pre-controls hidden-xs hidden-sm jp-current-time text-xs text-muted">00:00</div>
                        <div class="pre-controls hidden-xs hidden-sm jp-duration text-xs text-muted">03:29</div>
                        <div class="pre-controls hidden-xs hidden-sm">
                            <a title="mute" class="jp-mute"><i class="fa fa-volume-up fa-2x text-highlight"></i></a>
                            <a title="unmute" class="jp-unmute hid" style="display: none;"><i class="fa fa-volume-off fa-2x text-muted"></i></a>
                        </div>
                        <div class="pre-controls hidden-xs hidden-sm jp-volume">
                            <div class="jp-volume-bar" style="background-color: #4d5d6e">
                                <div class="jp-volume-bar-value" style="background-color: #778490; width: 100%;"></div>
                            </div>
                        </div>
                        <div class="pre-controls">
                            <a title="shuffle" class="jp-shuffle"><i class="fa fa-random fa-2x text-highlight"></i></a>
                            <a title="shuffle off" class="jp-shuffle-off hid" style="display: none;"><i class="fa fa-random fa-2x text-muted"></i></a>
                        </div>
                        <div class="pre-controls">
                            <a title="repeat" class="jp-repeat"><i class="fa fa-repeat fa-2x text-highlight"></i></a>
                            <a title="repeat off" class="jp-repeat-off hid" style="display: none;"><i class="fa fa-repeat fa-2x text-muted"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="playlist" class="jp-playlist dropup">
                <ul class="dropdown-menu aside-xl dker" style="display: block;">
                </ul>
            </div>
        </div>
    </div>
</footer>
</div>
<div>
    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" id="custom-menu">
        <li data-action="1"><a tabindex="-1" href="javascript:;"><i class="fa fa-link"></i>Open Song in New Tab</a></li>
        <li data-action="2"><a tabindex="-1" href="javascript:;"><i class="fa fa-link"></i>Open Song in New Window</a></li>
        <li data-action="3"><a tabindex="-1" href="javascript:;"><i class="fa fa-plus-circle"></i>Add This Song to playlist</a></li>
        <?php if(isset($playlist) && sizeof($playlist) > 0 ){ ?>
        <li class="dropdown-submenu">
            <a tabindex="-1" href="javascript:;"><i class="fa fa-plus-circle"></i>Add Song to</a>
            <ul class="dropdown-menu" id="userPlaylist-subMenu">
                <?php $index = 0;?>
                <?php foreach($playlist as $userPlaylist){ ?>
                    <li id="liContextMenu<?=$index;?>" data-action="subMenu_" data-action-val="subMenu_<?=$userPlaylist['playlist_id'];?>"><a tabindex="-1" href="javascript:;"><i class="fa fa-link"></i><?= $userPlaylist['playlist_name'];?></a></li>
                <?php $index++; }?>
            </ul>
        </li>
        <?php } ?>
    </ul>
</div>
<div>
    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" id="left-custom-menu">
        <li><a tabindex="-1" href="javascript:;" onclick="openDialogEditChannel();"><i class="fa fa-edit"></i>Edit Channel</a></li>
        <li><a tabindex="-1" href="javascript:;" onclick="openDialogConfirm();"><i class="fa fa-remove"></i>Remove Channel</a></li>
    </ul>
</div>
<div id="confirmModal" class="modal fade" role="dialog" aria-labelledby="gridSystemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">Confirm</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row" id="confirmBody">
                        <h4>Are you sure to remove this song from favorite collection?</h4>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" id="confirmModalOKbutton" class="btn btn-primary">Remove</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id="channelDialog" class="modal fade" role="dialog" aria-labelledby="gridSystemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel"><i class="fa fa-apple"></i>iChannel</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="channelInput"/>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" onclick="addCustomChannel();" class="btn btn-primary">Add Channel</button>
                        </div>
                    </div>
                    <div class="row" style="margin: auto; padding-top:10px;">
                        <h4>Synchronize with your <i class="fa fa-youtube-square"></i> youtube <a href="javascript:;" onclick="">account</a></h4>
                    </div>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id="channelDialogAction" class="modal fade" role="dialog" aria-labelledby="gridSystemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="channelDlActionTitle">
                    <i class="fa fa-edit"></i>Channel Edit
                </h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid" id="channelDlActionBody">
                    <div class="row">
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="channelDlActionInput"/>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" onclick="editChannelName();" class="btn btn-primary">Edit Channel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
    <input type="hidden" id="currChannelId" value="0" />
</div><!-- /.modal -->

</body>
<script type="text/javascript">
    $(document).ready(function(){
        $('.ui-loader').hide();
    });
</script>

</html>