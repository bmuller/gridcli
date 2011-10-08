module GridCLI
  class StorageBase
    def initialize
      @config = GridCLI.config
    end

    def append(posts)
      raise "Not implemented"
    end

    def search(type, query, state_date, end_date, output_format)
      raise "Not implemented"
    end

    def list(type, start_date, end_date, output_format)
      raise "Not implemented"
    end
  end
end
