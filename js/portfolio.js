
$(document).ready(function(){

$("#navBtnAbout").click(function(){
    $("html,body").animate( {scrollTop: $("#sectionTwoHome").offset().top }, 'slow'); 
});

$("#navBtnSkill").click(function(){
     $("html,body").animate( {scrollTop: $("#sectionThreeHome").offset().top }, 'slow'); 
});

$("#navBtnContact").click(function(){
    $("html,body").animate( {scrollTop: $("#sectionFiveHome").offset().top }, 'slow'); 
});

$("#sectionOneBoxButton").click(function(){
    $("html,body").animate( {scrollTop: $("#sectionTwoHome").offset().top }, 'slow'); 
});


});

