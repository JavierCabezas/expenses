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

ExpenseType.create(name: 'Electricidad', is_bill: true)
ExpenseType.create(name: 'Agua', is_bill: true)
ExpenseType.create(name: 'Gas', is_bill: true)
ExpenseType.create(name: 'Pan', is_bill: false)
ExpenseType.create(name: 'Frutas / Verduras', is_bill: false)