module Dotloop
  class Section
    attr_accessor :sections
    FIXED_SECTIONS = %i(
      contract_dates contract_info financials geographic_description listing_information
      offer_dates property_address property referral
    ).freeze

    def initialize(data)
      @sections = FIXED_SECTIONS.each_with_object({}) { |key, memo| memo[key] = {} }.merge(contacts: [])
      parse_data(data)
    end

    def parse_data(data)
      fix_hash_keys(data).each { |item| build_section(item[0], item[1]) }
    end

    private

    def build_section(key, section_data)
      values = fix_hash_keys(section_data)
      if FIXED_SECTIONS.include?(key)
        @sections[key] = values
      else
        @sections[:contacts] << build_contact(key, map_contact_keys(values))
      end
    end

    def build_contact(key, values)
      Dotloop::Models::Sections::Contact.new(values.merge(role: key.to_s))
    end

    def index_to_key(index)
      index.to_s.downcase.delete(%(')).gsub(/[^a-z]/, '_').squeeze('_').gsub(/^_*/, '').gsub(/_*$/, '').to_sym
    end

    def fix_hash_keys(bad_hash)
      bad_hash.each_with_object({}) do |item, memo|
        memo[index_to_key(item[0])] = item[1]
      end
    end

    def map_contact_keys(contact_data)
      contact_data.each_with_object({}) do |item, memo|
        key = contact_key_map[item[0].to_sym] || item[0]
        memo[key] = item[1]
      end
    end

    def contact_key_map
      {
        home_warranty_company: :company_name, home_warranty_email: :email, home_warranty_rep: :name,
        inspection_company: :company_name, inspection_company_rep: :name, mortgage_company: :company_name,
        mortgage_company_email: :email, mortgage_company_rep: :name, office_phone: :phone,
        postal_code: :zip_or_postal_code, state_or_province: :state_prov, suite: :unit_number,
        title_company_email: :email, title_company_rep: :name, zip_postal_code: :zip_or_postal_code
      }
    end
  end
end
