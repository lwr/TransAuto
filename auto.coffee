parseString = require('xml2js').parseString;
Transmission = require 'transmission'
http = require 'http'

fs = require 'fs';

# please copy the 'auto.conf.sample.json' to 'auto.conf.json' and change for your own
config = JSON.parse(fs.readFileSync("./auto.conf.json"));

# 请在 'auto.conf.json' 中填写你在 chd 的 rss 地址，格式参考 'auto.conf.sample.json'
rss_url = config.rss_url;

# 请在 'auto.conf.json' 中填写你的 transmission daemon 信息，格式参考 'auto.conf.sample.json'
transmission = new Transmission(config.transmission);

# 读取 rss 的间隔，单位：秒
frequency = config.frequency || 10;

transmission.on 'added', (hash, id, name) ->
    console.log '成功添加了种子：', name

main_proc = () ->
    try
        rss_req = http.request rss_url, (res) ->
            data = ''
            res.setEncoding 'utf8'
            res.on 'data', (chunk) ->
                data += chunk
            res.on 'end', () ->
                try
                    parseString data, (err, result) ->
                        unless err
                            for item in result?.rss?.channel?[0]?.item || []
                                torrent = item.enclosure[0].$.url
                                # console.log "Adding torrent: #{torrent}"
                                transmission.add torrent, (err, result) ->
                                    console.log err  if  err

                catch e
                    console.log "parse data failed: #{data}, error=#{e}"

        rss_req.on 'error', (e) ->
            console.log "获取 rss 时遭遇错误：#{e}"

        rss_req.end()
    catch e
        return

if process.argv[2] == 'runOnce'
    setTimeout main_proc
else
    setInterval main_proc, frequency * 1000
