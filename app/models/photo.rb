class Photo < ActiveRecord::Base
  belongs_to :album
  has_attached_file :photo,
                    styles: {
                        #original: "3000x3000>",
                              large: "1500x1500>", medium: "700x700>", small: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png",
                    :path => ":rails_root/public/photo/:id/:style/:filename",
                    :url  => "/photo/:id/:style/:filename"


  validates_attachment  :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
