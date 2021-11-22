# frozen_string_literal: true

module ApplicationHelper
  def active_link?(target)
    controller.controller_name.in?(target)
  end

  def tags_to_html(tags)
    return if tags.blank?

    category_tag = tags.map { |tag| tag if tag.kind.category? }.compact.first
    content_tag :div do
      concat(content_tag(:a, category_tag&.name, class: 'category-label event mr-1', style: "background-color: #{categoryname_to_color_code(category_tag&.name)}"))
      tags.collect { |tag| concat(content_tag(:a, tag&.name, class: 'tag-label mr-1')) }
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
