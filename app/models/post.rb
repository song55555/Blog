class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }

  def tag_names
    tags.map(&:name).join(", ")
  end

  def tag_names=(names)
    tag_names = names.split(",").map(&:strip).uniq
    new_tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_tags
  end
end