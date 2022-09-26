class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = List.all.sort_by(&:name)
    @list = List.new
  end

  def show
    @bookmarks = @list.bookmarks
    @bookmark = Bookmark.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render "lists/index", status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
