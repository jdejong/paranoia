module Paranoia
  def self.included(base)
      base.extend(ClassMethods)
  end
  def destroy
  	#_run_destroy_callbacks
	#if self.respond_to?(:paper_trail_active) && self.paper_trail_active
    #    self.class.paper_trail_off
	#	self.deleted_at = Time.now
	#	self.save!   
	#	self.class.paper_trail_on
	#else
	#	puts 'no_paper_trail'
	#	self.deleted_at = Time.now
	#	self.save!  
	#end
	_run_destroy_callbacks do
		self.deleted_at = Time.now
		self.save!  
	end
  end
  alias :delete :destroy

  def destroyed?
    !self[:deleted_at].nil?
  end
  alias :deleted? :destroyed?
  
  module ClassMethods
	  def list
		list = self.unscoped.all
	  end
  end
end

class ActiveRecord::Base
  def self.acts_as_paranoid
    self.send(:include, Paranoia)
    default_scope :conditions => { :deleted_at => nil }
  end
end
