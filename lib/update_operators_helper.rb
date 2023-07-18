module UpdateOperators

  DEFAULT_INCREMENT = 1

  def decrease_quality(item, quality_increase = DEFAULT_INCREMENT)
    item.quality -= (DEFAULT_INCREMENT * quality_increase) 
    item.quality = [item.quality, 0].max
  end

  def decrease_sell_in(item = self)
    item.sell_in -= 1
  end

  def increment_quality(quality_increase = DEFAULT_INCREMENT)
    self.quality += (DEFAULT_INCREMENT * quality_increase)
  end

  def expired?(item)
    item.quality == 0
  end

  def still_sellable(item)
    item.sell_in > 0
  end

  def max_quality
    self.quality == 50
  end

  def default_update(item, quality_increase = 1)
    return if expired?(item)
    if still_sellable(item)
      decrease_quality(item, quality_increase);
      decrease_sell_in(item)
    else
      decrease_quality(item, 2)
    end
  end

end
