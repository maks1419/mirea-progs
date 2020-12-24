function great_painter(r::Robot)
    num_ver=moves!(r,Sud)
    num_hor=moves!(r,West)
    putmarker!(r)
    side=Ost
    while isborder(r,Nord)==false
        paint_row(r,side)
        side=inverse(side)
        move!(r,Nord)
        putmarker!(r)
    end
    paint_row(r,side)
    moves!(r,West)
    moves!(r,Sud)    
    move_back(r,Nord,num_ver)
    move_back(r,Ost,num_hor)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function paint_row(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
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