# frozen_string_literal: true

RESERVED_HEADER_NAMES = %w[
  Content-Type
  Host
  HTTPS
].freeze

SUPPORTED_METHODS = %w[
  DELETE
  GET
  PATCH
  POST
  PUT
].freeze

RSpec.shared_context 'with authenticated customer' do
  let!(:current_user) { create(:user, role: :customer) }
  let!(:company) { create(:company, user: current_user) }

  before do
    sign_in current_user
  end
end

RSpec.shared_context 'with authenticated partner' do
  let!(:current_user) { create(:user, role: :partner) }

  before do
    sign_in current_user
  end
end

RSpec.shared_context 'with authenticated admin' do
  let!(:current_user) { create(:user, role: :admin) }

  before do
    sign_in current_user
  end
end

RSpec.shared_context 'with requesting' do
  let(:app) { Rails.application }

  let(:send_request) { send(http_method, path, params: request_body, headers: env) }

  let(:request_body) do
    if headers.any? { |key, value| key.casecmp('content-type')&.zero? && value == 'application/json' }
      params.to_json
    else
      params
    end
  end

  let(:headers) { {} }
  let(:params) { {} }
  let(:search_results) { {} }

  let(:env) do
    env = headers.inject({}) do |result, (key, value)|
      key = "HTTP_#{key}" unless RESERVED_HEADER_NAMES.include?(key)
      key = key.tr('-', '_').upcase
      result.merge(key => value)
    end

    if respond_to?(:authentication_token)
      env.merge('HTTP_AUTHORIZATION' => "Bearer #{authentication_token}")
    else
      env
    end
  end

  let(:endpoint_segments) do
    current_example = RSpec.respond_to?(:current_example) ? RSpec.current_example : example
    current_example.full_description.match(/(#{Regexp.union(SUPPORTED_METHODS)}) (\S+)/).to_a
  end

  let(:http_method) { endpoint_segments[1].downcase }
  let(:path) { endpoint_segments[2].gsub(/:(\w+[!?=]?)/) { send(Regexp.last_match(1)) } }
end

RSpec.shared_examples 'an endpoint returns' do |sym, debug_option|
  it sym.to_s do
    send_request

    binding.pry if debug_option == :pry # rubocop:disable Lint/Debugger
    if debug_option == :pp
      puts 'Expected:'
      pp instance_eval(sym.to_s)
      puts 'Got:'
      pp JSON.parse(response.body)
    end

    if debug_option == :diff
      File.write('tmp/response.raw.json', response.body)
      `cat tmp/response.raw.json | jq "." > tmp/response.json`
      File.write('tmp/expected.raw.json', Oj.dump(instance_eval(sym.to_s), mode: :compat, second_precision: 0))
      `cat tmp/expected.raw.json | jq "." > tmp/expected.json`
      puts `diff tmp/expected.json tmp/response.json`
    end

    expect(response).to be_successful
    obj = instance_eval(sym.to_s)
    expected_body = obj.present? || obj == [] ? Oj.dump(obj, mode: :compat, second_precision: 0) : ''
    expect(response.body).to eq(expected_body)
  end
end

RSpec.shared_examples 'an endpoint returns 2xx status' do
  it 'its response status should be 2xx' do
    send_request
    expect(response.status).to be_between(200, 299)
  end
end

RSpec.shared_examples 'an endpoint returns 3xx status' do
  it 'its response status should be 3xx' do
    send_request
    expect(response.status).to be_between(300, 399)
  end
end

RSpec.shared_examples 'an endpoint returns 4xx status' do
  it 'its response status should be 4xx' do
    send_request
    expect(response.status).to be_between(400, 499)
  end
end

RSpec.shared_examples 'an endpoint returns 400 status' do
  it 'its response status should be 400' do
    send_request
    expect(response.status).to be(400)
  end
end

RSpec.shared_examples 'an endpoint returns 404 status' do
  it 'its response status should be 404' do
    send_request
    expect(response.status).to be(404)
  end
end

RSpec.shared_examples 'an endpoint returns 5xx status' do
  it 'its response status should be 5xx' do
    expect { send_request }.to raise_error
  end
end

RSpec.shared_examples 'an endpoint returns record invalid' do
  it 'its response should raise ActiveRecord::RecordInvalid' do
    expect { send_request }.to raise_error(ActiveRecord::RecordInvalid)
  end
end

RSpec.shared_examples 'an endpoint redirects to' do |ignore_parameter|
  # let(:expected_redirect_to) {}

  it 'its response should redirect to expected redirect path' do
    send_request
    expect(response.status).to be_between(300, 399)
    if ignore_parameter
      expect(response.location.gsub('http://example.com', '').split('?').first).to include(expected_redirect_to)
    else
      expect(response.location.gsub('http://example.com', '')).to eq(expected_redirect_to)
    end
  end
end

RSpec.shared_examples 'an endpoint redirects match' do
  # let(:expected_redirect_to) {}

  it 'its response should redirect to expected redirect path' do
    send_request
    expect(response.status).to be_between(300, 399)
    expect(response.location.gsub('http://example.com', '')).to match(expected_redirect_to)
  end
end

RSpec.shared_examples 'an endpoint redirects back' do
  let(:referrer) { 'http://example.com/referer/path/to/redirect' }
  let(:headers) { { 'Referer' => referrer } }

  it 'its response should redirect back' do
    send_request
    expect(response.status).to be_between(300, 399)
    expect(response).to redirect_to(referrer)
  end
end

RSpec.shared_examples 'an endpoint set flash[:success] with' do |message|
  before do
    allow_any_instance_of(ApplicationController).to receive_message_chain(:flash, :[]=)
    expect_any_instance_of(ApplicationController).to receive_message_chain(:flash, :[]=)
      .with(:success, message)
  end

  it('should set flash[:success]') { send_request }
end

RSpec.shared_examples 'an endpoint set flash[:error] with' do |message|
  before do
    allow_any_instance_of(ApplicationController).to receive_message_chain(:flash, :[]=)
    expect_any_instance_of(ApplicationController).to receive_message_chain(:flash, :[]=)
      .with(:error, message)
  end

  it('should set flash[:error]') { send_request }
end

RSpec.configure do |config|
  config.after(:each, type: :request) { DatabaseCleaner.clean }
  config.include_context 'with requesting', type: :request
end
