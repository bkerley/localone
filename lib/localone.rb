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
      f.reveal :instance_variable_set
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
    proc.binding.eval('instance_variables').each do |ivn|
      fakescope.instance_variable_set(ivn, proc.binding.eval(ivn.to_s))
    end
    fakescope.instance_eval &proc
  end
end
