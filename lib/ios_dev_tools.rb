
module IOSDevTools

  autoload :VERSION,              'ios_dev_tools/version'
  #
  autoload :ApplicationBundle,    'ios_dev_tools/model/application_bundle'
  autoload :ProvisioningProfile,  'ios_dev_tools/model/provisioning_profile'
  autoload :InfoPlist,            'ios_dev_tools/model/info_plist'
  autoload :ApplicationIcon,      'ios_dev_tools/model/application_icon'
  autoload :VerificationResult,   'ios_dev_tools/model/verification_result'
  #
  autoload :Pack,                 'ios_dev_tools/commands/pack'
  autoload :Sign,                 'ios_dev_tools/commands/sign'
  autoload :Verify,               'ios_dev_tools/commands/verify'
  autoload :Tool,                 'ios_dev_tools/commands/tool'
  autoload :Help,                 'ios_dev_tools/commands/help'
  #
  autoload :VerifyDefaultImage,     'ios_dev_tools/verifications/verify_default_image'
  autoload :VerifyEmbeddedProfile,  'ios_dev_tools/verifications/verify_embedded_profile'
  autoload :VerifyForbiddenSymbols, 'ios_dev_tools/verifications/verify_forbidden_symbols'
  autoload :VerifyHasExecutable,    'ios_dev_tools/verifications/verify_has_executable'
  autoload :VerifyIcons,            'ios_dev_tools/verifications/verify_icons'
  autoload :VerifyIsSigned,         'ios_dev_tools/verifications/verify_is_signed'

end