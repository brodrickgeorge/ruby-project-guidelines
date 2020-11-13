class User < ActiveRecord::Base
    has_many :user_songs
    has_many :songs, through: :user_songs


    def all_songs
        my_songs = UserSong.all.select do |song|
            UserSong.user == self
        end
        my_users = my_songs.map do |usersong|
            usersong.user.name
        end
    end




    def self.setup_user
        system "clear"
        prompt = TTY::Prompt.new
        user_input = prompt.select("Please LogIn or SignUp!",
          %w(Login SignUp))
    system "clear"
        if user_input == "SignUp"
          self.create_new_user
        else
          self.find_existing_user
        end
      end
    

      def self.create_new_user
        puts "Please create username:"
        user_name = gets.chomp
    
        if User.find_by(name: user_name)
          puts "Username already taken"
          create_new_user
        else
          
            current_user = User.create(name: user_name)
            puts "Created Account! Welcome, #{current_user.name}!"
        end
            current_user
        end
    
    

      def self.find_existing_user
        puts "Please enter username to login!"
        user_name = gets.chomp
        current_user = User.find_by(name: user_name)
        system "clear"
        if current_user
            puts "Welcome back, #{current_user.name}!"
          else
            puts "Username not found!"
            find_existing_user
          end
          current_user
      end
    


    
end

