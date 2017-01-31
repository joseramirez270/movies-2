"""
Name: Jose Ramirez
Date: 2/1/2017

Description: Contains a file representing a ml-100 dataset. Can read the file and analyze what it sees
Generates a prediction about what a user might give a previously unseen movie
based on existing movie reviews.
"""

require 'descriptive_statistics'


class Ratings


  def initialize(file)
    """Takes a file and populates a dictionary of users and the movies that they
      reviewed with the information extracted from the file."""
    @user_info = {}
    filename = 'ml-100/' + file
    @ratings_file = open(filename).readlines()

    ratings_file.each do |line|
      line = line.split()
      user_id = line[0].to_i
      movie_id = line[1].to_i
      rating = line[2].to_i

      if @user_info.has_key?(user_id) then
        @user_info[user_id][movie_id] = rating
      else
        @user_info[user_id] = {movie_id => rating}
      end
    end
  end


  def predict(user, movie)
    """Predicts a user's review of a movie based on a user's past reviews"""
    if !@user_info.has_key?(user) then
      return 4.0
    else
      ratings = @user_info[user].values
      return ratings.median
    end
  end

  def predict2(user, movie)
    """Predicts a user's review of a movie based on a movie's past reviews"""
    if !@user_info[user].has_key?(user) then
      return 4.0
    else
      movie_ratings = []
      @user_info.keys.each do |user|
        @user_info[user].each do |each_movie|
          if each_movie == movie then
            movie_ratings.push(@user_info[user][each_movie])
          end
        end
      end
    end
    if movie_ratings.length == 0 then
      return 4.0
    else
      return movie_ratings.median
    end
  end
end

#ratings = Ratings.new('u.data')
#puts ratings.user_info
#puts ratings.predict(1, 2)
