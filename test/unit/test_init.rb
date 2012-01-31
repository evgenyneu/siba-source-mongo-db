# encoding: UTF-8

require 'helper/require_unit'
require 'siba-source-mongo-db/init'

describe Siba::Source::MongoDb::Init do
  before do                    
    @yml_path = File.expand_path('../yml', __FILE__)
    @plugin_category = "source"      
    @plugin_type = "mongo-db"         
  end

  it "siba should load plugin" do 
    options = load_options "valid"
    plugin = create_plugin "empty" 
    plugin = Siba::Source::MongoDb::Init.new({})
    plugin = create_plugin "valid"
    plugin.db.must_be_instance_of Siba::Source::MongoDb::Db
    plugin.db.settings[:host].must_equal options["host"]
    plugin.db.settings[:username].must_equal options["username"]
    plugin.db.settings[:password].must_equal options["password"]
    plugin.db.settings[:database].must_equal options["database"]
    plugin.db.settings[:collection].must_equal options["collection"]
  end

  it "should call backup" do
    create_plugin("valid").backup "/dest_dir"
  end

  it "should call restore" do
    create_plugin("valid").restore "/from_dir"
  end

end
