# frozen_string_literal: true

module ApplicationHelper
  def active_link?(target)
    controller.controller_name.in?(target)
  end

  # case tag_category_style
  # when rec.tags.categories.name == '音楽'
  #   'background-color: #F24051;'
  # when rec.tags.categories.name == '健康'
  #   'background-color: #95C15D;'
  # when rec.tags.categories.name == '趣味'
  #   'background-color: #8C428C;'
  # when rec.tags.categories.name == '創作'
  #   'background-color: #4276FC;'
  # when rec.tags.categories.name == '旅行'
  #   'background-color: #FE607D;'
  # when rec.tags.categories.name == '飲食'
  #   'background-color: #F3B30C;'
  # when rec.tags.categories.name == 'イベント'
  #   'background-color: #FD7E14;'
  # when rec.tags.categories.name == 'その他'
  #   'background-color: #339999;'
  # end
end
