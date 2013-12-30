require 'test/unit'
require 'ios_dev_tools'

class ApplicationBundleTest < Test::Unit::TestCase

  def test_create_with_not_existing_folder

    assert_raise RuntimeError do
      IOSDevTools::ApplicationBundle.new "dummy_folder"
    end

  end

end