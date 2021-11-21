# frozen_string_literal: true

module ApplicationHelper
  def active_link?(target)
    controller.controller_name.in?(target)
  end

  def tags_to_html(tags:)
    # 最初のcategoryは取得できた→tagsの中から削除も必要
    category_tag = rec.tags.map { |tag| tag if tag.kind.category? }.compact.first
    content_tag :div do
      [tag - category_tag].each_with_index do |tag, i|
        if i == 0
          # ここにstyleもしくは、classを当てるi
          content_tag(:span, category_tag.name)
        end
        # こっちは普通
        content_tag(:span, tag.name)
      end
    end
  end

  # case category_tag
  # when category_tag.name == '音楽'
  #   'background-color: #F24051;'
  # when category_tag.name == '健康'
  #   'background-color: #95C15D;'
  # when category_tag.name == '趣味'
  #   'background-color: #8C428C;'
  # when category_tag.name == '創作'
  #   'background-color: #4276FC;'
  # when category_tag.name == '旅行'
  #   'background-color: #FE607D;'
  # when category_tag.name == '飲食'
  #   'background-color: #F3B30C;'
  # when category_tag.name == 'イベント'
  #   'background-color: #FD7E14;'
  # when category_tag.name == 'その他'
  #   'background-color: #339999;'
  # end
end
