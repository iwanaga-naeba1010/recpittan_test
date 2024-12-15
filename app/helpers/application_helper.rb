# frozen_string_literal: true

module ApplicationHelper
  def active_link?(target)
    controller.controller_name.in?(target)
  end

  def mypage_path
    if current_user.role.customer?
      customer_mypage_path
    elsif current_user.role.admin?
      admin_mypage
    else
      partners_path(is_open: true)
    end
  end

  def categories
    [
      { id: 2, title: '音楽', descriptions: ['音楽療法', '和太鼓演奏など'], image_name: 'music.jpg' },
      { id: 3, title: '健康', descriptions: ['体操、フラダンス', '嚥下予防など'], image_name: 'health.jpg' },
      { id: 5, title: '趣味', descriptions: ['書道', '囲碁など'], image_name: 'hobby.jpg' },
      { id: 1, title: '創作', descriptions: ['生花', 'ガラス工芸など'], image_name: 'art.jpg' },
      { id: 4, title: '旅行', descriptions: ['オンライン旅行', 'お出かけなど'], image_name: 'travel.jpg' },
      { id: 6, title: '飲食', descriptions: ['マグロ解体ショー', '和菓子作りなど'], image_name: 'food.jpg' },
      { id: 0, title: 'イベント', descriptions: ['大道芸', '落語など'], image_name: 'event.jpg' },
      { id: 7, title: 'その他', descriptions: ['アニマルセラピー', '写真撮影など'], image_name: 'others.jpg' }
    ]
  end
end
