class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.includes(:user)

    
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
       redirect_to root_path
    else
      render :new
     
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
  
    redirect_to root_path
  end
  

 

  def edit
    unless @prototype.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    if @prototype.update(prototype_params)
       redirect_to action: "show"
    else
      render :edit
    end
  end
  
  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :image, :catch_copy, :concept).merge(user_id: current_user.id)
  end
  
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  
 
end
