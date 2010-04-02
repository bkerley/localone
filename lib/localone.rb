require 'blankslate'
module Localone
  module Object
    def with
      yield self
    end
  end

  module Let
    def self.anonyslate
      f = Class.new(::BlankSlate)
      unless f.instance_methods.include? :class
        f.reveal :class
      end
      f.new
    end
  end
end

class Object
  include Localone::Object
end

module Kernel
  def let(options, &proc)
    fakescope = Localone::Let.anonyslate
    options.each do |k,v|
      fakescope.class.send(:define_method, k) { v }
    end
    fakescope.instance_eval &proc
  end
end
