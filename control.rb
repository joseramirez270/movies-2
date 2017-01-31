"""
Name: Jose Ramirez
Date: 2/1/2017

Description: Runs the validator and prints out statistics about predictions
and their accuracy.
"""

require './validator.rb'
require './ratings.rb'

class Control

  def run(train_file, test_file, k=nil)
    train = Ratings.new(train_file)
    test = Ratings.new(test_file)
    validator = Validator.new(train, test, k)
    validate  = validator.validate()

    puts "Training file: " + train_file + " Test file: " + test_file
    puts "Number correct: " + validate[0].to_s
    puts "Off by one: " + validate[1].to_s
    puts "Average error: " + validate[2].to_s
    puts "Standard deviation: " + validate[3].to_s
    puts "Number of predictions: " + validate[4].to_s
    puts "Time taken: " + validate[5].to_s
    puts "\n"
  end
end
