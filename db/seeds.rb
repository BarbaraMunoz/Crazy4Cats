# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'


# Seed users
user1 = User.find_or_create_by(email: 'user1@example.com') do |user|
    user.password = 'password'
    user.username = 'user1'
end

user2 = User.find_or_create_by(email: 'user2@example.com') do |user|
    user.password = 'password'
    user.username = 'user2'
end

users = [user1, user2]

# Seed posts and comments
users.each do |user|
    3.times do
        post = user.posts.create!(
            title: Faker::Lorem.sentence,
            content: Faker::Lorem.paragraph
        )

        if post.id == 1
            image_file_path = Rails.root.join('app', 'assets', 'images', 'post1.jpg')
        elsif post.id == 2
            image_file_path = Rails.root.join('app', 'assets', 'images', 'post2.jpg')
        else
            image_file_path = nil
        end

        if image_file_path
            image_file = File.open(image_file_path)

            post.images.attach(io: image_file, filename: 'image.jpg', content_type: 'image/jpeg')

            image_file.close
        end

        guest_user = User.new(username: 'Guest')  # Crear un usuario "invitado" o "guest"
        2.times do
            post.comments.create!(
                content: Faker::Lorem.sentence,
                display_name: Faker::Name.name  # Generar un nombre aleatorio para el comentario
            )
        end
    end
end


#rails db:seed