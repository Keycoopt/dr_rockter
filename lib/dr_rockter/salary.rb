require "dr_rockter/md"

module DrRockter
  class Salary
    include MD
    
    json_attributes :min, :max, :kind, :rate_type, :variable
  end
end
