class BackstagePass < Item

  include UpdateOperators

  def update_self

    if self.sell_in <= 0
      self.quality = 0
    elsif self.sell_in > 10
      increment_quality
      decrease_sell_in
    elsif self.sell_in <= 5 
      increment_quality(3)
      decrease_sell_in
    elsif (self.sell_in <= 10)
      increment_quality(2)
      decrease_sell_in
    end

  end

end