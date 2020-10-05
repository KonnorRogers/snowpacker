require "test_helper"

MANIFEST_FILE = File.join(FIXTURE_DIR, "manifest.json")

class TestManifest < Minitest::Test
  def test_properly_parses_manifest
    assert_nil Snowpacker::Manifest.manifest_hash
  end
end
