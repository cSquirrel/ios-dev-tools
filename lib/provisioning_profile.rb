class ProvisioningProfile

  attr_accessor :profile_location

  def initialize profile_location

    raise "Profisioning profile file \"#{profile_location}\" doesn't exist" if not File.exists? profile_location

    @profile_location=profile_location

    yield self if block_given?

  end

  def application_identifier
    `egrep -a -A 2 application-identifier "#{@profile_location}" | grep string | sed -e 's/<string>//' -e 's/<\\/string>//' -e 's/ //' | awk '{split($0,a,"."); i = length(a); for(ix=2; ix <= i;ix++){ s=s a[ix]; if(i!=ix){s=s "."};} print s;}'`.strip
  end

  def is_compatible_with_bundle_id bundle_id
    bundle_id_prefix=application_identifier.sub(/\*$/,"")
    bundle_id.start_with? bundle_id_prefix
  end

end