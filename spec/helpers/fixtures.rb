module Fixtures
  def disclosure_file_data
    File.read(
      filename_to_path(
        'profile/1234/loop/76046/document/561622/AgencyDisclosureStatementSeller.pdf'
      )
    )
  end

  def filename_to_path(filename)
    dotloop_stub_path = ROOT.join('spec', 'stub_responses')
    File.new(dotloop_stub_path.join(filename))
  end
end
