class ArticlesController < ApplicationController 
  before_action :getArticle, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new
    @article = Article.new
  end 
  def show
  end 
  def edit
   
  end 
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end 
  
  
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if (@article.save) 
       flash[:success] = "Article was successfuly generated"
       redirect_to article_path(@article)
    else 
      render 'new'
    end
  end 
  
  
  def update 
    if @article.update(article_params) 
       flash[:success] = "Article was successfuly updated"
       redirect_to article_path(@article)
    else 
      render 'edit'
    end
  end
  
  def destroy
        @article.destroy
        flash[:danger] = "Article was successfuly deleted"
        redirect_to articles_path
  end 
  
  private 
    def getArticle 
      @article = Article.find(params[:id])
    end 
    def article_params
      params.require(:article).permit(:title, :description)
    end
    def require_same_user
       if @article.user != current_user
        flash[:danger] = "This is not your article to perform action on!"
         redirect_to root_path
      end
    end 
end
