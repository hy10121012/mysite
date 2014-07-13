class Album < ActiveRecord::Base
  has_many :photos


  def cover
    self.photos.sample
  end

end
