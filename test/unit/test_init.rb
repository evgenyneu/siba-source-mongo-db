# encoding: UTF-8

require 'helper/require_unit'
require 'siba-source-mongo-db/init'

# Unit test example
# 'rake' command runs unit tests
# 'guard' command will run unit tests automatically
describe Siba::Source::MongoDb do
  before do                    
    @yml_path = File.expand_path('../yml', __FILE__)
  end

  it "should load plugin" do
    # helper to load options from YAML from @yml_path dir
    options_hash = load_options "valid" 

    plugin = Siba::Source::MongoDb::Init.new options_hash
    plugin.must_be_instance_of Siba::Source::MongoDb::Init
  end

  it "siba should load plugin" do 
    # helper to load the plugin by siba (build and install mongo-db gem to make it work)
    # @plugin_category = "source"      
    # @plugin_type = "mongo-db"         
    # plugin = create_plugin "valid" 
  end
      
  it "should check log" do
    # ... code
    # must_log "info"
    # wont_log "warn"
    # wont_log_from "warn"
    # show_log 
  end

  it "should verify file operations" do
    # fmock = mock_file(:file_directory?, true, ["Path"])
    # fmock.expect(:file_utils_cd, nil, ["/dir"])
    # ... code
    # fmock.verify
  end
end
