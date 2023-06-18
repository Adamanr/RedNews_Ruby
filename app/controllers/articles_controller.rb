class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # GET /articles or /articles.json
  impressionist :actions => %i[show index]

  def index
    if params[:search].present?
      @articles = Article.joins(:user).where("users.name ILIKE ?", "%#{params[:search]}%")
    else
      @articles = Article.order(created_at: :desc)
    end

    @popular_tags = Article.tag_counts.most_used(4)


    respond_to do |format|
      format.html
      format.json { render json: { results: render_to_string(partial: "articles/list", locals: { articles: @articles }) } }
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @user = User.find(@article.user_id)
    impressionist(@article)
    @bookmarks = Bookmark.find_by(user_id: current_user.id, bookmarkable_id:@article.id, bookmarkable_type: "Article")
    @likes = Like.find_by(user_id: current_user.id, likeable_id:@article.id, likeable_type: "Article")
    @likes_count = Like.where( likeable_id:@article.id, likeable_type: "Article").count
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def find
    search = params[:search].gsub('_', ' ')
    if search == "all"
      @articles = Article.all
    else
      @articles = Article.where("title LIKE ?", "%#{params[:search]}%")
    end
  end

  def selected
  end

  def tag
    tag_name = params[:tag]
    @articles = Article.tagged_with(tag_name)
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.tag_list = params[:article][:tag_list] # Получаем теги из параметров формы

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article.tag_list = params[:article][:tag_list] # Получаем теги из параметров формы

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_comment
    @article = Article.find(params[:id])
    @comment = @article.articles_comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: 'Comment created successfully.'
    else
      redirect_to @article, alert: 'Failed to create comment.'
    end
  end

  def destroy_comment
    @comment = ArticlesComment.find(params[:comment_id])
    @article = Article.find(params[:id])
  
    if @comment.destroy
      redirect_to @article, notice: 'Comment deleted successfully.'
    else
      redirect_to @article, alert: 'Failed to delete comment.'
    end
  end


  private
    def comment_params
      params.require(:articles_comment).permit(:content)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :header, :tags)
    end
end
