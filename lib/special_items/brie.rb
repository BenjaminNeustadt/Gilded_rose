class Brie < Item

  include UpdateOperators

  def update_self

    if still_sellable(self)
      increment_quality
      decrease_sell_in
    else
      increment_quality(2) and decrease_sell_in unless max_quality
    end

  end

end
