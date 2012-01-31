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

  it "should backup" do
    out_dir = mkdir_in_tmp_dir "mongob"
    @cls.new({}).backup out_dir
  end
end
