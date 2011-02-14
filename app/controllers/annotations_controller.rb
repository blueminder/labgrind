class AnnotationsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @annotation = @item.annotations.create(params[:annotation])
    redirect_to item_path(@item)
  end
end
