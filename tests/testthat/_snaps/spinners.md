# glanceSpinners() generates the correct HTML

    Code
      glanceSpinners()
    Output
      <div class="standby">
        <div class="load1">
          <div class="loader"></div>
        </div>
      </div>

# spinners() generates the correct HTML

    Code
      spinners(uiOutput = plotOutput("plot"), type = 1, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load1 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# spinners() generates the correct HTML when type is 2

    Code
      spinners(uiOutput = plotOutput("plot"), type = 2, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load2 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# spinners() generates the correct HTML when type is 3

    Code
      spinners(uiOutput = plotOutput("plot"), type = 3, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load3 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# spinners() generates the correct HTML when type is 4

    Code
      spinners(uiOutput = plotOutput("plot"), type = 4, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load4 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# spinners() generates the correct HTML when type is 5

    Code
      spinners(uiOutput = plotOutput("plot"), type = 5, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load5 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# spinners() generates the correct HTML when type is 8

    Code
      spinners(uiOutput = plotOutput("plot"), type = 8, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load8 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

