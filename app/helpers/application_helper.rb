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
end
