pro battle
  raquelle_hp=16384.;define beginning stats
  barbie_hp=8000.
  ken_hp=8000.
  nikki_hp=8000.
  ryan_hp=8000.
  barbie_mp=149.
  ken_mp=99.
  nikki_mp=129.
  ryan_mp=199.
  ;def_hold=0.
  atk_hold=0.
  def_order=0.
  atk_order=0.
  statsarray=[[raquelle_hp], [barbie_hp], [ken_hp], [nikki_hp], [ryan_hp], [barbie_mp], [ken_mp], [nikki_mp], [ryan_mp], [def_order], [atk_hold], [atk_order]]
  mainscreen=mrdfits('Main_battle_screenfits.fit', 0)
  display, mainscreen
  pow=mrdfits('pow.fit', 0)
  perfume1=mrdfits('perfume1.fit', 0)
  perfume2=mrdfits('perfume2.fit', 0)
  perfume3=mrdfits('perfume3.fit', 0)
  perfume4=mrdfits('perfume4.fit', 0)
  music1=mrdfits('music1.fit', 0)
  music2=mrdfits('music2.fit', 0)
  music3=mrdfits('music3.fit', 0)
  music4=mrdfits('music4.fit', 0)
  pet1=mrdfits('pet1.fit', 0)
  pet2=mrdfits('pet2.fit', 0)
  pet3=mrdfits('pet3.fit', 0)
  pet4=mrdfits('pet4.fit', 0)
  stiletto1=mrdfits('barbiestiletto.fit', 0)
  stiletto2=mrdfits('kenstiletto.fit', 0)
  stiletto3=mrdfits('Nikkistiletto.fit', 0)
  stiletto4=mrdfits('Ryanstiletto.fit', 0)
  machodefense=mrdfits('machodefense.fit', 0)
  barbiemakeover1=mrdfits('barbiemakeover1.fit', 0)
  barbiemakeover2=mrdfits('barbiemakeover2.fit', 0)
  kenmakeover1=mrdfits('kenmakeover1.fit', 0)
  kenmakeover2=mrdfits('kenmakeover2.fit', 0)
  nikkimakeover1=mrdfits('nikkimakeover1.fit', 0)
  nikkimakeover2=mrdfits('nikkimakeover2.fit', 0)
  ryanmakeover1=mrdfits('ryanmakeover1.fit', 0)
  ryanmakeover2=mrdfits('ryanmakeover2.fit', 0)
  unswoon1=mrdfits('unswoon1.fit', 0)
  unswoon2=mrdfits('unswoon2.fit', 0)
  unswoon3=mrdfits('unswoon3.fit', 0)
  while (raquelle_hp GT 0) do begin;while raquelle is alive do begin
     statsarray=barbieturn(statsarray, pow, perfume1, perfume2, perfume3, perfume4, mainscreen, pet1, pet2, pet3, pet4)
     statsarray=overflow_check(statsarray)
     statsarray=kenturn(statsarray, pow, mainscreen, machodefense, unswoon1, unswoon2, unswoon3)
     statsarray=overflow_check(statsarray)
     statsarray=nikkiturn(statsarray, pow, music1, music2, mainscreen, barbiemakeover1, barbiemakeover2, kenmakeover1, kenmakeover2, nikkimakeover1, nikkimakeover2, ryanmakeover1, ryanmakeover2)
     statsarray=overflow_check(statsarray)
     statsarray=ryanturn(statsarray, pow, music1, music2, music3, music4, mainscreen)
     statsarray=overflow_check(statsarray)
     statsarray=raquelleturn(statsarray, stiletto1, stilleto2, stiletto3, stiletto4, mainscreen)
     statsarray=overflow_check(statsarray)
     if (statsarray(1) LT 1) AND (statsarray(2) LT 2) AND (statsarray(3) LT 1) AND (statsarray(4) LT 1) then begin
        print, "Everyone is swooned"
        goto, endgame
     endif
     ;incorporate def order in Raquelle's AI if (statsarray(11)=1)
     ;if (statsarray(9) EQ 0) then begin ;if def wasn't increased for the next turn
      ;  statsarray(11)=0.                ;makesure damage is normal
     ;endif
     ;if (statsarray(9) EQ 1) then begin;if def was increased for next turn
      ;  statsarray(9)=0.;make sure it doesn't remain increased without player's input 
        ;statsarray(11)=1.;increase defense for next turn
     ;endif
     if (statsarray(10) EQ 0) then begin
        statsarray(11)=0
     endif
     if (statsarray(10) EQ 1) then begin
        statsarray(11)=1
        statsarray(10)=0
     endif
  endwhile
  print, "Congratualations you won the game!! If I ever have time to program it the name of the procedure to run the bonus boss battle is street_fighter"
endgame: 
end
function barbieturn, statsarrayinput, powinput, perfumeframe1, perfumeframe2, perfumeframe3, perfumeframe4, mainbattleinput, petframe1, petframe2, petframe3, petframe4
  statsarray=statsarrayinput;define the beginning stat differences, they are zero cuz nothing happened yet
  pow=powinput
  perfume1=perfumeframe1
  perfume2=perfumeframe2
  perfume3=perfumeframe3
  perfume4=perfumeframe4
  pet1=petframe1
  pet2=petframe2
  pet3=petframe3
  pet4=petframe4
  mainscreen=mainbattleinput
  if (statsarray(1) GT 0.) then begin                                    ;if barbie is alive let her battle
     barbie_move=""                                                 ;define her move as a string
     barbie_command: read, "What will Barbie do?", barbie_move      ;ask for a command for barbie
     if (barbie_move EQ "attack") then begin                        ;if you command barbie to physically attack
        barbie_damage=175.*(1.+(.2*Randomu(Seed)))                    ;Barbie does base damage of 150 with 20% randomness
        if (statsarray(11) EQ 1.) then begin                              ;if the atk order is turned on by nikki
           barbie_damage=barbie_damage*1.5                             ; increase damage by 50%
        endif
        str_barbie_damage=string(barbie_damage)                     ;turn Barbie's damage into a string to display
        display, pow
        wait, .75
        display, mainscreen
        print, "Barbie did"+str_barbie_damage+" damage"           ;display the damage barbie did
        statsarray(0)=statsarray(0)-barbie_damage                   ;take away damage from raquelle health
     endif
     if (barbie_move EQ "pet fury") then begin
        if (statsarray(5)-35 LT 0) then begin
           print, "Barbie doesn't have enough mp"
           goto, barbie_command
        endif else begin
           statsarray(5)=statsarray(5)-35
           barbie_damage=600.*(1.+(.2*Randomu(Seed))) ;Barbie does base damage of 150 with 20% randomness
           if (statsarray(11) EQ 1.) then begin       ;if the atk order is turned on by nikki
              barbie_damage=barbie_damage*1.5         ; increase damage by 50%
           endif
           str_barbie_damage=string(barbie_damage)      ;turn Barbie's damage into a string to display
           display, pet1
           wait, .75
           display, pet2
           wait, .75
           display, pet3
           wait, .75
           display, pet4
           wait, .75
           display, mainscreen
           print, "Barbie did"+str_barbie_damage+" damage" ;display the damage barbie did
           statsarray(0)=statsarray(0)-barbie_damage       ;take away damage from raquelle health
        endelse
     endif
     if (barbie_move EQ "fragrance storm") then begin  ;if you choose to run fragrance storm 
        if (statsarray(5)-30. LT 0) then begin              ;if barbie doesn't have enough mp   
           print, "Barbie doesn't have enough mp"      ;inform player 
           goto, barbie_command ;startover                                                                                                                                      
        endif else begin
           statsarray(5)=statsarray(5)-30.;take away 30 mp
           display, perfume1;animate the ability
           wait, .75
           display, perfume2
           wait, .75
           display, perfume3
           wait, .75
           display, perfume4
           wait, .75
           display, mainscreen
           barbie_healed=400.*(1.+(.1*randomu(Seed))) ;heal barbie
           str_barbie_healed=string(barbie_healed)
           print, "Barbie recovered"+str_barbie_healed+" hp"
           statsarray(1)=statsarray(1)+barbie_healed
           barbie_healed=400.*(1.+(.1*randomu(Seed))) ;heal ken
           str_barbie_healed=string(barbie_healed)
           print, "Ken recovered"+str_barbie_healed+" hp"
           statsarray(2)=statsarray(2)+barbie_healed
           barbie_healed=400.*(1.+(.1*randomu(Seed))) ;heal Nikki
           str_barbie_healed=string(barbie_healed)
           print, "Nikki recovered"+str_barbie_healed+" hp"
           statsarray(3)=statsarray(3)+barbie_healed
           barbie_healed=400.*(1.+(.1*randomu(Seed))) ;heal Ryan
           str_barbie_healed=string(barbie_healed)
           print, "Ryan recovered"+str_barbie_healed+" hp"
           statsarray(4)=statsarray(4)+barbie_healed
        endelse
     endif
     if (barbie_move EQ "do nothing") then begin ;if you want to do nothing
     endif
     if (barbie_move NE "attack") AND (barbie_move NE "fragrance storm") AND (barbie_move NE "pet fury") AND (barbie_move NE "do nothing") then begin
        print, "Barbie does not understand"
        goto, barbie_command
     endif
  endif
  return, statsarray
end
function kenturn, statsarrayinput, powinput, mainscreeninput, machodefenseinput, unswoon1, unswoon2, unswoon3
  statsarray=statsarrayinput
  pow=powinput
  mainscreen=mainscreeninput
  machodefense=machodefenseinput
  if (statsarray(2) GT 0) then begin
     ken_move=""
     ken_command: read, "What will Ken do?", ken_move
     if (ken_move NE "attack") AND (ken_move NE "macho defense") AND (ken_move NE "unswoon") AND (ken_move NE "do nothing") then begin
        print, "ken does not understand"
        goto, ken_command
     endif
     if (ken_move EQ "attack") then begin
        ken_damage=150.*(1.+(.2*randomu(Seed)))
        if (statsarray(11) EQ 1) then begin
           ken_damage=ken_damage*1.5
        endif
        str_ken_damage=string(ken_damage)         ;turn Ken's damage into a string to display
        display, pow
        wait, .75
        display, mainscreen
        print, "Ken did"+str_ken_damage+" damage" ;display the damage ken did
        statsarray(0)=statsarray(0)-ken_damage              ;take away damage from raquelle health
     endif
     if (ken_move EQ "do nothing") then begin ;if you want to do nothing
     endif
     if (ken_move EQ "macho defense") then begin
        if (statsarray(6) LT 15) then begin
           print, "Ken does not have enough Mp"
           goto, ken_command
        endif else begin
           statsarray(6)=statsarray(6)-15
           statsarray(9)=1
           display, machodefense
           wait, .75
           display, mainscreen
           print, "Party will be protected for next attack"
        endelse 
     endif
     if (ken_move EQ "unswoon") then begin
        if (statsarray(6) LT 30) then begin     ;if he doesn't have enough mp
           print, "Ken does not have enough Mp" ;inform player
           goto, ken_command
        endif else begin
           unswoon_target=""                                                          ;make the target a string to be asked
           read, "On whom?", unswoon_target                                           ;ask for the target
           if (unswoon_target EQ "Barbie") OR (unswoon_target EQ "barbie") then begin ;if Ken targets barbie
              if (statsarray(1) NE 0) then begin                                      ;if she isn't swooned
                 print, "Barbie isn't swooned"                                        ;inform player
                 goto, ken_command                                                    ;startover
              endif else begin    ;otherwise
                 statsarray(6)=statsarray(6)-30                       ;take away 30 mp          
                 ken_healed=350.*(1.+(.1*randomu(Seed)))                                 ;heal barbie
                 str_ken_healed=string(ken_healed)                                       ;turn amount into string
                 display, unswoon1
                 wait, .75
                 display, mainscreen
                 print, "Barbie revived with"+str_barbie_healed+" hp" ;tell player
                 statsarray(1)=statsarray(1)+barbie_healed                               ;add it to barbie's health
              endelse
           endif
           if (unswoon_target EQ "Nikki") OR (unswoon_target EQ "nikki") then begin
              if (statsarray(3) NE 0) then begin
                 print, "Nikki isn't swooned"
                 goto, ken_command ;start over
              endif else begin
                 statsarray(6)=statsarray(6)-30          ;take away 30 mp          
                 ken_healed=800.*(1.+(.1*randomu(Seed)))    ;heal nikki
                 str_ken_healed=string(ken_healed)
                 display, unswoon2
                 wait, .75
                 display, mainscreen
                 print, "Nikki revived with"+str_ken_healed+" hp"
                 statsarray(3)=statsarray(3)+ken_healed
              endelse
           endif
           if (unswoon_target EQ "Ryan") OR (unswoon_target EQ "ryan") then begin
              if (statsarray(4) NE 0) then begin
                 print, "Ryan isn't swooned"
                 goto, ken_command ;start over
              endif else begin
                 statsarray(6)=statsarray(6)-30          ;take away 30 mp          
                 ken_healed=800.*(1.+(.1*randomu(Seed)))    ;heal nikki
                 str_ken_healed=string(ken_healed)
                 display, unswoon3
                 wait, .75
                 display, mainscreen
                 print, "Ryan revived with"+str_ken_healed+" hp"
                 statsarray(4)=statsarray(4)+ken_healed
              endelse
           endif
           if (unswoon_target NE "Barbie") AND (unswoon_target NE "barbie")  AND (unswoon_target NE "Nikki") AND (unswoon_target NE "nikki") AND (unswoon_target NE "Ryan") AND (unswoon_target NE "ryan") then begin ;if user does not input valid target
              print, "Ken does not understand"
              goto, ken_command
           endif
        endelse
     endif
     if (ken_move EQ "do nothing") then begin ;if you want to do nothing
     endif
     if (ken_move NE "attack") AND (ken_move NE "unswoon") AND (ken_move NE "macho defense") AND (ken_move NE "do nothing") then begin
        print, "Ken does not understand"
        goto, ken_command
     endif
  endif                         ;if ken is alive
  return, statsarray
end
function nikkiturn, statsarrayinput, powinput, music1frame, music2frame, mainbattleinput, barbiemakeover1, barbiemakeover2, kenmakeover1, kenmakeover2, nikkimakeover1, nikkimakeover2, ryanmakeover1, ryanmakeover2 
  statsarray=statsarrayinput;bring in the stats array
  pow=powinput
  music1=music1frame
  music2=music2frame
  mainscreen=mainbattleinput
  if (statsarray(3) GT 0) then begin ;if nikki's alive she gets to do stuff
     nikki_move=""                  ;
     nikki_command: read, "What will Nikki do?", nikki_move
     if (nikki_move EQ "attack") then begin
        nikki_damage=250.*(1.+(.2*randomu(Seed)));define nikki's damage
        if (statsarray(11) EQ 1) then begin
           nikki_damage=nikki_damage*1.5;increase it if atk buff is in effect
        endif                           ;if damage bonus is on
        str_nikki_damage=string(nikki_damage)                     ;turn Nikki's damage into a string to display
        display, pow
        wait, .75
        display, mainscreen
        print, "Nikki did"+str_nikki_damage+" damage" ;display the damage ken did
        statsarray(0)=statsarray(0)-nikki_damage                   ;take away damage from raquelle health
     endif;if nikki attacks
     if (nikki_move EQ "bend and snap DJ") then begin ;if the player wants bend and snap dj
        if (statsarray(7) LT 15) then begin
           print, "Nikki does not have enough Mp"
           goto, nikki_command
        endif else begin        ;if nikki doesn't have enough mp
           statsarray(7)=statsarray(7)-15
           statsarray(10)=1
           display, music1
           wait, .75
           display, music2
           wait, .75
           display, mainbattleinput
           print, "Party will be pumped next turn"
        endelse;else nikki does have enough hp 
     endif     ;if player chose bend and snap
     if (nikki_move EQ "makeover") then begin   ;if barbie does fragrance storm
        if (statsarray(7)-10. LT 0.) then begin      ;if barbie doesn't have enough mp it fails and prompt the player to try something else
           print, "Nikki doesn't have enough mp"
           goto, nikki_command
        endif else begin                                                                     ;if barbie does have enough mp continue with the ability
           makeover_target=""                                                                ;make the target a string to be asked
           read, "On whom?", makeover_target                                                 ;ask for the target
           if (makeover_target EQ "Barbie") OR (makeover_target EQ "barbie") then begin      ;if barbie targets barbie
              statsarray(7)=statsarray(7)-10                                                 ;take away 10 mp          
              barbie_healed=800.*(1.+(.1*randomu(Seed)))                                     ;heal barbie
              str_barbie_healed=string(barbie_healed)                                        ;turn the amount healled into string
              display, barbiemakeover1
              wait, .75
              display, barbiemakeover2
              wait, .75
              display, mainscreen
              print, "Barbie recovered"+str_barbie_healed+" hp" ;print the amount healed
              statsarray(1)=statsarray(1)+barbie_healed                                      ;add amount healed to barbie hp
           endif
           if (makeover_target EQ "Ken") OR (makeover_target EQ "ken") then begin
              statsarray(7)=statsarray(7)-10                 ;take away 10 mp          
              barbie_healed=800.*(1.+(.1*randomu(Seed)))                                     ;heal barbie
              str_barbie_healed=string(barbie_healed)                                        ;turn amount into string
              display, kenmakeover1
              wait, .75
              display, kenmakeover2
              wait, .75
              display, mainscreen
              print, "Ken recovered"+str_barbie_healed+" hp" ;print amount healed
              statsarray(2)=statsarray(2)+barbie_healed                                      ;add amount healed to ken hp
           endif
           if (makeover_target EQ "Nikki") OR (makeover_target EQ "nikki") then begin
              statsarray(7)=statsarray(7)-10
              barbie_healed=800.*(1.+(.1*randomu(Seed)))                                     ;heal Nikki
              str_barbie_healed=string(barbie_healed)                                        ;turn amount into string
              display, nikkimakeover1
              wait, .75
              display, nikkimakeover2
              wait, .75
              display, mainscreen
              print, "Nikki recovered"+str_barbie_healed+" hp" ;print amount healed
              statsarray(3)=statsarray(3)+barbie_healed                                        ;add amount healed to ken hp
           endif                                                                             ;if target is nikki
           if (makeover_target EQ "Ryan") OR (makeover_target EQ "ryan") then begin
              statsarray(7)=statsarray(7)-10
              barbie_healed=800.*(1.+(.1*randomu(Seed)))                                     ;heal Ryan
              str_barbie_healed=string(barbie_healed)                                        ;turn amount into string
              display, ryanmakeover1
              wait, .75
              display, ryanmakeover2
              wait, .75
              display, mainscreen
              print, "Ryan recovered"+str_barbie_healed+" hp" ;print amount healed
              statsarray(4)=statsarray(4)+barbie_healed                                      ;add amount healed to ken hp
           endif                                                                             ;if target is ryan
           if (makeover_target NE "Barbie") AND (makeover_target NE "barbie") AND (makeover_target NE "Ken") AND (makeover_target NE "ken") AND (makeover_target NE "Nikki") AND (makeover_target NE "nikki") AND (makeover_target NE "Ryan") AND (makeover_target NE "ryan") then begin
              print, "Nikki does not understand"
              goto, nikki_command
           endif                ;if target is unrecognizable
        endelse
     endif
     if (nikki_move EQ "do nothing") then begin ;if you want to do nothing
     endif 
     if (nikki_move NE "do nothing") AND (nikki_move NE "attack") AND (nikki_move NE "bend and snap DJ") AND (nikki_move NE "makeover") then begin
        print, "Nikki does not understand"
        goto, nikki_command
     endif
  endif                         ;end the if when nikki is alive
  return, statsarray
end
function ryanturn, statsarrayinput, powinput, music1frame, music2frame, music3frame, music4frame, mainbattleinput
  statsarray=statsarrayinput
  pow=powinput
  music1=music1frame
  music2=music2frame
  music3=music3frame
  music4=music4frame
  mainscreen=mainbattleinput
if (statsarray(4) GT 0) then begin ;if Ryan is alive he gets to do stuff
     ryan_move=""                  ;
     ryan_command: read, "What will Ryan do?", ryan_move
     if (ryan_move EQ "attack") then begin
        ryan_damage=200.*(1.+(.2*randomu(Seed)));define Ryan's damage
        if (statsarray(11) EQ 1) then begin
           ryan_damage=ryan_damage*1.5;increase it if atk buff is in effect
        endif                           ;if damage bonus is on
        str_ryan_damage=string(ryan_damage)                     ;turn Nikki's damage into a string to display
        display, powinput
        wait, .75
        display, mainscreen
        print, "Ryan did"+str_ryan_damage+" damage" ;display the damage ken did
        statsarray(0)=statsarray(0)-ryan_damage                   ;take away damage from raquelle health
     endif;if ryan attacks
     if (ryan_move EQ "jam out") then begin;if player chooses serenade
        if (statsarray(8) LT 30) then begin;if Ryan doesn't have enough Mp
           print, "Ryan does not have enough Mp"
           goto, ryan_command
        endif else begin;if ryan does have enough Mp
           statsarray(8)=statsarray(8)-35;take away 30 Mp from Ryan
           mp_buff=[[0], [0], [0], [0], [0], [20], [20], [20], [0], [0], [0], [0]]
           mp_buff=float(mp_buff)
           statsarray=statsarray+mp_buff
           display, music1
           wait, .75
           display, music2
           wait, .75
           display, mainscreen
           print, "Everyone else regained 20 Mp"
        endelse;end else ryan having enough mp
     endif                      ;if player chooses serenade
     if (ryan_move EQ "serenade") then begin
        if (statsarray(8) LT 1) then begin
           print, "Ryan does not have enough Mp"
           goto, ryan_command
        endif else begin
           display, music3
           wait, .75
           display, music4
           wait, .75
           display, mainscreen
           print, "Ryan serenaded Barbie revitalizing 40 Mp"
           statsarray(8)=statsarray(8)+50
        endelse
     endif
  endif;if ryan is alive
return, statsarray
end
function overflow_check, inputstatsarray
  statsarray=inputstatsarray
  if (statsarray(0) GT 16384.) then begin ;if Raquelle's hp overflows
     statsarray(0)=16384.                 ;set it to max
     raquellehp=string(statsarray(0))
     print, "Raquelle's hp is"+raquellehp  ;display her hp
  endif else begin              ;else display her hp normally
     barbiemp=string(statsarray(0))
     print, "Raquelle's hp is"+barbiemp
  endelse
  if (statsarray(1) GT 8000.) then begin ;if Barbie's hp overflows                         
     statsarray(1)=8000.                 ;set it to max
     barbiehp=string(statsarray(1))
     print, "Barbie's hp is"+barbiehp    ;display her hp
  endif else begin                         ;if it doesn't overflow
     if (statsarray(1) LT 0) then begin    ;if it underflows
        statsarray(1)=0                    ;set it to 0
        print, "Barbie is swooned"         ;state that she is swooned
     endif
     barbiehp=string(statsarray(2))
     print, "Barbie's hp is"+barbiehp    ;otherwise display normally
  endelse
  if (statsarray(2) GT 8000.) then begin ;if Ken's hp overflows                         
     statsarray(2)=8000.                 ;set it to max
     kenhp=string(statsarray(2))
     print, "Ken's hp is"+kenhp                ;display his hp
  endif else begin                         ;if it doesn't overflow
     if (statsarray(2) LT 0) then begin    ;if it underflows
        statsarray(2)=0                    ;set it to 0
        print, "Ken is swooned"            ;state that he is swooned
     endif
     kenhp=string(statsarray(2))
     print, "Ken's hp is"+kenhp       ;otherwise display normally
  endelse
  if (statsarray(3) GT 8000.) then begin
     statsarray(3)=8000.
     nikkihp=string(statsarray(3))
     print, "Nikki's hp is"+nikkihp
  endif else begin
     if (statsarray(3) LT 0) then begin
        statsarray(3)=0
        print, "Nikki is swooned"
     endif
     nikkihp=string(statsarray(3))
     print, "Nikkie's hp is"+nikkihp
  endelse
  if (statsarray(4) GT 8000.) then begin
     statsarray(4)=8000.
     ryanhp=string(statsarray(4))
     print, "Ryan's hp is"+ryanhp
  endif else begin
     if (statsarray(4) LT 0) then begin
        statsarray(4)=0
        print, "Ryan is swooned"
     endif
     ryanhp=string(statsarray(4))
     print, "Ryan's hp is"+ryanhp
  endelse
  if (statsarray(5) GT 149.) then begin ;if Barbie's mp overflows
     statsarray(5)=149.                 ;set it to max
     barbiemp=string(statsarray(5))
     print, "Barbie's Mp is"+barbiemp    ;display her mp
  endif else begin              ;if Barbie's mp doesn't overflow   
     barbiemp=string(statsarray(5))
     print, "Barbie's Mp is"+barbiemp    ;display mp normally
  endelse
  if (statsarray(6) GT 99.) then begin ;if Ken's mp overflows
     statsarray(6)=99.                 ;set it to max
     kenmp=string(statsarray(6))
     print, "Ken's Mp is"+kenhp              ;display his mp
  endif else begin              ;if Ken's mp doesn't overflow
     kenmp=string(statsarray(6))
     print, "Ken's Mp is"+kenmp       ;display mp normally
  endelse
  if (statsarray(7) GT 129.) then begin 
     statsarray(7)=129.
     kenmp=string(statsarray(7))
     print, "Nikki's Mp is"+kenmp
  endif else begin
     nikkimp=string(statsarray(7))
     print, "Nikki's Mp is"+nikkimp
  endelse
  if (statsarray(8) GT 199) then begin
     statsarray(8)=199
     ryanmp=string(statsarray(8))
     print, "Ryan's Mp is"+ryanmp
  endif else begin
     ryanmp=string(statsarray(8))
     print, "Ryan's Mp is"+ryanmp
  endelse
  return, statsarray
end
function raquelleturn, inputstatsarray, stiletto1, stiletto2, stiletto3, stiletto4, mainscreen
  statsarray=inputstatsarray
  raquelle_command: raquelle_move=fix(4*randomu(seed))
  if (raquelle_move EQ 0) then begin
     goto, raquelle_command
  endif                         ;if raquelle rolls a zero
  if (raquelle_move EQ 1) then begin;if racquelle rolls a one she does her stiletto attack
     raquelle_targeting: raquelle_target=fix(5*randomu(seed));she rolls a random target
     if (raquelle_target EQ 0) OR (raquelle_target EQ 5) then begin
        goto, raquelle_targeting
     endif;if raquelle rolls a 0 or a 1
     raquelle_damage=750.*(1.+(.2*randomu(Seed))) ;define Raquelle's damage
     if (statsarray(9) EQ 1) then begin
        raquelle_damage=raquelle_damage*.75 ;decrease damage if def buff is in effect
     endif      ;if def buff is on
     if (raquelle_target EQ 1) then begin;if racquelle targets barbie
        print, "Raquelle attacked Barbie with a stiletto"
        str_raquelle_damage=string(raquelle_damage)                   ;turn Raquelle's damage into a string to display
        display, stiletto1
        wait, .75
        display, mainscreen
        print, "Raquelle did"+str_raquelle_damage+" damage on Barbie" ;display the damage Raquelle did
        statsarray(1)=statsarray(1)-raquelle_damage;take away damage from barbie's health
     endif;if raquelle targets barbie
     if (raquelle_target EQ 2) then begin;if racqeulle targets ken
        print, "Raquelle attacked Ken with a stiletto"
        str_raquelle_damage=string(raquelle_damage)                   ;turn Raquelle's damage into a string to display
        display, stiletto2
        wait, .75
        display, mainscreen
        print, "Raquelle did"+str_raquelle_damage+" damage on Ken" ;display the damage Raquelle did
        statsarray(2)=statsarray(2)-raquelle_damage;take away damage from ken's health
     endif;if raquelle targets ken
     if (raquelle_target EQ 3) then begin;if raquelle targets Nikki
        print, "Raquelle attacked Nikki with a stiletto"
        str_raquelle_damage=string(raquelle_damage)                   ;turn Raquelle's damage into a string to display
        display, stiletto3
        wait, .75
        display, mainscreen
        print, "Raquelle did"+str_raquelle_damage+" damage on Nikki" ;display the damage Raquelle did
        statsarray(3)=statsarray(3)-raquelle_damage;take away damage from Nikki's health
     endif;if raqelle targets Nikki
     if (raquelle_target EQ 4) then begin
        print, "Raquelle attack Ryan with a stiletto"
        display, stiletto4
        wait, .75
        display, mainscreen
        str_raquelle_damage=string(raquelle_damage)                 ;turn Raquelle's damage into a string to display
        print, "Raquelle did"+str_raquelle_damage+" damage on Ryan"             ;display the damage Raquelle did
        statsarray(4)=statsarray(4)-raquelle_damage;take away damage from barbie's health
     endif;if raquelle targets Ryan
  endif;if raquelle rolls a 1
  if (raquelle_move EQ 2) then begin;if raquelle does her hit all, not that i copy and pasted from fragrance storm 
     print, "Raquelle threw everything but the kitchen sink"
     barbie_healed=500.*(1.+(.1*randomu(Seed))) ;heal barbie
     if (statsarray(9) EQ 1) then begin
        barbie_healed=barbie_healed*.75 ;decrease damage if def buff is in effect
     endif
     str_barbie_healed=string(barbie_healed)
     print, "Barbie suffered"+str_barbie_healed+" damage"
     statsarray(1)=statsarray(1)-barbie_healed
     barbie_healed=500.*(1.+(.1*randomu(Seed))) ;heal ken
     if (statsarray(9) EQ 1) then begin
        barbie_healed=barbie_healed*.75 ;decrease damage if def buff is in effect
     endif
     str_barbie_healed=string(barbie_healed)
     print, "Ken suffered"+str_barbie_healed+" damage"
     statsarray(2)=statsarray(2)-barbie_healed
     barbie_healed=500.*(1.+(.1*randomu(Seed))) ;heal Nikki
     if (statsarray(9) EQ 1) then begin
        barbie_healed=barbie_healed*.75 ;decrease damage if def buff is in effect
     endif
     str_barbie_healed=string(barbie_healed)
     print, "Nikki suffered"+str_barbie_healed+" damage"
     statsarray(3)=statsarray(3)-barbie_healed
     barbie_healed=500.*(1.+(.1*randomu(Seed))) ;heal Ryan
     if (statsarray(9) EQ 1) then begin
        barbie_healed=barbie_healed*.75 ;decrease damage if def buff is in effect
     endif
     str_barbie_healed=string(barbie_healed)
     print, "Ryan suffered"+str_barbie_healed+" damage"
     statsarray(4)=statsarray(4)-barbie_healed
  endif                         ;if raquelle threw everything but the kitchen sink
  if (raquelle_move EQ 3) then begin
     print, "Raquelle got her hair fixed"
     raquelle_healed=850.*(1.+(.1*randomu(Seed)))
     statsarray(0)=statsarray(0)+raquelle_healed
  endif;if raquelle fixes hair
  if (raquelle_move EQ 4) then begin
     raquelle_targeting2: raquelle_target=fix(5*randomu(seed));she rolls a random target
     if (raquelle_target EQ 0) OR (racquelle_target EQ 5) then begin
        goto, raquelle_targeting2
     endif;if raquelle rolls a 0 or a 1
     if (raquelle_target EQ 1) then begin
        print, "Raquelle's outfit actually outstages Barbie's"
        statsarray(1)=1+(9*randomu(seed));put Barbie's hp at crit health
     endif
     if (raquelle_target EQ 2) then begin
        print, "Raquelle creeped out Ken"
        statsarray(2)=1+(9*randomu(seed))
     endif
     if (raquelle_target EQ 3) then begin
        print, "Raquelle's music deafened Nikki"
        statsarray(3)=1+(9*randomu(seed))
     endif
     if (raquelle_target EQ 4) then begin
        print, "Raquelle commanded Ryan to stop"
        statsarray(4)=1+(9*randomu(seed))
     endif
  endif
  return, statsarray
end;end raquelle's turn
