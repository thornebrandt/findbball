class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(params[:contact])
        puts @contact.inspect

        if MemberMailer.report_problem(@contact).deliver
            flash[:notice] = "Message Sent."
        else
            flash[:notice] = "Cannot send message."
        end
        redirect_to request.referrer
    end

    def verify_email
    end

end
