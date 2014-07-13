// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require thirdparty/waitForImage
//= require thirdparty/jquery.touchwipe.min
//= require thirdparty/angular.min
//= require thirdparty/masonry.pkgd.min.js
//= require thirdparty/angular-masonry.min.js
//= require thirdparty/angular-cookies.min.js
//= require thirdparty/angular-sanitize.min.js
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

$(document).ready(function(){
    $(window).on('touchend click',function() {
        hide_side_bar()
        $('#blink').fadeOut(function(){
            $('#blink').remove();
        });
    });

    $('#side_menu').click(function(){
        show_side_bar()
    })
    $('#side_bar,#side_menu,#img').on('touchend click',function(event){
        event.stopPropagation();
    });
})


var mysite = angular.module('mysite',['ngCookies','ngSanitize','wu.masonry']);

mysite.directive('bgImg',function(){
return{
    restrict: 'A',
    link: function(scope, element, attrs) {
        element.css({
            'background-image': 'url('+attrs.bgImg+')',
            'background-repeat': 'no-repeat',
            'background-position': 'center center'
        })
        correctSize(attrs.id)
    }
}});


mysite.directive('bgImgFixed',function(){
return{
    restrict: 'A',
    link: function(scope, element, attrs) {
        element.css({
            'background-image': 'url('+attrs.bgImgFixed+')',
            'background-repeat': 'no-repeat',
            'background-size' : '100% 100%',
            'background-position': 'center center'
        })
    }
}});
mysite.directive('overText',function(){
    return{
        restrict: 'A',
        link: function(scope, element,attrs) {
            element.append('<div class="item_cover"><div id="show'+attrs.id+'" class="cover_text" >'+attrs.overText+'</div></div>');
            $('#show'+attrs.id).css("line-height",element.height()+'px');
            element.on('mouseenter', function() {
                $('#show'+attrs.id).css("visibility",'visible');
            });
            element.on('mouseleave', function() {
                $('#show'+attrs.id).css("visibility",'hidden');
            });
        }
    }
});
mysite.directive('highlight',function(){
    return{
        restrict: 'A',
        link: function(scope, element,attrs) {
            element.append('<div class="highlight_'+attrs.highlight+'" ></div>');
            element.on('mouseenter', function() {
                $('#show'+attrs.id).css("visibility",'visible');
            });
            element.on('mouseleave', function() {
                $('#show'+attrs.id).css("visibility",'hidden');
            });
        }
    }
}) ;


var lang = [{
    "id":"en",
    "url":"en"},{
    "id":"cn",
    "url":"cn"}];
mysite.service('languageServices',function($http){
    return {
        setDefaultLanguage:function(lang,callback){
            $http.get('/js/lang/'+lang+'.json').success(function(data){
                callback(data);
            })
        },
        changeLanguage:function(lang,callback){
            $http.get('/js/lang/'+lang+'.json').success(function(data){
                callback(data);
            })
        }
    }
})

mysite.controller('TopbarCtrl',function($scope,$rootScope,languageServices,$cookies){
    var setLang= function(data){
        $rootScope.lang=data;
    }
    $scope.languages = lang;
    if(!angular.isDefined($cookies.language))$cookies.language='cn';
    console.log($cookies.language);
    languageServices.setDefaultLanguage($cookies.language,setLang);

    $scope.changeLanguage = function(lang){
        if(lang=='en'){
            alert ('It is not ready yet! I am still working on it :)')
            return false;
        }
        $cookies.language= lang;
        languageServices.changeLanguage(lang,setLang)
    }

})
function show_side_bar(){
    $('#side_bar').animate({width: '300px'},200);
    $('#html_container').animate({left: '300px'},200);
    $('.wrap').animate({overflow: "hidden"},200);
    document.onmousewheel=function(){
        return false;
    };
}

function hide_side_bar(){
    $('#side_bar').animate({width: '0px'},200);
    $('#html_container').animate({left: '0px'},200);
    $('.wrap').animate({overflow: "auto"},200);
    document.onmousewheel=function(){
        return true;
    };
}
function get_ratio(id){
    var img = new Image();
    img.src =   $('#'+id).css('background-image').replace(/^url\(["']?/, '').replace(/["']?\)$/, '')
    var bgImgWidth
    var bgImgHeight;
        bgImgWidth  = img.width;
        bgImgHeight = img.height;
    return  bgImgWidth/bgImgHeight;

}

function correctSize(container){
    var img_ratio = get_ratio(container);
    var con = $('#'+container);
    var width = con.width();
    var height = con.height();
    var bg_ratio = width/height
    console.log("id: "+container+": background: "+bg_ratio+" / image: "+ img_ratio);
    if(width>height) { //如果是横屏幕
        if(img_ratio>0){                     //如果是宽图
            if(bg_ratio>img_ratio){     //如果屏幕比图宽
                con.css('background-size','100% auto ')
            }else{
                con.css('background-size','auto 100% ')
            }
        }else{                 //如果是长图
            con.css('background-size','100% auto')
        }
    }else{     //如果是竖屏幕
        if(img_ratio<0){                     //如果是竖图
            if(bg_ratio<mg_ratio){     //如果屏幕比图长
                con.css('background-size','100% auto')
            }else{
                con.css('background-size','100% auto')
            }
        }else{                 //如果是宽图
            con.css('background-size','auto 100%')
        }
    }
}

var pic_list= [];
open_img = function(element) {
    var blink, blink_d, container, html, img_url;
    img_url = $(element).attr('open-pic');
    blink = "<div style='z-index: 997' class='blink_c' id='blink_c'><div class='blink_c_centered'>Loading...</div></div>";
    blink_d = "<div style='z-index: 997' class='blink_u' id='blink_c'><div class='blink_c_centered'>Loading...</div></div>";
    container = "<div id='pic_center_container' class='pic_center_container'>";
    container += "<img style='cursor: pointer' id='img' src='" + img_url + "' >";
    container += "</div>";
    console.log(container)
    html = blink + "<div  class='blink' id='blink'>" + container + "</div>";
    $('body').prepend(html);
    $('#center_container_closer').on('click', function() {
        return $('#blink').fadeOut(function() {
            return $('#blink').remove();
        });
    });
    return $('#pic_center_container').waitForImages(function() {
        var current, img;
        current = pic_list.indexOf(img_url);
        img = $('#img');
        $('#img').on('touchend click', function(e) {
            return e.stopPropagation();
        });
        img.on('click', function(e) {
            var i, offset;
            offset = $(this).offset();
            i;
            if ((e.clientX - offset.left) > Math.round(img.width() * 0.5)) {
                i = current + 1;
                if (i >= pic_list.length) {
                    i -= pic_list.length;
                }
            } else {
                i = current - 1;
                if (i < 0) {
                    i = pic_list.length - 1;
                }
            }
            img.css('width', '');
            img.css('height', '');
            img.attr('src', pic_list[i]);
            $('body').prepend(blink_d);
            img.waitForImages(function() {
                return $('#blink_c').fadeOut(function() {
                    return $('#blink_c').remove();
                });
            });
            current = i;
            return adjust();
        });
        return adjust();
    });
};

adjust = function() {
    var container;
    container = $('#pic_center_container');
    if ($('#img').height() > Math.floor(window.innerHeight * 0.8)) {
        $('#img').css("height", Math.floor(window.innerHeight * 0.8) + 'px');
        $('#img').css("width", '');
    }
    if ($('#img').width() > Math.floor(window.innerWidth * 0.8)) {
        $('#img').css("width", Math.floor(window.innerWidth * 0.8) + 'px');
        $('#img').css("height", '');
    }
    return $('#pic_center_container').waitForImages(function() {
        var left_margin, top_margin;
        top_margin = Math.floor(window.innerHeight - $('#img').height()) / 2;
        left_margin = Math.floor(window.innerWidth - $('#img').width()) / 2;
        if (left_margin < 0) {
            left_margin = 0;
        }
        if (top_margin < 0) {
            top_margin = 0;
        }
        container.css('margin-top', top_margin + 'px');
        container.css('left', left_margin + 'px');
        return $('.blink_c').fadeOut(function() {
            return $('#blink_c').remove();
        });
    });
};