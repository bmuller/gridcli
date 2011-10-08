module GridCLI
  class Config < YMLHash
    def initialize
      super "config"
    end


    def default_config
      { 
        'site' => "http://gridcli.com",
        'token' => rand(36**31).to_s(36)
      }
    end
  end
end
