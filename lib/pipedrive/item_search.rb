module Pipedrive
  class ItemSearch < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Utils

    # https://developers.pipedrive.com/docs/api/v1/#!/ItemSearch

    def search(*args, &block)
      params = args.extract_options!
      params[:term] ||= args[0]
      params[:item_types] ||= args[1]
      params[:fields] ||= args[2]
      params[:exact_match] ||= args[3]
      raise 'term is missing' unless params[:term]
      raise 'item_types is not valid' unless %w[deal person organization product lead file mail_attachment].include? params[:item_types]

      res = make_api_call(:get, params)
      return [] unless res.success?
      res.data&.items
    end

    def search_field(*args, &block)
      params = args.extract_options!
      params[:term] ||= args[0]
      params[:field_key] ||= args[1]
      params[:field_type] ||= args[2]
      params[:exact_match] ||= args[3]
      params[:return_item_ids] ||= true
      raise 'term is missing' unless params[:term]
      raise 'field_type is not valid' unless %w[dealField personField organizationField productField].include? params[:field_type]

      res = make_api_call(:get, 'field', params)
      return [] unless res.success?
      res.data
    end

    def entity_name
      'itemSearch'
    end
  end
end
