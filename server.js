var MjpegProxy = require('mjpeg-proxy').MjpegProxy;
var express = require('express');
var app = express();
var url = '<put here test url>' 
app.get('/stream.mjpg', new MjpegProxy(url).proxyRequest);
app.listen(8082);
