module GridCLI
  class Stats < YMLHash
    def initialize
      super "stats"
    end

    def default_config
      {
        'last_sha' => nil
      }
    end
  end
end
