require 'spec_helper'

describe CreateSymlink do
  describe '##start' do
    it 'make a call setup profile command' do
      Profile.any_instance.should_receive(:execute).once
      CreateSymlink.start 'folder'
    end
  end
end

class Profile
  def initialize(folder)
    @folder = folder
  end
end

