$LOAD_PATH.unshift File.expand_path('../../.', __FILE__)

RSpec.configure do |config|
  config.before(:all) do
    $stdout = StringIO.new
  end

  config.after(:all) do
    $stdout = STDOUT
  end
end