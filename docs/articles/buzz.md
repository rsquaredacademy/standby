# Alerts and Notifications

standby offers several types of alerts, notifications and tooltips. This
document is a quickstart guide for using standby in your Shiny
applications. Let us look at a simple example below:

[`library`](https://rdrr.io/r/base/library.html)`(`[`shiny`](https://shiny.posit.co/)`)`` `[`library`](https://rdrr.io/r/base/library.html)`(`[`standby`](https://standby.rsquaredacademy.com/)`)`` `` ``ui`` ``<-`` `[`fluidPage`](https://rdrr.io/pkg/shiny/man/fluidPage.html)`(`` `` `` `` `[`useToast`](https://standby.rsquaredacademy.com/reference/toast.md)`(``)``, ``# include dependencies`` `` `[`actionButton`](https://rdrr.io/pkg/shiny/man/actionButton.html)`(``inputId ``=`` ``"btn"``,`` `` label ``=`` ``"iziToast Demo"``)`` `` `` ``)`` `` `` ``server`` ``<-`` ``function``(``input``, ``output``, ``session``)`` ``{`` `` `` `[`observeEvent`](https://rdrr.io/pkg/shiny/man/observeEvent.html)`(``input``$``btn``, ``{`` `` ``# display toast notification`` `` `[`toast`](https://standby.rsquaredacademy.com/reference/toast.md)`(``"Hey there!"``, ``"Thank you for exploring buzz!"``)`` `` ``}``)`` ``}`` `` `[`shinyApp`](https://rdrr.io/pkg/shiny/man/shinyApp.html)`(``ui``, ``server``)`

To use alerts or notifications from **buzz** in your Shiny application,
follow the below steps:

- Include the dependencies in the **UI** part of the app using the
  appropriate `use*` functions
  ([`useToast()`](https://standby.rsquaredacademy.com/reference/toast.md)
  in the above example).
- Include the corresponding rendering function in the **Server** part of
  the app
  ([`toast()`](https://standby.rsquaredacademy.com/reference/toast.md)
  in the above example).

## Details

The below table displays the dependency and rendering functions along
with references:

| Index | Dependency | Render | Reference |
|---:|:---|:---|:---|
| 1 | [`useAlertify()`](https://standby.rsquaredacademy.com/reference/alertify.md) | [`alertify_alert()`](https://standby.rsquaredacademy.com/reference/alertify.md) | <https://github.com/MohammadYounes/AlertifyJS> |
| 2 | [`useAlertify()`](https://standby.rsquaredacademy.com/reference/alertify.md) | [`alertify_notify()`](https://standby.rsquaredacademy.com/reference/alertify.md) | <https://github.com/MohammadYounes/AlertifyJS> |
| 3 | [`useBootBox()`](https://standby.rsquaredacademy.com/reference/bootBox.md) | [`bootBox()`](https://standby.rsquaredacademy.com/reference/bootBox.md) | <https://github.com/bootboxjs/bootbox> |
| 4 | [`useMicroTip()`](https://standby.rsquaredacademy.com/reference/microTip.md) | [`microTip()`](https://standby.rsquaredacademy.com/reference/microTip.md) | <https://github.com/ghosh/microtip> |
| 5 | [`useNS()`](https://standby.rsquaredacademy.com/reference/notice.md) | [`notice()`](https://standby.rsquaredacademy.com/reference/notice.md) | <https://tympanus.net/Development/NotificationStyles/> |
| 6 | [`useNotify()`](https://standby.rsquaredacademy.com/reference/notify.md) | [`notify()`](https://standby.rsquaredacademy.com/reference/notify.md) | <https://github.com/sciactive/pnotify> |
| 7 | [`useTingle()`](https://standby.rsquaredacademy.com/reference/tingle.md) | [`tingle()`](https://standby.rsquaredacademy.com/reference/tingle.md) | <https://github.com/robinparisi/tingle> |
| 8 | [`useToast()`](https://standby.rsquaredacademy.com/reference/toast.md) | [`toast()`](https://standby.rsquaredacademy.com/reference/toast.md) | <https://github.com/marcelodolza/iziToast> |

Visit the [documentation](https://standby.rsquaredacademy.com) to learn
how to customize the alerts and notifications.
