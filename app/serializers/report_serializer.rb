# frozen_string_literal: true

# == Schema Information
#
# Table name: reports
#
#  id                      :bigint           not null, primary key
#  body                    :text
#  expenses                :integer
#  number_of_facilities    :integer
#  number_of_people        :integer
#  status                  :integer
#  transportation_expenses :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  order_id                :bigint           not null
#
# Foreign Keys
#
#  reports_order_id_fkey  (order_id => orders.id)
#
class ReportSerializer
  def serialize_list(reports:)
    reports.map { |report| serialize(report:) }
  end

  def serialize(report:)
    order = OrderSerializer.new.serialize(order: report.order)
    {
      id: report.id,
      body: report.body,
      expenses: report.expenses,
      number_of_facilities: report.number_of_facilities,
      number_of_people: report.number_of_people,
      status: report.status,
      transportation_expenses: report.transportation_expenses,
      order:
    }
  end
end
