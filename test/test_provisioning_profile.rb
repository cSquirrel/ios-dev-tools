require 'test/unit'
require 'ios_dev_tools'

class ProvisioningProfileTest < Test::Unit::TestCase

  def test_english_hello
    assert_equal "hello world",
                 Hola.hi("english")
  end

end