class Entry < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, :body, presence: :true
  validates :user_id, numericality: :true
end
