require 'yaml'

module GridCLI
  class YMLHash < Hash
    def initialize(fname)
      # Initialize the grid dir
      @griddir = File.expand_path(File.join("~", ".grid"))
      Dir.mkdir(@griddir) if not File.exists?(@griddir)

      # This is a hash, so initialize it, set w/ default config options, then set
      # with any config options in the ~/.grid/#{fname} file
      @conffile = File.join(@griddir, fname)
      super
      update default_config
      # if conf file exists, update this obj w/ it's values.  Otherwise, create file
      File.exists?(@conffile) ? update(YAML.load_file(@conffile)) : save
    end

    def default_config
      {}
    end

    def save
      File.open(@conffile, 'w') { |f| YAML.dump(Hash.new.merge(self), f) }
    end
  end
end
