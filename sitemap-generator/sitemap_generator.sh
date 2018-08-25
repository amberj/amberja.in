#!/bin/bash

protocol=https
ping=false
output="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmp=/tmp/
name=sitemap
excludefilelist=xml,inc,old,save,txt,js,LCK,zip,ZIP,bmp,BMP,jpg,jpeg,JPG,GIF,PNG,png,gif,CSV,csv,css,class,jar,txt,ico,svg,SVG
DATE=`date +%Y-%m-%d`

while getopts ":p:sd:o:n:e:" opt; do
  case $opt in
    p)
      protocol=$OPTARG
      ;;
    s)
      ping=true
      ;;
    d)
      sitedomain=$OPTARG
      sitepath="${sitedomain//.}"
      ;;
    o)
      output=$OPTARG
      ;;
    n)
      name=$OPTARG
      ;;
    e)
      excludefilelist=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$sitedomain" ]; then
	echo "-d is empty"
	exit 1
fi

if ! [[ "$sitedomain" =~ ^(([a-zA-Z](-?[a-zA-Z0-9])*)\.)*[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}$ ]]; then
	echo "-d is not a valid domain"
	exit 1
fi

mkdir /tmp/$sitepath
cd /tmp/$sitepath
wget --spider --recursive --level=inf --no-verbose --output-file=linklist.txt -R $excludefilelist $protocol://$sitedomain/
grep -i URL linklist.txt | awk -F 'URL:' '{print $2}' | awk '{$1=$1};1' | awk '{print $1}' | sort -u | sed '/^$/d' > sortedurls.txt
header='<?xml version="1.0" encoding="UTF-8"?><urlset
      xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">'
echo $header > $name.xml
while read p; do
  case "$p" in
  $protocol://*/ | $protocol://*.html | $protocol://*.htm)
    echo "$p" >> $name.txt
    echo '<url><loc>'$p'</loc><lastmod>'$DATE'</lastmod><changefreq>daily</changefreq><priority>0.5</priority></url>' >> $name.xml
    ;;
  *)
    ;;
 esac
done < sortedurls.txt
echo "</urlset>" >> $name.xml
gzip -c -9 $name.xml > $name.xml.gz
/bin/cp -rf $name.xml $name.xml.gz $name.txt $output
rm -rf /tmp/$sitepath

if [ "$ping" = true ]; then
	wget -q --spider "http://www.bing.com/ping?sitemap=http%3A%2F%2F$sitedomain/$name.xml"
	wget -q --spider "http://www.google.com/webmasters/sitemaps/ping?sitemap=http%3A%2F%2F$sitedomain/$name.xml"
fi