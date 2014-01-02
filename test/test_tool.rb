require 'test/unit'
require 'ios_dev_tools'

class ToolTest < Test::Unit::TestCase

  def test_simple_command_name_to_class_name

    result=IOSDevTools::Tool.command_name_to_class_name "command"
    assert_equal "IOSDevTools::Command", result

  end

  def test_snake_command_name_to_class_name

      result=IOSDevTools::Tool.command_name_to_class_name "snake_command"
      assert_equal "IOSDevTools::SnakeCommand", result

  end

  def test_command_name_to_class

    result=IOSDevTools::Tool.command_name_to_class "sign"
    assert_not_nil result
    assert_equal IOSDevTools::Sign.class, result.class

  end

  def test_invalid_command_name_to_class

    result=IOSDevTools::Tool.command_name_to_class "invalid"
    assert_nil result

  end

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