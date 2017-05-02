# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi

  attr_reader :towers

  def initialize
    @towers = [[],[],[]]
    @towers[0] = [3,2,1]
  end

  def move(from_tower, to_tower)
    disc = @towers[from_tower].pop
    @towers[to_tower].push(disc)
  end

  def valid_move?(from_tower, to_tower)
    return false if @towers[from_tower] == nil || @towers[to_tower] == nil
    return false if @towers[from_tower].empty?
    return true if @towers[to_tower].empty?
    return true if @towers[from_tower].last < @towers[to_tower].last
    false
  end

  def won?
    return true if @towers[1].size == 3 || @towers[2].size == 3
    false
  end

  def asking
    puts "Choose column to pick up disc.(0,1,2)"
    @from_tower = gets.chomp
    if @from_tower == "quit"
      return
    end
    puts "Choose column to drop disc.(0,1,2)"
    @to_tower = gets.chomp
    if @to_tower == "quit"
      return
    end
      @from_tower = @from_tower.to_i
      @to_tower = @to_tower.to_i
  end

  def play
    system "clear"
    puts "Welcome to Towers of Hanoi!\nType in 'quit' to leave the game."
    render(@towers)
    until won?
      asking
      if @from_tower == "quit" || @to_tower == "quit"
        return system "exit"
      end
      until valid_move?(@from_tower, @to_tower)
        system "clear"
        puts "Invalid move. Try again."
        render(@towers)
        asking
        if @from_tower == "quit" || @to_tower == "quit"
          return system "exit"
        end
      end
      system "clear"
      move(@from_tower, @to_tower)
      render(@towers)
    end

      puts "Game Over!\nYou Win!!"
  end

  def render(array)
    @arr = array.dup
    @arr.map! { |arr| arr.reverse}
    @arr.each do |el|
      el.unshift(0) until el.length == 3
    end
    @arr.transpose.each { |arr| puts "#{arr}"}
  end
end

# game = TowersOfHanoi.new
# game.play
