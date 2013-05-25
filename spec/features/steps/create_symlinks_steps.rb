steps_for :create_symlinks do
  step 'there are files in a directory' do
    Profile.any_instance.stub(:path).and_return('spec/test_data/profile')

    ##removes synlink if exists
    Dir.foreach('spec/test_data/profile') do |file|
      if file != '.' && file != '..'
        system("rm 'spec/test_data/#{file}'")
      end
    end    
  end

  step 'I run the create symlink command' do
    CreateSymlink.start 'test_data/profile'
  end

  step 'I should have symlinks created for each file in the directory' do
    Dir.foreach('spec/test_data/profile') do |file|
      unless file == '.' || '..'
        File.symlink?(file).should be_true
      end
    end
  end
end
