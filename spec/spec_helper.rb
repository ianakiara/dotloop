$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'plissken'
require 'dotloop'
require 'pry'

def json_fixture(path)
  string = File.read(File.join(File.dirname(__FILE__), 'stub_responses', path))
  Dotloop::Client.snakify(JSON.parse(string))
end
