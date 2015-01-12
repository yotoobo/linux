acl purge {
"localhost";
"192.168.0.0"/24;
}

backend w37 {
.host = "192.168.0.37";
.port = "80";
.connect_timeout = 2s;
.probe = {
    .url       = "/";
    .expected_response = 301;
    .interval  = 5s;
    .timeout   = 2s;
    .window    = 5;
    .threshold = 3;
}
}

backend w67 {
.host = "192.168.0.67";
.port = "80";
.connect_timeout = 2s;
.probe = {
    .url       = "/";
    .expected_response = 301;
    .interval  = 5s;
    .timeout   = 2s;
    .window    = 5;
    .threshold = 3;
}
}

director taocz client {
{
    .backend = w37;
    .weight = 6;
}
{
    .backend = w67;
    .weight = 6;
}
}


sub vcl_recv {
remove req.http.X-Forwarded-For;
remove req.http.X-real-ip;  
set req.http.X-real-ip = client.ip;
set req.http.X-Forwarded-For = client.ip;
set req.backend = taocz;

set client.identity = client.ip;

if ((req.request == "GET" || req.request == "HEAD") && (req.http.host == "www.taocz.com" || req.http.host == "taocz.com" )) {
    if (req.url == "/" || req.url ~ "^/search-" || req.url ~ "^/goods-" || req.url ~ "^/store-" || req.url ~ "^/index\.php\?app=search\.search\&act=ajaxLoad" ) {
        if (req.http.Accept-Encoding) {
            if (req.http.Accept-Encoding ~ "gzip") {
                set req.http.Accept-Encoding = "gzip";
            } elsif (req.http.Accept-Encoding ~ "deflate") {
                set req.http.Accept-Encoding = "deflate";
            } else {
                remove req.http.Accept-Encoding;
            }
        }
        return (lookup);
    } else {
        return (pass);
    }
}

if (req.request == "BAN") {
    if (!client.ip ~ purge) {
        error 405 "Not allowed.";
    }
    ban("req.url == " + req.url);
    error 200 "Baned.";
}
if (req.request == "BANALL") {
    if (!client.ip ~ purge) {
        error 405 "Not allowed.";
    }
    ban("req.url ~ . ");
    error 200 "All Baned.";
}
return (pass);
}

sub vcl_hash {

}

sub vcl_fetch {

if ((req.request == "GET" || req.request == "HEAD") && (req.http.host == "www.taocz.com" ||req.http.host == "taocz.com" )) {

    if(req.url == "/" || req.url ~ "^/search-" || req.url ~ "^/goods-" || req.url ~ "^/store-" || req.url ~ "^/index\.php\?app=search\.search\&act=ajaxLoad" ) {
        unset beresp.http.Set-Cookie;
        unset beresp.http.Pragma;
        unset beresp.http.Cache-Control;
        unset beresp.http.Expires;
        if (beresp.status >= 400) {
            set beresp.ttl = 0s;
        } else {
            if( req.url ~ "^/goods-" ) {
                set beresp.ttl = 24h; 
            } else if( req.url ~ "^/index\.php\?app=search\.search\&act=ajaxLoad") {
		set beresp.ttl = 1800s;
	    } else {
                set beresp.ttl = 4h;
            }
        }
    }

    return (deliver);
}
}

sub vcl_deliver {
if (obj.hits > 0) {
    set resp.http.X-Cache = "HIT";
    set resp.http.X-Cache-Hits = obj.hits;
} else {
    set resp.http.X-Cache = "MISS";
}
set resp.http.Via = "taocz";
unset resp.http.X-Varnish;
}

sub vcl_error {
set obj.http.Content-Type = "text/html; charset=utf-8";
synthetic  "/* " + obj.status + " " + obj.response + " */" ;
return (deliver);
}

