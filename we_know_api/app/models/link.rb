class Link < ActiveRecord::Base
  require 'link_thumbnailer'

  validates :title, :fact_id, :url, presence: true
  belongs_to :fact

  before_validation(on: :create) do
    begin
      object = LinkThumbnailer.generate(self.url)
      self.title = object.title.force_encoding("utf-8")
      self.description = object.description.force_encoding("utf-8")
      if object.images.length > 0
        self.image = object.images.first.src.to_s.force_encoding("utf-8")
      end
    rescue LinkThumbnailer::Exceptions => e
      self.title = self.url
    end
  end
end
