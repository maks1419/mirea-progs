function great_painter(r::Robot)
    while (!isborder(r, Sud) || !isborder(r, West))#going to sud-west angle
        moves!(r, West)
        moves!(r, Sud)
    end
    count = 0
    side = Ost
    while !isborder(r, Nord)
        move!(r, Nord)
        change = 1
        while change != 0 #counting barriers "under" 1 row
            change = move_full_detour(r, side)
            if isborder(r, Sud)
                count += 1
                while isborder(r, Sud) #"skipping" the barrier as we counted it
                    move!(r, side)
                end
            end
        end
        side = inverse(side)
    end
    println("количество горизонтальных перегородок: ", count)

    #i was lazy to create the function to short the code
    #so i copied the previos one

    #we are at one of north angles and we need to go to sud-west one
    moves!(r, West)
    moves!(r, Sud)
    count = 0
    side = Nord
    while !isborder(r, Ost)
        move!(r, Ost)
        change = 1
        while change != 0 #counting barriers "left" 1 row
            change = move_full_detour(r, side)
            if isborder(r, West)
                count += 1
                while isborder(r, West) #"skipping" the barrier as we counted it
                    move!(r, side)
                end
            end
        end
        side = inverse(side)
    end
    println("количество вертикальных перегородок: ", count)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps = 0
    while !isborder(r, side)
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function move_full_detour(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r, side) && !isborder(r, next(side))
        move!(r,next(side))
        num_steps += 1
    end
    change = 0
    if !isborder(r, side)
        move!(r, side)
        change += 1
    end
    if num_steps != 0
        while isborder(r, inverse(next(side)))
            move!(r, side)
            change += 1
        end
        for _ in 1:num_steps
            move!(r, inverse(next(side)))
        end
    end
    return change
end

next(side::HorizonSide)=(HorizonSide(mod(Int(side)+1,4)))

inverse(side::HorizonSide)=(HorizonSide(mod(Int(side)+2,4)))