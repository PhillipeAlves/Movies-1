require "sinatra"
require "httparty"
# require "sinatra/reloader"

key = ENV["OMDB_KEY"]

get "/" do

    "Hello"

    erb :index

end

get "/results" do

    search  = params[:search]

    results = HTTParty.get("http://www.omdbapi.com/?apikey=#{key}&s=#{search}")

    if results.has_key? "Error"

        erb :results, locals: { results: results }

    elsif results["Search"].length == 1
    
        title = results["Search"][0]["Title"]

        movie = HTTParty.get("http://omdbapi.com/?t=#{title}&apikey=#{key}")
    
        erb :movie, locals: { movie: movie }

    else
        
        erb :results, locals: { results: results }
    
    end

end

get "/movie" do

    title = params[:title]

    movie = HTTParty.get("http://omdbapi.com/?t=#{title}&apikey=#{key}")

    erb :movie, locals: { movie: movie }

end

get "/about" do

    erb :about

end