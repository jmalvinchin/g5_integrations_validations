module G5IntegrationsValidations
  module YardiRentCafeInventoryValidations
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations

      validates :unit_cta_availability_threshold, presence: true

    end
  end
end
