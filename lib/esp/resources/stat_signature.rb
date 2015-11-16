module ESP
  class StatSignature < ESP::Resource
    include ESP::StatTotals

    # The signature these stats are for.
    belongs_to :signature, class_name: 'ESP::Signature'

    # Returns a paginated collection of signature stats for the given stat_id
    # Convenience method to use instead of ::find since a stat_id is required to return signature stats.
    #
    # ==== Parameter
    #
    # +stat_id+ | Required | The ID of the stat to list signature stats for
    #
    # ==== Example
    #   stats = ESP::StatSignature.for_stat(1194)
    def self.for_stat(stat_id = nil)
      fail ArgumentError, "You must supply a stat id." unless stat_id.present?
      from = "#{prefix}stats/#{stat_id}/signatures.json_api"
      find(:all, from: from)
    end

    # Find a StatRegion by id
    #
    # ==== Parameter
    #
    # +id+ | Required | The ID of the signature stat to retrieve
    #
    # :call-seq:
    #  find(id)
    def self.find(*arguments)
      scope = arguments.slice!(0)
      options = (arguments.slice!(0) || {}).with_indifferent_access
      return super(scope, options) if scope.is_a?(Numeric) || options[:from].present?
      params = options.fetch(:params, {}).with_indifferent_access
      stat_id = params.delete(:stat_id)
      for_stat(stat_id)
    end

    # :singleton-method: create
    # Not Implemented. You cannot create a Stat.

    # :method: save
    # Not Implemented. You cannot create or update a Stat.

    # :method: destroy
    # Not Implemented. You cannot delete a Stat.

    # :section: 'total' rollup methods

    # :method: total

    # :method: total_pass

    # :method: total_fail

    # :method: total_warn

    # :method: total_error

    # :method: total_info

    # :method: total_new_1h_pass

    # :method: total_new_1h_fail

    # :method: total_new_1h_warn

    # :method: total_new_1h_error

    # :method: total_new_1h_info

    # :method: total_new_1d_pass

    # :method: total_new_1d_fail

    # :method: total_new_1d_warn

    # :method: total_new_1d_error

    # :method: total_new_1d_info

    # :method: total_new_1w_pass

    # :method: total_new_1w_fail

    # :method: total_new_1w_error

    # :method: total_new_1w_info

    # :method: total_new_1w_warn

    # :method: total_old_fail

    # :method: total_old_pass

    # :method: total_old_warn

    # :method: total_old_error

    # :method: total_old_info

    # :method: total_suppressed

    # :method: total_suppressed_pass

    # :method: total_suppressed_fail

    # :method: total_suppressed_warn

    # :method: total_suppressed_error

    # :method: total_new_1h

    # :method: total_new_1d

    # :method: total_new_1w

    # :method: total_old
  end
end
