# frozen_string_literal: true

module Pipedrive
  class Deal < Base
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def list_participants(*args)
      params = args.extract_options!
      params.symbolize_keys!
      id = params[:id] || args[0]
      raise 'id must be provided' unless id

      res = make_api_call(:get, "#{id}/participants")
      return [] unless res.success?
      res.data
    end

    def add_participant(*args)
      params = args.extract_options!
      params.symbolize_keys!
      id = params[:id] || args[0]
      raise 'id must be provided' unless id

      params[:person_id] ||= args[1]
      raise 'person_id is missing' unless params[:person_id]

      make_api_call(:post, "#{id}/participants", params)
    end

    def delete_participant(*args)
      params = args.extract_options!
      params.symbolize_keys!
      id = params[:id] || args[0]
      raise 'id must be provided' unless id

      deal_participant_id = params[:deal_participant_id] || args[1]
      raise 'deal_participant_id must be provided' unless deal_participant_id

      make_api_call(:delete, "#{id}/participants/#{deal_participant_id}")
    end
  end
end
