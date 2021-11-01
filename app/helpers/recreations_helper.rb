module RecreationsHelper
  def price_pipe(price)
    return 'お問い合せください' if price == 0 || price.blank?

    number_to_currency(price)
  end
end
