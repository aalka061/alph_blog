class PagesController < ApplicationController
  def home 
    redirect_to articles_path if loggedin?
  end 
  
  def about
  end 
end