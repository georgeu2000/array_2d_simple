require "array_2d_simple/version"

module Array2dSimple
  class Array2d
    include Enumerable
    attr_reader :width, :height

    def initialize params
      raise 'width must be set' unless params[:width]
      raise 'height must be set' unless params[:height]

      params.each do |key,value|
        instance_variable_set("@#{key}",value)
      end
      @elements = Array.new(@height){ Array.new(@width) }
    end

    def to_s
      "#{ self.class }: #{ @width }x#{ @height }"
    end

    def get_by_rc r,c
      Printer.log 'Warning: #get_by_rc is depricated. Use get_by_xy. Note: arguments are reversed with get_by_xy'
      get_by_xy(c,r)
    end

    def set_by_rc r,c, value
      Printer.log 'Warning: #set_by_rc is depricated. Use set_by_xy. Note: arguments are reversed with set_by_xy'
      set_by_xy(c,r,value)
    end

    def get_by_xy x,y
      raise 'x out of range' if x >= @width
      raise 'y out of range' if y >= @height
      @elements[y][x]
    end

    def set_by_xy(x,y,value)
      raise 'x out of range' if x >= @width
      raise 'y out of range' if y >= @height
      @elements[y][x] = value
    end

    def [] x,y
      get_by_xy(x,y)
    end

    def []= x,y, value
      set_by_xy(x,y,value)
    end

    def output
      size = format2(max.to_f).size
      output = ''
      
      (0..@height - 1).each do |r|
        (0..@width - 1).each do |c|
          output += "%#{ size + 4 }s" % format2(get_by_rc(r,c).to_f) if get_by_rc(r,c).respond_to? :to_f
        end
        output += "\n"
      end

      output
    end

    def max
      @elements.dup.flatten.max
    end

    def min
      @elements.dup.flatten.min
    end

    def project &proc
      new_array = self.class.new( width: @width, height: @height )
      
      new_array.set_each{ |x, y| proc.call( get_by_xy( y,x ))}

      new_array
    end

    def set_each &proc
      each_with_index do |v,i| 
        x = i[0]
        y = i[1]
        @elements[x][y] = proc.call(x,y)
      end
    end

    def each_with_index
      (0..@width - 1).each do |y|
        (0..@height - 1).each do |x|
          yield(@elements[x][y],[x,y])
        end
      end
    end

    def each &block
      each_with_index &block
    end

    # Helper methods
    def format2 value
      "%0.2f" % value.round(2).to_s if value.finite?
    end
  end
end


class Printer
  def self.log(message)
    puts message
  end
end