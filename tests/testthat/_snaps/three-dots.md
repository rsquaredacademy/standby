# glanceThreeDots() generates expected HTML

    Code
      glanceThreeDots()
    Output
      <div class="standby">
        <div class="dot-elastic standby-wait"></div>
      </div>

# threeDots() generates the correct HTML

    Code
      threeDots(plotOutput("plot"))
    Output
      <div class="standby">
        <div class="standby-wait dot-elastic" id="threedots"></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

