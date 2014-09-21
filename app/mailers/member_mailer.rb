class MemberMailer < ActionMailer::Base

    def test_mail
        mail to: 'thornebrandt@gmail.com', subject: "using findbball", from: "info@findbball.com"
    end


    def report_problem
        mail to: 'thornebrandt@gmail.com, eldonnellk@gmail.com', subject: "testing multiple recipients", from: "info@findbball.com"
    end


end
