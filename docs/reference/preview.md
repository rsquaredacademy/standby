# Preview Alerts

Preview different types of alerts/notifications.

Preview different types of spinners/loaders.

## Usage

``` r
previewAlerts(type = "toast")

previewSpinners(spinner = "threedots")
```

## Arguments

- type:

  Type of alert/notification. Valid values are:

  - alertify

  - bootbox

  - notice

  - notify

  - tingle

  - toast

- spinner:

  Type of spinner. The following spinners are available:

  - threedots

  - spinkit

  - vizload

  - spinners

  - loaders

## Value

In an interactive session, a Shiny app object; otherwise `NULL`
invisibly.

In an interactive session, browsable HTML; otherwise `NULL` invisibly.
