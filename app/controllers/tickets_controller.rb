class TicketsController < ApplicationController
  before_filter :login_required
  
  def index
    list
    render :action => 'list'
  end

  def list
    @ticket_pages, @tickets = paginate :tickets, :per_page => 10
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
