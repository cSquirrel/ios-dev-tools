require 'test/unit'
require 'ios_dev_tools'

class ApplicationBundleTest < Test::Unit::TestCase

  include IOSDevTools

  def test_create_with_app_folder

      app_bundle=ApplicationBundle.new "test_resources/DummyApp.app"

      assert_not_nil app_bundle
      info_plist=app_bundle.info_plist
      assert_not_nil info_plist
      assert_equal "Bundle display name", app_bundle.info_plist.display_name
      assert_equal "com.csquirrel.app.DummyApp", app_bundle.info_plist.bundle_id

  end

  def test_create_with_not_existing_folder

    assert_raise RuntimeError do
      ApplicationBundle.new "dummy_folder"
    end

  end

  def test_has_mobileprovision

    app_bundle=ApplicationBundle.new "test_resources/DummyApp.app"
    mobileprovision_path=app_bundle.mobileprovision_path
    assert_not_nil mobileprovision_path

  end

end