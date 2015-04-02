#! /usr/bin/env node
// -*- js -*-

"use strict";

(function () {

    var xpath = require('xpath');
    var DOMParser = require('xmldom').DOMParser;
    var Transmission = require('transmission');
    var config = require("./auto.conf.json");

    var url = config.rss_url;
    var transmission = new Transmission(config.transmission);

    function requestRss(once) {

        var request = (url.match(/^https:/) ? require('https') : require('http')).request(url, function (res) {
            var data = '';
            res.setEncoding('utf8');
            res.on('data', function (chunk) {
                data += chunk;
            });
            res.on('end', function () {
                try {
                    var urls = xpath.select("/rss/channel/item/enclosure/@url", new DOMParser().parseFromString(data));
                    if (once && !urls.length) {
                        console.log("rss 无任何内容");
                    }

                    urls.forEach(function (url) {
                        var title = xpath.select1("../../title/text()", url).nodeValue;
                        var torrent = url.value;
                        transmission.add(torrent, function (err) {
                            if (err) {
                                console.log("添加种子失败: %s, torrent=%s, error=%s", title, torrent, err.stack || err);
                            } else {
                                console.log("添加种子成功: %s, torrent=%s", title, torrent);
                            }
                        });
                    });
                } catch (e) {
                    console.log("parse data failed: %s\n%s", e.stack, data);
                }
            });
        });

        request.on('error', function (e) {
            console.log("获取 rss 时遭遇错误：" + e);
        });
        request.end();
    }

    if (process.argv[2] === 'once' || process.argv[2] === 'runOnce') {
        requestRss(true);
    } else {
        setInterval(requestRss, (config.frequency || 10) * 1000);
    }

})();
