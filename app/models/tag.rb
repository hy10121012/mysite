class
Tag < ActiveRecord::Base
  has_many :blogTags
  has_many :blogs, through: :blogTags
end
