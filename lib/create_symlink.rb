require File.expand_path("../../lib/profile", __FILE__)
module SymlinkCreator
  def self.start(folder)
    profile = Profile.new(folder)
    profile.execute
  end
end
