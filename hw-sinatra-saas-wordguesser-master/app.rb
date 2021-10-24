require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/wordguesser_game.rb'

class WordGuesserApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || WordGuesserGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  # These two routes are good examples of Sinatra syntax
  # to help you with the rest of the assignment
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end
  
  post '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || WordGuesserGame.get_random_word
    # NOTE: don't change previous line - it's needed by autograder!

    @game = WordGuesserGame.new(word)
    redirect '/show'
  end
  
  # Use existing methods in WordGuesserGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    if letter == nil
       flash[:message] = "Invalid guess."
      else if letter == "@"
             flash[:message] = "Invalid guess."
                  else if @game.word_with_guesses.include? letter or @game.word_with_guesses.include? letter.downcase or @game.wrong_word_with_guesses.include? letter or @game.wrong_word_with_guesses.include? letter.downcase
                     flash[:message] = "You have already used that letter."
                    else @game.guess(letter)
                    if @game.word_with_guesses == @game.word
                      flash[:message] = "You Win!"
                    else flash[:message] = "Sorry, you lose!"
                    end
                  end
             end
    end

    redirect '/show'
  end
  
  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in WordGuesserGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  # Notice that the show.erb template expects to use the instance variables
  # wrong_guesses and word_with_guesses from @game.
  get '/show' do
    ### YOUR CODE HERE ###
    erb :show # You may change/remove this line
  end
  
  get '/win' do
    ### YOUR CODE HERE ###
    redirect '/show'
    i = 0
    while i < @game.word.length do
      @game.word_with_guesses << '-'
      i=i+1
    end
    erb :win # You may change/remove this line
  end
  
  get '/lose' do
    ### YOUR CODE HERE ###
    redirect '/show'
    i = 0
    while i < @game.word.length do
      @game.word_with_guesses << '-'
      i=i+1
    end
    erb :lose # You may change/remove this line
  end
  
end
