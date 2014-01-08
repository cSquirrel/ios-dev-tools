require 'test/unit'
require 'ios_dev_tools'

class VerifyEmbeddedProfileTest < Test::Unit::TestCase

  include IOSDevTools

  # NOTE: This test requires valid profile to be present. Is it safe to add the profile to public repo ?
  # Option: Don't add profile to the repo. Use reference to local profile instead.
  # This will require some preparation before test can be exexuted but sound like a smarter choice.
  def disabled_test_verify_pass

    puts "test_verify_pass"

      # prepare
      app_bundle=ApplicationBundle.new "test_resources/DummyApp.app"
      verifier=VerifyIsSigned.new

      # execute
      verification_result=verifier.verify app_bundle

      # verify
      assert_not_nil verification_result
      assert_equal VerifyIsSigned, verification_result.verificator
      assert_equal :VERIFICATION_PASSED, verification_result.status
      assert_equal "Verify the bundle is signed", verification_result.title
      assert_nil verification_result.comments

  end

  def test_verify_failed

    # prepare
    app_bundle=ApplicationBundle.new "test_resources/DummyApp-no.prov.profile.app"
    verifier=VerifyIsSigned.new

    # execute
    verification_result=verifier.verify app_bundle

    # verify
    assert_not_nil verification_result
    assert_equal VerifyIsSigned, verification_result.verificator
    assert_equal :VERIFICATION_FAILED, verification_result.status
    assert_equal "Verify the bundle is signed", verification_result.title
    assert_not_nil "Invalid signature", verification_result.comments

  end

end