require "dr_rockter/md"

module DrRockter
  class Picture
    include MD
    
    json_attributes default: :url, wide: :url
  end
end
