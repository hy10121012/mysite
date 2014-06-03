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
//= require thirdparty/angular.min
//= require thirdparty/angular-cookies.min
//= require thirdparty/angular-sanitize.min

$(document).ready(function(){
    $(window).click(function() {
        hide_side_bar()
    });

    $('#side_menu').click(function(){
        show_side_bar()
    })
    $('#side_bar,#side_menu').click(function(event){
        event.stopPropagation();
    });
})


var mysite = angular.module('mysite',['ngCookies','ngSanitize']);

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
    if(!angular.isDefined($cookies.language))$cookies.language='en';
    console.log($cookies.language);
    languageServices.setDefaultLanguage($cookies.language,setLang);

    $scope.changeLanguage = function(lang){
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


