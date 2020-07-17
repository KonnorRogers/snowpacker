# frozen_string_literal: true

require 'ostruct'
RSpec.describe Snowpacker::Rails::Runner do
  before do
    FileUtils.rm_rf(PUBLIC_SNOWPACKER_DIR)
    FileUtils.rm_rf(CACHE_DIR)
    FileUtils.mkdir_p(PUBLIC_SNOWPACKER_DIR)
  end

  context 'from config' do
    describe 'compile' do
      it 'compiles all given assets' do
        asset = [FIXTURES_DIR.join('simple_js_project', 'index.js')]
        Rails = OpenStruct.new(
          application: OpenStruct.new(
            config: OpenStruct.new(
              snowpacker: OpenStruct.new(
                entry_points: asset,
                destination: PUBLIC_SNOWPACKER_DIR
              )
            )
          )
        )
        Snowpacker::Rails::Runner.from_config.compile
        expect(File.exist?(PUBLIC_SNOWPACKER_DIR.join('index.js'))).to eq true
      end
    end
  end
end
