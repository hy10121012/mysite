class Blog < ActiveRecord::Base
  has_many :blogTags
  has_many :tags, through: :blogTags
  has_many :comments
  has_attached_file :cover,
                    styles: {large: "1500x1500>" },
                    default_url: "/images/:style/missing.png",
                    :path => ":rails_root/public/images/blogs/:id.:extension",
                    :url  => "/images/blogs/:id.:extension"

  validates_attachment  :cover, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
