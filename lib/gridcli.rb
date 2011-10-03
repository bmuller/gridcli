require 'active_resource'

require 'gridcli/storage/base'
require 'gridcli/storage/files'

require 'gridcli/config'

module GridCLI
  def self.config
    @config ||= Config.new
  end
  
  def self.storage
    @storage ||= FileStorage.new
  end
end

require 'gridcli/version'
require 'gridcli/runner'

require 'gridcli/commands/base'
require 'gridcli/commands/signup'
require 'gridcli/commands/help'
require 'gridcli/commands/profile'
require 'gridcli/commands/befriend'
require 'gridcli/commands/block'
require 'gridcli/commands/friends'
require 'gridcli/commands/message'
require 'gridcli/commands/status'
require 'gridcli/commands/like'
require 'gridcli/commands/dislike'
require 'gridcli/commands/update'
require 'gridcli/commands/search'
require 'gridcli/commands/list'

require 'gridcli/resources/base'
require 'gridcli/resources/user'
require 'gridcli/resources/friendship'
require 'gridcli/resources/post'
require 'gridcli/resources/blockage'

