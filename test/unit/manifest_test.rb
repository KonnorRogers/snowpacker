require "test_helper"
require "json"

MANIFEST_FILE = File.join(FIXTURE_DIR, "manifest.json")
MANIFEST_DATA = JSON.parse(File.read(MANIFEST_FILE), symbolize_names: true)

class ManifestTest < Minitest::Test
  def setup
    Snowpacker::Manifest.manifest_hash = MANIFEST_DATA
  end

  def teardown
    Snowpacker::Manifest.manifest_hash = nil
  end

  def test_parse_manifest_without_error
    Snowpacker::Manifest.manifest_hash = nil

    assert_nil Snowpacker::Manifest.manifest_hash

    Snowpacker::Manifest.reload_manifest(MANIFEST_FILE)

    assert_equal Snowpacker::Manifest.manifest_hash, MANIFEST_DATA
  end

  def test_finds_all_entrypoint_files
    js = Snowpacker::Manifest.find_entrypoint(:application, :js)
    js_map = Snowpacker::Manifest.find_entrypoint(:application, :"js.map")
    css = Snowpacker::Manifest.find_entrypoint(:application, :css)
    css_map = Snowpacker::Manifest.find_entrypoint(:application, :"css.map")

    assert_equal js, "/entrypoints/application-9856bc23.js"
    assert_equal js_map, "/entrypoints/application-9856bc23.js.map"
    assert_equal css, "/css/application-4ceb08db.css"
    assert_equal css_map, "/css/application-4ceb08db.css.map"
  end

  def test_find_file
    app = Snowpacker::Manifest.find_file("entrypoints/application.js")
    assert_equal app, "/entrypoints/application-9856bc23.js"

    non_existant = Snowpacker::Manifest.find_file("does-not-exist")
    assert_nil non_existant
  end
end
