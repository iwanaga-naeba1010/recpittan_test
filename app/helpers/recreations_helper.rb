module RecreationsHelper
  def price_pipe(price)
    return 'お問い合せください' if price.zero? || price.blank?

    number_to_currency(price)
  end
end
