class HomeController < ApplicationController
  def index
  end
  def write
       
        @jaemok = params[:title]
        @cherry = params[:email]
        @naeyong = params[:content]
        
        mg_client = Mailgun::Client.new("key-1c3adfd8b7583556c6bd90c223e21659")

        message_params =  {
                   from: 'stargosu@leejongwon.com',
                   to:   @cherry,
                   subject: @jaemok,
                   text:    @naeyong,
                  }

        result = mg_client.send_message('sandboxa6dadf35078843e29ec8424676a48e60.mailgun.org', message_params).to_h!

        message_id = result['id']
        message = result['message']

      
      new_post = Post.new
      new_post.title = params[:title]
      new_post.content = params[:content]
      new_post.save
      
      redirect_to  "/list"
  end
  
  def list
      @every_post = Post.all.order("id desc")
  end
  
  def update_view
      @one_post = Post.find(params[:post_id])
  end
  
  def siljae
      @one_post = Post.find(params[:post_id])
      @one_post.title = params[:title]
      @one_post.content = params[:content]
      @one_post.save
      redirect_to "/list"
  end
    
  def destroy
      @one_post = Post.find(params[:post_id])
      @one_post.destroy
      redirect_to "/list"
  end
  
end
