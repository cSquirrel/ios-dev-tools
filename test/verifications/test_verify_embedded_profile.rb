require 'test/unit'
require 'ios_dev_tools'

class VerifyEmbeddedProfileTest < Test::Unit::TestCase

  include IOSDevTools

  def test_verify_pass

      # prepare
      app_bundle=ApplicationBundle.new "test_resources/DummyApp.app"
      verifier=VerifyEmbeddedProfile.new

      # execute
      verification_result=verifier.verify app_bundle

      # verify
      assert_not_nil verification_result
      assert_equal VerifyEmbeddedProfile, verification_result.verificator
      assert_equal :VERIFICATION_PASSED, verification_result.status
      assert_equal "Verify embedded profile exists", verification_result.title
      assert_nil verification_result.comments

  end

  def test_verify_failed

    # prepare
    app_bundle=ApplicationBundle.new "test_resources/DummyApp-no.prov.profile.app"
    verifier=VerifyEmbeddedProfile.new

    # execute
    verification_result=verifier.verify app_bundle

    # verify
    assert_not_nil verification_result
    assert_equal VerifyEmbeddedProfile, verification_result.verificator
    assert_equal :VERIFICATION_FAILED, verification_result.status
    assert_equal "Verify embedded profile exists", verification_result.title
    assert_not_nil "File not found test_resources/DummyApp-no.prov.profile.app/embedded.mobileprovision", verification_result.comments

  end

end