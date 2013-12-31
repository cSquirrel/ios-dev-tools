
module IOSDevTools

  autoload :VERSION,              'ios_dev_tools/version'
  autoload :ApplicationBundle,    'ios_dev_tools/model/application_bundle'
  autoload :ProvisioningProfile,  'ios_dev_tools/model/provisioning_profile'
  autoload :InfoPlist,            'ios_dev_tools/model/info_plist'
  autoload :Pack,                 'ios_dev_tools/commands/pack'
  autoload :Sign,                 'ios_dev_tools/commands/sign'
  autoload :Verify,               'ios_dev_tools/commands/verify'
  autoload :Tool,                 'ios_dev_tools/commands/tool'
  autoload :Help,                 'ios_dev_tools/commands/help'

end