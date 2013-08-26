class Profile
  attr_accessor :folder

  def initialize(folder)
    @folder = folder
  end

  def execute
    prepare_folder
    create_symlinks(@files)
  end
  
  def prepare_folder
    Dir.foreach(path) do |file|
      remove_old_symlinks(file)
      remove_existing_files(file)
    end
  end

  def remove_old_symlinks(file)
    if File.symlink?("#{path}/../#{file}")
      system("rm #{path}/../#{file}")
    end
  end

  def remove_existing_files(file)
    @files = []
    if File.exist?("#{path}/../#{file}")
      puts "The #{file} already exists"
    else
      @files << file
    end
  end

  def create_symlinks(files)
    files.each do |file|
      File.symlink("#{path}/#{file}", "#{path}/../#{file}")
      puts "symlink created for #{file}"
    end
  end

  def path
    File.expand_path("~/#{folder}")
  end
end
