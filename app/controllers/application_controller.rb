class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    resource.admin? ? admin_path : home_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "У вас нет доступа к этой странице"
  end
end
