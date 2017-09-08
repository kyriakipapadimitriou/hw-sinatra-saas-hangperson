class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @current_status = :play
    #initialize guesses and wrong_guesses too with empty strings
    @guesses = ''
    @wrong_guesses = ''
  end
  attr_accessor :word
  attr_accessor :wrong_guesses
  attr_accessor :guesses

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def check_win_or_lose
    #check if status is win or lose
    return @current_status
  end
  
  def word_with_guesses
    word.gsub(/./)  { |letter| guesses.include?(letter) ? letter : '-' }
  end
  
  def guess(g)
    if g =~ /[^a-zA-Z]+/ || g.nil? || g.empty?
      raise ArgumentError
    end 
    g.downcase!
    if !guesses.to_s.include?(g) && word.include?(g)
      self.guesses = guesses.to_s + g
    elsif !wrong_guesses.to_s.include?(g) && !word.include?(g)
      self.wrong_guesses = wrong_guesses.to_s + g
    else
      false
    end
  end
end
