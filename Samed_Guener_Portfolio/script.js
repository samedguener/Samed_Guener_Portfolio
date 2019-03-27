/* window.onload = function() {
    // Load last three blogposts from rss-feed
    fetch('http://127.0.0.1:5500/rss.xml', { method : 'GET', headers : { "Content-Type": "application/xml"}})
    .then((res) => { 
        if(res.ok)
            return res.text()
        
        return Promise.reject("Fetching of posts have failed!");
    })
    .then((xmlString) => { 
        xmlParser = new DOMParser();
        xmlDoc = xmlParser.parseFromString(xmlString, "text/xml");
        items = xmlDoc.getElementsByTagName("channel")[0].getElementsByTagName("item"); 
        blogItems = document.getElementById("blog-items");
        for(i=0; i < 3; i++){
            blogPost = document.createElement("div");
            blogPost.className = "blog-post";

            blogPostTitle = document.createElement("div");
            blogPostTitle.className = "blog-post-title";
            blogPostTitle.textContent = items[i].getElementsByTagName("title")[0].textContent;
            
            blogPostDate = document.createElement("div");
            blogPostDate.className = "blog-post-date";
            blogPostDate.textContent = items[i].getElementsByTagName("pubDate")[0].textContent;

            blogPostDescription = document.createElement("div");
            blogPostDescription.className = "blog-post-description";
            blogPostDescription.textContent = items[i].getElementsByTagName("description")[0].textContent;

            blogPost.appendChild(blogPostTitle);
            blogPost.appendChild(blogPostDate);
            blogPost.appendChild(blogPostDescription);

            blogItems.appendChild(blogPost);
        } 
        
    })
    .catch((err) => { console.log(err)})
    
} */

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