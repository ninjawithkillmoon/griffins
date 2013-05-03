class StaticPagesController < ApplicationController
  def home
    #if signed in, render another 'portal' page 
  end

  def about
    add_breadcrumb "About", about_path
  end

  def contact
    add_breadcrumb "Contact", contact_path
  end
end
