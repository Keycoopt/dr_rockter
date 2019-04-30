require "delegate"
require "date"
require "json"

module DrRockter
  class Candidate < SimpleDelegator
    GENDERS = [MALE = 1, FEMALE = 2]
    
    attr_accessor :reference, :consent_date, :origin, :locale, :message
    
    def initialize
      @personnal_info = PersonnalInfo.new
      super @personnal_info
    end
    
    def as_json(*args)
      {
        "reference"          => @reference,
        "consent_date"       => @consent_date.to_date,
        "s_o"                => @origin,
        "locale"             => @locale,
        "ApplicationMessage" => Message.new(@message),
        "ApplicationProfile" => @personnal_info,
      }
    end
    
    def to_json(*args)
      as_json.to_json *args
    end
    
    class PersonnalInfo
      attr_accessor :gender, :first_name, :last_name, :email, :phone, :job, :street, :zip_code, :city
      
      
      def as_json(*args)
        {
          "gender"        => @gender.to_s,
          "firstName"     => @first_name,
          "lastName"      => @last_name,
          "email"         => @email,
          "phoneNumber"   => @phone,
          "job"           => @job,
          "addressStreet" => @street,
          "addressZip"    => @zip_code,
          "addressCity"   => @city
        }
      end
      
      def to_json(*args)
        as_json.to_json *args
      end
    end
    private_constant :PersonnalInfo
    
    class Message
      def initialize(content)
        @content = content
      end
      
      def as_json(*args)
        {
          "message": @content
        }
      end
      
      def to_json(*args)
        as_json.to_json *args
      end
    end
    private_constant :Message
  end
end
