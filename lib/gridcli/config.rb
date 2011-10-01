require 'yaml'

module GridCLI
  class Config < Hash
    def initialize
      @griddir = File.expand_path(File.join("~", ".grid"))
      Dir.mkdir(@griddir) if not File.exists?(@griddir)

      @conffile = File.join(@griddir, "config")
      super
      update default_config
      update(YAML.load_file(@conffile)) if File.exists? @conffile
    end


    def default_config
      { 
        'site' => "http://savorthegrid.com:3000"
      }
    end
  end
end
