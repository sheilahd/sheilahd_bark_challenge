class LikesController < ApplicationController
    
    def create
       
        @like = current_user.likes.new(like_params)
      
        
      
        if !@like.save
            flash[:notice] = @like.errors.full_messages.to_sentence 
        end    
        redirect_to @like.dog
    end
   

    def destroy
        @like = current_user.likes.find(params[:id])
        dog = @like.dog
        @like.destroy
        redirect_to dog
    end

    private
    def like_params
    params.require(:like).permit(:dog_id)
    end
end
