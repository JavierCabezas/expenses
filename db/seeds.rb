# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'Feña')
User.create(username: 'Pato')
User.create(username: 'Mari')
User.create(username: 'Javier')

ExpenseType.create(name: 'Electricity', is_bill: true, is_fixed_cost: false)
ExpenseType.create(name: 'Water', is_bill: true, is_fixed_cost: false)
ExpenseType.create(name: 'Gas', is_bill: true, is_fixed_cost: false)
ExpenseType.create(name: 'Bread', is_bill: false, is_fixed_cost: false)
ExpenseType.create(name: 'Fruits / Vegetables', is_bill: false, is_fixed_cost: false)
ExpenseType.create(name: 'Supermarket', is_bill: false, is_fixed_cost: false)
ExpenseType.create(name: 'Internet', is_bill: true, is_fixed_cost: true)


Month.create(month: 10, year: 2015, payed: false)
Month.create(month: 11, year: 2015, payed: false)
Month.create(month: 12, year: 2015, payed: false)
Month.create(month: 1,  year: 2016, payed: false)
Month.create(month: 2,  year: 2016, payed: false)
Month.create(month: 3,  year: 2016, payed: false)
Month.create(month: 4,  year: 2016, payed: false)
Month.create(month: 5,  year: 2016, payed: false)
Month.create(month: 6,  year: 2016, payed: false)
Month.create(month: 7,  year: 2016, payed: false)
Month.create(month: 8,  year: 2016, payed: false)
Month.create(month: 9,  year: 2016, payed: false)
Month.create(month: 10, year: 2016, payed: false)
Month.create(month: 11, year: 2016, payed: false)
Month.create(month: 12, year: 2016, payed: false)


User.all.each do |u|
  Month.all.each do |m|
    days = Time.days_in_month(m.month, m.year)
    (1..days).each do |d|
      IsUserInHouse.create(day: d, was_at_home: true, month_id: m.id, user_id: u.id )
    end
  end
end

