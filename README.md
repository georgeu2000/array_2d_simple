# Array2dSimple

This gem allows you to create a 2D Array in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'array_2d_simple'

And then execute:

    $ bundle

Or install it without using Gemfile as:

    $ gem install array_2d_simple

## Usage

Initalization:
You must:
    require 'array_2d_simple.rb'

And within your model:
    include Array2dSimple

There are 2 ways of putting data in the 2D Array:

1. By iterating with #set_by_rc
2. By passing a block to #set_each(see below)


##Example: A board for tic-tac-toe

    require 'array_2d_simple.rb'

    class Board
      include Array2dSimple

      def initialize
        @board = Array2d.new( width:3, height:3 )
      end
    end

To fill board with numbers 1-9 and output:

      def fill
        @board.set_each{ |r, c| r*3 + c+1}
      end

      def output
        @board.output
      end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
