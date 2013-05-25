class Profile
  def initialize(folder)
    @folder = folder
  end

  def execute
    files = remove_existing_files
    create_symlinks(files)
  end

  def remove_existing_files
    @files = []
    @existing_files = []
    Dir.foreach(path) do |file|
      if File.exist?("#{path}/../#{file}") && File.symlink?("#{path}/../#{file}") == false
        puts "The #{file} already exists"
      else
        @files << file
      end
    end
    return @files
  end

  def create_symlinks(files)
    files.each do |file|
      File.symlink("#{path}/#{file}", "#{path}/../#{file}")
      puts "symlink created for #{file}"
    end
  end

  def path
    File.expand_path("~/#{@folder}")
  end
end
