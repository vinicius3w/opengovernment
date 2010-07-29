module OpenGov
  class Photos < Resources
    class << self
      def import!
        puts "Importing photos from VoteSmart"
        i = 0
        Person.with_votesmart_id.with_current_role.each do |person|
          begin
            bio = GovKit::VoteSmart::Bio.find(person.votesmart_id)
            i += 1

            # puts "Updating #{person.to_param}"
            unless bio.photo.blank?
              person.votesmart_photo_url = bio.photo
              #puts "Updating #{person.to_param}"
              person.save
            else
              puts "Skipping..no photo found"
            end

          rescue GovKit::ResourceNotFound
            puts "No bio found for #{person.to_param}"
          end
        end
      end
    end
  end
end
