# frozen_string_literal: true

module SystemHelper
  # テーマのCSSを当てるとチェックボックスやラジオボタンが capybara で押せないので、
  # ラベルをクリックして間接的にチェックする
  def click_labels(*labels)
    all('label').each do |label|
      label.click if labels.include?(label.text)
    end
  end

  def click_check_boxes(*labels)
    click_labels(*labels)
  end

  def click_radio_buttons(*labels)
    click_labels(*labels)
  end

  def click_buttons(*labels)
    labels.each do |label|
      all(:link_or_button, label).each(&:click)
    end
  end

  def input_text_boxes(selector, value)
    all(selector).each do |box|
      box.fill_in with: value
    end
  end

  def select_all(selector, value)
    all(selector).each do |select|
      select.select(value)
    end
  end

  def click_all(selector)
    all(selector).each(&:click)
  end
end
