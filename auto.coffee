parseString = require('xml2js').parseString;
Transmission = require 'transmission'
http = require 'http'
# 您在chd的rss地址
rss_url = "http://chdbits.org/torrentrss.php?myrss=1&linktype=dl&uid=......."
# 填写您的transmission信息
transmission = new Transmission
    host: 'localhost'
    port: 9091
    username: 'admin'
    password: '123123'
# 读取rss的间隔，单位：秒
frequency = 10

transmission.on 'added', (hash, id, name) ->
    console.log '成功添加了种子：', name

setInterval ->
    try
        rss_req = http.request rss_url, (res) ->
            res.setEncoding 'utf8'
            res.on 'data', (trunk) ->
                parseString trunk, (err, result) ->
                    unless err
                        items = result.rss.channel[0].item
                        if items
                            for item in items
                                torrent = item.enclosure[0].$.url
                                transmission.add torrent, (err, result) ->
                                    console.log err  if  err

        rss_req.on 'error', (e) ->
            console.log '获取rss时遭遇错误：#{e.message}'

        rss_req.end()
    catch e
        return
, frequency * 1000
