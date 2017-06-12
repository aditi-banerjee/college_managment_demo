class CollectionImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/collection"
  end

  def extension_with_list
    %w(zip)
  end

   version :specificFile do
    process :extract_file
    def full_filename (for_file = model.logo.file)
      "SpecificFile.ext"
    end
  end

  def extract_plist
    file = nil
    Zip::ZipFile.open(current_path) do |zip_file|
      file = zip_file.select{|f| f.name.match(/specificFile/)}.first
      zip_file.extract(file, "tmp/" + file.name.gsub("/", "-")){ true }
    end    
    File.delete(current_path)
    FileUtils.cp("tmp/" + file.name.gsub("/", "-"), current_path)
  end
  # process :unzip_folder

  # def unzip_folder
  #   cache_stored_file! if !cached?

  #   directory = File.dirname( current_path )

  #   Zip::File.open(current_path) do |zip_file|
  #     zip_file.each do |entry|
  #     next if entry.name =~ /__MACOSX/ || entry.name =~ /\.DS_Store/ || !entry.file?
  #       entry_full_path = File.join( directory, entry.name )
  #       unless File.exist?(entry_full_path)
  #         FileUtils::mkdir_p(File.dirname(entry_full_path))
  #         zip_file.extract(entry, entry_full_path)
  #       end
  #     end
  #   end
  # end


end
