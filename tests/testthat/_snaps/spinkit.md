# glanceSpinkit() generates the correct HTML

    Code
      glanceSpinkit(color = "red", width = "25px", height = "25px")
    Output
      <div class="standby">
        <div class="sk-plane standby-wait" style="width:25px; height:25px; background-color:red;"></div>
      </div>

# spinkit_plane() generates the correct HTML

    Code
      spinkit_plane(color = "#333", size = "40px")
    Output
      <div class="sk-plane standby-wait" style="width: 40px; height: 40px; background-color: #333;"></div>

# spinkit_chase() generates the correct HTML

    Code
      spinkit_chase(size = "40px")
    Output
      <div class="sk-chase standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
      </div>

# spinkit_bounce() generates the correct HTML

    Code
      spinkit_bounce(color = "#333", size = "40px")
    Output
      <div class="sk-bounce standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-bounce-dot" style="background-color:#333;"></div>
        <div class="sk-bounce-dot" style="background-color:#333;"></div>
      </div>

# spinkit_wave() generates the correct HTML

    Code
      spinkit_wave(color = "#333", size = "40px")
    Output
      <div class="sk-wave standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-wave-rect" style="background-color:#333;"></div>
        <div class="sk-wave-rect" style="background-color:#333;"></div>
        <div class="sk-wave-rect" style="background-color:#333;"></div>
        <div class="sk-wave-rect" style="background-color:#333;"></div>
        <div class="sk-wave-rect" style="background-color:#333;"></div>
      </div>

# spinkit_pulse() generates the correct HTML

    Code
      spinkit_pulse(color = "#333", size = "40px")
    Output
      <div class="sk-pulse standby-wait" style="width: 40px; height: 40px; background-color:#333;"></div>

# spinkit_flow() generates the correct HTML

    Code
      spinkit_flow(color = "#333", size = "40px")
    Output
      <div class="sk-flow standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-flow-dot" style="background-color:#333;"></div>
        <div class="sk-flow-dot" style="background-color:#333;"></div>
        <div class="sk-flow-dot" style="background-color:#333;"></div>
      </div>

# spinkit_swing() generates the correct HTML

    Code
      spinkit_swing(color = "#333", size = "40px")
    Output
      <div class="sk-swing standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-swing-dot" style="background-color:#333;"></div>
        <div class="sk-swing-dot" style="background-color:#333;"></div>
        <div class="sk-swing-dot" style="background-color:#333;"></div>
      </div>

# spinkit_circle() generates the correct HTML

    Code
      spinkit_circle(size = "40px")
    Output
      <div class="sk-circle standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
        <div class="sk-circle-dot"></div>
      </div>

# spinkit_circle_fade() generates the correct HTML

    Code
      spinkit_circle_fade(size = "40px")
    Output
      <div class="sk-circle-fade standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
        <div class="sk-circle-fade-dot"></div>
      </div>

# spinkit_grid() generates the correct HTML

    Code
      spinkit_grid(color = "#333", size = "40px")
    Output
      <div class="sk-grid standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
        <div class="sk-grid-cube" style="background-color:#333;"></div>
      </div>

# spinkit_wander() generates the correct HTML

    Code
      spinkit_wander(color = "#333", size = "40px")
    Output
      <div class="sk-wander standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-wander-cube" style="background-color:#333;"></div>
        <div class="sk-wander-cube" style="background-color:#333;"></div>
        <div class="sk-wander-cube" style="background-color:#333;"></div>
        <div class="sk-wander-cube" style="background-color:#333;"></div>
      </div>

# spinkit_fold() generates the correct HTML

    Code
      spinkit_fold(size = "40px")
    Output
      <div class="sk-fold standby-wait" style="width: 40px; height: 40px;">
        <div class="sk-fold-cube"></div>
        <div class="sk-fold-cube"></div>
        <div class="sk-fold-cube"></div>
        <div class="sk-fold-cube"></div>
      </div>

# spinkit() generates the correct HTML

    Code
      spinkit(uiOutput = plotOutput("plot"), type = "plane", color = "#333", size = "40px")
    Output
      <div class="standby">
        <div class="sk-plane standby-wait" style="width: 40px; height: 40px; background-color: #333;"></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

