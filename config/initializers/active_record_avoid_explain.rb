module ActiveRecord::ConnectionAdapters
  class JdbcAdapter < AbstractAdapter
    def explain(*args)
      # Do nothing :'(
    end
  end
end