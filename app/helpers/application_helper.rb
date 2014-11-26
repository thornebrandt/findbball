module ApplicationHelper
	def full_title(page_title)
		base_title = "Findbball"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def member_since_date(datetime)
		# formatted_date = Date.strptime(datetime).strftime("%m/%d/%Y")
		# formatted_date.to_s
		datetime.strftime("%b %-d, %Y")
	end

    def link_to_add_fields(name, f, association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
            render(association.to_s.singularize + "_fields", :f => builder)
        end
        link_to name, '#', :onclick =>  h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), remote: true
    end

end
