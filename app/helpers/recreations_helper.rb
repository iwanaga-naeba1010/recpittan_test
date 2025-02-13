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

  def tag_labels_only(recreation, limit: true)
    return if recreation.blank?

    tags = recreation.tags
    category = recreation.category_text
    content_tag :div do
      # カテゴリ表示
      if category.present?
        concat content_tag(:span, category,
                           class: 'category-label event',
                           style: "margin-right: 4px; background-color: #{categoryname_to_color_code(category)}")
      end

      # タグ表示 (リンクなし)
      tags = tags.first(2) if limit
      tags.each do |tag|
        concat content_tag(:span, "##{tag.name}",
                           class: 'tag-label px-1 my-1 font-weight-bold d-inline-block',
                           style: 'margin-right: 4px;')
      end
    end
  end

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
    Recreation.sort_order.values.map do |v|
      [I18n.t("enumerize.recreation.sort_orders.#{v}"), v]
    end
  end

  def recreation_kinds
    [
      { id: 0, name: '訪問', value: 'visit' },
      { id: 1, name: 'オンライン', value: 'online' },
      { id: 2, name: '郵送キット', value: 'mailing' },
    ]
  end

  def recreation_categories
    [
      { id: 2, name: '音楽', value: 'music' },
      { id: 3, name: '健康', value: 'health' },
      { id: 5, name: '趣味', value: 'hobby' },
      { id: 1, name: '創作', value: 'work' },
      { id: 4, name: '旅行', value: 'travel' },
      { id: 6, name: '飲食', value: 'food' },
      { id: 0, name: 'イベント', value: 'event' },
      { id: 7, name: 'その他', value: 'other' },
    ]
  end

  def recreation_prices
    [
      { value: '0-10000', text: '0~ 10,000円' },
      { value: '10001-20000', text: '10,001~ 20,000円' },
      { value: '20001-30000', text: '20,001~ 30,000円' },
      { value: '30000-', text: '30,000円以上' },
    ]
  end
end
