require 'bundler'
Bundler.require(:default, :test)

require 'minitest/autorun'
require File.join(__dir__, '../lib/easy_api.rb')
