require 'yaml'

module GridCLI
  class Config < Hash
    def initialize
      # Initialize the grid config / message dir
      @griddir = File.expand_path(File.join("~", ".grid"))
      Dir.mkdir(@griddir) if not File.exists?(@griddir)

      # This is a hash, so initialize it, set w/ default config options, then set
      # with any config options in the ~/.grid/config file
      @conffile = File.join(@griddir, "config")
      super
      update default_config
      # if conf file exists, update this obj w/ it's values.  Otherwise, create file
      File.exists?(@conffile) ? update(YAML.load_file(@conffile)) : save
    end


    def default_config
      { 
        'site' => "http://savorthegrid.com:3000",
        'token' => rand(36**31).to_s(36)
      }
    end

    def save
      File.open(@conffile, 'w') { |f| YAML.dump(self, f) }
    end
  end
end
