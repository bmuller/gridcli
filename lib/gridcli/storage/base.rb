module GridCLI
  class StorageBase
    def initialize
      @config = GridCLI.config
    end

    def append(posts)
      raise "Not implemented"
    end

    def search(type, query, dates)
      raise "Not implemented"
    end
  end
end
