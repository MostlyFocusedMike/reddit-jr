class CommentsController < ApplicationController
  def create 
    # the request.referer returns the page the form came from: 
    #     https:/site.com/posts/2
    # so we use regex to pull the post number to use as our id 
   post_id = request.referer.match(/.+\/(\d)/).captures[0]
   content = params[:comment][:content]
   
   # checks to see if there are any words in the comment 
   if content =~ /\w/
     user_id = session[:user_id]
     Comment.create(user_id: user_id, post_id: post_id, content: content)
   else 
     flash[:comment_warning] = "Don't leave a blank comment"
   end 
   redirect_to post_path(post_id)
  end 

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy 
    redirect_to post_path(post)
  end 
end 