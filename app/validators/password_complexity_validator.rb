# frozen_string_literal: true

class PasswordComplexityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    types = 0
    types += 1 if value =~ /\d/        # 数字
    types += 1 if value =~ /[a-z]/     # 小文字
    types += 1 if value =~ /[A-Z]/     # 大文字
    types += 1 if value =~ /[\W_]/     # 記号

    unless types >= 2
      record.errors.add(attribute, 'は数字・英小文字・英大文字・記号のうち2種類以上を含める必要があります')
    end
  end
end
