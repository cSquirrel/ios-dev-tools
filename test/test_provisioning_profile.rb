require 'test/unit'
require 'ios_dev_tools'

class ProvisioningProfileTest < Test::Unit::TestCase

  include IOSDevTools

  def test_create_with_not_existing_folder

    assert_raise RuntimeError do
      ProvisioningProfile.new "dummy_folder"
    end

  end

end