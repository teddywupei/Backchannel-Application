class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index

    @posts = Post.search(params[:search])


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    session[:last_viewed_post] = @post.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        @post.update_attribute('modified_date', Date.current )
        @post.update_attribute('modified_time', Time.now )
        @post.update_attribute('creator_id', session[:user_name])
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        @post.update_attribute('modified_date', Date.current )
        @post.update_attribute('modified_time', Time.now )
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])

    if(( User.find_by_name(session[:user_name]).admin_flag == 1) || (session[:user_name] == @post.creator_id))

      @post.destroy

      respond_to do |format|
        format.html { redirect_to posts_url }
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
    @post = Post.find(params[:id])
  end

  end
