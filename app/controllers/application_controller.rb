class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session

	def averages
		#Set default params
		if params["rating-min"].nil? or params["rating-min"] == ""
			params["rating-min"] = 0
		end
		if params["rating-max"].nil? or params["rating-max"] == ""
			params["rating-max"] = 5
		end
		if params["title"].nil? or params["title"] == ""
			params["title"] = ""
		end
		if params["tag"].nil? or params["tag"] == ""
			params["tag"] = ""
		end

		sql = "SELECT g.name, avg(r.rating) FROM hasagenre h "\
				 "JOIN genres g on g.genreid = h.genreid "\
				 "JOIN movies m on h.movieid = m.movieid "\
				 "JOIN ratings r on h.movieid = r.movieid "\
				 "JOIN tags t on t.movieid = m.movieid "\
				 "JOIN taginfo i on i.tagid = t.tagid "\
				 "WHERE r.rating >= #{params['rating-min']} "\
				 	"AND r.rating <= #{params['rating-max']} "\
				 	"AND m.title ILIKE '%#{params["title"]}%' "\
				 	"AND i.content ILIKE '%#{params["tag"]}%' "\
				 "GROUP BY g.name"

		avg = ActiveRecord::Base.connection.exec_query(sql)

		sql = "SELECT g.name, count(distinct m.movieid) FROM hasagenre h "\
				 "JOIN genres g on g.genreid = h.genreid "\
				 "JOIN movies m on h.movieid = m.movieid "\
				 "JOIN ratings r on h.movieid = r.movieid and r.movieid = m.movieid "\
				 "JOIN tags t on t.movieid = m.movieid "\
				 "JOIN taginfo i on i.tagid = t.tagid "\
				 "WHERE r.rating >= #{params['rating-min']} "\
				 	"AND r.rating <= #{params['rating-max']} "\
				 	"AND m.title ILIKE '%#{params["title"]}%' "\
				 	"AND i.content ILIKE '%#{params["tag"]}%' "\
				 "GROUP BY g.name"

		count = ActiveRecord::Base.connection.exec_query(sql)

		result = {'avg' => avg, 'count' => count}

		render json: result
	end
end
