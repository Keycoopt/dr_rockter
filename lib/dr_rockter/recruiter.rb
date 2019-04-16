require "dr_rockter/md"

module DrRockter
  class Recruiter
    extend MD
    
    json_attributes :firstname, :lastname, picture_url: :url
    
    def full_name
      [firstname, lastname].join " "
    end
  end
end
