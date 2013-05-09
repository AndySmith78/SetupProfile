require 'rspec/core'

Dir.glob("spec/features/steps/**/*steps.rb") { |f| load f, true }
