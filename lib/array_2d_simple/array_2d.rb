require "array_2d_simple/version"

module Array2dSimple
  class Array2d
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
      raise 'x out of range' if c >= @width
      raise 'y out of range' if r >= @height
      @elements[r][c]
    end

    def set_by_rc r,c, value
      raise 'x out of range' if c >= @width
      raise 'y out of range' if r >= @height
      @elements[r][c] = value
    end

    def get_by_xy x,y
      get_by_rc y,x
    end

    def [] x,y
      get_by_rc y,x
    end

    def []= x,y, value
      @elements[y][x] = value
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
      max = -999999
      (0..@height - 1).each do |r|
        (0..@width - 1).each do |c|
          value = get_by_rc(r,c).to_f if get_by_rc(r,c).respond_to?(:to_f)
          max = [max, value].max if value and ! value.to_f.nan?
        end
      end
      max
    end

    def min
      min = 999999
      (0..@height - 1).each do |r|
        (0..@width - 1).each do |c|
          value = get_by_rc(r,c).to_f if value.respond_to?(:to_f)
          min = [min, value].min if value and ! value.to_f.nan?
        end
      end
      min
    end

    def project &proc
      new_array = self.class.new( width: @width, height: @height )
      (0..@height - 1).each do |r|
        (0..@width - 1).each do |c|
          new_array.set_by_rc(r,c, proc.call(get_by_rc(r,c)))
        end
      end
      new_array
    end

    def set_each &proc
      (0..@height - 1).each do |r|
        (0..@width - 1).each do |c|
          @elements[r][c] = proc.call(r,c)
        end
      end
    end

    def each &proc
      (0..@height - 1).each do |r|
        (0..@width - 1).each do |c|
          @elements[r][c] = proc.call(@elements[r][c]) if @elements[r][c].class == Float
        end
      end
    end

    # Helper methods
    def format2 value
      "%0.2f" % value.round(2).to_s if value.finite?
    end

  end
end