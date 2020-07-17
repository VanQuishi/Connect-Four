class Player
    attr_accessor :marker
    @@board = Array.new(7) {Array.new(6)}

    def initialize(marker)
        @marker  = marker
    end

    def is_filled_below?(x,y)
        #if the position belongs to the last row, return false
        if y == 5
            return false
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

    def drop(marker,x,y)
        #a target cell is available to be filled is when all the 
        #cell below it are filled and the target cell is empty

        if (@@board[x][y] == nil) && (is_filled_below?(x,y))
            @@board[x][y] = marker
            return true
        end

        return false
    end

    def vertical_win?(x,y)
    end
end

p Player.class_variables