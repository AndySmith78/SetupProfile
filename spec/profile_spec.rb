require 'spec_helper'
require File.expand_path("../../lib/profile", __FILE__)

describe Profile do
  describe '#execute' do
    let(:profile) { Profile.new 'some_folder' }
    it 'should call prepare_folder and then create_symlinks' do
      Profile.any_instance.should_receive(:prepare_folder)
      Profile.any_instance.should_receive(:create_symlinks)
      profile.execute
    end
  end
  
  describe '#prepare_folder' do
    let(:profile) { Profile.new 'spec/test_data/profile2' }
    before :each do
      profile.stub(:path).and_return('spec/test_data/profile2')
    end 

    it 'makes a call remove old symlinks for each file in directory' do
      profile.stub(:remove_existing_files).and_return(true)
 
      Profile.any_instance.should_receive(:remove_old_symlinks).exactly(4).times
      profile.prepare_folder
    end

    it 'makes a call to remove existing files for each file in directory' do
      profile.stub(:remove_old_symlinks).and_return(true)
 
      Profile.any_instance.should_receive(:remove_existing_files).exactly(4).times
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

  describe '#remove_existing_files' do
    let(:profile) { Profile.new 'some_folder' }

    it "return a file if it does not exist" do
      profile.remove_existing_files('file.txt').should == ['file.txt']
    end

    it "not return the file if it does exist" do
      profile.remove_existing_files('duplicate.txt').should_not == ['file.txt']
    end
  end

  describe '#create_symlinks' do
    let(:profile) { Profile.new 'spec/test_data/profile' }

    it 'should create symlinks for files in a directory' do
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
