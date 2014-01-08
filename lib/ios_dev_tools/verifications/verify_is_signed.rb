#
#
#
module IOSDevTools

  #
  #
  #
  class VerifyIsSigned

  def verify application_bundle

    identity=application_bundle.current_identity

    result=VerificationResult.new
    result.verificator=self.class
    result.title="Verify the bundle is signed"

    if identity==:INVALID_SIGNATURE
      result.status=:VERIFICATION_FAILED
      result.comments="Invalid signature"
    else
      result.status=:VERIFICATION_PASSED
      result.comments=nil
    end

    return result

  end

  end
end
