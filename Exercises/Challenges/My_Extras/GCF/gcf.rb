class GCF
  def initialize(*nums)
    @nums = nums
  end

  def calculate
    @nums.min.downto(1) do |factor|
      return factor if @nums.all? { |num| num % factor == 0 }
    end
  end
end