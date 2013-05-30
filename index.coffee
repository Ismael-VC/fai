# Node modules
HTTP = require 'http'
OS   = require 'os'
Path = require 'path'
FS   = require 'fs'

# I know, this is not recommended, but fuck it.
GLOBAL.ﬁ = {}

path = './core/'

# All paths used throughout ﬁ
ﬁ.path  = require "#{path}path"

# Core configuration
ﬁ.conf  = require "#{path}conf"

# Debugging methods
ﬁ.debug = require "#{path}debug"

# Underscore, on steroids.
ﬁ.util  = require "#{path}util"

# Enable logs
ﬁ.log = require "#{path}log"

# Helper methods
ﬁ[name] = helper for name,helper of require "#{path}help"

# Enable custom error with traceback
ﬁ.error = ﬁ.require 'core', 'error'

# Make sure default files exist
require "#{path}defaults"

# Populate settings
ﬁ.settings = ﬁ.require 'core', 'settings'

# Populate controls
ﬁ.controls = ﬁ.requireFS ﬁ.path.controls

# Populate locals
ﬁ.locals = ﬁ.require 'core', 'locals'

# Initialize middleware
ﬁ.middleware = ﬁ.require 'core', 'middleware'
ﬁ.middleware.push ﬁ.log.middleware

# Initializae Asset managament
ﬁ.assets = ﬁ.require 'core', 'assets'
ﬁ.locals = ﬁ.util.extend ﬁ.locals, ﬁ.assets

# Setup server
ﬁ.server = ﬁ.require 'core', 'server'

ﬁ.routes = ﬁ.require 'core', 'routes'
ﬁ.require 'backend', 'routes'

ﬁ.listen = ->
	throw new ﬁ.error 'ﬁ is already listening.' if ﬁ.isListening

	HTTP.createServer(ﬁ.server).listen ﬁ.conf.port
	ﬁ.log.custom (method:'info', caller:"fi"), "Listening on #{ﬁ.conf.url}"
	ﬁ.isListening = true
	ﬁ.debug('listen')
