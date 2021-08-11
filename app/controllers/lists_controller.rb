class ListsController < ApplicationController
  before_action :find_user, only: %i[index create]
  before_action :find_list, except: %i[index create]

  def index
    render json: @user.lists
  end

  def show
    render json: @list
  end

  def create
    @list = @user.lists.build(list_params)
    if @list.save
      render json: @list
    else
      render json: { error: 'Unable to create list' }, status: :bad_request
    end
  end

  def update
    if @list
      @list.update(list_params)
      render json: { list: @list, message: 'List sucessfully updated' }, status: :ok
    else
      render json: { error: 'Unable to update list' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @list
      @list.destroy
      render json: { id: @list.id, message: 'List deleted' }, status: :ok
    else
      render json: { error: 'Unable to delete list' }, status: :bad_request
    end
  end

  private

  def list_params
    params.require(:list).permit(:id, :name, :user_id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_list
    @list = List.find(params[:id])
  end
end
