class PagesController < ApplicationController
  def home
    #reset_session
    puts "//////////////////"
    '''
    res = BattlenetOauthService.ottieniId(session[:access_token])

    ids = res[0]
    teams = res[1]


    teams.each do |team|
      r = BattlenetOauthService.ottieniIdDaTeam(session[:access_token], team)
      ids = ids + r
    end


    ids = ids.uniq
    ids = ids.sort
'''

    ids = []
    min = 5500
    max = 6000

    for i in min...max    #primo valore a 3313
      ids.push(i)
    end
    volte = 0
    ids.each do |id|
      if volte < ids.size
        puts "#{volte}/#{ids.size}  => #{id}/#{max}"
        #BattlenetOauthService.infoId(session[:access_token], id)
        #BattlenetOauthService.infoEroiId(session[:access_token], id)
      end
      volte = volte + 1
    end
    #valori = Stat.pluck(:id) # Estrae tutti i valori della colonna dal database
    #risultato = valori.map { |valore| "\"#{valore}\"" }.join(",") # Formatta i valori nel formato richiesto
    #puts risultato
    puts "//////////////////"

  end
end


