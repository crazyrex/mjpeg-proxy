# Using the Paparazzo.js module

Paparazzo = require 'paparazzo'
http = require 'http'
url = require 'url'

# For a list of public cameras to test check:
# https://github.com/rodowi/Paparazzo.js/wiki/List-of-public-cameras

auth = 'Basic ' + new Buffer('admin:manga123').toString('base64')

paparazzo = new Paparazzo
    host: '10.0.0.4'
    port: 80
    path: '/videostream.cgi?&loginuse=admin&loginpas=manga123&p=f.mjpg'

updatedImage = ''

paparazzo.on "update", (image) =>
    updatedImage = image
    console.log "Downloaded #{image.length} bytes"

paparazzo.on 'error', (error) =>
    console.log "Error: #{error.message}"

paparazzo.start()

http.createServer (req, res) ->
    data = ''
    path = url.parse(req.url).pathname

    if path == '/camera' and updatedImage?
        data = updatedImage
        console.log "Will serve image of #{data.length} bytes"

    res.writeHead 200,
        'Content-Type': 'image/jpeg'
        'Content-Length': data.length

    res.write data, 'binary'
    res.end()
.listen(3000)
