# frozen_string_literal: true

module RecreationsHelper
  def price_pipe(price, user)
    return 'お問い合わせください' if user&.role&.partner?

    return 'お問い合わせください' if price == 0 || price.blank?

    number_to_currency(price)
  end

  # rubocop:disable Style/OptionalBooleanParameter
  def tag_to_html(recreation, limit = true)
    return if recreation.blank?

    tags = recreation.tags

    category = recreation.category_text
    content_tag :div do
      if category.present?
        concat link_to category, customers_recreations_path(
          q: { category_eq: recreation.category.value }
        ), class: 'category-label event', style: "margin-right: 4px; background-color: #{categoryname_to_color_code(category)}"
      end
      if limit
        tags = tags.first(2)
      end
      tags.collect do |tag|
        concat(
          link_to("##{tag.name}", customers_recreations_path(q: { tags_id_eq: tag.id }),
                  class: 'tag-label px-1 my-1 font-weight-bold d-inline-block', style: 'margin-right: 4px;')
        )
      end
    end
  end
  # rubocop:enable Style/OptionalBooleanParameter

  def recreation_capacity(capacity)
    return '制限なし' if [0, nil].include?(capacity)

    "#{capacity}人"
  end

  def categoryname_to_color_code(categoryname)
    case categoryname
    when '音楽'
      '#F24051;'
    when '健康'
      '#95C15D;'
    when '趣味'
      '#8C428C;'
    when '創作'
      '#4276FC;'
    when '旅行'
      '#FE607D;'
    when '飲食'
      '#F3B30C;'
    when 'イベント'
      '#FD7E14;'
    when '食べ物'
      '#800000;'
    when 'その他'
      '#339999;'
    else
      ''
    end
  end

  def sort_order_options
    [
      ['新着順', 'newest'],
      ['価格 (低い順)', 'price_low_to_high'],
      ['価格 (高い順)', 'price_high_to_low'],
      ['口コミの数 (多い順)', 'reviews_count']
    ]
  end
end
