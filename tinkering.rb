# Importing json package
require 'json'

# Powering on PAT
puts "| Personal Assistant Technology |"
puts "To power on PAT simply say 'power on'"
puts "To power down say 'exit'"

input = gets.chomp.upcase

# Encapsulate script within a while loop to keep software running until user prompts exit
prompt = 0
while prompt < 1

  # Creating introduction for new users who haven't used system
  def introductions
    puts "What do you like to be called?"
    name = gets.chomp

    puts "Hello, #{name}! I'm your Personal Productivity Assistant."
    puts "I've registered you as the primary user in my database."
    puts "My name is PAT, short for Personal Assistant Technology."
    puts "Right now I'm very simple. I can only help you compile a To-Do list."
    puts "Although in future versions I may be able to do other things..."
    puts "Maybe we can help each other become better versions of ourselves."
    puts "Let me know if I can be of some assistance to you."

    # Opening JSON file
    # This essentially acts as a "save" file when combined with logic
    # For example, using an if statement in regards to the value of the session key
    # A value of 0 implies the user is new
    file = File.read('session.json')
    userdata = JSON.parse(file)
    userdata['session'] += 1
    userdata['name'] = name
    File.write('session.json', JSON.dump(userdata))
  end

  # User menu
  class UserInterface

    def self.mainmenu
      puts "Main Menu"
      puts "To create a list: CREATE"
      puts "To view your list: VIEW"
      puts "To delete list entries: DELETE\n"
    end

    def self.createlist
      # Method to create a list for user
      file = File.read('todo.json')
      todolist = JSON.parse(file)

      # Asking user how many things to add to list
      puts "How many objects are in your list?"
      amount = gets.chomp.to_i
      puts "\n"

      # Setting up a while loop to add things to list
      key = 1
      while key <= amount
        puts "Add to your list:"
        todolist[key] = gets.chomp
        File.write('todo.json', JSON.dump(todolist))
        i += 1
      end
      puts "Here is your list:\n"
      todolist.each do |key, value|
        puts value
      end
      puts "\n"
    end

    def self.viewlist
      # Method to view made lists
      file = File.read('todo.json')
      todolist = JSON.parse(file)
      todolist.each do |key, value|
        puts value
      end
      puts "\n"
    end

    def self.addItem
      # Method to add item to list
      file = File.read('todo.json')
      todolist = JSON.parse(file)
      puts "What would you like to add?"
      listlength = todolist.length
      entry = gets.chomp
      newkey = listlength
      todolist[newkey] = entry
      todolist.merge(todolist)
      puts "Does this look correct?"
      todolist.each do |key, value|
        puts value
      end
      File.write('todo.json', JSON.dump(todolist))
      puts "\n"
    end

    def self.delete
      # Under construction
      # Method for deleting entries
      file = File.read('todo.json')
      todolist = JSON.parse(file)

      # What's to be deleted
      puts "Here is your current list:"
      todolist.each do |key, value|
        puts value
      end
      puts "\n"
      puts "What would you like to delete?"
      dele = gets.chomp
      todolist.delete_if { |key, value| value == dele }
      puts "Entry successfully deleted."
      puts "\n"
      puts "Here is your updated list:"
      todolist.each do |key, value|
        puts value
      end
      puts "\n"
      File.write('todo.json', JSON.dump(todolist))
    end

  end
  # Load JSON file
  data = File.read('session.json')
  session_data = JSON.parse(data)

  # Calling introductions method for new users
  introductions if input == "POWER ON" and session_data['session'] == 0

  # Calling user menu for existing user
  UserInterface.mainmenu if input == "POWER ON" and session_data['session'] > 0

  select = gets.chomp.upcase

  # Calling methods based on select input
  if select == "CREATE"
    UserInterface.createlist

  elsif select == "VIEW"
    UserInterface.viewlist

  elsif select == "ADD"
    UserInterface.addItem

  elsif select == "DELETE"
    UserInterface.delete

  elsif select == "EXIT"
    prompt += 1

  else
  puts "...I'll be here when you need me."

  end
end