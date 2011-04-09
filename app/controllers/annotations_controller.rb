# The controller for manipulation of annotations.
class AnnotationsController < ApplicationController
  # Creates a new annotation for the given item.
  # After creation, this will redirect to the item page.
  def create
    @item = Item.find(params[:item_id])
    @annotation = @item.annotations.create(params[:annotation])
    redirect_to item_path(@item)
  end
end
