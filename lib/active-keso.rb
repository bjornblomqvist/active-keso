
require 'active_record'
require 'keso'

class Array 
  def to_keso nil_fix = {}
    
    tuples = []
    
    self.each do |value|
      if value.is_a? ActiveRecord::Base
        tuple = Tuple.new
        value.attribute_names.each do |column_name|
          
          v = value[column_name]
          v = nil_fix[column_name.to_sym] unless v
          
          tuple = tuple.add(column_name.to_sym => v)
        end
        tuples.push tuple
      else
        throw "Sorry but this is only for active record =/"
      end
    end
    
    return Relation.new if tuples.length == 0 # FIXME, it should return a relation with the correct heading
    
    to_return = Relation.new tuples.first.heading
    
    tuples.each do |tuple|
      to_return = to_return.add tuple
    end
    
    to_return
    
  end
end
