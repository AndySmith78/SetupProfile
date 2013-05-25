require File.expand_path("../../app/profile", __FILE__)
require 'pry'
module CreateSymlink
  def self.start(folder)
    profile = Profile.new(folder)
    profile.execute
  end
end
