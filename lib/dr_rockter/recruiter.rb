require "dr_rockter/md"

module DrRockter
  class Recruiter
    include MD
    
    json_attributes :firstname, :lastname, picture_url: :url
    
    def full_name
      [firstname, lastname].join " "
    end
  end
end
