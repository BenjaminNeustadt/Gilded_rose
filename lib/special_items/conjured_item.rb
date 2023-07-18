class ConjuredItem < Item
  include UpdateOperators

  def decrement_pace
    @decrement_pace = 2
  end

  def update_self
    decrease_quality(self, decrement_pace)
    decrease_sell_in(self)
  end

end
