# frozen_string_literal: true

Dir[Rails.root.join('db/seeds/*.rb')].sort.each { |seed| load seed }
