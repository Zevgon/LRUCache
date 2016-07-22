class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    each_with_index do |el, idx|
      result ^= result ^ el.to_s.ord ^ idx
    end
    result
  end
end

class String
  def hash
    result = 0
    each_char.with_index do |char, idx|
      result ^= result ^ char.ord ^ idx
    end

    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (self.keys.sort + self.values.sort).hash
  end
end
