# This class represents an annotation, which is a small bit of text that a user
# can attach to an inventory item.
# Magic Rails properties are:
# text (string): the annotation text
# item_id (integer): the ID of the item this is annotating
# user_id (integer): the ID of the user who wrote this annotation
# created_at (datetime): when this annotation was created
# updated_at (datetime): the last time this annotation was updated at
class Annotation < ActiveRecord::Base

  # Disallow nil annotations
  validates :text, :presence => true

  # Also, let Rails magic happen what with the User and Item references
  belongs_to :item
  belongs_to :user
end
