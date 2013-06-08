steps_for :create_symlinks do
  step 'there are files in a directory' do
    Profile.any_instance.stub(:path).and_return('spec/test_data/profile')
  end

  step 'there is a folder with symlinks already created' do 
    path = "spec/test_data/profile3"
    Profile.any_instance.stub(:path).and_return('spec/test_data/profile3')

    file = 'Untitled.rft'
    File.symlink("#{path}/#{file}", "#{path}/../#{file}")
  end

  step 'I run the create symlink command' do
    CreateSymlink.start 'test_data/profile'
  end
  
  step 'I run the create symlink command with folder 3' do
    CreateSymlink.start 'test_data/profile3'
  end
  
  step 'I run the create symlink command' do

  end

  step 'I should have symlinks created for each file in the directory' do
    Dir.foreach('spec/test_data/profile') do |file|
      unless file == '.' || '..'
        File.symlink?(file).should be_true
      end
    end
    ##removes synlink if exists
    Dir.foreach('spec/test_data/profile') do |file|
      if file != '.' && file != '..'
        system("rm 'spec/test_data/#{file}'")
      end
    end    

  end

  step 'the existing symlinks should be removed and created for my directory' do
    File.readlink('spec/test_data/Untitled.rft').should == 'spec/test_data/profile3/Untitled.rft'
    ##removes synlink if exists
    Dir.foreach('spec/test_data/profile3') do |file|
      if file != '.' && file != '..'
        system("rm 'spec/test_data/#{file}'")
      end
    end
  end
end
