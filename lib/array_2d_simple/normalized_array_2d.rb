require 'delegate'

module Array2dSimple
  class NormalizedArray2d < SimpleDelegator
    def [] x, y
      normalized_by_rc y,x
    end

    def normalized_by_rc r,c
      value = get_by_rc(r,c)
      # value = max if value == Float::INFINITY
      # value = min if value == -Float::INFINITY # Does this work?
      if value and value.respond_to?(:to_f)
        return (value.to_f - min) / (max - min).to_f 
       else
        return 0.0
      end
    end

  end
end