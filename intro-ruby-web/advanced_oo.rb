class SecretFile
  attr_reader :logger

  def initialize(secret_data, logger)
    @logger = logger
    @data = secret_data
  end

  def get_data
    logger.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry
    puts "log created"
  end
end

logger = SecurityLogger.new

file = SecretFile.new("Paolo", logger)

file.get_data
