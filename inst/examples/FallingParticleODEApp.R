# +++++++++++++++++++++++++++++++++++++++++++++++  example: FallingParticleApp.R
# Application that simulates the free fall of a ball using Euler ODE solver

importFromExamples("FallingParticleODE.R")      # source the class

FallingParticleODEApp <- function(verbose = FALSE) {
    # initial values
    initial_y <- 10
    initial_v <- 0
    dt <- 0.01
    ball <- FallingParticleODE(initial_y, initial_v)
    solver <- Euler(ball)                        # set the ODE solver
    solver <- setStepSize(solver, dt)            # set the step
    rowVector <- vector("list")
    i <- 1
    # stop loop when the ball hits the ground, state[1] is the vertical position
    while (ball@state[1] > 0) {
        rowVector[[i]] <- list(t  = ball@state[3],
                               y  = ball@state[1],
                               vy = ball@state[2])
        solver <- step(solver)                   # move one step at a time
        ball <- solver@ode                       # update the ball state
        i <- i + 1
    }
    DT <- data.table::rbindlist(rowVector)
    return(DT)
}
# show solution
solution <- FallingParticleODEApp()
plot(solution)
