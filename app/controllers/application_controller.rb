class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session

	def averages
		#Set default params
		if params["lower"] == ""
			params["lower"] = 0
		end
		if params["upper"] == ""
			params["upper"] = 5
		end
		if params["title"] == ""
			params["title"] = ""
		end
		if params["tag"] == ""
			params["tag"] = ""
		end

		sql = "SELECT g.name, avg(r.rating) FROM hasagenre h "\
				 "JOIN genres g on g.genreid = h.genreid "\
				 "JOIN movies m on h.movieid = m.movieid "\
				 "JOIN ratings r on h.movieid = r.movieid and r.movieid = m.movieid "\
				 "JOIN tags t on t.movieid = m.movieid "\
				 "JOIN taginfo i on i.tagid = t.tagid "\
				 "WHERE r.rating > #{params['lower']} "\
				 	"AND r.rating < #{params['upper']} "\
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
				 "WHERE r.rating > #{params['lower']} "\
				 	"AND r.rating < #{params['upper']} "\
				 	"AND m.title ILIKE '%#{params["title"]}%' "\
				 	"AND i.content ILIKE '%#{params["tag"]}%' "\
				 "GROUP BY g.name"

		count = ActiveRecord::Base.connection.exec_query(sql)

		result = {'avg' => avg, 'count' => count}

		render json: result
	end
end
