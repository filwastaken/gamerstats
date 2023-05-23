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
    for i in 0..300
      ids.push(i)
    end
    volte = 0
    ids.each do |id|
      if volte < ids.size
        puts "#{id}/#{ids.size}"
        BattlenetOauthService.infoId(session[:access_token], id)
        BattlenetOauthService.infoEroiId(session[:access_token], id)
      end
      volte = volte + 1
    end
    puts "//////////////////"

  end
end


