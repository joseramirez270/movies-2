require './validator.rb'
require './ratings.rb'

class Control

  def run(train_file, test_file)
    train = Ratings.new(train_file)
    test = Ratings.new(test_file)
    validator = Validator.new(train, test)
    return validator.validate()
  end
end

control = Control.new()
puts control.run('u1.base', 'u1.test').to_s
puts control.run('u2.base', 'u2.test').to_s
puts control.run('u3.base', 'u3.test').to_s
puts control.run('u4.base', 'u4.test').to_s
puts control.run('u5.base', 'u5.test').to_s
