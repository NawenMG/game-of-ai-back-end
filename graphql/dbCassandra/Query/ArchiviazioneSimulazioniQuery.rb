module Queries
  class ArchiviazioneSimulazioniQuery < Queries::BaseQuery
    description 'Retrieves all simulation archives'

    type [Types::ArchiviazioneSimulazioniType], null: false

    def resolve
      service = ArchiviazioneSimulazioniService.new
      service.get_all
    end
  end
end
