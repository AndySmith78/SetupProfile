require 'spec_helper'
require File.expand_path("../../app/profile", __FILE__)

describe Profile do
  describe '#execute' do
    it 'should create a new instance of profile class' do
      profile = Profile.new('folder')
      Profile.any_instance.should_receive(:remove_existing_files)
      Profile.any_instance.should_receive(:create_symlinks)
      profile.execute
    end
  end

  describe '#remove_existing_files' do
    it "should remove existing files" do
      profile = Profile.new 'test_data/profile2'
      profile.stub(:path).and_return('spec/test_data/profile2')
      files = profile.remove_existing_files
      files.should == ["not_duplicate.txt"]
    end
  end

  describe '#create_symlinks' do
    it 'should create symlinks for files in a directory' do
      profile = Profile.new 'spec/test_data/profile'
      files = []

      Dir.foreach('spec/test_data/profile')do |file|
        unless file == '.' || '..'
          files << file
        end
      end

      profile.create_symlinks(files)
      files.each do |file|
        File.symlink?("spec/test_data/#{file}").should == true
      end

      ## cleanup
      files.each do |file|
        system("rm 'spec/test_data/#{file}'")
      end
    end
  end
end
