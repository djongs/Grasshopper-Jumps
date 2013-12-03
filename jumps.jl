using DataFrames

function uniform(a,b)
    u = rand()
    return u*(b-a) + a
end


function generate_jump(r)
    theta = uniform(0,2)*pi
    x = r*cos(theta)
    y = r*sin(theta)
    return [x,y]
end


function generate_n_jump(n, r)
    place_xy = [0,0]
    for i=1:n
        jump = generate_jump(r)
        place_xy += jump
    end
    return place_xy
end


function simulate_jumps(N,n,r)
    x = zeros(N)
    y = zeros(N)
    for i=1:N
        xy = generate_n_jump(n, r)
        x[i] = xy[1]
        y[i] = xy[2]
    end
    return DataFrame(x=x,y=y)
end



#@elapsed simulate_jumps(100000, 1000, 1)


