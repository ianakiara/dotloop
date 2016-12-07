require_relative '../spec_helper'

RSpec.describe Dotloop::Section do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  let(:loop) { Dotloop::Loop.new(client: client) }

  before(:each) { dotloop_mock_batch(:loops) }

  describe '#detail' do
    it 'finds a single loop detail by id' do
      dotloop_mock(:loop_detail)
      loop_detail = loop.detail(profile_id: 1234, loop_view_id: 76_046)
      sections = loop_detail.sections
      Dotloop::Section::FIXED_SECTIONS.each do |section|
        expect(sections[section]).to have_attributes(result[section.to_sym])
      end
      result[:contacts].each do |expected|
        contact_with_role = sections.contacts.select { |x| x.role == expected[:role] }.first
        expect(contact_with_role).to have_attributes(expected)
      end
    end
  end

  # rubocop:disable Metrics/MethodLength
  def result
    {
      contract_dates: {
        contract_date: '12/06/2016',
        closing_date: '12/15/2016'
      },
      contract_info: {
        transaction_number: 'TRANS98765',
        type: 'ListType'
      },
      financials: {
        earnest_money_held_by: 'Best Trust Company',
        comission_rate: '4',
        earnest_money_amount: '16000',
        sale_commission_total: '14000',
        buy_side_sale_commission_split: '2',
        sale_commission_split_sell_side: '7000',
        sell_side_sale_commission_split: '2',
        sale_commission_split_buy_side: '7000',
        purchase_price: '350000'
      },
      geographic_description: {
        subdivision: 'NorthWoodshire Division',
        mls_legal_description: 'LOT#98765',
        deed_book: 'DeedBook 4',
        map_grid: 'MAPGRID1',
        deed_page: 'Deedpag123',
        block: 'Bock9292',
        lot: '987654',
        addition: 'Addition32',
        mls_area: 'MLSAREA1',
        section: 'Section8'
      },
      listing_information: {
        property_excludes: 'Removable Sauna',
        description_of_other_liens: 'Lien on Shed',
        expiration_date: '12/31/2016',
        listing_date: '12/06/2016',
        total_encumbrances: '60',
        property_includes: 'Fridge,Stove,Washer,Dryer',
        remarks: 'some remarks',
        current_price: '350000',
        first_mortgage_balance: '210000',
        homeowner_association: 'CMHC',
        second_mortgage_balance: '1',
        original_listing_price: '379999',
        other_liens: '1',
        homeowner_association_dues: '50'
      },
      offer_dates: {
        offer_date: '12/06/2016',
        inspection_date: '12/06/2016',
        occupancy_date: '12/31/2016',
        offer_expiration_date: '12/08/2016'
      },
      property: {
        bedrooms: '4',
        year_built: '2003',
        square_footage: '2300',
        type: 'Residential Attached',
        bathrooms: '2',
        school_district: 'Cincinnati School District',
        lot_size: '10000'
      },
      property_address: {
        mls_number: 'MLS3838',
        property_address_country: 'USA',
        postal_code: '45202',
        county: 'district of Cincinnati',
        unit_number: '1',
        parcel_tax_id: 'TAXID9876',
        state_or_province: 'OH',
        street_name: 'Walter Street',
        street_number: '1234',
        city: 'Cincinnati'
      },
      referral: {
        referral_source: 'Rene Referral',
        referral_percentage: '1'
      },
      contacts: [
        {
          role: 'listing_agent',
          phone: '555-555-5555',
          unit_number: '12',
          cell_phone: '555-555-5555',
          fax: '555-555-5555',
          zip_postal_code: '45202',
          country: 'USA',
          city: 'Cincinnati',
          name: 'Annie Agent',
          state_prov: 'OH',
          email: 'agent2@example.com',
          license: '987654321',
          id: '12345',
          company_name: 'ListingGroup',
          street_number: '12',
          street_name: 'Twelve Street'
        },
        {
          role: 'transaction_coordinator',
          name: 'Tranny C O Ordinator',
          email: 'coordinator@example.com',
          country: 'USA'
        },
        {
          role: 'insurance_rep',
          name: 'In Surance',
          email: 'insurance@example.com',
          country: 'USA'
        },
        {
          role: 'appraiser',
          name: 'Appy Praiser',
          email: 'appraiser@example.com',
          country: 'USA'
        },
        {
          role: 'listing_broker',
          email: 'utilprovider@example.com',
          name: 'Usef Provi',
          country: 'USA'
        },
        {
          role: 'managing_broker',
          name: 'Martin Manager',
          state_prov: 'OH',
          unit_number: '2',
          phone: '555-555-5555',
          cell_phone: '555-555-5555',
          email: 'manager@example.com',
          license: '987654321',
          zip_postal_code: '45202',
          id: '12345',
          street_number: '42',
          company_name: 'Admin Brokerage',
          country: 'USA',
          city: 'Cincinnati',
          street_name: 'Life Street'
        },
        {
          role: 'home_warranty',
          home_warranty_email: 'homewarranty@example.com',
          phone: '555-555-5555',
          unit_number: '2',
          cell_phone: '555-555-5555',
          home_warranty_company: 'Waranty Guys',
          zip_postal_code: '45202',
          country: 'USA',
          city: 'Cincinnati',
          state_prov: 'OH',
          license: '98765432',
          id: '1234',
          street_number: '2',
          home_warranty_rep: 'Warren Home',
          street_name: 'Guy Road'
        },
        {
          role: 'admin',
          name: 'Andy Admin',
          state_prov: 'OH',
          phone: '555-555-5555',
          street_name: 'Admin Street',
          zip_postal_code: '45202',
          id: '99887766',
          street_number: '413',
          company_name: 'Admin Brokerage',
          country: 'USA',
          license: '987654321',
          city: 'Cincinnati'
        },
        {
          role: 'loan_officer',
          phone: '555-555-5555',
          unit_number: '44',
          cell_phone: '555-555-5555',
          mortgage_company: 'Cash Money Loans',
          zip_postal_code: '45202',
          country: 'USA',
          city: 'Cincinnati',
          state_prov: 'OH',
          license: '12345',
          id: '12345',
          mortgage_company_rep: 'Loan Officer',
          mortgage_company_email: 'loanofficer@example.com',
          street_number: '69',
          street_name: 'Shark Street'
        },
        {
          role: 'buying_agent',
          phone: '555-555-5555',
          unit_number: '#1a',
          cell_phone: '555-555-5555',
          fax: '555-555-5555',
          zip_postal_code: '45202',
          country: 'USA',
          city: 'Cincinnati',
          name: 'Randy Remax',
          state_prov: 'OH',
          email: 'otheragent@example.com',
          license: '987654321',
          id: '123456',
          company_name: 'Randys Remax',
          street_number: '5555',
          street_name: 'Five Street'
        },
        {
          role: 'buying_broker',
          cell_phone: '555-555-5555',
          fax: '555-555-5555',
          street_name: 'Five Street',
          country: 'USA',
          office_phone: '555-555-5555',
          city: 'Cincinnati',
          postal_code: '45202',
          email: 'ob@example.com',
          license: '987654321',
          name: 'Oscar Outside',
          id: '123456',
          street_number: '5555',
          state_or_province: 'OH',
          company_name: 'Randys Remax',
          suite: '2a'
        },
        {
          role: 'moving_storage',
          name: 'Maximillian Mover',
          email: 'mover@example.com',
          country: 'USA'
        },
        {
          role: 'inspector',
          phone: '555-555-5555',
          unit_number: 'B',
          cell_phone: '555-555-5555',
          inspection_company: 'Inspector Gadgets',
          zip_postal_code: '45202',
          country: 'USA',
          inspection_company_rep: 'Inspector Gadget',
          city: 'Cincinnati',
          state_prov: 'OH',
          email: 'inspector@example.com',
          license: '1234',
          id: '1234',
          street_number: '221',
          street_name: 'Baker Street'
        },
        {
          role: 'buyer',
          phone: '555-555-5555',
          unit_number: '8',
          cell_phone: '555-555-5555',
          zip_postal_code: '45202',
          country: 'USA',
          city: 'Cincinnati',
          name: 'Billy Buyer',
          marital_status: 'Married',
          state_prov: 'OH',
          email: 'buyer@example.com',
          company_name: 'Buyer Company',
          street_number: '88',
          street_name: 'Keys Street'
        },
        {
          role: 'escrow_title',
          title_company_email: 'escrow@example.com',
          country: 'USA',
          title_company_rep: 'Bear Crow'
        },
        {
          role: 'seller',
          phone: '555-555-5555',
          unit_number: '33',
          cell_phone: '555-555-5555',
          zip_postal_code: '45202',
          country: 'USA',
          city: 'Cincinnati',
          name: 'Sally Seller',
          marital_status: 'Single',
          state_prov: 'OH',
          email: 'seller@example.com',
          company_name: 'Sellers Company',
          street_number: '1234',
          street_name: 'Wendy Street'
        },
        {
          role: 'home_security_provider',
          name: 'Tash Yar',
          email: 'security@example.com',
          country: 'USA'
        },
        {
          role: 'sellers_attorney',
          name: 'Sell Attorney',
          email: 'selllawyer@example.com',
          country: 'USA'
        },
        {
          role: 'loan_processor',
          name: 'Loan Processor',
          email: 'loanproc@example.com',
          country: 'USA'
        },
        {
          role: 'buyers_attorney',
          name: 'Buy Attorney',
          email: 'buylawyer@example.com',
          country: 'USA'
        },
        {
          role: 'home_inspector',
          name: 'Home Inspector',
          email: 'homeinspector@example.com',
          country: 'USA'
        }
      ]
    }
  end
end
