require "dr_rockter/md"
require "dr_rockter/job_offer"

module DrRockter
  class JobOffersExport
    include MD
    
    json_attributes :count, :spontaneous_apply_url, ads: [JobOffer]
    
    def self.json_create(object)
      object[:spontaneous_apply_url] = object.delete("spontaneousApplyUrl") # Fixing theAnnoyingCamelCase
      super object
    end
  end
end
