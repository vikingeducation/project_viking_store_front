class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def sign_in(user)
    session[:current_user_id] = user.id
    current_user = user
    #session.delete(:cart)
  end

  def sign_out
    session.delete(:current_user_id) && current_user == nil
  end

  def current_user
    return nil unless session[:current_user_id] 
      @current_user ||= User.find(session[:current_user_id])
  end
  helper_method :current_user

  def current_user=(user)
    @current_user = user
  end

  def signed_in_user?
    current_user
  end
  helper_method :signed_in_user?

  def login_required
    redirect_to('/') if current_user.blank?
  end

  def get_states
  ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY']
  end

end
