class Entry < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, :body, presence: :true
  validates :user_id, numericality: :true

  def self.page(num_page = 1)
    num_offset = (num_page - 1) * 5
    Entry.limit(5).offset(num_offset).reverse_order
  end
end
