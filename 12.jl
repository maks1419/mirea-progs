X_COORD=0
Y_COORD=0
SIZE=0 

function great_painter(r::Robot, n::Int)
    global SIZE, Y_COORD, X_COORD
    SIZE=n
    num_ver=moves!(r,Sud)
    num_hor=moves!(r,West)
    marking(r)
    move_back(r,Sud,Y_COORD-num_ver)
    move_back(r,West,X_COORD-num_hor)
end

function marking(r::Robot)
    mark_row(r,Ost)
    side=West
    while isborder(r,Nord)==false
        move_to_side(r,Nord)
        mark_row(r,side)
        side=inverse(side)
    end
end

function mark_row(r::Robot,side::HorizonSide)
    mark_or_no(r,X_COORD,Y_COORD,SIZE)
    while isborder(r,side)==false
        move_to_side(r,side)
        mark_or_no(r,X_COORD,Y_COORD,SIZE)
    end
end
        
function mark_or_no(r::Robot, x_coord::Int, y_coord::Int, size::Int)
    if ((mod(x_coord,2*size) in 0:size-1)&&(mod(y_coord,2*size) in 0:size-1))
        putmarker!(r)
    end
    if ((mod(x_coord,2*size) in size:2*size-1)&&(mod(y_coord,2*size) in size:2*size-1))
        putmarker!(r)
    end
end

function move_to_side(r::Robot, side::HorizonSide)
    global X_COORD, Y_COORD
    if side==Nord
        Y_COORD+=1
    elseif side==Sud
        Y_COORD-=1
    elseif side==Ost
        X_COORD+=1
    elseif side==West
        X_COORD-=1
    end 
    move!(r,side)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function move_back(r::Robot,side::HorizonSide,num_steps::Int)
    if (num_steps<0)==true
        side=inverse(side)
        num_steps*=-1
    end
    for _ in 1:num_steps
        move!(r,side)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))