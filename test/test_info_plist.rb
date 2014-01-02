require 'test/unit'
require 'ios_dev_tools'

class InfoPlistTest < Test::Unit::TestCase

  def test_create_with_file

      info_plist=IOSDevTools::InfoPlist.new "test_resources/DummyApp.app/Info.plist"

      assert_equal "Dummy Bundle", info_plist.display_name
      assert_equal "com.csquirrel.dummy.bundle", info_plist.bundle_id

  end

  def test_create_with_not_existing_file

    assert_raise RuntimeError do
      IOSDevTools::ApplicationBundle.new "dummy.file.plist"
    end

  end

end