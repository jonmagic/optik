class TicketsController < ApplicationController
  before_filter :login_required
  
  def index
    list
    render :action => 'list'
  end

  def list
    @tickets_pending = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "1" )
    @tickets_inprogress = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "2" )
    @tickets_waiting = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "3" )
    @tickets_scheduled = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "4" )
    @tickets_completed = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "5" )        
  end

  def list_pending
    @tickets = Ticket.find(:all)
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @users = User.find(:all)
    @states = State.find(:all)
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      @ticket.tag(params[:tags], :clear => true)
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @users = User.find(:all)
    @states = State.find(:all)
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      @ticket.tag(params[:tags], :clear => true)      
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to :action => 'show', :id => @ticket
    else
      render :action => 'edit'
    end
  end

  def destroy
    Ticket.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
