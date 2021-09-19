class ExpensesController < ApplicationController
  skip_before_action :authorized, except: %i[create update destroy]
  before_action :find_list, only: %i[index create]
  before_action :find_expense, except: %i[index create]

  def index
    render json: @list.expenses
  end

  def show
    render json: @expense
  end

  def create
    @expense = @list.expenses.build(expense_params)

    if @expense.save
      render json: @expense
    else
      render json: { error: 'Unable to create expense' }, status: :bad_request
    end
  end

  def update
    if @expense
      @expense.update(expense_params)
      render json: { expense: @expense, message: 'Expense sucessfully updated' }, status: :ok
    else
      render json: { error: 'Unable to update expense' }, status: :bad_request
    end
  end

  def destroy
    if @expense
      @expense.destroy
      render json: { id: @expense.id, message: 'Expense deleted' }, status: :ok
    else
      render json: { error: 'Unable to delete expense' }, status: :bad_request
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:id, :title, :amount, :date, :notes, :list_id)
  end

  def find_list
    @list = List.find(params[:list_id])
  end

  def find_expense
    @expense = Expense.find(params[:id])
  end
end
