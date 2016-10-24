$ ->
  places =
    "sorami":"ソラミ坂ひろば"
    "B3":"地下3階エントランススペース"
    "3F9":"3階9番地エスカレーター横"
    "4F5":"4階5番地ツリービレッジエントランス横"
    "hiroba":"ソラマチひろば"
    "sky":"スカイアリーナ"
    "f350":"タワー天望デッキフロア350"

  $.getJSON "./sas.json", (data)->
    bands = []

    for place in ["sorami","B3","3F9","4F5","hiroba","sky","f350"]
      for band, i in data["timetable"][place]
        band["place"] = place
      bands = bands.concat data["timetable"][place]

    bands.sort (a,b) ->
      if a["start_time"] >= b["start_time"] then 1 else -1

    timetable = $("#timetable")
    for band in bands
      div = $('<div>').addClass('info')
      #div.data("id", band["id"])
      band_text = date_str(new Date(band["start_time"])) + "〜 " + band["band"]
      band_text += "<span class='circle'>（#{band["circle"]}）</span>" if band["circle"]
      div.append $('<p>').addClass("bandname").append(band_text)
      div.append $('<p>').addClass("date").text("＠" + places[band["place"]])
      timetable.append div

  $("#search_text").keyup ->
    result = $(".info:contains('#{$(this).val()}')")
    result.show()
    $(".info").not(result).hide()

  $("#search_reset").click ->
    $("#search_text").val("")
    $(".info").show()

date_str = (date)->
  date.getDate() + "日" + ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2)