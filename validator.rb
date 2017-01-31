"""
Name: Jose Ramirez
Date: 2/1/2017

Description: Takes two instances of Ratings representing training and test sets
and tests the ratings predicted by the training set against those in the test set.
Return statistics about predictions including number correct or off by one, mean,
standard deviation.
"""


require './ratings.rb'
require 'descriptive_statistics'

class Validator

  def initialize(ratings_train, ratings_test, k=nil)
    """Creates Ratings objects for both training and test data"""
    @ratings_train = ratings_train # should be rating objects
    @ratings_test = ratings_test
    @k = k # number of predictions to make
  end


  def validate()
    """Evaluate the predictions obtained from the training set against the
      test set reviews, and returns an array object consisting of
      average, standard deviation, root mean squared error (as well as
      the number of predictions made and the time it took to run all the
      predictions)"""
    test = @ratings_test.user_info
    train = @ratings_train.user_info

    t1 = Time.now
    @errors = run_test(train, test, @k)
    t2 = Time.now
    correctness_stats = calculate_correctness()
    num_correct = correctness_stats[0]
    off_by_one = correctness_stats[1]
    avg = @errors.mean
    std_dev = @errors.standard_deviation

    return [num_correct, off_by_one, avg, std_dev, @k, (t2 - t1)]
  end

  def run_test(train, test, k=nil)
    """Takes the user_info dictionaries from training and test sets
    and loops through the user and movie keys in test set to make a
    prediction for each user-movie review. Calculate the differences
    between the true reviews and the predictions and return those as
    a list"""

    errors = []
    num_predictions = 0

    # since the same user will likely be seen multiple times
    # and the prediction will be the same each time
    user_predictions = {}

    test.keys.each do |user| # loop through the users
      test[user].keys.each do |movie| # loop through the user's movies
        if k != nil and num_predictions == k then # if we've hit the limit
          return errors
        end

        # if we've seen the user before, extract prediction from user_predictions
        # else, predict and store the prediction in user_predictions
        if !user_predictions.has_key?(user) then
          prediction = @ratings_train.predict(user, movie)
          user_predictions[user] = prediction
        else
          prediction = user_predictions[user]
        end

        true_rating = test[user][movie].to_f # get true rating from test dictionary
        errors.push((true_rating - prediction).abs)
        num_predictions += 1
      end
    end
    return errors
  end

  def calculate_correctness()
    correct = 0
    off_by_one = 0
    @errors.each do |error|
      if error == 0.0 then
        correct += 1
      elsif error == 1.0 then
        off_by_one += 1
      end
    end
    return [correct, off_by_one]
  end
end
