class SubjectsController < ApplicationController
  
  layout 'admin'
  before_filter :confirm_logged_in, :only => [:index, :menu]
  
  def index
   list
   render('list')  
  end
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  def new
  @subject = Subject.new  
  @subject_count = Subject.count + 1
  end
  
  def create
  new_position = params[:subject].delete(:position)
  #instantiate a new object using form parameters
  @subject = Subject.new(params[:subject])
  # save the object
  if @subject.save
    @subject.move_to_position(new_position)
    #if save succeeds, redirect to the list action
    flash[:notice] = "Subject created."
    redirect_to(:action => 'list')
  else
  # if save fails, redisplay the form so user can fix probelm  
  @subject_count = Subject.count + 1
    render('new')  #form_for looks at @subject instance variable, so it will prepopulate the form with what the user already filled in
  end
end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end
  
  def update
    #instantiate a new object using form parameters
    @subject = Subject.find(params[:id])
        # save the object
    new_position = params[:subject].delete(:position)   
    if @subject.update_attributes(params[:subject])
      #if save succeeds, redirect to the list action
      @subject.move_to_position(new_position)     
      flash[:notice] = "Subject updated."
      redirect_to(:action => 'show', :id => @subject.id)
    else
    # if save fails, redisplay the form so user can fix probelm  
    @subject_count = Subject.count
    render('edit')  #form_for looks at @subject instance variable, so it will prepopulate the form with what the user already filled in
    end
  end
  
  def delete
    @subject = Subject.find(params[:id])  
  end
  
  def destroy
    subject = Subject.find(params[:id])
    subject.move_to_position(nil)
    subject.destroy
      flash[:notice] = "Subject destroyed."
    redirect_to(:action => 'list')
  end
  
  
end
