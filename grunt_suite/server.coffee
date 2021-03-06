###
This is developer server
###

stylus      = require 'stylus'
express     = require 'express'
path        = require 'path'
fs          = require 'fs'
util        = require 'util'
livereload  = require 'livereload2'
Clinch      = require 'clinch'

root_path = path.join __dirname, '..'

{get_pack_config} = require './pack_configurator'

packer = new Clinch

###
This is error handlers
###

logErrors = (err, req, res, next) ->
  console.error err.stack
  next err

clientErrorHandler = (err, req, res, next) ->
  if req.xhr
    res.send 500, error: err
  else
    next err

errorHandler = (err, req, res, next) ->
  res.status 500
  res.render 'error',  error: err 

allowCrossDomain = (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS'
  res.header 'Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With'
  # intercept OPTIONS method
  if 'OPTIONS' is req.method then res.send 200 else next()


###
This function create developer server to work with project or docs
###
port = process.env.PORT or 3000

app = express()
app.locals.pretty = true

app.configure ->
  app.set 'views', path.join root_path, 'develop_suite/views'
  app.set 'view engine', 'jade'

  app.use allowCrossDomain

  # its for stylus pre-compiller
  app.use stylus.middleware 
    src : path.join root_path, 'develop_suite/public'

  app.use express.static path.join root_path, 'develop_suite/public'

  app.use express.favicon()
  
  app.use logErrors
  app.use clientErrorHandler
  app.use errorHandler


# static page
app.get '/', (req, res) -> res.redirect 301, '/index.html'

# this is our jade files
app.get '/:html_name', (req,res) ->
  [filename, ext] = req.param('html_name').split '.'
  res.render filename

# our widgets
app.get "/js/:js_name", (req, res, next) ->
  [filename, ext] = req.param('js_name').split '.'

  pack_config = get_pack_config filename
  
  packer.buldPackage pack_config, (err, data) ->
    if err
      next err
    else
      res.type 'application/json'
      res.send data

# live reload suport
livereload_server = livereload.createServer exts: ['styl', 'jade', 'coffee', 'js']
livereload_server.watch path.join root_path, 'develop_suite'
livereload_server.watch path.join root_path, 'src'

console.log "Starting server on port: #{port}"
server = app.listen port

###
This is for clean fast shutdown 
###
process.once 'SIGUSR2', ->
  console.log 'Shutdown Express...'
  server.close()
  process.kill process.pid, 'SIGUSR2'

