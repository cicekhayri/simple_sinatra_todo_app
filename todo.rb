require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/default.db")

class Note
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :created_at, DateTime
	property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@notes = Note.all :order => :id.desc
	erb :index
end

post '/' do
	note = Note.new
	note.content = params[:content]
	note.created_at = Time.now
	note.updated_at = Time.now
	note.save
	redirect '/'
end

get '/:id' do
	@note = Note.get params[:id]
	erb :edit
end

put '/:id' do
	note = Note.get params[:id]
	note.content = params[:content]
	note.updated_at = Time.now
	note.save
	redirect '/'
end




