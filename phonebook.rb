# PAT's phonebook

# Importing tinkering
require_relative './tinkering'

# This UI functions differently than the class UserInterface in tinkering.rb
# Instead of using a while loop I call the pbmenu function at the end of other functions
class PhoneBookUI
  # Creating addcontact function
  def self.addcon
    file = File.read('phonebook.json')
    phnbk = JSON.parse(file)

    puts "First name:"
    fname = gets.chomp

    puts "Last name:"
    lname = gets.chomp

    fullname = fname + " " + lname

    puts "Area code:"
    areacode = gets.chomp

    puts "Phone number:"
    phonenum = gets.chomp

    fullnum = areacode + " " + phonenum

    phnbk[fullname] = fullnum
    phnbk.merge(phnbk)
    puts "Does this look correct?"
    phnbk.each do |key, value|
      puts key
      puts value
    end
    File.write('phonebook.json', JSON.dump(phnbk))
    puts "\n"
    self.pbmenu
  end

  # creating viewcontact function
  def self.viewcon
    file = File.read('phonebook.json')
    phnbk = JSON.parse(file)

    phnbk.each {|key, value| puts "#{key}: #{value}\n"}
    puts "\n"
    self.pbmenu
  end

  def self.pbmenu
    # prompt = 0
    # while prompt < 1
      puts "PhoneBook Menu"
      puts "To add a contact: ADD"
      puts "To view contacts: VIEW"
      puts "Return to previous menu: RETURN\n"

      pbselect = gets.chomp.upcase

      if pbselect == "ADD"
        PhoneBookUI.addcon
      elsif pbselect == "VIEW"
        PhoneBookUI.viewcon
      elsif pbselect == "RETURN"
        UserInterface.mainmenu
      else
        self.pbmenu
      end
  end
end
