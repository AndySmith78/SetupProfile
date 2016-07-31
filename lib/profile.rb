class Profile
  attr_accessor :folder

  def initialize(folder)
    @folder = folder
  end

  def execute
    prepare_folder
  end
  
  def prepare_folder
    Dir.foreach(path) do |file|
      unless file == '.git'
        remove_old_symlinks(file)
        check_for_existing_file(file)
      end
    end
  end

  def remove_old_symlinks(file)
    if File.symlink?("#{path}/../#{file}")
      system("rm #{path}/../#{file}")
    end
  end

  def check_for_existing_file(file)
    if File.exist?("#{path}/../#{file}")
      puts "The #{file} already exists"
    else
      create_symlinks(file)
    end
  end

  def create_symlinks(file)
    File.symlink("#{path}/#{file}", "#{path}/../#{file}")
    puts "symlink created for #{file}"
  end

  private

  def path
    File.expand_path("~/#{@folder}")
  end
end
