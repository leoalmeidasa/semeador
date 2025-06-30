class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: %i[edit update destroy]

  def index
    @goals = current_user.goals.order(due_date: :asc)
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goals_path, notice: "Meta criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      redirect_to goals_path, notice: "Meta atualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_path, notice: "Meta removida."
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:title, :target_amount, :due_date, :progress)
  end
end
