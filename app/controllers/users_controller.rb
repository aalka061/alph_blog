class UsersController< ApplicationController
  
 before_action :set_user, only: [:edit, :show, :update]
 before_action :require_same_user, only: [:edit, :update]
 before_action :require_admin, only: [:destroy]

  
  def new 
   @user = User.new
  end

  def create 
    @user = User.new(user_params)
    
    if @user.save 
      session[:user_id]= @user.id
      flash[:success] = "Welcome to Alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    
  end 
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account has been successfully updated"
      redirect_to articles_path
    else 
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end 
  
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:danger] = "User and all articles created by the user have been deleted"
    redirect_to users_path
    
  end
  
  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if (loggedin? && current_user != @user)
      flash[:danger] = "You only can edit or update your own account"
      redirect_to root_path
    end
    else if (!loggedin?) 
      flash[:danger] = "You must be logged in!"
      redirect_to root_path
    end
  end

  def require_admin 
      if (loggedin? && !current_user.admin?)
      flash[:danger] = "Only admin can perform this action"
      redirect_to root_path
      end 
  end

end
