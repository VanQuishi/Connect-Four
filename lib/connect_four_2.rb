class Player
    attr_accessor :marker
    @@board = Array.new(7) {Array.new(6)}

    def initialize(marker)
        @marker  = marker
    end

    def is_filled_below?(position)
        #if the position belongs to the last row, return false
        if [35,36,37,38,39,40,41].include? position
            return false
        end

        temp_pos = position + 7

        while ![35,36,37,38,39,40,41].include? temp_pos do
            if @@board[temp_pos] == nil
                return false
            end
            temp_pos += 7
        end

        #check the last row
        if @@board[temp_pos] == nil
            return false
        end

        return true
    end

    def isInside?(x,y)  #seems hard to check for a win comb. Consider 2D array
        if (x >= 0 && x <= 6 && y >= 0 && y <= 5)
            return true
        end
        return false
    end

    def drop(marker,position)
        #a target cell is available to be filled is when all the 
        #cell below it are filled and the target cell is empty

        if (@@board[position] == nil) && is_filled_below?(position)
            @@board[position] = marker
            return true
        end

        return false
    end
end

p Player.class_variables