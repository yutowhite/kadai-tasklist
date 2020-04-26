class TasksController < ApplicationController
    
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    
    
    def index 
        if logged_in? 
            @task = current_user.tasks.build
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
        end
    end 
    
    def show
    end 
    
    def new 
        @task = Task.new
    end 
    
    def create 
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Task が正常に作成されました"
            redirect_to task_url(@task)
        else 
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash[:danger] = "Task が作成できませんでした"
            render :new
        end 
    end 
    
    def edit 
    end 
    
    def update 
        
        if @task.update(task_params)
            flash[:success] = "Taskは正常に更新されました"
            redirect_to @task
        else 
            flash.now[:danger] = "Taskは更新されませんでした"
            render :edit 
        end 
    end 
    
    def destroy
        @task.destroy
        
        flash[:success] = "Taskは正常に削除されました"
        redirect_to tasks_url
    end 
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end 
    
    def task_params 
        params.require(:task).permit(:content, :status)
    end 
end
