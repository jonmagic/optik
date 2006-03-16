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
    @page_title = 'My Tickets'
  end
  
  def overview
    @tickets_pending = Ticket.find_all_by_state_id( "1" )
    @tickets_inprogress = Ticket.find_all_by_state_id( "2" )
    @tickets_waiting = Ticket.find_all_by_state_id( "3" )
    @tickets_scheduled = Ticket.find_all_by_state_id( "4" )
    @tickets_completed = Ticket.find_all_by_state_id( "5" )
    @page_title = 'Overview'
  end
  
  def archived
    @archived_pages, @tickets_archived = paginate :tickets, :conditions => ['state_id = ?', "6"], :order => 'created_at ASC', :per_page => 50
    @page_title = 'Archived Tickets'
  end
  
  def advanced_search
    
  end
  
  def search   
    @tickets = Ticket.search(params[:query])
    @page_title = 'Search Results'
  end
  
  def goto
    @ticket = params[:number]
    redirect_to :action => 'show', :id => @ticket
  end
  

  def show
    @users = User.find(:all)
    @states = State.find(:all)  
    @ticket = Ticket.find(params[:id])
    @page_title = 'Show Ticket'    
  end

  def new
    @users = User.find(:all)
    @states = State.find(:all)
    @ticket = Ticket.new
    @page_title = 'New Ticket'    
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

  def add_note
    Ticket.find(params[:id]).notes.create(params[:note])
    flash[:notice] = "Added Your Note."
    redirect_to :action => "show", :id => params[:id]
  end
  
  def delete_note
    @ticket = Ticket.find(params[:id])
    Note.find(params[:note]).destroy
    redirect_to :action => "show", :id => @ticket
  end
  
  def update_note
    @ticket = Ticket.find(params[:id])
    @note = Note.find(params[:n])
    if @note.update_attributes(params[:note])
      flash[:notice] = 'Memorial was successfully updated.'
      redirect_to :action => 'show', :id => @ticket
    else
      redirect_to :action => 'show', :id => @ticket
    end
  end
  
end
