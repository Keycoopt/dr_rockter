require "dr_rockter/md"
require "dr_rockter/node_manager_info"
require "dr_rockter/hierarchy"

module DrRockter
  class Entity
    include MD
    
    json_attributes :public_name, :around, :internal_ref, :address, manager: NodeManagerInfo, hierarchy: Hierarchy

    def hierarchy_node_name(column_name)
      hierarchy[column_name]&.public_name
    end
  end
end
