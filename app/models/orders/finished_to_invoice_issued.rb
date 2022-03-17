# frozen_string_literal: true

class Orders::FinishedToInvoiceIssued < Order
  # NOTE(okubo): 完了から請求書発行済みに強制移行するために機能
  default_scope { where(status: :finished) }
end
