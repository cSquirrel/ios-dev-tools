require 'test/unit'
require 'ios_dev_tools'

class ApplicationBundleTest < Test::Unit::TestCase

  def test_create_with_app_folder

      app_bundle=IOSDevTools::ApplicationBundle.new "test_resources/DummyApp.app"

      assert_not_nil app_bundle
      info_plist=app_bundle.info_plist
      assert_not_nil info_plist
      assert_equal "Dummy Bundle", app_bundle.info_plist.display_name
      assert_equal "com.csquirrel.dummy.bundle", app_bundle.info_plist.bundle_id

  end

  def test_create_with_not_existing_folder

    assert_raise RuntimeError do
      IOSDevTools::ApplicationBundle.new "dummy_folder"
    end

  end

end