module Markitup

  module ClassMethods
    def uses_markitup(options = {})
      markitup_options = options.delete(:options)

      proc = Proc.new do |c|
        c.instance_variable_set(:@markitup_options, markitup_options)
        c.instance_variable_set(:@uses_markitup, true)
      end

      before_filter(proc, options)
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.helper MarkitupHelper
  end

end
