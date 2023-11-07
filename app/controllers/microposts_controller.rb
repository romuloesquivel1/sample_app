class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_micropost,  only: [:edit, :update]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])

    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else 
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil? || request.referrer == microposts_url
     redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  # Updates a micropost with the given parameters.
  # If successful, redirects to the root url with a success message.
  # If unsuccessful, calls handle_unsuccessful_update method.
  def update
    purge_image_if_needed
    if @micropost.update(micropost_params)
      flash[:success] = "Micropost updated!"
      redirect_to root_url
    else
      handle_unsuccessful_update
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def set_micropost
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.nil?
      render 'static_pages/post_not_found', status: :not_found
      return
    end
  end

  def handle_unsuccessful_update
    @feed_items = current_user.feed.paginate(page: params[:page])
    render 'static_pages/home', status: :unprocessable_entity
  end

  def purge_image_if_needed
    if params[:micropost][:remove_image] == '1' && @micropost.image.attached?
      @micropost.image.purge
    end
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @micropost.nil?
  end
end
