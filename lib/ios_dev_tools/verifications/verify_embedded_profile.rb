#
#
#
module IOSDevTools

  #
  #
  #
  class VerifyEmbeddedProfile

  def verify application_bundle

    mobileprovision_path=application_bundle.mobileprovision_path

    result=VerificationResult.new
    result.verificator=self.class
    result.title="Verify embedded profile exists"

    if File.exist? mobileprovision_path
      result.status=:VERIFICATION_PASSED
      result.comments=nil
    else
      result.status=:VERIFICATION_FAILED
      result.comments="File not found #{mobileprovision_path}"
    end

    return result
  end

  end
end
