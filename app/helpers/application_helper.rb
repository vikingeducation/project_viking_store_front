module ApplicationHelper
  def sign_in_button
    if @current_user
      link_to "Sign Out", session_path(@current_user), :method => "DELETE"
    else
      link_to "Sign In", new_session_path
    end
  end
end
