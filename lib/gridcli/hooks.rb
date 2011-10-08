module GridCLI
  class Hooker
    def initialize
      @hooks = {}
    end

    def register(name, &method)
      @hooks[name] = @hooks.fetch(name, []) + [method]
    end

    def invoke(name, arg=nil)
      @hooks.fetch(name, []).inject(arg) { |params,proc| proc.call(params) }
    end
  end
end
