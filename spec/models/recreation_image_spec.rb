# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_images
#
#  id            :bigint           not null, primary key
#  document_kind :string
#  filename      :string
#  image         :text
#  kind          :integer          default("slider")
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_images_recreation_id_fkey  (recreation_id => recreations.id)
#
require 'rails_helper'

RSpec.describe RecreationImage, type: :model do
  it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:document_kind).of_type(:string).with_options(null: true) }
end
