# Sitemap generator

Sitemap Generator as a shell script to generate sitemaps for your website. It generates .xml, .xml.gz and .txt. It can also submit the sitemap to Bing and Google



### Version
0.1.0

### Requirements

You will need to have the following things installed
- wget

### Installation

To install it just download sitemap_generator.sh and make it executable

```sh
$ chmod a+x sitemap_generator.sh
```

It takes the following parameters

`-p`, which protocol (https | http), default is https

`-s`, should it submit the sitemap to Bing and Google

`-d`,  this one is mandatory because it is the domain name

`-o`, Output directory, ex. /var/www/html/

`-n`, name of the sitemap files, ex sitemap generates sitemap.xml etc

`-e`, takes a comma-separated list of file extensions to exclude from the file list

### USAGE
Here is a few examples:

Simple one, where we just set the domain name, it will output the files in the same folder as the script
```sh
$ ./sitemap_generator.sh -d example.com
```

Here is one where we set the protocol to http and submitting it to Google and Bing
```sh
$ ./sitemap_generator.sh -d example.com -p http -s
```

And the last where we set the output folder and change the name of the files
```sh
$ ./sitemap_generator.sh -d example.com -o /sitemaps/ -n maps
```

### TODO
- change lastmod, priority and changefreq



