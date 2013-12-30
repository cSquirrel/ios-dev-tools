require 'test/unit'
require 'ios_dev_tools'

class ProvisioningProfileTest < Test::Unit::TestCase

  def test_create_with_not_existing_folder

    assert_raise RuntimeError do
      IOSDevTools::ProvisioningProfile.new "dummy_folder"
    end

  end

end