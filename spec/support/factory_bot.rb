require_relative 'requests_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include RequestSpecHelper, type: :request
end
