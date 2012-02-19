# encoding: UTF-8

require 'helper/require_integration'
require 'siba-source-mongo-db/init'

# Integration test example
# 'rake test:i9n' command runs integration tests
describe Siba::Source::MongoDb::Db do
  TEST_DB_NAME = "sibatestm92"
  TEST_VALUE = rand 100000
  include Siba::FilePlug

  before do
    @cls = Siba::Source::MongoDb::Db
  end

  it "should init" do
    @cls.new({})  
  end

  it "should backup and restore" do
    begin
      out_dir = mkdir_in_tmp_dir "mongob"

      # insert data into db
      drop_db
      insert_value
      count_values.must_equal 1
      
      # backup
      @cls.new({database: TEST_DB_NAME}).backup out_dir
      Siba::FileHelper.dir_empty?(out_dir).must_equal false

      # modify db after backup
      insert_value
      count_values.must_equal 2

      # restore
      @cls.new({database: TEST_DB_NAME}).restore out_dir

      count_values.must_equal 1, "Database must have pre-backup value"
    ensure
      drop_db rescue nil
    end
  end  

  def drop_db
    siba_file.shell_ok?(%(mongo #{TEST_DB_NAME} --quiet --eval "db.dropDatabase()")).must_equal true
  end

  def insert_value
    siba_file.run_shell(%(mongo #{TEST_DB_NAME} --quiet --eval "db.foo.save({a: #{TEST_VALUE}})"))
  end

  def count_values
    siba_file.run_shell(%(mongo #{TEST_DB_NAME} --quiet --eval "db.foo.count({a: #{TEST_VALUE}})")).to_i
  end
end
