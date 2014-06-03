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
		datetime.strftime("%B %-d, %Y")
	end

end
