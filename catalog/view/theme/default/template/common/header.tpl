<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
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
    <script src="<?php echo STATIC_PATH ?>js/common.js" type="text/javascript"></script>
</head>
<body>
<div id="container">
    <header id="header" class="navbar navbar-static-top">
        <div class="navbar-header">
            <a type="button" id="button-menu" class="pull-left">
                <i class="fa fa-indent fa-lg"></i>
            </a>
            <img src="<?php echo STATIC_PATH ?>image/logo.png" alt="" title="Logo" />
        </div>
        <ul class="nav pull-right">
            <li class="dropdown">
                <a title="Send invitation">
                    <i class="fa fa-paper-plane"></i>
                    <span>Send invitation</span>
                </a>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown">
                    <span class="label label-danger pull-left">5</span>
                    <i class="fa fa-bell fa-lg"></i>
                    <span>Notifications</span>
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
            <li><a href="/"><span class="hidden-xs hidden-sm hidden-md">Back to homepage</span> <i class="fa fa-sign-out fa-lg"></i></a></li>
        </ul>
    </header>