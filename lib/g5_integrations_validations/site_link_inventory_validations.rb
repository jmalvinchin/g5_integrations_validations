module G5IntegrationsValidations::SiteLinkInventoryValidations

  VALID_RATE_BASES = %w(push_rate standard_rate)
  VALID_IN_STORE_RATE_BASES = VALID_RATE_BASES + ['calculated_from_web_rate']
  VALID_WEB_RATE_BASES = VALID_RATE_BASES + ['calculated_from_in_store_rate']
  CTAS_FOR_IN_AND_ABOVE_THRESHOLD = %w(quote reserve)
  CTAS_FOR_IN_AND_ABOVE_THRESHOLD_WITH_RENT_NOW = [
    'quote',
    'reserve',
    'reserve_fee',
    # todo: before removing 'rent_now', make sure this doesn't
    # isn't used by any app using this gem
    'rent_now',
    'rent_now_or_reserve',
    'rent_now_or_reserve_fee'
  ]
  CTAS_FOR_BELOW_THRESHOLD = %w(call quote)

  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations

    include G5IntegrationsValidations::RateValidations.model(
      in_store_rate_bases: VALID_IN_STORE_RATE_BASES,
      web_rate_bases: VALID_WEB_RATE_BASES,
    )

    validates(:unit_availability_cta_in_and_above_threshold, {
      inclusion: {in: CTAS_FOR_IN_AND_ABOVE_THRESHOLD_WITH_RENT_NOW}
    })
    validates(:unit_availability_cta_below_threshold, {
      inclusion: {in: CTAS_FOR_BELOW_THRESHOLD},
      allow_blank: true
    })
  end

end
