module Paranoia
  def destroy
    _run_destroy_callbacks
    self[:deleted_at] ||= Time.now
    self.save    
  end
  alias :delete :destroy

  def destroyed?
    !self[:deleted_at].nil?
  end
  alias :deleted? :destroyed?
  
  def self.list
  	list = self.unscoped.all
  end
  alias :lists :list
end

class ActiveRecord::Base
  def self.acts_as_paranoid
    self.send(:include, Paranoia)
    default_scope :conditions => { :deleted_at => nil }
  end
end
