class Link < ActiveRecord::Base
  require 'link_thumbnailer'

  validates :title, :fact_id, :url, presence: true
  belongs_to :fact

  before_validation(on: :create) do
    begin
      object = LinkThumbnailer.generate(self.url)
      self.title = object.title
      self.description = object.description
      self.image = object.images.first.src.to_s
    rescue LinkThumbnailer::Exceptions => e
      self.title = self.url
    end
  end
end
