require "forwardable"

require "dr_rockter/md"
require "dr_rockter/address_parts"

module DrRockter
  class Address
    extend MD, Forwardable
    
    json_attributes :formatted, :position, parts: AddressParts
    def_delegators :@parts, :street, :zip, :city, :county, :state, :country
  end
end
