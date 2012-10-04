require 'minitest/autorun'
require 'minitest/unit'

require 'aequitas'
require 'virtus'
require 'aequitas/virtus_integration'

#$LOAD_PATH << File.expand_path('../../lib', __FILE__)

Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each { |f| require(f) }
