# app/graphql/types/save_configuration_type.rb
module Types
  class SaveConfigurationType < BaseObject
    field :id, String, null: false
    field :live_symbol, String, null: false
    field :dead_symbol, String, null: false
    field :live_color, String, null: false
    field :dead_color, String, null: false
  end
end
