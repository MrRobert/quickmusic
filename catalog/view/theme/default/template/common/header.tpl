<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>QuickMusic</title>
    <meta name="description" content="descriptions" />
    <meta name="keywords" content="keyword" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <script type="text/javascript" src="<?php echo STATIC_PATH ?>js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="<?php echo STATIC_PATH ?>js/bootstrap.min.js"></script>
    <link href="<?php echo STATIC_PATH ?>css/opencart.css" type="text/css" rel="stylesheet" />
    <link href="<?php echo STATIC_PATH ?>css/font-awesome.min.css" type="text/css" rel="stylesheet" />
    <script src="<?php echo STATIC_PATH ?>js/moment.js" type="text/javascript"></script>
    <script src="<?php echo STATIC_PATH ?>js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <link href="<?php echo STATIC_PATH ?>css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
    <link type="text/css" href="<?php echo STATIC_PATH ?>css/stylesheet.css" rel="stylesheet" media="screen" />
    <link type="text/css" href="<?php echo STATIC_PATH ?>css/jplayer.flat.css" rel="stylesheet" media="screen" />
    <script src="<?php echo STATIC_PATH ?>js/jquery.jplayer.min.js" type="text/javascript"></script>
    <script src="<?php echo STATIC_PATH ?>js/jplayer.playlist.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var mainPlayList = null;
        var secondPlaylist = null;
        var isMainPlaying = false;
        var isSecondPlaying = false;
        var playingIndex = false;
        var isHasLoad = true;
    </script>
    <script src="<?php echo STATIC_PATH ?>js/cookie-handler.js" type="text/javascript"></script>
    <script src="<?php echo STATIC_PATH ?>js/demo.js" type="text/javascript"></script>
    <script src="<?php echo STATIC_PATH ?>js/common.js" type="text/javascript"></script>
</head>
<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3&appId=651313361641726";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>

<div id="container">
    <header id="header" class="navbar navbar-static-top">
        <div class="navbar-header">
            <a href="index.php" style="">
                <i class="fa fa-headphones pull-left" style="font-size: 46px; padding: 5px 0 0 11px"></i>
                <span class="pull-left hidden-xs" style="padding: 19px 0px 0px; font-size: 20px;">MUSIC</span>
            </a>
            <a type="button" id="button-menu" class="">
                <i class="fa fa-indent fa-lg"></i>
            </a>

            <div id="searchForm" class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs">
                <div class="form-group" style="padding-top: 10px;">
                    <div class="input-group">
                        <span class="input-group-btn">
                            <button onclick="searchSubmit();" class="btn btn-sm bg-white" style="background-color: #ffffff; border-radius: 7px;"><i class="fa fa-search"></i></button> </span>
                            <input name="search_name" type="text" placeholder="Search songs, albums..." class="form-control input-sm" style="border-radius: 0px 7px 7px 0px;">
                    </div>
                    <i id="searchIndicator" style="display: none;" class="fa fa-spinner fa-spin"></i>
                </div>
            </div>
            <script type="text/javascript">
                $("input[name='search_name']").keypress(function(e){
                    if(e.keyCode == 13){
                        searchSubmit();
                    }
                });
            </script>
        </div>
        <ul class="nav pull-right">
            <li class="dropdown hidden-xs">
                <a title="Send invitation">
                    <i class="fa fa-paper-plane"></i>
                </a>
            </li>
            <li class="dropdown hidden-xs">
                <a class="dropdown-toggle" data-toggle="dropdown">
                    <span class="label label-danger pull-left">5</span>
                    <i class="fa fa-bell fa-lg"></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
                    <li class="dropdown-header">text_order</li>
                    <li><a href="" style="display: block; overflow: auto;"><span class="label label-warning pull-right">order status total</span>text order status</a></li>
                    <li><a href=""><span class="label label-success pull-right">complete status total</span>text complete status total</a></li>
                    <li><a href=""><span class="label label-danger pull-right">Return total</span>Test return</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">customer</li>
                    <li><a href=""><span class="label label-success pull-right">online_total</span>text online</a></li>
                    <li><a href=""><span class="label label-danger pull-right">customer_total</span>text_approval</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">text product</li>
                    <li><a href=""><span class="label label-danger pull-right">product_total</span>text_stock</a></li>
                    <li><a href=""><span class="label label-danger pull-right">review_total</span>text_review</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">text_affiliate</li>
                    <li><a href=""><span class="label label-danger pull-right">affiliate_total</span>text_approval</a></li>
                </ul>
            </li>
            <li>
                <a data-toggle="dropdown" class="dropdown-toggle bg clear" href="#">
                    <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm">
                        <img style="height: 47px; width: 50px;" alt="John.Smith" class="img-circle" src="https://graph.facebook.com/819276394825557/picture?width=47">
                    </span> Robert Duy &nbsp;
                </a>
                <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
                    <li><a href="" style="display: block; overflow: auto;">Setting</a></li>
                    <li><a href="">Profile</a></li>
                    <li><a href="">Notifications</a></li>
                    <li class="divider"></li>
                    <li><a href="">Logout</a></li>
                </ul>
            </li>
        </ul>
    </header>