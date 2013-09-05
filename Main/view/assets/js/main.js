var TWC = {};

TWC.isMobile = function () {
        return $(window).width() < 768;
};
TWC.isDesktop = function () {
    return $(window).width() >= 975;
};

TWC.isTablet = function () {
    var w = $(window).width();
    return w >= 768 && w < 975;
};

$(window).resize(function(){
    // if(!TWC.isMobile()){
        // $('article.service header').siblings('p').removeClass('visuallyhidden');
    // }
});

$(document).ready(function(){
    $('.rslides').responsiveSlides();
    $('article.service p').addClass('visuallyhidden');
    $('header nav ul ').addClass('visuallyhidden');
    $('header nav a.menu').click(function(){
        if(TWC.isMobile()){
            $(this).siblings('ul').toggleClass('visuallyhidden');
        }
    });
    $('article.service header').click(function(){
        if(TWC.isMobile()){
            $(this).children("span.icon.expand").toggleClass("minus");
            $(this).siblings('p').toggleClass('visuallyhidden');
        }
    });
});
