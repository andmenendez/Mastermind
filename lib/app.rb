require 'game_board'

class MastermindApp < Sinatra::Base

	set :method_override, true
	set :root, 'lib/app'			

	not_found do
		erb :error
	end

	get '/' do
		erb :index
	end

	get '/instructions' do
		erb :instructions
	end

	get '/new_game_s' do
		erb :new_game_s
	end

	post '/new_game_s/new-breaker' do
		Gameboard.create()
		Gameboard.createSolution("r")
		puts "Created Gameboard"
		redirect '/gameboard'
	end

  post "/new_game_s/new-master" do
    Gameboard.create()
    puts "Created Gameboard"
    redirect '/gameboard/ai'
  end



	get '/new_game_2' do
		erb :new_game_2
	end

	post "/new_game_2" do
    Gameboard.create()
    puts "Created Gameboard"
    redirect '/gameboard/p2'
  end

	get '/gameboard' do
		erb :gameboard_view, locals: {:data => Gameboard.data}
	end

	put '/gameboard/:id' do |id|
		block_type = params[:id].split("-")
		Gameboard.update(block_type[1], block_type[0])
		redirect '/gameboard'
	end

	put '/gameboard/verify/:id' do |id|
		receipt = Gameboard.verify_row(id.to_i)
		if receipt[0].to_i == 4
			redirect '/gameboard/victory'
		else
			Gameboard.update(5,id, receipt)
		end
		redirect '/gameboard'
	end


	get '/gameboard/victory' do
		erb :victory_view, locals: {:data => Gameboard.data}
	end



# USER
	get '/gameboard/p2' do
		erb :gameboard_p2_view, locals: {:data => Gameboard.data[0]}
  end

  put '/gameboard/p2/:id' do
    Gameboard.update(params[:id].to_s, 0)
    redirect '/gameboard/p2'
  end

  post '/gameboard/p2/submit' do
    puts "Submitted User Solution: Begin Break-in"
    Gameboard.createSolution("i")
    redirect '/gameboard/p2/pause'
  end

  get '/gameboard/p2/pause' do
    erb :pause_view
  end



# A I
  get '/gameboard/ai' do
    erb :gameboard_ai_view, locals: {:data => Gameboard.data[0]}
  end

  put '/gameboard/ai/:id' do
    Gameboard.update(params[:id].to_s, 0)
    redirect '/gameboard/ai'
  end

  post '/gameboard/ai/submit' do
    puts "Submitted User Solution: Begin Break-in"
    Gameboard.createSolution("i")
    redirect '/gameboard/ai/pause'
  end

  get '/gameboard/ai/pause' do
    erb :pause_ai_view
  end
end



