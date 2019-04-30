require "dr_rockter/md"

module DrRockter
  class AddressParts
    include MD
    
    json_attributes :street, :zip, :city, :county, :state, :country
  end
end
