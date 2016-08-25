module ESP
  class Suppression
    class Region < ESP::Resource
      self.prefix += "suppressions/"
      # Not Implemented. You cannot search for Suppression::Region.
      #
      # Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions.
      #
      # @return [void]
      def self.where(*)
        fail ESP::NotImplementedError, 'Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions'
      end

      # Not Implemented. You cannot search for Suppression::Region.
      #
      # Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions.
      #
      # @return [void]
      def self.find(*)
        fail ESP::NotImplementedError, 'Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions'
      end

      # Not Implemented. You cannot update a Suppression::Region.
      #
      # @return [void]
      def update
        fail ESP::NotImplementedError
      end

      # Not Implemented. You cannot destroy a Suppression::Region.
      #
      # @return [void]
      def destroy
        fail ESP::NotImplementedError
      end

      # This instance method is called by the #save method when new? is true.
      #
      # @private
      def create
        original_prefix = self.class.prefix
        if attributes[:alert_id]
          self.class.prefix += "alert/:alert_id/"
          prefix_options[:alert_id] = alert_id
        end
        super
      ensure
        self.class.prefix = original_prefix
      end

      # @!method self.create(attributes = {})
      #   Create a suppression for a region.
      #
      #   If you pass an +alert_id+, include the +reason+ and all other params will be ignored, and the suppression will be created based on that alert.
      #
      #   *call-seq* -> +super.create(attributes={})+
      #
      #   @param attributes [Hash] Required hash of region suppression attributes.
      #     ===== Valid Attributes
      #
      #     See {API documentation}[http://api-docs.evident.io?ruby#suppression-region-create] for valid arguments
      #   @return [ESP::Suppression::Region>]
      #   @example When Not Creating for Alert
      #     create(regions: ['us_east_1'], external_account_ids: [5], reason: 'My very good reason for creating this suppression')
      #   @example When Creating for Alert
      #     create(alert_id: 5, reason: 'My very good reason for creating this suppression')

      # @!method save
      #   Create a suppression for a region.
      #
      #   If you set an +alert_id+, set the +reason+ and all other params will be ignored, and the suppression will be created based on that alert.
      #
      #   ===== Valid Attributes
      #
      #   See {API documentation}[http://api-docs.evident.io?ruby#suppression-region-create] for valid arguments
      #
      #   @return [Boolean]
      #   @example When Not Creating for Alert
      #     suppression = new(regions: ['us_east_1'], external_account_ids: [5], reason: 'My very good reason for creating this suppression')
      #     suppression.save
      #   @example When Creating for Alert
      #     suppression = new(alert_id: 5, reason: 'My very good reason for creating this suppression')
      #     suppression.save
    end
  end
end
