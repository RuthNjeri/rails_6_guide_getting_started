class CommentsController < ApplicationController
  http_basic_authenticate_with name: "Ruth", password: "secret", only: %i[destroy]
  before_action :find_article, only: %i[create destroy]

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end
end
