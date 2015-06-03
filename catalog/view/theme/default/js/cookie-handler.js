var CookieHandler = {};
CookieHandler.exdays = 2;
CookieHandler.setCookie = function(cname, cvalue, exdays){
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

CookieHandler.updateCookie = function(cname, addValue){
    var cookie = CookieHandler.getCookie(cname);
    if(cookie != ""){
        if(cookie instanceof []){
            cookie.push(addValue);
            CookieHandler.setCookie(cname, cookie, CookieHandler.exdays);
        }else if(typeof cookie == "string"){
            cookie = addValue;
            CookieHandler.setCookie(cname, cookie, CookieHandler.exdays);
        }
    }
}

CookieHandler.getCookie = function(cname){
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
    }
    return "";
}