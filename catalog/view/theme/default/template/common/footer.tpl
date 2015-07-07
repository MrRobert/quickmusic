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
    <ul class='custom-menu'>
        <li data-action = "1"><i class="fa fa-link"></i>Open Song in New Tab</li>
        <li data-action = "2"><i class="fa fa-link"></i>Open Song in New Window</li>
        <li data-action = "3"><i class="fa fa-plus-circle"></i>Add This Song to playlist</li>
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
                    <div class="row">
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

</body>
<script type="text/javascript">
    $(document).ready(function(){
        $('.ui-loader').hide();
    });
</script>

</html>