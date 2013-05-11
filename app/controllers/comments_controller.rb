class CommentsController < ApplicationController

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    session[:last_comment_viewed] = @comment.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.post_id = session[:last_viewed_post]
    @comment.creator_id = session[:user_name]
    respond_to do |format|
      if @comment.save
        Post.find(:all).each do |post|
          if post.id == @comment.post_id
            post.update_attribute('modified_date', Date.current )
            post.update_attribute('modified_time', Time.now )
          end
        end
        @comment.update_attribute('creator_id', session[:user_name])
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.html { redirect_to Post.find_by_id(@comment.post_id), notice: 'Comment was successfully created.' }
        #format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        Post.find(:all).each do |post|
          if post.id == @comment.post_id
            post.update_attribute('modified_date', Date.current )
            post.update_attribute('modified_time', Time.now )
          end
        end
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    if(( User.find_by_name(session[:user_name]).admin_flag == 1) || (session[:user_name] == @comment.creator_id))
      @comment.destroy

      respond_to do |format|
       format.html { redirect_to comments_url }
       format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/wrong.html' }
        format.json { head :no_content }
      end
    end
  end

  def votes
    @comment = Comment.find(params[:id])
  end

  def submit_votes
    @comment = params[@comment]
  end

end
