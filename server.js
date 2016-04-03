var MjpegProxy = require('mjpeg-proxy').MjpegProxy;
var express = require('express');
var app = express();
 
app.get('/stream.mjpg', new MjpegProxy('http://admin:manga123@10.0.0.4/videostream.cgi?&loginuse=admin&loginpas=manga123').proxyRequest);
app.listen(8082);
