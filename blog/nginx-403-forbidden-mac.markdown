## 403 Forbidden in Nginx on Mac OSX

If you installed `nginx` on your MacOSX system using `brew install nginx` and if you are getting a **403 Forbidden** error for static html files in your web browser on localhost, then this is usually a permissions issue. If you look at nginx error logs (usually `/var/logs/nginx/error.log`), you will see something like:

<div class=terminal><pre>
$ tail -f /var/log/nginx/error.log 
2015/10/11 01:19:16 [error] 24181#0: *5 "/Users/amberj/Dropbox/projects/amberja.in/index.html" is forbidden (13: Permission denied), client: 127.0.0.1, server: localhost, request: "GET / HTTP/1.1", host: "localhost:8080"</pre></div>

In this case, many people suggested doing `chmod -R ugo+x` on `root` directory (as defined in either `nginx.conf` or `*.conf` in `/usr/local/etc/nginx/`).

Another solution suggested on Google suggest fixing the following line in your `nginx.conf` according to your system user configuration:
<pre>user  www-data;</pre>

But none of these worked for me. Then I read on some forum that one needs to do `chmod -R ugo+x` for all parent directories (of document root in nginx config) up until the Mac's root directory. In my case, I had put the static html file at `/Users/amberj/Dropbox/projects/amberja.in` and I didnt had `o+x` permissions on `/Users/amberj/Dropbox/` directory. Bingo!

So, I checked that all of the following directories:

* `/Users/`
* `/Users/amberj/`
* `/Users/amberj/Dropbox/`
* `/Users/amberj/Dropbox/projects/`
* `/Users/amberj/Dropbox/projects/amberja.in`

had `o+x` permissions and used `chmod o+x` on those directories which didnt had this permission. Then when I reloaded [http://localhost:8080/](http://localhost:8080/), tada! There it was.. my sweet little index.html page.

**Thanks** to [Pawan Rawal](https://www.linkedin.com/in/pawanrawal1) for reading early draft of this post.