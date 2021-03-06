require "dr_rockter/md"

module DrRockter
  class NodeManagerInfo
    extend MD
    
    json_attributes :section_title, :section_body, :firstname, :lastname, :position, picture_url: :url
  end
end
