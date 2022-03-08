# frozen_string_literal: true

class Orders::WaitingForAnEventToTakePlaceToInProgress < Order
  # NOTE(okubo): 実地待ち相談中に強制移行するために機能
  default_scope { where(status: :waiting_for_an_event_to_take_place) }
end
