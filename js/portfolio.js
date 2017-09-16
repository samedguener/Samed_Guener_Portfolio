
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

function menu() {
    var x = document.getElementById("mainNav");
    if (x.className === "mainNav") {
        x.className += " responsive";
    } else {
        x.className = "mainNav";
    }

    var y = document.getElementById("icon");
    if(y.className === "icon"){
        y.className += " clicked";
        y.textContent = "X";
        y.style.fontFamily = "'Montserrat'";
    } else {
        y.className = "icon";
        y.textContent = "☰";
        
    }
}
