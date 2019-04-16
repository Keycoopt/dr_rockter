require "forwardable"

require "dr_rockter/md"
require "dr_rockter/address"
require "dr_rockter/entity"
require "dr_rockter/picture"
require "dr_rockter/recruiter"
require "dr_rockter/salary"

module DrRockter
  class JobOffer
    extend MD, Forwardable
    
    json_attributes :locale, :reference, :catch_phrase, :contract_type, :contract_duration,
                    :service, :experience_level, :education_level, :title, :description, :profile, :skills,
                    published_at: :datetime, internal_apply_url: :url, apply_url: :url,
                    salary: Salary, pictures: [Picture], address: Address, entity: Entity,
                    referent_recruiter: Recruiter
  
   def_delegator :@entity, :public_name, :entity_name
   
   def referent_recruiter_name
     @referent_recruiter.full_name unless @referent_recruiter.nil?
   end
  end
end
