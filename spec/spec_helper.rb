# require 'simplecov'
# SimpleCov.start if ENV['CODE_COVERAGE']
require './lib/array_2d_simple.rb'

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
  c.filter_run_excluding slow: true unless ENV['ALL']
end
