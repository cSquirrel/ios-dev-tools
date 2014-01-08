require 'test/unit'
require 'ios_dev_tools'

class VerifyIconsTest < Test::Unit::TestCase

  include IOSDevTools

  def test_all_icons

      # prepare
      verifier=VerifyIcons.new

      # execute
      icons_arr=verifier.all_icons

      # verify
      assert_not_nil icons_arr
      assert_equal 23, icons_arr.count

  end

  def test_ios4_ipad_icons

    # prepare
    verifier=VerifyIcons.new

    # execute
    icons_arr=verifier.ios_specific_icons :IOS4, :IPAD

    # verify
    assert_not_nil icons_arr
    assert_equal 6, icons_arr.count

  end

  def test_ios5_ipad_icons

    # prepare
    verifier=VerifyIcons.new

    # execute
    icons_arr=verifier.ios_specific_icons :IOS5, :IPAD

    # verify
    assert_not_nil icons_arr
    assert_equal 6, icons_arr.count

  end

  def test_ios7_ipad_icons

    # prepare
    verifier=VerifyIcons.new

    # execute
    icons_arr=verifier.ios_specific_icons :IOS7, :IPAD

    # verify
    assert_not_nil icons_arr
    assert_equal 6, icons_arr.count

  end

  def test_ios4_iphone_icons

    # prepare
    verifier=VerifyIcons.new

    # execute
    icons_arr=verifier.ios_specific_icons :IOS4, :IPHONE

    # verify
    assert_not_nil icons_arr
    assert_equal 6, icons_arr.count

  end

  def test_ios5_iphone_icons

    # prepare
    verifier=VerifyIcons.new

    # execute
    icons_arr=verifier.ios_specific_icons :IOS5, :IPHONE

    # verify
    assert_not_nil icons_arr
    assert_equal 6, icons_arr.count

  end

  def test_ios7_iphone_icons

    # prepare
    verifier=VerifyIcons.new

    # execute
    icons_arr=verifier.ios_specific_icons :IOS7, :IPHONE

    # verify
    assert_not_nil icons_arr
    assert_equal 3, icons_arr.count

  end
end