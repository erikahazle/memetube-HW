require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry'

get '/' do
  erb :index
end

get '/videos' do
  sql = "SELECT * FROM videos"
  @library = run_sql(sql)

  erb :videos
end

get '/videos/new' do
  erb :new
end

post '/videos' do
  sql = "INSERT INTO videos (title, description, url, genre) VALUES ('#{params['title']}', '#{params['description']}', '#{params['url']}', '#{params['genre']}')"
  run_sql(sql)
  erb :videos
end

get '/videos/:id' do
  sql = "SELECT * FROM videos WHERE id=#{params[:id]}"
  @video = run_sql(sql).first
  erb :show
end

get '/videos/:id/edit' do
  sql = "SELECT * FROM videos WHERE id=#{params[:id]}"
  @video = run_sql(sql).first
  erb :edit
end

get '/videos/:id/delete' do

end


private

def run_sql(sql)
  conn = PG.connect(dbname: 'video_library', host: 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end
end