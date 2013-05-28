parseString = require('xml2js').parseString;
Transmission = require 'transmission'
exec = require('child_process').exec

# 您在chd的rss地址
rss_url = "http://chdbits.org/torrentrss.php?myrss=1&linktype=dl&uid=123445&passkey=abcd"

# 填写您的transmission信息
transmission = new Transmission
    host: 'localhost'
    port: 9091
    username: 'admin'
    password: '12345'

fetch_rssurl = "curl --silent '"+rss_url+"'"
transmission.on 'added', (hash, id, name) ->
    console.log '成功添加了种子：', name
console.log "开始读取rss..."+Date()
child = exec fetch_rssurl, (error, stdout, stderr) ->
    parseString stdout, (err, result) ->
        items = result.rss.channel[0].item
        if items
            console.log "找到了"+items.length+"个种子"
            for item in items
                torrent = item.enclosure[0].$.url
                transmission.add torrent, (err, result) ->
                    console.log(err) if err
        else
            console.log "没有需要添加的种子."