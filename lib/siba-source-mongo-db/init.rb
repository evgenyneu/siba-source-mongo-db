# encoding: UTF-8

require 'siba-source-mongo-db/db'

module Siba::Source
  module MongoDb                 
    class Init                 
      include Siba::LoggerPlug
      attr_accessor :db
      
      def initialize(options)
        host = Siba::SibaCheck.options_string options, "host", true
        username = Siba::SibaCheck.options_string options, "username", true
        password = Siba::SibaCheck.options_string options, "password", true
        database = Siba::SibaCheck.options_string options, "database", true
        collection = Siba::SibaCheck.options_string options, "collection", true
        @db = Siba::Source::MongoDb::Db.new({
          host: host, 
          username: username, 
          password: password, 
          database: database, 
          collection: collection})
      end                      

      # Collect source files and put them into dest_dir
      # No return value is expected
      def backup(dest_dir)
        logger.info "Dumping MongoDb"
        @db.backup dest_dir
      end

      # Restore source files from_dir 
      # No return value is expected
      def restore(from_dir)
      end
    end
  end
end
