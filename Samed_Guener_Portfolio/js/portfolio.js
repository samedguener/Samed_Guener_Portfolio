$(document).ready(function () {

    $("#navBtnAbout").click(function () {
        $("html,body").animate({
            scrollTop: $("#about").offset().top
        }, 'slow');
    });
    
    $("#navBtnResume").click(function () {
        $("html,body").animate({
            scrollTop: $("#resume").offset().top
        }, 'slow');
    });

    $("#navBtnSkill").click(function () {
        $("html,body").animate({
            scrollTop: $("#skill").offset().top
        }, 'slow');
    });

    $("#navBtnContact").click(function () {
        $("html,body").animate({
            scrollTop: $("#contact").offset().top
        }, 'slow');
    });

    $("#sectionOneBoxButton").click(function () {
        $("html,body").animate({
            scrollTop: $("#about").offset().top
        }, 'slow');
    });


});

var textarea = document.querySelector('textarea');

textarea.addEventListener('keydown', autosize);

function autosize() {
    var el = this;
    setTimeout(function () {
        el.style.cssText = 'height:auto; padding:0';
        el.style.cssText = 'height:' + el.scrollHeight + 'px';
    }, 0);
}

function menu() {
    var x = document.getElementById("mainNav");
    if (x.className === "mainNav") {
        x.className += " responsive";
    } else {
        x.className = "mainNav";
    }

    var y = document.getElementById("icon");
    if (y.className === "icon") {
        y.className += " clicked";
        y.textContent = "X";
        y.style.fontFamily = "'Montserrat'";
    } else {
        y.className = "icon";
        y.textContent = "☰";

    }
}
