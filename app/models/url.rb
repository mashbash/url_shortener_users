require 'digest/md5'
require 'uri'

class Url < ActiveRecord::Base
  before_create :create_short_url

  validates :long, :presence => true,
                   :format   => { with: URI::regexp }

  private
  def create_short_url
    self.short = Digest::MD5.hexdigest(self.long)[0..5]
  end
end
