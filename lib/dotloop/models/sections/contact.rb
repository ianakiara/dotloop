module Dotloop
  module Models
    module Sections
      class Contact
        include Virtus.model
        attribute :role
        attribute :cell_phone
        attribute :city
        attribute :company_name
        attribute :country
        attribute :email
        attribute :fax
        attribute :id
        attribute :license
        attribute :marital_status
        attribute :name
        attribute :phone
        attribute :state_prov
        attribute :street_name
        attribute :street_number
        attribute :unit_number
        attribute :zip_or_postal_code

        alias_method :home_warranty_company, :company_name
        alias_method :home_warranty_email, :email
        alias_method :home_warranty_rep, :name
        alias_method :inspection_company, :company_name
        alias_method :inspection_company_rep, :name
        alias_method :mortgage_company, :company_name
        alias_method :mortgage_company_email, :email
        alias_method :mortgage_company_rep, :name
        alias_method :office_phone, :phone
        alias_method :postal_code, :zip_or_postal_code
        alias_method :state_or_province, :state_prov
        alias_method :suite, :unit_number
        alias_method :title_company_email, :email
        alias_method :title_company_rep, :name
        alias_method :zip_postal_code, :zip_or_postal_code
      end
    end
  end
end
