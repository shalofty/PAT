# Importing json package
require 'json'

# Powering on PAT
puts "| Personal Assistant Technology |"
puts "To power on PAT simply say 'power on'"
puts "To power down say 'exit'"

input = gets.chomp.upcase

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
    # Parse JSON file for name
    file = File.read('session.json')
    userdata = JSON.parse(file)
    puts "Greetings #{userdata['name']}. How might I be of assistance?"
    puts "To create a list: CREATE"
    puts "To view your list: VIEW"
    puts "To delete list entries: DELETE"
  end

  def self.createlist
    # Method to create a list for user
    file = File.read('todo.json')
    todolist = JSON.parse(file)

    # Asking user how many things to add to list
    puts "How many objects are in your list?"
    amount = gets.chomp.to_i

    # Setting up a while loop to add things to list
    i = 1
    while i <= amount
      puts "Add to your list:"
      todolist[i:] = gets.chomp
      File.write('todo.json', JSON.dump(todolist))
      i += 1
    end
  end

  def self.viewlist
    # Method to view made lists
    file = File.read('todo.json')
    todolist = JSON.parse(file)
    todolist.each do |key, value|
      puts value
    end
  end

  def self.delete
    # Under construction
    # Method for deleting entries
    file = File.read('todo.json')
    todolist = JSON.parse(file)

    # What's to be deleted
    puts "What do you want to delete?"
    dele = get.chomp

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

if select == "CREATE"
UserInterface.createlist
elsif select == "VIEW"
UserInterface.viewlist
elsif select == "DELETE"
UserInterface.delete
else
puts "...I'll be here when you need me."
end