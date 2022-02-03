# frozen_string_literal: true

module RecreationsHelper
  def price_pipe(price, user)
    return 'お問い合せください' if user.blank? || user&.role&.partner?

    return 'お問い合せください' if price == 0 || price.blank?

    number_to_currency(price, unit: "￥", precision: 0)
  end

  def tags_to_html(tags, limit = true)
    return if tags.blank?

    category_tag = tags.map { |tag| tag if tag.kind.category? }.compact.first
    content_tag :div do
      if category_tag.present?
        tags -= [category_tag]
        concat link_to category_tag&.name, customers_recreations_path(q: { tags_id_eq: category_tag.id }),
                       class: 'category-label event',
                       style: "margin-right: 4px; background-color: #{categoryname_to_color_code(category_tag&.name)}"
      end
      if limit
        tags = tags.first(2)
      end
      tags.collect do |tag|
        concat(link_to("##{tag.name}", customers_recreations_path(q: { tags_id_eq: tag.id }), class: 'tag-label',
                                                                                              style: 'margin-right: 4px;'))
      end
    end
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
    when 'その他'
      '#339999;'
    else
      ''
    end
  end
end
