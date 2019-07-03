require 'yaml/store'

class Gameboard

  def self.create()
    # @solution = []

    database.transaction do
      database['solution'] = []
    end

    resetdb()
  end

  def self.createSolution(inst)

    if inst == "r"
      4.times do

        database.transaction do
          database['solution'] << 1 + rand(6)
        end

      end
    elsif inst == 'i'

      database.transaction do
        database['solution'] << database['data'][0][0][0,4]
      end

    end
    print "SOLUTION: "
    print get_solution()
    puts ""
    resetdb()
  end

  def self.database
  	@database ||= YAML::Store.new("db/game_data")
  end

  def self.data
    database.transaction do |db|
      db['data'] || []
    end
  end

  def self.update(x, y, val = [])
    if val == []
      database.transaction do
        if database['data'][0][y.to_i][4] == ""
          database['data'][0][y.to_i][x.to_i] < 6 ? 
            database['data'][0][y.to_i][x.to_i] += 1 : 
            database['data'][0][y.to_i][x.to_i] = 1
        end
      end
    else

      database.transaction do
        database['data'][0][y.to_i][x.to_i-1] = val[0]
        database['data'][0][y.to_i][x.to_i] = val[1]
      end
    end
  end

  def self.verify_row(row)

    @sol = get_solution()
    @guess = get_row(row)

    b_index = 0
    w_index = 0

    4.times do |i|
      if (@sol[i] - @guess[i] == 0)
        b_index += 1
      elsif (@guess.include?(@sol[i]))
        w_index += 1
      end
    end
    [b_index, w_index]
  end

  private_class_method def self.get_solution()
    database.transaction do
      database['solution'][0]
    end
  end

  private_class_method def self.get_row(row)
    database.transaction do
      database['data'][0][row.to_i]
    end
  end

  private_class_method def self.resetdb
    database.transaction do 
        database['data'] = []
        database['data'] << [
            # =>             0. 1. 2. 3. 4. 5.
                            [7, 7, 7, 7, "", ""], #0
                            [7, 7, 7, 7, "", ""], #1
                            [7, 7, 7, 7, "", ""], #2
                            [7, 7, 7, 7, "", ""], #3
                            [7, 7, 7, 7, "", ""], #4
                            [7, 7, 7, 7, "", ""], #5
                            [7, 7, 7, 7, "", ""], #6
                            [7, 7, 7, 7, "", ""], #7
                            [7, 7, 7, 7, "", ""], #8
                            [7, 7, 7, 7, "", ""], #9
                            [7, 7, 7, 7, "", ""], #10
                            [7, 7, 7, 7, "", ""]  #11
                            ]
    end
    puts "Database reset"
  end

end


  # def self.delete()
  #   database.transaction do
  #     database['ideas'].delete_at(pos)
  #   end
  # end
  # private



# hash1 = {
# 	:a => {:b => 1, :c => 2, :d => 3}, 
# 	:b => {:b => 4, :c => 5, :d => 6}
# }

# hash2 = 
# {
# 	1 => {2 => 1, 3 => 2, 4 => 3}, 
# 	2 => {2 => 4, 3 => 5, 4 => 6}
# }
# puts hash1
# puts hash2


# puts hash1[:a][:c]
# puts hash2[1][4]


	# @data = 
	# 	[ 	[1, 1, 1, 1, 1, 1], # 01
	# 		[1, 1, 1, 1, 1, 1], # 02
	# 		[1, 1, 1, 1, 1, 1], # 03
	# 		[1, 1, 1, 1, 1, 1], # 04
	# 		[1, 1, 1, 1, 1, 1], # 05
	# 		[1, 1, 1, 1, 1, 1], # 06 
	# 		[1, 1, 1, 1, 1, 1], # 07
	# 		[1, 1, 1, 1, 1, 1], # 08
	# 		[1, 1, 1, 1, 1, 1],	# 09
	# 		[1, 1, 1, 1, 1, 1],	# 10
	# 		[1, 1, 1, 1, 1, 1], # 11
	# 		[1, 1, 1, 1, 1, 1] 	# 12
	# 	 ]