<div class="page-header">
    <div class="container-fluid">
        <section id="bjax-target" class="scrollable padder-lg w-f-md">
        <a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
            <i id="refresh" class="icon-refresh i-lg inline"></i>
        </a>
        <h2 class="font-thin m-b">Hot Songs
                            <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                                <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                                <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                                <span class="bar5 a5 bg-danger dker"></span>
                            </span>
        </h2>
        <?php if(isset($music_vn)){ ?>
            <?= $music_vn; ?>
        <?php } ?>
        </section>

        <!-- SESSION UK -->
        <section id="bjax-target" class="scrollable padder-lg w-f-md">
        <a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
            <i id="refresh" class="icon-refresh i-lg inline"></i>
        </a>
        <h2 class="font-thin m-b">Hot Songs UK
                            <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                                <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                                <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                                <span class="bar5 a5 bg-danger dker"></span>
                            </span>
        </h2>
        <?php if(isset($music_uk)){ ?>
            <?= $music_uk; ?>
        <?php } ?>
        </section>
    </div>
</div>
<div class="container-fluid text-center">
</div>
<script type="text/javascript">
    $(document).ready(function(){
//        bindCommonAction();
    });
</script>