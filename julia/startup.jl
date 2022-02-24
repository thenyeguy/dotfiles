# Automatically include some basic packages.
atreplinit() do repl
    @eval using DSP
    @eval using FFTW
    @eval using Plots
    @eval using Revise
    @eval using StatsBase

    # Configure kitty show plots inline.
    if ENV["TERM"] == "xterm-kitty"
        @eval using KittyTerminalImages
        Base.invokelatest(set_kitty_config!, :scale, 2.0)
        Base.invokelatest(set_kitty_config!, :prefer_png_to_svg, false)
        Base.invokelatest(Plots.theme, :gruvbox_dark)
    end
end
