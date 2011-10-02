module GridCLI
  class FileStorage < StorageBase
    def append(posts)
      puts "Appending #{posts.length} posts to file storage"
    end
  end
end
