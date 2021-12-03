class Array
  def my_uniq
    my_uniq = []
    self.each { |el| my_uniq << el unless my_uniq.include?(el) }
    my_uniq
  end

  def two_sum
    two_sum = []
    self.each_with_index do |el1, idx1|
      self.each_with_index do |el2, idx2|
        two_sum << [idx1, idx2] if (el1 + el2 == 0) && (idx2 > idx1)
      end
    end

    two_sum
  end

  def my_transpose
    transposed = []

    (0...self.length).each do |i|
      temp_arr = []
      (0...self.length).each { |j| temp_arr << self[j][i] }
      transposed << temp_arr
    end

    transposed
  end
end