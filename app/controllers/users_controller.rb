class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
  #  if User.find_by_name(session[:user_name]).admin_flag == 0
  #    redirect_to '/wrong.html'
  #  else
    @users = User.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml =>  @users }
   # end
  end
 end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        @user.update_attribute('admin_flag', 0)
        format.html { redirect_to login_path, notice: "User #{@user.name} was successfully created." }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path, notice: "User #{@user.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])

    if( (User.find_by_name(session[:user_name]).admin_flag == 1) && (@user.name != 'boss') )

      begin
       @user.destroy
       Post.find(:all).each do |post|
         if post.creator_id == @user.name
           post.destroy
         end
       end

       Comment.find(:all).each do |comment|
         if comment.creator_id == @user.name
           comment.destroy
         end
       end

       PostVote.find(:all).each do |vote|
         if vote.voter_id == @user.name
           vote.destroy
         end
       end

       CommentVote.find(:all).each do |vote|
         if vote.voter_id == @user.name
           vote.destroy
         end
       end
       flash[:notice] = "user #{@user.name} deleted"
     rescue Exception => e
       flash[:notice] = e.message
     end

     respond_to do |format|
       format.html { redirect_to (users_url) }
       format.xml { head :ok }
     end
    else
      respond_to do |format|
        format.html { redirect_to '/wrong.html' }
        format.xml { head :ok }
      end
    end
  end
end