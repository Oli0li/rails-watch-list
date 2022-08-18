class ListsController < ApplicationController
  def index
    @lists = List.all.sort_by(&:name)
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all
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

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
