require 'test/unit'
require 'mocha/setup'

require 'logger'
require 'tempfile'

module Rails
  module_function
  def logger
    @@_logger ||= Logger.new(STDOUT)
  end
end
