require 'rspec/core'
require File.expand_path("../../app/create_symlink", __FILE__)


Dir.glob("spec/features/steps/**/*steps.rb") { |f| load f, true }
