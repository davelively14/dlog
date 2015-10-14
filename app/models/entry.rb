class Entry < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, :body, presence: :true
  validates :user_id, numericality: :true

  private

  @entries_per_page = 5

  def self.page(num_page = 1)
    num_offset = (num_page - 1) * @entries_per_page
    self.limit(@entries_per_page).offset(num_offset).reverse_order
  end

  def self.max_pages
    (self.all.length.to_f / @entries_per_page).ceil.to_i
  end
end
