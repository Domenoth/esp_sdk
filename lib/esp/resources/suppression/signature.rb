module ESP
  class Suppression
    class Signature < ESP::Resource
      self.prefix += "suppressions/"
      # Not Implemented. You cannot search for Suppression::Signature.
      #
      # Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions.
      def self.where(*)
        fail ESP::NotImplementedError, 'Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions'
      end

      # Not Implemented. You cannot search for Suppression::Signature.
      #
      # Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions.
      def self.find(*)
        fail ESP::NotImplementedError, 'Regular ARELlike methods are disabled.  Use the ESP::Suppression object to search suppressions'
      end

      # Not Implemented. You cannot update a Suppression::Signature.
      def update
        fail ESP::NotImplementedError
      end

      # Not Implemented. You cannot destroy a Suppression::Signature.
      def destroy
        fail ESP::NotImplementedError
      end

      # This instance method is called by the #save method when new? is true.
      def create # :nodoc:
        original_prefix = self.class.prefix
        if attributes[:alert_id]
          self.class.prefix += "alert/:alert_id/"
          prefix_options[:alert_id] = alert_id
        end
        super
      ensure
        self.class.prefix = original_prefix
      end

      # :singleton-method: create
      # Create a suppression for a signature or custom signature.
      #
      # If you pass an +alert_id+, include the +reason+ and all other params will be ignored, and the suppression will be created based on that alert.
      #
      # :call-seq:
      #   create(attributes={})
      #
      # ==== Parameter
      #
      # +attributes+ | Required | A hash of signature suppression attributes
      #
      # ===== Valid Attributes
      #
      # See {API documentation}[http://api-docs.evident.io?ruby#suppression-signature-create] for valid arguments
      #
      # ==== Example When Not Creating for Alert
      #   create(signature_ids: [4, 2], regions: ['us_east_1'], external_account_ids: [5], reason: 'My very good reason for creating this suppression')
      #
      # ==== Example When Creating for Alert
      #   create(alert_id: 5, reason: 'My very good reason for creating this suppression')

      # :method: save
      # Create a suppression for a signature or custom signature.
      #
      # If you set an +alert_id+, set the +reason+ and all other params will be ignored, and the suppression will be created based on that alert.
      #
      # ===== Valid Attributes
      #
      # See {API documentation}[http://api-docs.evident.io?ruby#suppression-signature-create] for valid arguments
      #
      # ==== Example When Not Creating for Alert
      #   suppression = new(signature_ids: [4, 2], regions: ['us_east_1'], external_account_ids: [5], reason: 'My very good reason for creating this suppression')
      #   suppression.save
      #
      # ==== Example When Creating for Alert
      #   suppression = new(alert_id: 5, reason: 'My very good reason for creating this suppression')
      #   suppression.save
    end
  end
end
