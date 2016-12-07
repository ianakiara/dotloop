module Dotloop
  class Section
    FIXED_SECTIONS = %w(
      contract_dates contract_info financials geographic_description listing_information
      offer_dates property_address property referral
    ).freeze

    def self.call(data)
      new.call(data)
    end

    def call(data)
      @sections = { contacts: [] }
      data.each { |item| build_section(item[0], item[1]) }
      @sections
    end

    private

    def build_section(index, values)
      key = index_to_key(index)
      if FIXED_SECTIONS.include?(key)
        @sections[key.to_sym] = values
      else
        @sections[:contacts] << build_contact(key, values)
      end
    end

    def build_contact(key, values)
      Dotloop::Models::Sections::Contact.new(values.merge(role: key))
    end

    def index_to_key(index)
      index.to_s.downcase.delete('^a-z ').strip.tr(' ', '_')
    end
  end
end
