# frozen_string_literal: true

class Customers::InvoiceInformationsController < Customers::ApplicationController
  before_action :authenticate_user!
  skip_before_action :require_customer
  before_action :set_invoice_information, only: %i[edit update]

  def new
    @invoice_information = current_user.build_invoice_information
  end

  def create
    outcome = Resources::InvoiceInformations::Create.run(
      params: params_create,
      current_user: current_user
    )
    if outcome.valid?
      @invoice_information = outcome.result
      redirect_to customers_path,
                  notice: t('action_messages.created', model_name: InvoiceInformation.model_name.human)
    else
      # TODO(okubo): 綺麗にしたいが、interactionを使っているので、これ以外なさそう
      @invoice_information = current_user.build_invoice_information(outcome.params)
      outcome.errors.errors.each do |e|
        @invoice_information.errors.add(e.attribute, e.message)
      end
      render :new
    end
  end

  def edit; end

  def update
    if @invoice_information.update(params_create)
      redirect_to customers_path, notice: t('action_messages.updated', model_name: InvoiceInformation.model_name.human)
    else
      render :edit
    end
  end

  private def set_invoice_information
    @invoice_information = current_user.invoice_information
  end

  private def params_create
    params.require(:invoice_information).permit(:name, :code, :zip, :prefecture, :city, :street, :building, :memo)
  end
end
