class TicketsController < ApplicationController
  before_filter :login_required, :except => [ :rss_show, :rss_mytickets ]
  
  def index
    mytickets
    render :action => 'mytickets'
  end
  
  def list
    mytickets
    render :action => 'mytickets'
  end

  def mytickets
    @tickets_pending = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "1" )
    @tickets_inprogress = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "2" )
    @tickets_waiting = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "3" )
    @tickets_scheduled = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "4" )
    @tickets_completed = Ticket.find_all_by_user_id_and_state_id(@session[:user].id, "5" )
    counters
    @page_title = 'My Tickets'
  end
  
  def overview
    @tickets_pending = Ticket.find_all_by_state_id( "1" )
    @tickets_inprogress = Ticket.find_all_by_state_id( "2" )
    @tickets_waiting = Ticket.find_all_by_state_id( "3" )
    @tickets_scheduled = Ticket.find_all_by_state_id( "4" )
    @tickets_completed = Ticket.find_all_by_state_id( "5" )
    counters
    @page_title = 'Overview'
  end
  
  def archived
    @archived_pages, @tickets_archived = paginate :tickets, :conditions => ['state_id = ?', "6"], :order => 'created_at ASC', :per_page => 50
    @total_archived = Ticket.find(:all, :conditions => ['state_id =?', "6"]).size.to_s 
    @page_title = 'Archived Tickets'
  end
  
  def statistics

  end
  
  def search   
    @query = params[:query] || request.raw_post || request.query_string
    @result_pages = Paginator.new self, Ticket.quicksearch(@query, :count => true), 50, @params['page']
    @tickets = Ticket.quicksearch(@query, 
                                  :limit  =>  @result_pages.items_per_page,
                                  :offset =>  @result_pages.current.offset)
    if @tickets.blank?
      flash[:notice] = 'No results found'
    else
    end
  end
  
  def goto
    @ticket = params[:number]
    redirect_to :action => 'show', :id => @ticket
  end
  
  # Ticket stuff

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
    @selected_user = session[:user]
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
  
  def ajax_update_ticket_owner
    @ticket = Ticket.find(params[:id])
    @ticket.user_id = params[:user_id]
    @ticket.save
  end

  def ajax_update_ticket_state
    @ticket = Ticket.find(params[:id])
    @ticket.state_id = params[:state_id]
    @ticket.save
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      @ticket.tag(params[:tags], :clear => true)
      if @ticket.state_id == 5
        flash[:notice] = 'Ticket has been completed.'
        redirect_to :action => 'index'
      elsif @ticket.state_id == 6
        flash[:notice] = 'Ticket has been archived.'
        redirect_to :action => 'overview'
      else
        flash[:notice] = 'Ticket was successfully updated.'
        redirect_to :action => 'show', :id => @ticket
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    Ticket.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  # Note stuff

  def ajax_add_note
    @ticket = Ticket.find(params[:id])    
    @newnote = Note.new(params[:note])
    @newnote.ticket = @ticket
    if request.post? and @newnote.save
      flash[:notice] = "Added Your Note."      
      render :partial => "note", :object => @newnote
    else
      render :text => @newnote.errors.full_messages.join(", "), :status => 500
    end
  end
  
  def ajax_nuke_note
    note = Note.find(params[:id])
    note.destroy 
    render :nothing => true
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
  
  def counters
    @count_pending = '(' + @tickets_pending.size.to_s + ')'
    @count_inprogress = '(' + @tickets_inprogress.size.to_s + ')'
    @count_waiting = '(' + @tickets_waiting.size.to_s + ')'
    @count_scheduled = '(' + @tickets_scheduled.size.to_s + ')'
    @count_completed = '(' + @tickets_completed.size.to_s + ')'    
  end
  
  #rss feeds
  
  def rss_show
    @ticket = Ticket.find(params[:id])
    @notes = Ticket.find(params[:id]).notes
    render_without_layout
  end
  
  def rss_mytickets
    @tickets = Ticket.find_all_by_user_id(params[:user])
    render_without_layout
  end
  
  def rss_overview
    render_without_layout
  end

end
