TransAuto
=========

RSS downloader for Transmission, written in Node.js.
CHDBits.org only.

## 这是做什么的？

当你在CHD某个种子页面里，点击「RSS下载」后，这个种子就会被自动添加到你服务器上的transmission里了

## HOW TO USE:

1. Install node, npm.
2. `npm install transmission xml2js`
3. Edit auto.coffee/auto.js && Compile coffee it into auto.js 
4. `coffee auto.coffee` or `node auto.js`


英文不好写着真难受啊啊啊啊啊啊。
其实就是先装上transmission和xml2js这两个模块，然后编辑一下auto.coffee或者auto.js，填写一下你的RSS地址和transmission的信息，完事儿了直接运行即可。

暂时应该只支持CHD，因为我只有这个PT站的号...
不过猜想如果用的都是同一套PT站的程序，应该都通用，比如BYR的

## TODO:
- [x] Make it an infinite loop, so you can use it without crontab.
- [x] Use Built-in HTTP request method to fetch RSS feed instead of using cURL.
- [ ] Support other PT sites.
