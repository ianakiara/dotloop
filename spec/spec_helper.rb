$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ROOT = Pathname.new(Gem::Specification.find_by_name('dotloop').gem_dir).freeze
require 'plissken'
require 'dotloop'
require 'pry'
require 'webmock/rspec'
require_relative './helpers/webmocks'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |conf|
  conf.include Helpers
end
