$ ->
  if( $("#board").length > 0)

    incrementPage = ->
      el = $("a.load-more")
      href = el.attr('href')
      currentPage =  parseInt(href.match(/page=([0-9]+)/i)[1])
      el.attr "href", href.replace("page=#{currentPage}","page=#{currentPage + 1}")
      currentPage
    
    boardSelect = ->
      board = $("#board").val()
      eid = $("#eid-search").val()
      if(eid != "")
        eid = "?search=" + eid
      if(board == "Overall")
        window.location = "/" + eid
      else
        window.location = "/boards/" + board + eid
      
    searchFilter = ->
      val = $("#eid-search").val()
      if(val == "")
        $("#rankings li").removeClass("faded").removeClass("selected").removeClass("squished")
      else
        $("#rankings li").addClass("faded").removeClass("selected").removeClass("squished")
        $("#rankings li:contains(#{val})").removeClass("faded").addClass("selected")
        first = $(".leaderboard li:contains(#{val})").first()
        if(first.size() == 1)
          first.prev().prev().prev().prev().prev().prevAll().addClass('squished')
        else
          loadMore()
      false
     
    loadMore = ->
      path = $("a.load-more").attr('href')
      incrementPage()
      $.get path, (res)->
        $('#rankings').append(res)
        if res.trim().length < 50
          $("a.load-more").remove()
        searchFilter()
      false
    
    $("a.load-more").on 'inview', (e,isInView)->
      loadMore() if isInView
    .on 'click', loadMore

    $("#board").on 'change', boardSelect

    $("#eid-search").on 'keyup', searchFilter

    searchFilter()
