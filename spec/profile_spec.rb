require 'spec_helper'
require File.expand_path("../../lib/profile", __FILE__)

describe Profile do
  describe '#execute' do
    let(:profile) { Profile.new 'some_folder' }
    it 'should call prepare_folder and then create_symlinks' do
      Profile.any_instance.should_receive(:prepare_folder)
      profile.execute
    end
  end
  
  describe '#prepare_folder' do
    let(:profile) { Profile.new 'spec/test_data/profile2' }
    before :each do
      profile.stub(:path).and_return('spec/test_data/profile2')
    end 

    it 'makes a call remove old symlinks for each file in directory' do
      profile.stub(:check_for_existing_file).and_return(true)
 
      Profile.any_instance.should_receive(:remove_old_symlinks).exactly(4).times
      profile.prepare_folder
    end

    it 'makes a call to remove existing files for each file in directory' do
      profile.stub(:remove_old_symlinks).and_return(true)
 
      Profile.any_instance.should_receive(:check_for_existing_file).exactly(4).times
      profile.prepare_folder
    end
  end

  describe "#remove_old_symlinks" do
    let(:profile) { Profile.new 'some_folder' }
    it 'removes symlinks for old files' do
      File.symlink("spec/test_data/profile2/not_duplicate.txt", "spec/test_data/not_duplicate.txt")
      profile.stub(:path).and_return('spec/test_data/profile2')
      profile.remove_old_symlinks("not_duplicate.txt")

      File.symlink?("spec/test_data/not_duplicate.txt").should == false
    end
  end

  describe '#check_for_existing_file' do
    let(:profile) { Profile.new 'some_folder' }

    it "call create symlinks if file does not exist" do
      profile.should_receive(:create_symlinks).with('file.txt')
      profile.check_for_existing_file('file.txt')
    end

    it "not return the file if it does exist" do
      profile.should_not_receive(:create_symlinks).with('file.txt')
      profile.check_for_existing_file('duplicate.txt')
    end
  end

  describe '#create_symlinks' do
    let(:profile) { Profile.new 'spec/test_data/profile' }

    it 'should create symlinks for files' do
      profile.stub(:path).and_return('spec/test_data/profile')
      file = 'Untitled.rft'

      profile.create_symlinks(file)
      File.symlink?("spec/test_data/#{file}").should == true

      ## cleanup
      system("rm 'spec/test_data/#{file}'")
    end
  end
end
