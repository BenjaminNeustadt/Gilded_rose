class Sulfuras < Item

  def quality
    @quality = 80
  end

  def update_self
    self.quality
    self.sell_in
  end

end
