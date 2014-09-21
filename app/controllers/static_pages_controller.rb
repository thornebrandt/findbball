class StaticPagesController < ApplicationController
  def home
  	@hero = true
  end

  def splash
  	@noHeaderFooter = true
  end

  def test_mail
    if MemberMailer.report_problem().deliver
        redirect_to home_path
    end
  end


end
