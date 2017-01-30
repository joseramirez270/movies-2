# contains a file(s): u.data or u1.test or u1.base ...
# can read the file and analyze what it sees
# generates a prediction, based on file, or what rating a user would give a movie
require 'descriptive_statistics'


class Ratings


  def initialize(file)
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


  attr_reader :ratings_file
  attr_reader :user_info


  def predict(user, movie)
    # TODO: create a real algorithm
    if !@user_info.has_key?(user) then
      return 4.0
    else
      ratings = @user_info[user].values
      return ratings.median
    end
  end
end

#ratings = Ratings.new('u.data')
#puts ratings.user_info
#puts ratings.predict(1, 2)
