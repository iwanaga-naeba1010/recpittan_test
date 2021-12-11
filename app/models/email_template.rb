# == Schema Information
#
# Table name: email_templates
#
#  id          :bigint           not null, primary key
#  body        :text
#  explanation :string
#  kind        :integer
#  signature   :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EmailTemplate < ApplicationRecord
end
