class Movie < ActiveRecord::Base

  def self.movies(filters, sort)
    return self.order(sort) if not filters
    self.where({:rating => filters}).order(sort)
  end
  
  def self.ratings
    self.pluck(:rating).uniq
  end
  
  def self.current(params, session)
    setup = {:redirect => false}
	
	if params[:ratings].kind_of? Hash
	  params[:ratings].keys
	else
	  params[:ratings]
	end
	
	setup[:ratings] = if params[:ratings]
	  if params[:ratings].kind_of? Hash
	    params[:ratings].keys
	  else
	    params[:ratings]
	  end
	elsif session[:ratings]
	  session[:ratings]
	else
	  self.ratings
	end
	
    setup[:sort] = if params[:sort]
	  params[:sort]
	elsif session[:sort]
	  setup[:redirect] = true
	  session[:sort]
	else
	  nil
	end
	return setup
  end
  
end
