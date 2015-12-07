class ExpendituresController < ApplicationController
  before_action :set_expenditure, only: [:show, :edit, :update, :destroy]

  # GET /expenditures
  # GET /expenditures.json
  # Shows all the expenditures with status = Overdue
  def index
    @expenditures = Expenditure.all.where(status: 0)
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
  end

  # GET /expenditures/new
  def new
    @expenditure = Expenditure.new
  end

  # GET /expenditures/1/edit
  def edit
  end

  # POST /expenditures
  # POST /expenditures.json
  def create
    @expenditure = Expenditure.new(expenditure_params)

    respond_to do |format|
      if @expenditure.save
        format.html { redirect_to @expenditure, notice: 'Expenditure was successfully created.' }
        format.json { render :show, status: :created, location: @expenditure }
      else
        format.html { render :new }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenditures/1
  # PATCH/PUT /expenditures/1.json
  def update
    respond_to do |format|
      if @expenditure.update(expenditure_params)
        format.html { redirect_to @expenditure, notice: 'Expenditure was successfully updated.' }
        format.json { render :show, status: :ok, location: @expenditure }
      else
        format.html { render :edit }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.json
  def destroy
    @expenditure.destroy
    respond_to do |format|
      format.html { redirect_to expenditures_url, notice: 'Expenditure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def month_detail
    @expense_per_user = {} #Hash in where to store each of the expenses for each of the users
    @total_expense_per_user = {} #The total ammount that each user has as expenses
    @total_expenses = 0
    @days_per_user = {} # Hash that stores the user name, id and number of days that he/she was at the appartment for that month.
                        # format: hash[user_id]['name'] = 'Name', hash[user_id]['days'] = 'Number of days that the person was at the apt' hash[user_id]['id'] = 'Id of the person'
    @expense_ammount_per_type = { } #Stores each of the expenses in the format ['name'] = 'Name' , ['ammount'] = 'Ammount of money for this expense'


    if params['month_id'].present?
      @selected_month_id = params['month_id']
    else
      @selected_month_id = Month.get_current_month_id
    end

    @days_in_month = 30   #@todo: Make this come from the selected month
    @month_name = Month.find(@selected_month_id).month_and_year
    @users = User.all
    @user_count = @users.count
    @expenditure_types = ExpenseType.all
    @all_expenses = Expenditure.where(month_id: @selected_month_id, status: 0).order(:user_id).all #used for the _month_defatil_expense_detail_table
    @pending_expenditure_per_user = Expenditure.expenditures_per_user( @all_expenses, @users )

    @users.each do |usu|
      days_user = IsUserInHouse.where(was_at_home: true, month_id: @selected_month_id, user_id: usu.id).count()

      expense_user = Expenditure.where( month_id:@selected_month_id, user_id:usu.id ).group(:expense_type_id).pluck(:expense_type_id, 'sum(ammount)')
      @expense_per_user[usu.id] = expense_user;

      total_expense_user = Expenditure.where( month_id:@selected_month_id, user_id:usu.id ).sum(:ammount)
      @total_expenses += total_expense_user
      @total_expense_per_user[usu.id] = total_expense_user;

      temp = { }
      temp['id'] = usu.id
      temp['name'] = usu.username
      temp['days'] = days_user
      @days_per_user[usu.id] = temp
    end

    #@todo: Make this query not sucky. Use relations to get the name.
    Expenditure.where(month_id: @selected_month_id, status: 0).group(:expense_type_id).sum(:ammount).each do |expense_id, quantity|
      temp_name = ExpenseType.find_by_id(expense_id).name
      @expense_ammount_per_type[temp_name] = quantity
    end

    @was_at_home = IsUserInHouse.where(month_id: @selected_month_id).order(:day).all.to_a

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expenditure
      @expenditure = Expenditure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expenditure_params
      params.require(:expenditure).permit(:ammount, :status, :comment, :user_id, :expense_type_id, :month_id)
    end
end
