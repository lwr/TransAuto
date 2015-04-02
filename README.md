
TransAuto
=========

RSS downloader for Transmission, written in Node.js.
CHDBits.org only.

## 这是做什么的？

当你在CHD某个种子页面里，点击「RSS下载」后，这个种子就会被自动添加到你服务器上的transmission里了

## HOW TO USE:

1. `npm install`
2. Copy 'auto.conf.sample.json' to 'auto.conf.json' and edit for your own
3. `node auto.js`

-- 此乃既不萌又不帅的中文版分隔线 --

1. `npm install` 安装所有依赖
2. 创建一个 'auto.conf.json'，填写一下你的 RSS 地址和 transmission daemon 的信息
3. `node auto.js` 完事儿直接跑就是了


## 测试过的站点列表（待补充）

- <http://chdbits.org> - 第一大站 CHD，真不幸，截至当前 (2015-4-2) 仍在关闭中
- <https://tp.m-team.cc>

一般来说所有支持 RSS 的 PT 站应该都能支持

## TODO:
- [x] Make it an infinite loop, so you can use it without crontab.
- [x] Use Built-in HTTP request method to fetch RSS feed instead of using cURL.
- [ ] Support other PT sites.
