# encoding: UTF-8

require 'helper/require_unit'
require 'siba-source-mongo-db/init'

describe Siba::Source::MongoDb::Db do
  before do                    
    @cls = Siba::Source::MongoDb::Db
  end

  it "should init" do 
    settings= {one: "two"}
    @obj = @cls.new settings
    @obj.settings.must_equal settings
  end

  it "should backup" do 
    @obj = @cls.new({})
    @obj.backup("/dest_dir")
  end

  it "should call get_shell_parameters" do
    settings = {
      host: "host:port",
      username: "uname",
      password: "my password",
      database: "dbname",
      collection: "db collection"}
    @obj = @cls.new(settings)
    params = @obj.get_shell_parameters
    settings.each do |key,value|
      params.must_include %("#{value}") if key != :password
      params.must_include %("#{@cls::HIDE_PASSWORD_TEXT}") if key == :password
    end
  end

  it "should espace for shell" do
    @obj = @cls.new({})
    @obj.escape_for_shell("hi\"").must_equal "hi\\\""
  end
end
