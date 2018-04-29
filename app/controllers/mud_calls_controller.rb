class MudCallsController < ApplicationController
    #before_action :set_mud_call, only: [:edit, :update, :show, :destroy]
    #before_action :require_login, only: [:new, :index, :create]
    before_action :require_admin_or_role, only: [:new, :index, :create]
    #before_action :require_admin, only: [:destroy]

    def index
       @activities = Activity
       @pens = Pen
       @new_mud_call = Mud_call.new
       @users = User
       #select('DISTINCT ON ("group") *').order(:group, date: :desc, id: :desc)
       @mud_calls = Activity.joins('LEFT OUTER JOIN "mud_calls" ON "activities"."id" = "mud_calls"."activity_id"').group("pen_id").select('activities.*').order(:pen_id, id: :desc)
       #select('DISTINCT ON ("pen_id") *').order(:activity_id, checkout: :desc, id: :desc)
       #select("activities.*").group("activities.pen_id").order("activities.check_out DESC").limit(1)
       #@mud_calls = Activity.joins('LEFT OUTER JOIN "mud_calls" ON "activities"."id" = "mud_calls"."activity_id"').select("activities.*").group("activities.pen_id").order("activities.check_out DESC").limit(1)
       @mud_calls = @mud_calls.having("pen_mud_check = 0 and (mud_calls.resolved = 0 or mud_calls.resolved is NULL)")
       #@mud_calls = @mud_calls.where("mud_calls.resolved = 'true' or mud_calls.resolved is NULL")
       @mud_calls = @mud_calls.paginate(page: params[:page], per_page: 4)

       #.paginate(page: params[:page], per_page: 5)
    end

    def create
      # render plain: params[:mud_call].inspect
      #debugger
      @new_mud_call = Mud_call.new(mud_call_params)
      @new_mud_call.user = current_user
       #@mud_call.save
      # redirect_to mud_calls_path(@mud_call)
      if @new_mud_call.save
          flash[:success] = 'mud_call was successfully created'
          redirect_to mud_calls_path
      else
          render 'new'
      end

    end

    private
        def set_mud_call
            @mud_call = Mud_call.find(params[:id])
        end

        def mud_call_params
            params.require(:mud_call).permit(:resolved, :activity_id)
        end


        def require_login
          if !logged_in?
            flash[:danger] = "Please login first to perform that action"
            redirect_to root_path
          end
        end

        def require_same_user
            if current_user != @maintenance.user and current_user.admin == 0
                flash[:danger] = "You can only edit or delete your own mud_calls"
                redirect_to root_path
            end
        end

        def require_admin_or_role
           if !logged_in?
              flash[:danger] = "Please login first to perform that action"
              redirect_to root_path
           elsif logged_in? and current_user.admin == 0 and current_user.handy == 0
              flash[:danger] = "Only admin and yard technician can perform that action"
              redirect_to root_path
           end
         end

end
