module ESP
  class Signature < ESP::Resource
    ##
    # The service this signature belongs to.
    belongs_to :service, class_name: 'ESP::Service'

    # Not Implemented. You cannot create or update a Signature.
    def save
      fail ESP::NotImplementedError
    end

    # Not Implemented. You cannot destroy a Signature.
    def destroy
      fail ESP::NotImplementedError
    end

    # Run this signature.
    # Returns a collection of alerts.
    # Throws an error if not successful.
    #
    # ==== Parameters
    #
    # +arguments+ | Required | A hash of run arguments
    #
    # ===== Valid Arguments
    #
    # See {API documentation}[http://api-docs.evident.io?ruby#signature-run] for valid arguments
    #
    # ==== Example
    #   signature = ESP::Signature.find(3)
    #   alerts = signature.run!(external_account_id: 3, region: 'us_east_1')
    def run!(arguments = {})
      result = run(arguments)
      return result if result.is_a?(ActiveResource::Collection)
      result.message = result.errors.full_messages.join(' ')
      fail(ActiveResource::ResourceInvalid.new(result)) # rubocop:disable Style/RaiseArgs
    end

    # Run this signature.
    # Returns a collection of alerts.
    # If not successful, returns a Signature object with the errors object populated.
    #
    # ==== Parameters
    #
    # +arguments+ | Required | A hash of run arguments
    #
    # ===== Valid Arguments
    #
    # See {API documentation}[http://api-docs.evident.io?ruby#signature-run] for valid arguments
    #
    # ==== Example
    #   signature = ESP::Signature.find(3)
    #   alerts = signature.run(external_account_id: 3, region: 'us_east_1')
    def run(arguments = {})
      arguments = arguments.with_indifferent_access
      attributes['external_account_id'] ||= arguments[:external_account_id]
      attributes['region'] ||= arguments[:region]

      response = connection.post("#{self.class.prefix}signatures/#{id}/run.json", to_json)
      ESP::Alert.send(:instantiate_collection, self.class.format.decode(response.body))
    rescue ActiveResource::BadRequest, ActiveResource::ResourceInvalid, ActiveResource::ResourceNotFound => error
      load_remote_errors(error, true)
      self.code = error.response.code
      self
    end

    # Create a suppression for this signature.
    #
    # ==== Parameter
    #
    # +arguments+ | Required | A hash of signature suppression attributes
    #
    # ===== Valid Arguments
    #
    # See {API documentation}[http://api-docs.evident.io?ruby#suppression-create] for valid arguments
    #
    # ==== Example
    #   suppress(regions: ['us_east_1'], external_account_ids: [5], reason: 'My very good reason for creating this suppression')
    def suppress(arguments = {})
      arguments = arguments.with_indifferent_access
      ESP::Suppression::Signature.create(signature_ids: [id], regions: Array(arguments[:regions]), external_account_ids: Array(arguments[:external_account_ids]), reason: arguments[:reason])
    end

    # :singleton-method: where
    # Return a paginated Signature list filtered by search parameters
    #
    # ==== Parameters
    #
    # +clauses+ | Hash of attributes with appended predicates to search, sort and include.
    #
    # ===== Valid Clauses
    #
    # See {API documentation}[http://api-docs.evident.io?ruby#signature-attributes] for valid arguments
    #
    # :call-seq:
    #  where(clauses = {})

    ##
    # :singleton-method: find
    # Find a Signature by id
    #
    # ==== Parameter
    #
    # +id+ | Required | The ID of the signature to retrieve
    #
    # +options+ | Optional | A hash of options
    #
    # ===== Valid Options
    #
    # +include+ | The list of associated objects to return on the initial request.
    #
    # ===== Valid Includable Associations
    #
    # See {API documentation}[http://api-docs.evident.io?ruby#signature-attributes] for valid arguments
    #
    # :call-seq:
    #  find(id, options = {})

    # :singleton-method: all
    # Return a paginated Signature list
  end
end
