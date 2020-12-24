function great_painter(r::Robot)
    side=Ost
    num_ver=moves!(r,Sud)
    num_hor=moves!(r,Ost)
    count=moves!(r,West)
    num_hor=count-num_hor
    while count>0
        putmarker!(r)
        for _ in 1:count
            move!(r,side)
            putmarker!(r)
        end
        if isborder(r,West)==false
            move!(r,West)
        end
        if isborder(r,Nord)==false
            move!(r,Nord)
            num_ver-=1
        else
            break
        end
        side=inverse(side)
        count-=1
    end
    putmarker!(r)
    moves!(r,West)
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