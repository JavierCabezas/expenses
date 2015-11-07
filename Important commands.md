Generate a table with CRUD on the database:
rails g scaffold (table_name) (column):(type)

Update the database (both schema and data):
rake db:migrate
rake db:seed

Add a new table:


Add a new row on an existing database:
rails g migration AddCommentsToExpense

Then the aplication will create a migration on expnese/db/migrate. Edit the change action with a code like this one:
add_column :expenses, :comment, :text, null: true

