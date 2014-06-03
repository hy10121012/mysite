class Blog < ActiveRecord::Base
  has_many :blogTags
  has_many :tags, through: :blogTags
  has_many :comments
end
