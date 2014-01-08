#
#
#
module IOSDevTools

  #
  #
  #
  class VerifyIcons

    def verify application_bundle
      puts "VerifyIcons"
    end

    def ios_specific_icons ios_identifier, device_type
      icons=all_icons
      icons.map! do |i|

        result=nil
        result=i if i.ios_identifier==ios_identifier and i.device_type.include? device_type
      end
      icons.compact!
      icons
    end

    def all_icons

      [
          # ios4
          ApplicationIcon.new(:IOS4, [:IPHONE, :IPAD], false, 50, 50, "Non retina Spotlight icon iPhone & iPad iOS4"),
          ApplicationIcon.new(:IOS4, [:IPHONE, :IPAD], false, 100, 100, "Retina Spotlight icon iPhone & iPad iOS4"),
          ApplicationIcon.new(:IOS4, [:IPHONE, :IPAD], false, 29, 29, "Non retina Settings icon iPhone & iPad iOS4"),
          ApplicationIcon.new(:IOS4, [:IPHONE, :IPAD], false, 58, 58, "Retina Settings icon iPhone & iPad iOS4"),
          # ios5
          ApplicationIcon.new(:IOS5, [:IPHONE, :IPAD], false, 50, 50, "Non retina Spotlight icon iPhone & iPad iOS5"),
          ApplicationIcon.new(:IOS5, [:IPHONE, :IPAD], false, 100, 100, "Retina Spotlight icon iPhone & iPad iOS5"),
          ApplicationIcon.new(:IOS5, [:IPHONE, :IPAD], false, 29, 29, "Non retina Settings icon iPhone & iPad iOS5"),
          ApplicationIcon.new(:IOS5, [:IPHONE, :IPAD], false, 58, 58, "Retina Settings icon iPhone & iPad iOS5"),
          # ios7
          ApplicationIcon.new(:IOS7, [:IPHONE, :IPAD], false, 80, 80, "Retina Spotlight icon iPhone & iPad iOS7"),
          ApplicationIcon.new(:IOS7, [:IPHONE, :IPAD], false, 58, 58, "Retina Settings icon iPhone & iPad iOS7"),

          # iphone only
          # ios4
          ApplicationIcon.new(:IOS4, :IPHONE, true, 57, 57, "Non retina App icon iPhone iOS4"),
          ApplicationIcon.new(:IOS4, :IPHONE, true, 114, 114, "Retina App icon iPhone iOS4"),
          # ios5
          ApplicationIcon.new(:IOS5, :IPHONE, true, 57, 57, "Non retina App icon iPhone iOS5"),
          ApplicationIcon.new(:IOS5, :IPHONE, true, 114, 114, "Retina App icon iPhone iOS5"),
          # ios7
          ApplicationIcon.new(:IOS7, :IPHONE, true, 120, 120, "Retina App icon iPhone iOS7"),

          # ipad only
          # ios4
          ApplicationIcon.new(:IOS4, :IPAD, true, 72, 72, "Retina App icon iPad iOS4"),
          ApplicationIcon.new(:IOS4, :IPAD, true, 144, 144, "Retina App icon iPad iOS4"),
          # ios5
          ApplicationIcon.new(:IOS5, :IPAD, true, 72, 72, "Retina App icon iPad iOS5"),
          ApplicationIcon.new(:IOS5, :IPAD, true, 144, 144, "Retina App icon iPad iOS5"),
          # ios7
          ApplicationIcon.new(:IOS7, :IPAD, true, 76, 76, "Retina App icon iPad iOS7"),
          ApplicationIcon.new(:IOS7, :IPAD, true, 152, 152, "Retina App icon iPad iOS7"),
          ApplicationIcon.new(:IOS7, :IPAD, false, 40, 40, "Non retina Spotlight icon iPad iOS7"),
          ApplicationIcon.new(:IOS7, :IPAD, false, 29, 29, "Non retina Settings icon iPad iOS7"),
      ]

    end

  end
end
