class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = List.all.sort_by(&:name)
    @list = List.new
  end

  def show
    # @list = List.find(params[:id])
    @bookmarks = @list.bookmarks
    @bookmark = Bookmark.new
  end

  def create
    @lists = List.all
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render "lists/index", status: :unprocessable_entity
    end
  end

  def destroy
    # @list = List.find(params[:id])
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
