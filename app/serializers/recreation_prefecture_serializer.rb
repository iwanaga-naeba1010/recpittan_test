# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_prefectures
#
#  id            :bigint           not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_prefectures_recreation_id_fkey  (recreation_id => recreations.id)
#
class RecreationPrefectureSerializer
  def serialize_list(recreation_prefectures:)
    recreation_prefectures.map { |prefecture| serialize(recreation_prefecture: prefecture) }
  end

  def serialize(recreation_prefecture:)
    {
      id: recreation_prefecture.id,
      name: recreation_prefecture.name
    }
  end
end
