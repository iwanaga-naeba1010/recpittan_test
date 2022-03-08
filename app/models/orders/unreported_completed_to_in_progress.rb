# frozen_string_literal: true

class Orders::UnreportedCompletedToInProgress < Order
  # NOTE(okubo): 終了報告未から相談中に強制移行するために機能
  default_scope { where(status: :unreported_completed) }
end
