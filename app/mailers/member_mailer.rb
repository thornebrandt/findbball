class MemberMailer < ActionMailer::Base

    def test_mail
        mail to: 'thornebrandt@gmail.com', subject: "using findbball", from: "info@findbball.com"
    end


    def report_problem(contact)
        @contact = contact
        mail to: 'thornebrandt@gmail.com',
            subject: "Problem Reported",
            from: "info@findbball.com"
    end

    def verify_email(member)
        @member = member
        mail to: @member.email,
            subject: "Welcome to FindBball",
            from: "info@findbball.com"
    end


end
