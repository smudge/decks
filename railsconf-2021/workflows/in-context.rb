class WorkflowsController < ApplicationController
  def show
    @workflow = current_user.workflows.find(params[:workflow_id])
  end

  def update
    @workflow = current_user.workflows.find(params[:workflow_id])

    if current_user.update(permitted_params)
      @workflow.update(step: @workflow.next_step)

      redirect_to workflow_step_two_path(@workflow)
    else
      render :show
    end
  end

  private

  def permitted_params
    # ...
  end
end
