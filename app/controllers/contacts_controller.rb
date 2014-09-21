class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(params[:contact])
        puts @contact.inspect
        @dude = @contact
        redirect_to test_form_path

        # @contact.request = request
        # if @contact.deliver
        #     flash.now[:error] = nil
        #     flash.now[:notice] = "Message Sent."
        # else
        #     flash.now[:error] = "Cannot send message."
        #     render :new
        # end
    end
end
