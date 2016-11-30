$ ->
  $.getJSON "./sas.json", (data)->
    now = new Date()

    for place in ["hiroba","sorami","sky","B3","2F10","3F12","s634","f350"]
      len = data["timetable"][place].length

      div_p = $("##{place}")

      flag = false
      for band, i in data["timetable"][place]
        s = new Date(band["start_time"])
        e = new Date(band["end_time"])

        if now >= s and now < e
          flag = true
          div = div_p.find(".now")

          time_text = time_str(s) + "〜" + time_str(e)

          div.find(".time").text(time_text)

          band_text = band["band"]
          band_text += "（#{band["circle"]}）" if band["circle"]
          div.find(".band").text(band_text)

          n = Math.max(0, Math.min(len-(i+1), 4))

          if n > 0
            for next_band in data["timetable"][place][(i+1)..(i+n)]
              next_date = new Date(next_band["start_time"])
              if now.getDate() == next_date.getDate()
                band_text = next_band["band"]
                band_text += "（#{next_band["circle"]}）" if next_band["circle"]
                next = "→ #{time_str(next_date)} #{band_text} "
                div_p.find(".next").append $('<p>').text(next)

          break
      div_p.find(".band").text("ただいま演奏していません") unless flag

time_str = (date)->
  ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2)
