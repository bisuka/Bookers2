users = [["aa",1],["bb",2],["cc",3]]
users.each do |user|
	puts "<tr>"
	puts "<td>"+user[0]+"</td>"
	puts "<td>"+"<%= link_to user_path("+user[1].to_s+")</td>"
	puts "</tr>"
end