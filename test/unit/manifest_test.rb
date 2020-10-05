require "test_helper"

MANIFEST_FILE = File.join(FIXTURE_DIR, "manifest.json")
MANIFEST_DATA = JSON.parse(File.read(MANIFEST_FILE))

class ManifestTest < Minitest::Test
  def setup
    Snowpacker::Manifest.manifest_hash = nil
  end

  def teardown
    Snowpacker::Manifest.manifest_hash = nil
  end

  def test_parse_manifest_without_error
    assert_nil Snowpacker::Manifest.manifest_hash

    Snowpacker::Manifest.parse_manifest(MANIFEST_FILE)

    assert_equal Snowpacker::Manifest.manifest_hash, MANIFEST_DATA
  end

  def test_
end
