class ArticlesController < ApplicationController 
  before_action :getArticle, only: [:show, :edit, :update, :destroy ]
  
  def new
    @article = Article.new
  end 
  def show
  end 
  def edit
  end 
  def index
    @articles = Article.all
  end 
  
  
  
  def create
    @article = Article.new(article_params)
    if (@article.save) 
       flash[:notice] = "Article was successfuly generated"
       redirect_to article_path(@article)
    else 
      render 'new'
    end
  end 
  
  
  def update 
    if @article.update(article_params) 
       flash[:notice] = "Article was successfuly updated"
       redirect_to article_path(@article)
    else 
      render 'edit'
    end
  end
  
  def destroy
        @article.destroy
        flash[:notice] = "Article was successfuly deleted"
        redirect_to articles_path
  end 
  
  private 
    def getArticle 
      @article = Article.find(params[:id])
    end 
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
