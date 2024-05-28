# frozen_string_literal: true

class Solazu::BroadcastMovieWorker
  include Sidekiq::Worker

  def initialize
    puts 'Solazu::BroadcastMovieWorker'
  end

  def perform(movie_id)
    movie = Movie.find(movie_id)
    content = {
      title: movie.title,
      user: movie.user.email
    }
    ActionCable.server.broadcast('movie_channel', content)
  rescue StandardError => e
    puts "BroadcastMovieWorker #{e}"
  end
end
