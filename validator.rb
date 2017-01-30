require './ratings.rb'
require 'descriptive_statistics'

class Validator

  def initialize(ratings_train, ratings_test)
    @ratings_train = ratings_train # should be rating objects
    @ratings_test = ratings_test
  end


  def validate()
    # we only need to call rating once, since it'll always be the same
    @errors = []

    test = @ratings_test.user_info
    train = @ratings_train.user_info
    test.keys.each do |user| # loop through the users
      test[user].keys.each do |movie| # loop through the user's movies
        prediction = @ratings_train.predict(user, movie) # the prediction should be the same for each movie
        true_rating = test[user][movie].to_f
        @errors.push((true_rating - prediction).abs)
      end
    end

    avg = @errors.mean
    std_dev = @errors.standard_deviation
    rmsd = root_mean_sqd_err(@errors)

    return [avg, std_dev, rmsd]
  end

  def root_mean_sqd_err(errors)
    # get root mean squared error
    sqd_errors = []
    @errors.each do |error|
      sqd_errors.push(error ** 2)
    end
    mean_sqd_err = sqd_errors.sum / sqd_errors.length
    rmsd = Math.sqrt(mean_sqd_err)
    return rmsd
  end
end

#ratings1 = Ratings.new('u3.base')
#ratings2 = Ratings.new('u3.test')
#validator = Validator.new(ratings1, ratings2)
#puts validator.validate().to_s
