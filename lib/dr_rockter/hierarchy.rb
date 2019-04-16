require "delegate"

require "dr_rockter/hierarchy_node"

module DrRockter
  class Hierarchy < DelegateClass(Hash)
    def self.json_creatable?
      true
    end
    
    def self.json_create(object)
      new(*object.map { |o| HierarchyNode.json_create(o) })
    end
    
    def initialize(*nodes)
      super nodes.each_with_object({}) { |n, h| h[n.column_name] = n }
    end
    
    def at_depth(n)
      detect { |_, node| node.depth == n.to_i }.last
    end
    
    def at_depths(*n)
      select { |_, node| n.map(&:to_i).include? node.depth }.map &:last
    end
  end
end
