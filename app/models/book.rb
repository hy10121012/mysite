class Book < ActiveRecord::Base
  attr_accessor :img_url,:file_url
  has_attached_file :cover,
                    styles: {large: "1500x1500>" },
                    default_url: "/images/:style/missing.png",
                    :path => ":rails_root/public/images/book/:id.:extension",
                    :url  => "/images/book/:id.:extension"
  has_attached_file :file,
                    default_url: "javascript:alert('no resource is available')",
                    :path => ":rails_root/public/books/:id_:filename",
                    :url  => "/books/:id_:filename"


  validates_attachment  :cover, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment  :file, content_type: { content_type: ["application/pdf", "application/txt", "application/mobi", "application/epub"] }


  def as_json(options = { })
    h = super(options)
    h[:img_url]   = cover(:large)
    h[:file_url]   = file(:large)
    h
  end



end
