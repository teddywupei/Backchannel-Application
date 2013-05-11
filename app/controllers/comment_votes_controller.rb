class CommentVotesController < ApplicationController

  # GET /comment_votes
  # GET /comment_votes.json
  def index
    @comment_votes = CommentVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment_votes }
    end
  end

  # GET /comment_votes/1
  # GET /comment_votes/1.json
  def show
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/new
  # GET /comment_votes/new.json
  def new
    @comment_vote = CommentVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/1/edit
  def edit
    @comment_vote = CommentVote.find(params[:id])
  end

  # POST /comment_votes
  # POST /comment_votes.json
  def create
    @comment_vote = CommentVote.new(params[:comment_vote])
    @comment_vote.comment_id = session[:last_comment_viewed]
    @comment_vote.voter_id = session[:user_name]
    respond_to do |format|

      comment = Comment.find_by_id(@comment_vote.comment_id)
      if(( comment.comment_votes.find_all_by_voter_id(session[:user_name]).empty?) && (comment.creator_id != session[:user_name]))
        if @comment_vote.save

          Post.find_by_id(comment.post_id).update_attribute('modified_date', Date.current )
          Post.find_by_id(comment.post_id).update_attribute('modified_time', Time.current )
          format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully created.' }
          format.json { render json: @comment_vote, status: :created, location: @comment_vote }
        else
          format.html { render action: "new" }
          format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to '/voted_twice.html' }
      end

    end
  end

  # PUT /comment_votes/1
  # PUT /comment_votes/1.json
  def update
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      if @comment_vote.update_attributes(params[:comment_vote])
        temp_id = 0
        Comment.find(:all).each do |temp_comment|
          if temp_comment.id == @comment_vote.comment_id
            temp_id = temp_comment.post_id
          end
        end
        Post.find(:all).each do |post|
          if post.id == temp_id
            post.update_attribute('modified_date', Date.current )
            post.update_attribute('modified_time', Time.now )
          end
        end
        format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_votes/1
  # DELETE /comment_votes/1.json
  def destroy
    @comment_vote = CommentVote.find(params[:id])
    if(( User.find_by_name(session[:user_name]).admin_flag == 1) || (session[:user_name] == @comment_vote.voter_id))
      @comment_vote.destroy

      respond_to do |format|
       format.html { redirect_to comment_votes_url }
       format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/wrong.html' }
        format.json { head :no_content }
      end
    end
  end
end
