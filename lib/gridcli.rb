require 'active_resource'

require 'gridcli/storage/base'
require 'gridcli/storage/files'

require 'gridcli/ymlhash'
require 'gridcli/config'
require 'gridcli/subgrids'

module GridCLI
  def self.config
    @config ||= Config.new
  end
  
  def self.storage
    @storage ||= FileStorage.new
  end
end

require 'gridcli/pprinter'
require 'gridcli/runner'
require 'gridcli/version'

require 'gridcli/commands/base'
require 'gridcli/commands/befriend'
require 'gridcli/commands/block'
require 'gridcli/commands/dislike'
require 'gridcli/commands/friends'
require 'gridcli/commands/help'
require 'gridcli/commands/like'
require 'gridcli/commands/list'
require 'gridcli/commands/message'
require 'gridcli/commands/pprint'
require 'gridcli/commands/profile'
require 'gridcli/commands/search'
require 'gridcli/commands/signup'
require 'gridcli/commands/status'
require 'gridcli/commands/subgrid'
require 'gridcli/commands/update'

require 'gridcli/resources/base'
require 'gridcli/resources/blockage'
require 'gridcli/resources/friendship'
require 'gridcli/resources/post'
require 'gridcli/resources/user'
