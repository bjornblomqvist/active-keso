require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'rubygems'
require 'active_record'
require 'active-keso'

class User < ActiveRecord::Base
end

describe "ActiveKeso" do
  it "should return a keso relation" do

    #
    # setup
    #
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => '/tmp/keso_test.sqlite3',
      :pool => 5,
      :timeout => 5000)
    
    ActiveRecord::Schema.define :version => 0 do
      create_table :users, :force => true do |t|
        t.string :name
      end
    end
    
    User.create :name => 'Tedy bear'
    
    #
    # The test
    #

    User.first.name.should eql('Tedy bear')
    
    User.all.to_keso.should be_an_instance_of Relation
    
    User.all.to_keso.should eql Relation.new(Tuple.new(:id => 1,:name => 'Tedy bear'))
    
    
  end
  
  it 'should work when using find_by_sql' do
    
    #
    # setup
    #
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => '/tmp/keso_test.sqlite3',
      :pool => 5,
      :timeout => 5000)
    
    ActiveRecord::Schema.define :version => 0 do
      create_table :users, :force => true do |t|
        t.string :name
      end
    end
    
    User.create! :name => 'Tedy bear'
    
    #
    # The test
    #

    puts User.find_by_sql("select name from \"users\";").first.attribute_names.inspect

    User.find_by_sql("select name from \"users\";").to_keso.should eql Relation.new(Tuple.new(:name => 'Tedy bear'))

  end
  
  it "should be able to handle nil in the activerecord" do

    #
    # setup
    #
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => '/tmp/keso_test.sqlite3',
      :pool => 5,
      :timeout => 5000)
    
    ActiveRecord::Schema.define :version => 0 do
      create_table :users, :force => true do |t|
        t.string :name
      end
    end
    
    User.create! :name => nil
    
    #
    # The test
    #

    User.first.name.should be_nil
    
    User.all.to_keso(:name => "").should be_an_instance_of Relation
    
    User.all.to_keso(:name => '').should eql Relation.new(Tuple.new(:id => 1,:name => ''))
    
    
  end
end
