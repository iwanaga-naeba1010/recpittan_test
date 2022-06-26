# frozen_string_literal: true

class Customers::InvoiceInformationsController < Customers::ApplicationController
  include InteractionHandling
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
      redirect_to edit_customers_invoice_information_path(@invoice_information.id),
                  notice: t('action_messages.created', model_name: InvoiceInformation.model_name.human)
    else
      @invoice_information = handle_interaction_errors(
        variable: current_user.build_invoice_information(outcome.params),
        params: outcome.params,
        errors: outcome.errors.errors
      )
      render :new
    end
  end

  def edit; end

  def update
    outcome = Resources::InvoiceInformations::Update.run(
      id: current_user.invoice_information.id,
      params: params_create,
      current_user: current_user
    )
    if outcome.valid?
      @invoice_information = outcome.result
      redirect_to edit_customers_invoice_information_path(@invoice_information),
                  notice: t('action_messages.updated', model_name: InvoiceInformation.model_name.human)
    else
      @invoice_information = handle_interaction_errors(
        variable: current_user.invoice_information,
        params: outcome.params,
        errors: outcome.errors.errors
      )
      render :edit
    end
  end

  private def set_invoice_information
    @invoice_information = current_user.invoice_information
  end

  private def params_create
    params.require(:invoice_information).permit(:name, :zip, :prefecture, :city, :street, :building, :memo)
  end
end
