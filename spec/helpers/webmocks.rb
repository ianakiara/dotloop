module Helpers
  def dotloop_mock(request)
    WebMock.reset!
    endpoint = standard_endpoints(request)
    data_file = File.new(filename_to_path_json(endpoint))
    WebMock
      .stub_request(:get, endpoint_to_url(endpoint))
      .to_return(body: data_file, status: 200, headers: { 'Content-Type' => 'application/json' })
  end

  def dotloop_mock_batch(request)
    endpoint = standard_endpoints(request)
    batch1_file = File.new(filename_to_path_json([endpoint, '_page1']))
    batch2_file = File.new(filename_to_path_json([endpoint, '_page2']))
    url = endpoint_to_url(endpoint)
    WebMock.reset!
    WebMock
      .stub_request(:get, [url, '?batchNumber=1&batchSize=50'].join)
      .to_return(body: batch1_file, status: 200, headers: { 'Content-Type' => 'application/json' })
    WebMock
      .stub_request(:get, [url, '?batchNumber=2&batchSize=50'].join)
      .to_return(body: batch2_file, status: 200, headers: { 'Content-Type' => 'application/json' })
  end

  def dotloop_pdf
    WebMock.stub_request(
      :get,
      endpoint_to_url(
        'profile/1234/loop/76046/document/561622/AgencyDisclosureStatementSeller.pdf'
      )
    )
           .to_return(body: disclosure_file_data,
                      status: 200,
                      headers: {
                        'Content-Type' => 'application/pdf',
                        'content-disposition' => ['attachment; filename="AgencyDisclosureStatementSeller.pdf"']
                      })
  end

  private

  def filename_to_path_json(filenames)
    filename_to_path([filenames, '.json'].flatten.join)
  end

  def endpoint_to_url(endpoint)
    dotloop_url = 'https://www.dotloop.com/my/api/v1_0/'
    [dotloop_url, endpoint].join
  end

  def standard_endpoints(lookup)
    {
      profiles:        'profile',                          loops:               'profile/1234/loop',
      loop:            'profile/1234/loop/76046',          loop_detail:         'profile/1234/loop/76046/detail',
      loop2:           'profile/1234/loop/76047',          loop2_detail:        'profile/1234/loop/76047/detail',
      loop_activities: 'profile/1234/loop/76046/activity', documents:           'profile/1234/loop/76046/document',
      tasks:           'profile/1234/loop/76046/task',     participants:        'profile/1234/loop/76046/participant',
      folders:         'profile/1234/loop/76046/folder',   person:              'person/3603862',
      employees:       'profile/1234/employee',            document_activities: 'profile/1234/document/561622/activity',
      admins:          'profile/1234/admin',               persons:             'person'
    }[lookup.to_sym]
  end
end
