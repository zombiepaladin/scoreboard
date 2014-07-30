$ ->
  $(".popup-trigger").on "click", () ->
    console.log this
    url = $(this).data("url")
    qr = $(this).data("qr")
    auto = $(this).data("auto")
    label = ""
    if(qr == true)
      label = "QR Code"
    else
      label = "Link"
    if( auto == true )
      $("#linkModal .modal-header h3").html("Auto-Completion URL")
      $("#linkModal .modal-body").html("<p>Following this link or scanning the qr code will automatically complete the task for a signed-in user.")
    else
      $("#linkModal .modal-header h3").html("Solve URL")
      $("#linkModal .modal-body").html("<p>Following this link or scanning the QR code will prompt the user for the answer to complete the task.")
    $("#linkModal .modal-body").prepend("<div class='link-display'>" + url + "</div>")
    qrDiv = $("<div/>").get(0)
    new QRCode qrDiv,
      width: 150
      height: 150
      text: url
      correctLevel: QRCode.CorrectLevel.L
    $("#linkModal .modal-body").prepend(qrDiv);    
    $("#linkModal").modal("show")
  
###
  codeCount = 0
  $("[data-qr=true]").popover
    title: "Task Completion QR Code"
    placement: 'left'
    html: true
    trigger: 'manual'
    content: ->
      link = $(@).attr("href")
      div = $("<div/>").get(0)
      new QRCode div,
        width: 150
        height: 150
        text: link
        correctLevel: QRCode.CorrectLevel.L
      div
  .click ->
    $("[data-qr]").not(@).popover('hide')
    $(@).popover('toggle')
    false
###