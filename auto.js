(function() {
  var Transmission, frequency, http, parseString, rss_url, transmission;

  parseString = require('xml2js').parseString;

  Transmission = require('transmission');

  http = require('http');
  
  // 您在chd的rss地址
  rss_url = "http://chdbits.org/torrentrss.php?myrss=1&linktype=dl&uid=.......";
  
  // 填写您的transmission信息
  transmission = new Transmission({
    host: 'localhost',
    port: 9091,
    username: 'admin',
    password: '123123'
  });
  
  // 读取rss的间隔，单位：秒
  frequency = 10;

  transmission.on('added', function(hash, id, name) {
    return console.log('成功添加了种子：', name);
  });

  setInterval(function() {
    var rss_req;
    rss_req = http.request(rss_url, function(res) {
      res.setEncoding('utf8');
      return res.on('data', function(trunk) {
        return parseString(trunk, function(err, result) {
          var item, items, torrent, _i, _len, _results;
          if (!err) {
            items = result.rss.channel[0].item;
            if (items) {
              _results = [];
              for (_i = 0, _len = items.length; _i < _len; _i++) {
                item = items[_i];
                torrent = item.enclosure[0].$.url;
                _results.push(transmission.add(torrent, function(err, result) {
                  if (err) {
                    return console.log(err);
                  }
                }));
              }
              return _results;
            }
          }
        });
      });
    });
    rss_req.on('error', function(e) {
      return console.log('获取rss时遭遇错误：#{e.message}');
    });
    return rss_req.end();
  }, frequency * 1000);

}).call(this);
