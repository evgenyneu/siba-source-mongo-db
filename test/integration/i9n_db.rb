# encoding: UTF-8

require 'helper/require_integration'
require 'siba-source-mongo-db/init'

# Integration test example
# 'rake test:i9n' command runs integration tests
describe Siba::Source::MongoDb::Db do
  before do
    @cls = Siba::Source::MongoDb::Db
  end

  it "should init" do
    @cls.new({})  
  end

  it "should backup and restore" do
    out_dir = mkdir_in_tmp_dir "mongob"
    @cls.new({database: "sibatest"}).backup out_dir
    Siba::FileHelper.dir_empty?(out_dir).must_equal false

    @cls.new({database: "sibatest"}).restore out_dir
  end
end
