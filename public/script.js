// Navigation for Mobile Devices
function showNav(barButton) {
    var x = document.getElementById("nav");
    if (x.className === "nav") {
        x.className += " show";
    } else {
        x.className = "nav";
    }
    barButton.classList.toggle("mobileNavEnabled");
}