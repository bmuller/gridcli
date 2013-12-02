module GridCLI
  class Config < YMLHash
    def initialize
      super "config"
    end

    def default_config
      { 
        'site' => "https://api.griddoor.com",
        'token' => rand(36**31).to_s(36),
        'alias' => {}
      }
    end
  end
end
