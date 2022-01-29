# frozen_string_literal: true

class Orders::ForceWaitingForAnEventToTakePlace < Order
  # NOTE(okubo): 相談中から完了に強制移行するために機能なのでin_progressで対応
  default_scope { where(status: :in_progress) }
end
