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

    def link_to_member_action(member_action)
        case member_action.linkType
            when "court" then
                if court = Court.where({id: member_action.link_id}).first
                    link_to court.name, court
                else
                    "(deleted)"
                end
            when "pickup game" then
                if court = Court.where({id: member_action.link_id}).first
                    link_to court.name, court
                else
                    "(deleted)"
                end

            when "event" then
                if event = Event.where({id: member_action.link_id}).first
                    link_to event.name, event
                else
                    "(deleted)"
                end

            else
                member_action.linkType
        end

    end


end
