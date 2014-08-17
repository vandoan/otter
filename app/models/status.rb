class Status < ActiveRecord::Base
	belongs_to :user

def full_names
    @full_name = full_name.order('name ASC')
end 
end
