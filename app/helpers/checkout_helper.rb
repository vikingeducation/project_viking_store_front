module CheckoutHelper
  def user_cc
    if @user.payment
      @user.payment.cc_number
    else
      ""
    end
  end

  def user_exp_month
    if @user.payment
      @user.payment.exp_month
    else ""
    end
  end

  def user_exp_year
    if @user.payment
      @user.payment.exp_year
    else 
      ""
    end
  end

  def user_ccv
    if @user.payment
      @user.payment.ccv
    else
     ""
    end
  end
end
