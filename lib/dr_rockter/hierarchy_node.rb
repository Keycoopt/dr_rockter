require "dr_rockter/md"

module DrRockter
  class HierarchyNode
    include MD
    
    json_attributes :depth, :column_name, :public_name
  end
end
