Create a new table:

    rails generate model (table name) (field):type
    Example:
    rails g model month month:integer year:integer payed:boolean

Generate a table with CRUD on the database:

    rails g scaffold (table_name) (column):(type)

Update the database (both schema and data):

    rake db:migrate
    rake db:seed

Add a new column to a table:

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

How to add new gems (extensions):

    First we must add the gem on the Gemfile file (that's redundant)
    Ex: gem "selectize-rails"

    Then we must run bundle install so Rails will take care of installing the gems that we defined before
    After that the extension installed by the gem is ready to use.

How to validate two fields at the same time:

    validates_uniqueness_of :field1, :scope => :field2
    In this software we can have the same month or the same year, but we can repeat the same month and year in the same record.
    validates_uniqueness_of :month, :scope => :year
    
    
To make a method in a model that is accesible from the outside:

    We must use self. before the method name. The return seems to be automatic. Lets say that we want to have a method in a model that returns an array for a dropdown list:
    
    def self.select_for_dropdown
        [ ['Text for option one', 1], ['Text for option two', 2], .... ]
    end
      
      
How to return a hash with virtual methods from the database:
    
    This has almost nothing to do with the question but it may be interesting later: http://stackoverflow.com/questions/31304825/create-array-of-arrays-from-database-query-in-rails
    This one is pretty interesting to: http://stackoverflow.com/questions/19380554/rails-how-to-convert-a-query-result-hash
    
    
      