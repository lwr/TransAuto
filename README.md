TransAuto
=========

RSS downloader for Transmission, written in Node.js

## HOW TO USE:

1. Install node, npm. Make sure you have cURL installed.
2. `npm install transmission xml2js`
3. Edit auto.coffee/auto.js && Compile it into auto.js 
4. Create a cron job to run the script every 15 min using following expression `*/15 * * * * node /path/to/auto.js >> /path/to/logfile` or `*/15 * * * * node /path/to/auto.js` without log.

## TODO:
- [ ] Make it an infinite loop, so you can use it without crontab.
- [ ] Use Built-in HTTP request method to fetch RSS feed instead of using cURL.