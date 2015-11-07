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


Creating a table with a (simple) relation to another:

    Links:
    http://stackoverflow.com/questions/3808926/whats-the-difference-between-belongs-to-and-has-one
    http://edgeguides.rubyonrails.org/active_record_migrations.html

    First create a database table as you would normally do
    rails g scaffold expenditures ammount:integer status:integer comment:text

    These are the possible types of data:
    :binary, :boolean, :date, :datetime, :decimal, :float, :integer, :primary_key
    :string, :text, :time, :timestamp

    Then add the the associatons. These are the possible options:
    belongs_to, has_one, has_many, has_many :through, has_one :through, has_and_belongs_to_many

    Create the migration for the new relationship between the tables:
    rails g migration AddUserReferenceToExpenditures

    Then fill the migration with the relation:
    class AddUserReferenceToExpenditures < ActiveRecord::Migration
      def change
        add_reference :expenditures, :user, index: true, foreign_key: true
      end
    end


    Finish the process by running rake db:migrate
