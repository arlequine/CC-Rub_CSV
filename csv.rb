#use the CSV format. Information read and know overwrite files in this format
#'faker' and 'CSV' are required
require 'faker'
require 'csv'
class Person 
	#Create the Person class with the following attribute:
	#first_name, last_name, email, phone, created_at
	#read an write attributes
	attr_accessor :first_name, :last_name, :email, :phone, :created_at
	
	#it initialize'Person' class
	def initialize(first_name, last_name, email, phone, created_at)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@phone = phone
		@created_at = created_at
	end	
end

#it generate random person attributes
def fake_info
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	email = Faker::Internet.email
	phone = Faker::PhoneNumber.cell_phone
	created_at = Time.now
	#it creates an object with randome attributes
	Person.new(first_name, last_name, email, phone, created_at)
end
#creat an array of objects person
def people(num)
	people = []
	num.times do 
		people << fake_person
	end
	p people
end

#it creates CSV file
class PersonWriter
	#it initialize 'PersonWriter' class
	def initialize(file, people_array)
		@file = file
		@people_array = people_array
	end
	#CSV file is created with attributes of object
	def create_csv
		CSV.open(@file, "wb") do |csv|
			@people_array.each do |person|
				csv << [person.first_name, person.last_name, person.email, person.phone, person.created_at]
			end
		end
	end
end
#it reads csv file
class PersonParser
	#initialize PersonParser class
	def initialize(str_file)
	@str_file = str_file
	p str_file
	end
	#it creates an instance of object person in an array
	def parse_file
		people_list = []
		CSV.foreach(@str_file) do |row|
			p row
			people_list << Person.new(row[0], row[1], row[2], row[3], row[4])
		end
		p people_list(0..9)
	end
end

#Driver Code
person_writer = PersonWriter.new("people.csv", people(20))
person_writer.create_csv
parser = PersonParser.new('people.csv')
p parser.parse_file