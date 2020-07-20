class Player
    attr_accessor :marker
    @@board = Array.new(7) {Array.new(6)}

    def initialize(marker)
        @marker  = marker
    end

    def self.display()

        puts "  |0 |1 |2 |3 |4 |5 |6"
        for i in (0..5)
            puts "#{i} | #{@@board[0][i]} | #{@@board[1][i]} | #{@@board[2][i]} | #{@@board[3][i]} | #{@@board[4][i]} | #{@@board[5][i]} | #{@@board[6][i]}"
            puts "------------------------"
        end
        #puts " #{@@board[0]} | #{@@board[1]} | #{@@board[2]} "
        #puts "-----------"
        #puts " #{@@board[3]} | #{@@board[4]} | #{@@board[5]} "
        #puts "-----------"
        #puts " #{@@board[6]} | #{@@board[7]} | #{@@board[8]} "
    end


    def is_filled_below?(x,y)
        #if the position belongs to the last row, return false
        if y == 5
            return true
        end

        #otherwise:
        temp_y = y + 1

        while temp_y <= 5 do
            if @@board[x][temp_y] == nil
                return false
            end
            temp_y += 1
        end

        return true
    end

    def isInside?(x,y)  #seems hard to check for a win comb. Consider 2D array
        if (x >= 0 && x <= 6 && y >= 0 && y <= 5)
            return true
        end
        return false
    end

    def drop(x,y)
        #a target cell is available to be filled is when all the 
        #cell below it are filled and the target cell is empty

        if (@@board[x][y] == nil) && (is_filled_below?(x,y))
            @@board[x][y] = @marker
            return true
        end

        return false
    end

    def vertical_win?(x)
        0.upto(2) do |i|
            if @@board[x][i] != nil && @@board[x][i] == @@board[x][i+1] && @@board[x][i+1] == @@board[x][i+2] && @@board[x][i+2] == @@board[x][i+3]
                return true
            end
        end
        return false
    end

    def horizontal_win?(y)
        count = 0
        0.upto(5) do |i|
            if @@board[i][y] != nil && @@board[i][y] == @@board[i+1][y]
                count += 1
            else
                count = 0   #eliminate cases when symbols are not consecutive
            end

            if count == 3
                return true
            end
        end

        return false
    end

    def diagonal_win?(x,y)
        upper_half_count = 0
        lower_half_count = 0

        temp_x = x
        temp_y = y

        temp_x_2 = x
        temp_y_2 = y
        for i in (0..4)
            if (isInside?(temp_x,temp_y)) && (isInside?(temp_x-1,temp_y-1)) && (@@board[temp_x][temp_y] != nil) && (@@board[temp_x][temp_y] == @@board[temp_x-1][temp_y-1])
                upper_half_count += 1
                temp_x -= 1
                temp_y -= 1
            else
                upper_half_count = 0
                temp_x -= 1
                temp_y -= 1
            end

            if (isInside?(temp_x_2,temp_y_2)) && (isInside?(temp_x_2+1,temp_y_2+1)) && (@@board[temp_x_2][temp_y_2] != nil) && (@@board[temp_x_2][temp_y_2] == @@board[temp_x_2+1][temp_y_2+1])
                lower_half_count += 1
                temp_x_2 += 1
                temp_y_2 += 1
            else
                lower_half_count = 0
                temp_x_2 += 1
                temp_y_2 += 1
            end

            if (upper_half_count == 3) || (lower_half_count == 3)
                return true
            end
        end

        false
    end

    def game_over?(x,y)
        if vertical_win?(x) || horizontal_win?(y) || diagonal_win?(x,y)
            return true
        end

        false
    end

    def self.empty()
        @@board = Array.new(7) {Array.new(6)}
        #for i in (0..6)
            #for j in (0..5)
                #@@board[i][j] = nil
            #end
        #end
    end

end

def connect_four()
    user_1 = Player.new('X')
    user_2 = Player.new('O')

    print "Name of 1st player: "
    user_1_name = gets.chomp
    print "Name of 2nd player: "
    user_2_name = gets.chomp

    result = true

    while result
        Player.display()

        puts "Where do you want to place your token, #{user_1_name}?"
        print "Input x-coordinate: "
        x = gets.chomp.to_i()
        print "Input y-coordinate: "
        y = gets.chomp.to_i()

        while !user_1.drop(x,y) do
            puts "Invalid cell. Choose again"
            print "Input x-coordinate: "
            x = gets.chomp.to_i()
            print "Input y-coordinate: "
            y = gets.chomp.to_i()

            #user_1.drop(x,y)
        end

        Player.display()

        if user_1.game_over?(x,y)
            puts "#{user_1_name} won!!!"
            Player.empty()
            result = false
        else
            puts "Where do you want to place your token, #{user_2_name}?"
            print "Input x-coordinate: "
            x = gets.chomp.to_i()
            print "Input y-coordinate: "
            y = gets.chomp.to_i()

            while !user_2.drop(x,y) do
                puts "Invalid cell. Choose again"
                print "Input x-coordinate: "
                x = gets.chomp.to_i()
                print "Input y-coordinate: "
                y = gets.chomp.to_i()

                user_2.drop(x,y)
                #Player.display()
            end
            
            if user_2.game_over?(x,y)
                puts "#{user_2_name} won!!!"
                Player.empty()
                result = false
            end
        end
    end
end

#Player.display()

#p Player.class_variable_get(:@@board)

connect_four();
