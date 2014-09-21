class Contact < MailForm::Base
    attribute :name, :validate => true
    attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i


    attribute :message
    attribute :address,     :captcha => true

    def headers
        {
            :subject => "Bug reported",
            :to => 'thornebrandt@gmail.com',
            :from => %("#{name}" <#{email}>)
        }
    end
end