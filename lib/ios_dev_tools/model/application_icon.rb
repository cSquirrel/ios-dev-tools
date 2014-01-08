
  #
  #
  #
  class ApplicationIcon

    attr_accessor :ios_identifier
    attr_accessor :device_type
    attr_accessor :is_mandatory
    attr_accessor :width
    attr_accessor :height
    attr_accessor :description

    def initialize ios_identifier, device_type, is_mandatory, width, height, description
      self.ios_identifier=ios_identifier
      self.device_type=[device_type].flatten
      self.is_mandatory=is_mandatory
      self.width=width
      self.height=height
      self.description=description
    end

  end