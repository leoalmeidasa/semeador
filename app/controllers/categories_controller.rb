class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]
  def index
    @categories = Category.for_user(current_user).order(:name)
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Categoria criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    forbid_global!
  end

  def update
    forbid_global! and return
    if @category.update(category_params)
      redirect_to categories_path, notice: "Categoria atualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    forbid_global! and return
    @category.destroy
    redirect_to categories_path, notice: "Categoria removida."
  end

  private

  def set_category
    @category = current_user.categories.try(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def forbid_global!
    if @category.nil?
      redirect_to categories_path, notice: "Você não pode editar ou excluir essa categoria."
    end
  end
end
