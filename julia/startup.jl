# Automatically include some basic packages.
atreplinit() do repl
    @eval using DSP
    @eval using FFTW
    @eval using Plots
    @eval using Revise
    @eval using StatsBase
end
