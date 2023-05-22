# glanceVizLoad generates the correct HTML

    Code
      glanceVizLoad()
    Output
      <div class="standby">
        <div class="lv-bars lv-mid lg standby-wait">
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
        </div>
      </div>

# viz_bars() generates the correct HTML

    Code
      viz_bars()
    Output
      <div class="lv-bars lv-mid lg standby-wait">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>

# viz_squares() generates the correct HTML

    Code
      viz_squares()
    Output
      <div class="lv-squares lv-mid lg standby-wait">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>

# viz_circles() generates the correct HTML

    Code
      viz_circles()
    Output
      <div class="lv-circles lv-mid lg standby-wait">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>

# viz_dots() generates the correct HTML

    Code
      viz_dots()
    Output
      <div class="lv-dots lv-mid lg standby-wait">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>

# viz_spinner() generates the correct HTML

    Code
      viz_spinner()
    Output
      <div class="lv-spinner lv-mid lg standby-wait">
        <div></div>
      </div>

# viz_dashed() generates the correct HTML

    Code
      viz_dashed()
    Output
      <div class="lv-dashed lv-mid lg standby-wait">
        <div></div>
      </div>

# viz_line() generates the correct HTML

    Code
      viz_line()
    Output
      <div class="lv-line lg lv-mid standby-wait" style="height: 5px;">
        <div style="height: 5px;"></div>
      </div>

# viz_bordered_line() generates the correct HTML

    Code
      viz_bordered_line()
    Output
      <div class="lv-bordered_line lg lv-mid standby-wait" style="height: 21px;">
        <div style="height: 5px;"></div>
      </div>

# vizLoad() generates the correct HTML

    Code
      vizLoad(uiOutput = plotOutput("plot"), type = "bars", size = "large", color = "red",
      add_label = FALSE, label = "Loading...")
    Output
      <div class="standby">
        <div class="lv-bars lv-mid lg standby-wait">
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# vizLoad() generates the correct HTML when type is circles

    Code
      vizLoad(uiOutput = plotOutput("plot"), type = "circles", size = "large", color = "red",
      add_label = FALSE, label = "Loading...")
    Output
      <div class="standby">
        <div class="lv-circles lv-mid lg standby-wait">
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# vizLoad() generates the correct HTML when add_label is TRUE

    Code
      vizLoad(uiOutput = plotOutput("plot"), type = "bars", size = "large", color = "red",
      add_label = TRUE, label = "Loading...")
    Output
      <div class="standby">
        <div class="lv-bars lv-mid lg standby-wait" data-label="Loading...">
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
          <div style="background-color:red;"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

