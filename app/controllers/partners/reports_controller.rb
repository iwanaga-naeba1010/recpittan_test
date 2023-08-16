# frozen_string_literal: true

class Partners::ReportsController < Partners::ApplicationController
  before_action :set_order
  before_action :restrict_initialization, except: %i[edit update confirm]

  def new
    @report = @order.build_report
  end

  def edit
    @report = @order.report
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @order.build_report(params_create)
    # NOTE: 冗長だけど、更新のために必要
    @order.status = :final_report_admits_not
    @order.number_of_people = params_create[:number_of_people]
    @order.transportation_expenses = params_create[:transportation_expenses]
    @order.expenses = params_create[:expenses]
    @order.number_of_facilities = params_create[:number_of_facilities]

    if @order.save
      CustomerCompleteReportMailer.notify(order: @order).deliver_now
      message = <<~MESSAGE
        開催日： #{@order.start_at}
        パートナー名： #{@order.recreation.profile_name}
        レク名： #{@order.recreation_title}
        施設名： #{@order.user.company.facility_name}
        レポート本文： #{@order.report_body}
        管理画面案件URL #{admin_order_url(@order.id)}
      MESSAGE
      SlackNotifier.new(channel: '#終了報告スレッド').send('パートナーが終了報告をしました', message)
      redirect_to partners_order_path(@order.id), notice: t('action_messages.created', model_name: Report.model_name.human)
    else
      render :new
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update
    if @order.report.update(params_create)
      @order.update(
        status: :final_report_admits_not,
        number_of_people: params_create[:number_of_people],
        transportation_expenses: params_create[:transportation_expenses].to_i,
        expenses: params_create[:expenses].to_i,
        number_of_facilities: params_create[:number_of_facilities].to_i
      )
      CustomerCompleteReportMailer.notify(order: @order).deliver_now
      redirect_to partners_order_path(@order.id), notice: t('action_messages.updated', model_name: Report.model_name.human)
    else
      render :edit
    end
  end

  def confirm
    is_confirm = params[:is_confirm]
    return render 'partners/orders/deny' if is_confirm == 'deny'

    render 'partners/orders/accept' if is_confirm == 'accept'
  end

  def complete; end

  private def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end

  private def params_create
    params.require(:report).permit(
      :body, :expenses, :number_of_facilities,
      :number_of_people, :transportation_expenses
    )
  end

  private def restrict_initialization
    redirect_to edit_partners_order_report_path(id: @order.report, order_id: @order), alert: '終了報告は作成済みです' if @order.report.present? # rubocop:disable Rails/I18nLocaleTexts
  end
end
