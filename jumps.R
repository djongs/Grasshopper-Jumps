require(multicore)
require(ggplot2)
require(hexbin)

generate_jump <- function()
{
    x <- runif(1, -1, 1)
    y <- sqrt(1-x^2) * sample(c(-1,1),1)
    return(c(x,y))
}


generate_n_jump <- function(n)
{
    jumps <- lapply(1:n, function(x)generate_jump() )
    jumps <- do.call('rbind', jumps)
    jumps <- rbind(c(0,0), jumps) # initial state
    return(apply(jumps,2,cumsum))
    #return(jumps)
}


put_arrows <- function(jump_dataframe)
{
    x <- jump_dataframe[,1]
    y <- jump_dataframe[,2]
    for(i in 1:(dim(jump_dataframe)[1]-1))
    {
        arrows(x[i], y[i], x[i+1], y[i+1], lty=2)
    }
}


simulate_one <- function(n)
{
    jumps <- generate_n_jump(n)
    xmax <- max(jumps[,1]) ; xmin <- min(jumps[,1])
    ymax <- max(jumps[,2]) ; ymin <- min(jumps[,2])
    max <- max(xmax,ymax)
    min <- min(xmin, ymin)
    plot(jumps[,1], jumps[,2], ylim=c(min,max), xlim=c(min,max))
    put_arrows(jumps)
}


N_simulate <- function(N, n, cores)
{
    vetor <- rep(n, N)
    #sim <- lapply(vetor, function(x)generate_n_jump(x)[x+1,])
    sim <- mclapply(vetor, function(x)generate_n_jump(x)[x+1,], mc.cores=cores)
    sim <- do.call('rbind', sim)
    return(sim)
}


plot_density <- function(simulation)
{
    data.frame(simulation) -> simulation
    names(simulation) <- c('x', 'y')
    d <- ggplot(simulation, aes(x = x, y = y))
    plot(d + stat_binhex(bins=50) + scale_fill_gradient("Count", low = "green", high = "red") )
}

# Chamadas exemplos

#simulate_one(10)
#t1<-Sys.time()
#dados <- N_simulate(100000, 1000, cores=12)
#t2<-Sys.time()
#plot_density(dados)
