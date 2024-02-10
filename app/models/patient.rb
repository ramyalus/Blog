class Patient < ApplicationRecord
	has_many :appointments
	has_many :physicians, through: :appointments
end


=begin 
p = Physician.first
p.patients

select * from patients inner join appointments on patients.id = appointments.patients where appointments.physician_id = p.id;

Physician
1, 2, 3

Patient
1, 2, 3

appointments
patient_id 1, physician_id 1 
patient_id 2, physician_id 1

p = Patient.last
p.physicians
select ph.name as physician_name, p.name as patient_name from physicians ph inner join appointments ap on ph.id = ap.physician_id where ap.patient_id = p.id;

p.appointments.create(physician_id: 123)

habtm 

p.physicians.create(name: 'shiva')


date  = Time.now - 2.days
physician = 1

results = ActiveRecord::Base.connection.execute("select ap.id, p.name, ph.name, ap.appointment_date from appointments ap 
inner join patients p on p.id = ap.patient_id
inner join physicians ph on ph.id = ap.physician_id
where ap.appointment_date > '2024-02-02 15:40:18 +0530' and ap.physician_id = 10;")

results = ActiveRecord::Base.connection.execute("select ph.name as physician_name, p.name as patient_name from physicians ph inner join appointments ap on ph.id = ap.physician_id  inner join patients p on p.id = ap.patient_id where ap.patient_id = p.id;")

assembly habtm :parsts
part habtm :assemblies

assemblies_parts

database


Polymorphic associations

Employee -
	name, email, age, image

	has_many :images, as: :imageable

Product 
	name, price, image
	p = Product.first 
	p.image 

	has_many :images, as: :images

Picture
  imageable_id - employee.id
  imageable_type - Employee
  imageurl - 

	belongs_to :imageable, polymorphic: true


  imageable_id - product.id
  imageable_type - Product
  imageurl - 

	




=end