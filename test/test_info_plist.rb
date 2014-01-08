require 'test/unit'
require 'ios_dev_tools'

class InfoPlistTest < Test::Unit::TestCase

  include IOSDevTools

  def setup
    @info_plist=InfoPlist.new "test_resources/DummyApp.app/Info.plist"
  end

  def test_create_with_file

      assert_equal "Bundle display name", @info_plist.display_name
      assert_equal "com.csquirrel.app.DummyApp", @info_plist.bundle_id

  end

  def test_create_with_not_existing_file

    assert_raise RuntimeError do
      ApplicationBundle.new "dummy.file.plist"
    end

  end

  def test_display_name

    assert_equal "Bundle display name", @info_plist.display_name

  end

  def test_bundle_id

    assert_equal "com.csquirrel.app.DummyApp", @info_plist.bundle_id

  end

  def test_xcode_build_number

    assert_equal "4H1003", @info_plist.xcode_build_number

  end

  def test_xcode_version

    assert_equal "0462", @info_plist.xcode_version

  end

  def test_device_family

    assert_equal ["1"], @info_plist.device_family

  end

  def test_bundle_icon_file

    assert_equal "Icon.png", @info_plist.bundle_icon_file

  end

  def test_bundle_icon_files

    assert_equal ["Icon.png", "Icon@2x.png", "Icon-60.png", "Icon-60@2x.png"], @info_plist.bundle_icon_files

  end

  def test_bundle_version

    assert_equal "APPL", @info_plist.bundle_version

  end

  def test_bundle_short_version

    assert_equal "1.0.0", @info_plist.bundle_short_version

  end

  def test_app_fonts

    assert_equal ["Font1", "Font2", "Font3", "Font4"], @info_plist.app_fonts

  end

end