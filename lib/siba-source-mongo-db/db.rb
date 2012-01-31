# encoding: UTF-8

module Siba::Source
  module MongoDb                 
    class Db
      HIDE_PASSWORD_TEXT = "****p7d****"
      include Siba::FilePlug
      include Siba::LoggerPlug
      attr_accessor :settings

      def initialize(settings)
        @settings = settings
        check_installed
      end

      def check_installed
        siba_file.run_this do
          raise Siba::Error, "'mongodump' utility is not found. Please install mongodb." unless siba_file.shell_ok? "mongodump --help"
          raise Siba::Error, "'mongorestore' utility is not found. Please install mongodb." unless siba_file.shell_ok? "mongorestore --help"
          logger.info "Mongo backup utilities verified"
        end
      end

      def backup(dest_dir)
        siba_file.run_this do
          unless Siba::FileHelper.dir_empty? dest_dir
            raise Siba::Error, "Failed to backup MongoDB: output directory is not empty: #{dest_dir}"
          end

          command_without_password = %(mongodump -o "#{dest_dir}" #{get_shell_parameters})
          command = command_without_password
          unless settings[:password].nil?
            command = command_without_password.gsub HIDE_PASSWORD_TEXT, settings[:password]
          end
          siba_file.run_shell command, "failed to backup MongoDb: #{command_without_password}"

          if Siba::FileHelper.dir_empty?(dest_dir)
            raise Siba::Error, "Failed to backup MongoDB: dump directory is empty"
          end

          Siba::FileHelper.entries(dest_dir).each do |entry|
            path_to_collection = File.join dest_dir, entry
            next unless File.directory? path_to_collection
            if Siba::FileHelper.dir_empty? path_to_collection
              logger.warn "MongoDB collection/database name '#{entry}' is incorrect or it has no data."
            end
          end
        end
      end

      def restore(from_dir)
        siba_file.run_this do
          if Siba::FileHelper.dir_empty? from_dir
            raise Siba::Error, "Failed to restore MongoDB: backup directory is empty: #{from_dir}"
          end

          command_without_password = %(mongorestore --drop #{get_shell_parameters} "#{from_dir}")
          command = command_without_password
          unless settings[:password].nil?
            command = command_without_password.gsub HIDE_PASSWORD_TEXT, settings[:password]
          end
          siba_file.run_shell command, "failed to restore MongoDb: #{command_without_password}"
        end
      end

      def get_shell_parameters
        params = []
        params << "-h \"#{escape_for_shell settings[:host]}\"" unless settings[:host].nil?
        params << "-u \"#{escape_for_shell settings[:username]}\"" unless settings[:username].nil?
        params << "-p \"#{HIDE_PASSWORD_TEXT}\"" unless settings[:password].nil?
        params << "-d \"#{escape_for_shell settings[:database]}\"" unless settings[:database].nil?
        params << "-c \"#{escape_for_shell settings[:collection]}\"" unless settings[:collection].nil?
        params.join " "
      end

      def escape_for_shell(str)
        str.gsub "\"", "\\\""
      end

      def db_and_collection_names
        names = []
        names << "db #{settings[:database]}" unless settings[:database].nil?
        names << "db #{settings[:database]}" unless settings[:database].nil?
        out = names.join(", ")
        our = ": " + out unless out.empty?
        out
      end
    end
  end
end  
