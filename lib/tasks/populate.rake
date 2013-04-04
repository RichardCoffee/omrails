namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
#    10.times do |n|
#      puts "[Debug] creating user #{n+1} of 10"
#      name = Faker::Name.name
#      email = "user-#{n+1}@example.com"
#      password = "password"
#      User.create!( name: name,
#                    email: email,
#                    password: password,
#                    password_confirmation: password )
#    end

    User.all.each do |user|
      if user.id > 8
        puts "[Debug] uploading images for user #{user.id} of #{User.last.id}"
        10.times do |n|
# had to use '*.*' instead of '*' since symlink had subdirectories
# can I use an exclude? Or maybe some sort of RegExp?
          image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*.*')).sample)
          description = %w(cool awesome crazy wow adorable incredible).sample
          puts "[Debug] #{n+1} - #{image}" # how do I get image path?
# Paperclip didn't like some of th image formats
# Validation failed: Image Paperclip::Errors::NotIdentifiedByImageMagickError
          user.pins.create!(image: image, description: description)
        end
      end
    end
  end
end
