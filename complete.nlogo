globals [
  b26_bombDamage b26_machineGunDamage b26_rocketDamage b26_rocketRadius
  t33_machineGunDamage t33_bombDamage
  seaFury_machineGunDamage seaFury_bombDamage seaFury_rocketDamage seaFury_rocketRadius
  patch-type moveSwampSpeed
]

breed [attackers attacker] ; these are ground troops
breed [defenders defender]
breed [ allAttackingB26 attackingB26 ]
breed [ allDefendingB26 defendingB26 ]
breed [ allSeaFury seaFury ]
breed [ allT33 t33 ]

turtles-own [ healthPoints accuracy attackRange damage moveSpeed turnAngle sightRange supporting target]
attackers-own [targetLocationX targetLocationY]
allAttackingB26-own [ bombRadius bombDamage bombCount rocketRadius rocketRange rocketDamage rocketCount machineGunRange machineGunDamage machineGunAmmo resupplyX resupplyY supplyDelay resupplying ]
allDefendingB26-own [ bombRadius bombDamage bombCount rocketRadius rocketRange rocketDamage rocketCount machineGunRange machineGunDamage machineGunAmmo resupplyX resupplyY supplyDelay resupplying ]
allSeaFury-own [ bombRadius bombDamage bombCount rocketRange rocketDamage rocketRadius rocketCount machineGunRange machineGunDamage machineGunAmmo resupplyX resupplyY supplyDelay resupplying ]
allT33-own [ bombRadius bombDamage bombCount machineGunRange machineGunDamage machineGunAmmo resupplyX resupplyY supplyDelay resupplying ]


to go
  if ticks >= 20000 [ stop ]
  if count attackers = 0 [ stop ]
  if count defenders = 0 [ stop ]
  move-attackers
  move-defenders
  move-allB26
  move-allT33
  move-allSeaFury
  check-death
  display-labels
  tick
end

to check-death
  ask turtles [
    if healthPoints <= 0 [ die ]
  ]
end

to setup
  clear-all

  import-drawing "./new_map.png"

  setup-patches
  ask patches [setup-swamp setup-water]
  setup-attackers-beach-a
  setup-attackers-beach-b
  setup-defenders-base-a
  setup-defenders-base-b
  setup-defenders-base-c

  setup-allB26
  setup-allT33
  setup-allSeaFury

  display-labels

  set b26_bombDamage 2
  set b26_machineGunDamage 1
  set b26_rocketDamage 2
  set b26_rocketRadius 2
  set t33_machineGunDamage 1
  set t33_bombDamage 2
  set seaFury_machineGunDamage 1
  set seaFury_bombDamage 2
  set seaFury_rocketDamage 2
  set seaFury_rocketRadius 2

  reset-ticks
end

to setup-patches ;; patch procedure
  ask patches [ set pcolor green ]

   ;import-drawing "bay_map.png"

end

to setup-swamp
  ;swamp top left up the road
   if pxcor > -7 and pxcor < 24 and pycor > 25[ set pcolor 54 set patch-type "swamp"]
  if pxcor > -7 and pxcor < 27 and pycor > 23 and pycor < 26[ set pcolor 54 set patch-type "swamp"]
  if pxcor > -5 and pxcor < 30 and pycor > 20 and pycor < 24[ set pcolor 54 set patch-type "swamp"]
  if pxcor > -3 and pxcor < 33 and pycor > 18 and pycor < 21[ set pcolor 54 set patch-type "swamp"]
  if pxcor > -2 and pxcor < 35 and pycor > 15 and pycor < 19[ set pcolor 54 set patch-type "swamp"]
  if pxcor > -1 and pxcor < 37 and pycor > 12 and pycor < 16[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 0 and pxcor < 39 and pycor > 11 and pycor < 13[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 0 and pxcor < 41 and pycor > 10 and pycor < 12[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 0 and pxcor < 43 and pycor > 9 and pycor < 11[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 1 and pxcor < 44 and pycor > 6 and pycor < 10[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 2 and pxcor < 45 and pycor > 5 and pycor < 7[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 3 and pxcor < 46 and pycor > 4 and pycor < 6[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 4 and pxcor < 46 and pycor > 2 and pycor < 5[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 5 and pxcor < 45 and pycor > 2 and pycor < 4[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 6 and pxcor < 45 and pycor > 1 and pycor < 3[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 7 and pxcor < 45 and pycor > 0 and pycor < 2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 8 and pxcor < 45 and pycor > -1 and pycor < 2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 9 and pxcor < 44 and pycor > -2 and pycor < 1[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 11 and pxcor < 24 and pycor > -3 and pycor < -1[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 13 and pxcor < 23 and pycor > -4 and pycor < -2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 15 and pxcor < 22 and pycor > -5 and pycor < -3[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 17 and pxcor < 21 and pycor > -6 and pycor < -4[ set pcolor 54 set patch-type "swamp"]
   if pxcor > 25 and pxcor < 35 and pycor > -3 and pycor < -1[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 26 and pxcor < 34 and pycor > -4 and pycor < -2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 27 and pxcor < 33 and pycor > -5 and pycor < -3[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 28 and pxcor < 32 and pycor > -6 and pycor < -4[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 29 and pxcor < 31 and pycor > -7 and pycor < -5[ set pcolor 54 set patch-type "swamp"]
   if pxcor > 36 and pxcor < 44 and pycor > -3 and pycor < -1[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 37 and pxcor < 43 and pycor > -4 and pycor < -2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 38 and pxcor < 43 and pycor > -5 and pycor < -3[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 39 and pxcor < 42 and pycor > -6 and pycor < -4[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 40 and pxcor < 42 and pycor > -7 and pycor < -5[ set pcolor 54 set patch-type "swamp"]

  ; swamp bottom right down the road
  if pxcor > 47 and pxcor < 49 and pycor > 3 and pycor < 5[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 47 and pxcor < 50 and pycor > 2 and pycor < 4[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 46 and pxcor < 51 and pycor > 1 and pycor < 3[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 46 and pxcor < 52 and pycor > 0 and pycor < 2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 45 and pxcor < 53 and pycor > -1 and pycor < 1[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 45 and pxcor < 54 and pycor > -3 and pycor < 0[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 44 and pxcor < 55 and pycor > -4 and pycor < -2[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 44 and pxcor < 57 and pycor > -5 and pycor < -3[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 43 and pxcor < 58 and pycor > -6 and pycor < -4[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 43 and pxcor < 59 and pycor > -7 and pycor < -5[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 44 and pxcor < 71 and pycor > -8 and pycor < -6[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 45 and pxcor < 71 and pycor > -9 and pycor < -7[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 46 and pxcor < 71 and pycor > -10 and pycor < -8[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 47 and pxcor < 72 and pycor > -11 and pycor < -9[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 48 and pxcor < 73 and pycor > -12 and pycor < -10[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 49 and pxcor < 73 and pycor > -13 and pycor < -11[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 74 and pxcor < 76 and pycor > -13 and pycor < -11[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 50 and pxcor < 79 and pycor > -15 and pycor < -12[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 49 and pxcor < 78 and pycor > -16 and pycor < -14[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 50 and pxcor < 77 and pycor > -17 and pycor < -15[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 51 and pxcor < 76 and pycor > -18 and pycor < -16[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 52 and pxcor < 75 and pycor > -19 and pycor < -17[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 53 and pxcor < 70 and pycor > -20 and pycor < -18[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 70 and pxcor < 74 and pycor > -20 and pycor < -18[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 71 and pxcor < 73 and pycor > -21 and pycor < -19[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 55 and pxcor < 69 and pycor > -21 and pycor < -19[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 57 and pxcor < 68 and pycor > -22 and pycor < -20[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 59 and pxcor < 67 and pycor > -23 and pycor < -21[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 61 and pxcor < 66 and pycor > -24 and pycor < -22[ set pcolor 54 set patch-type "swamp"]
  if pxcor > 62 and pxcor < 65 and pycor > -25 and pycor < -23[ set pcolor 54 set patch-type "swamp"]

  ;swamp all left
  if pxcor < -22 and pycor < 17 and pycor > -11[ set pcolor 54 ]
  if pxcor < -21 and pycor < 16 and pycor > -11[ set pcolor 54 ]
  if pxcor < -20 and pycor < 15 and pycor > -11[ set pcolor 54 ]
  if pxcor < -19 and pycor < 14 and pycor > -11[ set pcolor 54 ]
  if pxcor < -18 and pycor < 13 and pycor > -11[ set pcolor 54 ]
  if pxcor < -17 and pycor < 12 and pycor > 9 [ set pcolor 54 ]
  if pxcor < -17 and pycor < 2 and pycor > -11[ set pcolor 54 ]
  if pxcor < -16 and pycor < -2 and pycor > -11[ set pcolor 54 ]
end

to setup-water
  if pxcor > -16 and pxcor <= 100 and pycor = -25 [set pcolor blue set patch-type "water"]
  if pxcor > -16 and pxcor < 18 and pycor = -24 [set pcolor blue set patch-type "water"]
  if pxcor > -16 and pxcor < 16 and pycor = -23 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < 14 and pycor = -22 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 12 and pycor = -21 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 10 and pycor = -20 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 8 and pycor = -19 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 6 and pycor = -18 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 5 and pycor = -17 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 4 and pycor = -16 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 3 and pycor = -15 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < 2 and pycor = -14 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < 1 and pycor = -13 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < 0 and pycor = -12 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < 0 and pycor = -11 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < 0 and pycor = -10 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < -1 and pycor = -9 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < -1 and pycor = -8 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -1 and pycor = -7 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -1 and pycor = -6 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -2 and pycor = -5 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -2 and pycor = -4 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -3 and pycor = -3 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -3 and pycor = -2 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -3 and pycor = -1 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -4 and pycor = 0 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -4 and pycor = 1 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -4 and pycor = 2 [set pcolor blue set patch-type "water"]
  if pxcor > -13 and pxcor < -4 and pycor = 3 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -4 and pycor = 4 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -5 and pycor = 5 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -5 and pycor = 6 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -6 and pycor = 7 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -6 and pycor = 8 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -6 and pycor = 9 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -6 and pycor = 10 [set pcolor blue set patch-type "water"]
  if pxcor > -14 and pxcor < -6 and pycor = 11 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < -7 and pycor = 12 [set pcolor blue set patch-type "water"]
  if pxcor > -15 and pxcor < -9 and pycor = 13 [set pcolor blue set patch-type "water"]

  if pxcor > 94 and pxcor <= 100 and pycor = 0 [set pcolor blue set patch-type "water"]
  if pxcor > 92 and pxcor <= 100 and pycor = -1 [set pcolor blue set patch-type "water"]
  if pxcor > 92 and pxcor <= 100 and pycor = -2 [set pcolor blue set patch-type "water"]
  if pxcor > 92 and pxcor <= 100 and pycor = -3 [set pcolor blue set patch-type "water"]
  if pxcor > 93 and pxcor <= 100 and pycor = -4 [set pcolor blue set patch-type "water"]
  if pxcor > 93 and pxcor <= 100 and pycor = -5 [set pcolor blue set patch-type "water"]
  if pxcor > 94 and pxcor <= 100 and pycor = -6 [set pcolor blue set patch-type "water"]
  if pxcor > 94 and pxcor <= 100 and pycor = -7 [set pcolor blue set patch-type "water"]
  if pxcor > 95 and pxcor <= 100 and pycor = -8 [set pcolor blue set patch-type "water"]
  if pxcor > 95 and pxcor <= 100 and pycor = -9 [set pcolor blue set patch-type "water"]
  if pxcor > 96 and pxcor <= 100 and pycor = -10 [set pcolor blue set patch-type "water"]
  if pxcor > 96 and pxcor <= 100 and pycor = -11 [set pcolor blue set patch-type "water"]
  if pxcor > 97 and pxcor <= 100 and pycor = -12 [set pcolor blue set patch-type "water"]
  if pxcor > 97 and pxcor <= 100 and pycor = -13 [set pcolor blue set patch-type "water"]
end

to setup-attackers-beach-a
  create-attackers attacker-number-beach-a [
    setxy 10 + random-float 5 -22 + random-float 4
    set color red
    set heading 0
    set healthPoints 50
    set accuracy 0.3
    set attackRange 3
    set damage 1
    set targetLocationX 100
    set targetLocationY -18
    set moveSpeed 0.01
  ]
end

to setup-attackers-beach-b
  create-attackers attacker-number-beach-b [
    setxy -14 + random-float 5 13 + random-float 4
    set color red
    set heading 0
    set healthPoints 50
    set accuracy 0.3
    set attackRange 3
    set damage 1
    set targetLocationX -24 + random-float 27
    set targetLocationY 24 - random-float 10
    set moveSpeed 0.01
  ]
end

to setup-defenders-base-a
  create-defenders defender-number-base-a[
    setxy 94 + random-float 6 -15 + random-float 30
    set color blue
    set heading 180
    set healthPoints 50
    set accuracy 0.3
    set attackRange 3
    set damage 1
    set moveSpeed 0.015
  ]
end

to setup-defenders-base-b
  create-defenders defender-number-base-b[
    setxy -20 + random-float 30 25 + random-float 5
    set color blue
    set heading 180
    set healthPoints 50
    set accuracy 0.3
    set attackRange 3
    set damage 1
    set moveSpeed 0.015
  ]
end

to setup-defenders-base-c
  create-defenders defender-number-base-c[
    setxy -25 + random-float 5 13 + random-float 12
    set color blue
    set heading 180
    set healthPoints 50
    set accuracy 0.3
    set attackRange 3
    set damage 1
    set moveSpeed 0.015
  ]
end

to setup-allB26
  ; Performance:
  ; Maximum speed: 359 mph
  ; Cruise speed: 266 mph
  ; Range: 1,600 mi
  ; Combat range: 700 mi

  ; Guns:

  ; 8 0.50 M2 Browning machine guns
  ; Rockets: Up to 10 HVAR rockets
  ; Bombs: Up to 6,000 lb (2,700 kg) capacity
  create-allAttackingB26 initial-number-attacking-b26 [
    set color red - 1
    set size 2
    set label-color red - 2
    set attackRange 10
    set bombRadius 1
    setxy random-xcor -25
    set healthPoints 100
    set shape "airplane"
    set resupplyX 0
    set resupplyY -25
    set bombCount 12
    set moveSpeed 1
    set rocketCount 10
    set rocketRadius b26_rocketRadius
    set bombDamage b26_bombDamage
    set machineGunAmmo 1000
    set machineGunDamage b26_machineGunDamage
    set supporting 0
    set supplyDelay 0
    set heading 0
    set healthPoints 1000
  ]
  create-allDefendingB26 initial-number-defending-b26 [
    set color blue - 1
    set size 2
    set label-color blue - 2
    set attackRange 10
    set bombRadius 1
    setxy random-xcor 25
    set healthPoints 100
    set shape "airplane"
    set resupplyX 50
    set resupplyY 30
    set bombCount 12
    set moveSpeed 1
    set rocketCount 10
    set rocketRadius b26_rocketRadius
    set bombDamage b26_bombDamage
    set machineGunAmmo 1000
    set machineGunDamage b26_machineGunDamage
    set supplyDelay 0
    set heading 180
    set healthPoints 1000
  ]
end

to setup-allT33
  ;Maximum speed: 600 mph (521 knots, 965 km/h)
  ;Cruise speed: 455 mph (396 knots, 732 km/h)
  ;Range: 1,275 mi (1,110 nmi, 2,050 km)

  ;Armament
  ;Machine Guns: 2 x12.7mm M3 machine guns on the nose
  ;Hardpoints: 2 with a capacity of 2,000 lb (907 kg) of bombs or rockets (AT-33)
  create-allT33 initial-number-t33 [
    set color blue - 1
    set size 1.5
    set label-color blue - 2
    set attackRange 10
    setxy random-xcor 25
    set healthPoints 100
    set shape "airplane"
    set bombRadius 1
    set bombCount 2
    set bombDamage 2
    set moveSpeed 1.5
    set resupplyX 50
    set resupplyY 30
    set machineGunAmmo 1000
    set machineGunDamage t33_machineGunDamage
    set supplyDelay 0
    set heading 180
    set healthPoints 200
  ]
end

to setup-allSeaFury
  ;Maximum speed: 460 mph (400 knots, 740 km/h)
  ;Range: 700 mi (609 nmi, 1,126 km)

  ;Armament
  ;Guns: 4 × 20 mm Hispano Mk V autocannon
  ;Rockets: 12 × 3 in (76.2 mm) rockets or
  ;Bombs: 2,000 lb (907 kg) of bombs
  create-allSeaFury initial-number-seaFury [
    set color blue - 1
    set size 1.5
    set label-color blue - 2
    set attackRange 10
    setxy random-xcor 25
    set healthPoints 100
    set shape "airplane"
    set moveSpeed 1.5
    set bombCount 4
    set bombRadius 1
    set rocketCount 12
    set rocketRadius 2
    set rocketDamage seaFury_rocketDamage
    set bombDamage seaFury_bombDamage
    set machineGunAmmo 1000
    set machineGunDamage seaFury_machineGunDamage
    set supplyDelay 0
    set resupplyX 50
    set resupplyY 30
    set heading 180
    set healthPoints 500
  ]
end

to move-attackers
  ask attackers[
    ifelse count defenders with [healthPoints > 0] in-radius attackRange >= 1 [
      ifelse count attackers in-radius attackRange with [color = 18] >= count attackers in-radius attackRange with [color = red] [
        set heading towardsxy targetLocationX targetLocationY
        set color red
        set moveSpeed 0.01
        if pcolor = 54
    [set moveSpeed 0.007]
        forward moveSpeed

      ]
      [
        set color 18
        set heading towards min-one-of defenders [distance myself]
        let potentialTarget min-one-of defenders with [healthPoints > 0] [distance myself]
        let damageHolder damage
        if random-float 1 < accuracy [
          ask potentialTarget [
            set healthPoints healthPoints - damageHolder
          ]
        ]
        if count allAttackingB26 with [supporting = 0] > 0 [
          ask min-one-of allAttackingB26 with [supporting = 0] [distance myself] [
            set supporting 1
            set target potentialTarget
          ]
        ]
      ]
    ]
    [
      set heading towardsxy targetLocationX targetLocationY
      set color red
      set moveSpeed 0.01
        if pcolor = 54
    [set moveSpeed 0.007]

       ;forward moveSwampSpeed
      forward moveSpeed
    ]
  ]
end

to move-defenders
  ask defenders[
    ifelse count attackers with [healthPoints > 0] in-radius attackRange >= 1 [
      set color 108
      let potentialTarget min-one-of attackers with [healthPoints > 0] [distance myself]
      let damageHolder damage
      if random-float 1 < accuracy [
        ask potentialTarget [
          set healthPoints healthPoints - damageHolder
        ]
      ]
      let defendingAircraft (turtle-set allDefendingB26 allT33 allSeaFury)
      if count defendingAircraft with [supporting = 0] > 0 [
        ask min-one-of defendingAircraft with [supporting = 0] [distance myself] [
          set supporting 1
          set target potentialTarget
        ]
      ]
    ]
    [
      set heading towards min-one-of attackers [distance myself]
      set color blue
      set moveSpeed 0.01
        if pcolor = 54
    [set moveSpeed 0.007]
      forward moveSpeed
    ]
  ]
end

to move-allB26
  ask allAttackingB26 [
    ifelse supplyDelay = 0 [
      set color red
      ifelse bombCount > 0 or rocketCount > 0 or machineGunAmmo > 0 [

        let potentialTargets defenders in-cone attackRange 30
        let farTarget max-one-of potentialTargets [distance myself]
        if bombCount >= 0 [
          let closeTargets defenders in-radius bombRadius
          ask closeTargets [ set healthPoints healthPoints - b26_bombDamage ]
          if count closeTargets > 0 [ set bombCount (bombCount - 1) ]
        ]
        if rocketCount >= 0 [
          let finalTarget one-of potentialTargets
          if finalTarget != nobody [
            ask finalTarget [
              let nearbyTargets defenders in-radius b26_rocketRadius
              ask nearbyTargets [
                set healthPoints healthPoints - b26_rocketDamage
              ]
            ]
            set rocketCount (rocketCount - 1)
          ]
        ]

        let allT33Ahead allT33 in-cone attackRange 330
        let allSeaFuryAhead allSeaFury in-cone attackRange 330
        let allDefendingB26Ahead allDefendingB26 in-cone attackRange 330

        let allT33Behind (allT33 in-radius attackRange) with [not member? self allT33Ahead]
        let allSeaFuryBehind (allSeaFury in-radius attackRange) with [not member? self allSeaFuryAhead]
        let allDefendingB26Behind (allDefendingB26 in-radius attackRange) with [not member? self allDefendingB26Ahead]

        let behindTargets (turtle-set allT33Behind allSeaFuryBehind allDefendingB26Behind)

        if machineGunAmmo >= 0 [
          ask potentialTargets [
            let currentPatch [patch-type] of patch-here
            ifelse currentPatch = "swamp" [set healthPoints healthPoints - (0.5 * b26_machineGunDamage) ]
            [ set healthPoints healthPoints - b26_machineGunDamage ]
          ]
          ask behindTargets [ set healthPoints healthPoints - b26_machineGunDamage ]
          set machineGunAmmo (machineGunAmmo - count potentialTargets - count behindTargets)
        ]

        ifelse supporting = 1 [
          ifelse target != nobody and distance target > attackRange [;and member? target potentialTargets [
            set heading towards target
          ]
          [
            set supporting 0
            ifelse farTarget != nobody [
              set heading towards farTarget
              set color red + 1
            ]
            [
              set color red
              rt random 5
              lt random 5
            ]
          ]
        ]
        [
          ifelse farTarget != nobody [
            set heading towards farTarget
            set color red + 1
          ]
          [
            set color red
            rt random 5
            lt random 5
          ]
        ]

        if xcor >= max-pxcor [ set heading 270 ]
        if xcor <= min-pxcor [ set heading 90 ]
        if ycor >= max-pycor [ set heading 180 ]
        if ycor <= min-pycor [ set heading 0 ]
        ifelse xcor < max-pxcor and xcor > min-pxcor and ycor > min-pycor and ycor < max-pycor [
          set resupplying false
        ]
        [
          if resupplying = false [
            set supplyDelay 20
            set resupplying true
          ]
        ]
      ]
      [

        ifelse heading < towardsxy resupplyX resupplyY [
          rt 5
        ]
        [
          lt 5
        ]
        set color orange + 1
      ]
      ifelse distancexy resupplyX resupplyY < 2 [
        set bombCount 2
        set rocketCount 10
        set machineGunAmmo 1000
        if resupplying = false [
          set supplyDelay 100
          set resupplying true
          set heading 0
        ]
      ]
      [
        set resupplying false
      ]

      fd moveSpeed
    ]
    [
      set supplyDelay supplyDelay - 1
    ]
  ]

  ask allDefendingB26 [
    ifelse supplyDelay = 0 [
      set color blue
      ifelse bombCount > 0 or rocketCount > 0 or machineGunAmmo > 0 [

        let potentialTargets (turtle-set (attackers in-cone attackRange 30) (allAttackingB26 in-cone attackRange 30) )
        let farTarget max-one-of potentialTargets [distance myself]
        if bombCount >= 0 [
          let closeTargets attackers in-radius bombRadius
          ask closeTargets [ set healthPoints healthPoints - b26_bombDamage ]
          if count closeTargets > 0 [ set bombCount (bombCount - 1) ]
        ]
        if rocketCount >= 0 [
          let finalTarget one-of potentialTargets
          if finalTarget != nobody [
            ask finalTarget [
              let nearbyTargets attackers in-radius b26_rocketRadius
              ask nearbyTargets [
                set healthPoints healthPoints - b26_rocketDamage
              ]
            ]
            set rocketCount (rocketCount - 1)
          ]
        ]
        if machineGunAmmo >= 0 [
          ask potentialTargets [
            let currentPatch [patch-type] of patch-here
            ifelse currentPatch = "swamp" [set healthPoints healthPoints - (0.5 * b26_machineGunDamage) ]
            [ set healthPoints healthPoints - b26_machineGunDamage ]
          ]
          set machineGunAmmo (machineGunAmmo - count potentialTargets)
        ]

        ifelse supporting = 1 [
          ifelse target != nobody [;and member? target potentialTargets [
            set heading towards target
          ]
          [
            set supporting 0
            ifelse farTarget != nobody [
              set heading towards farTarget
              set color blue + 1
            ]
            [
              set color blue
              rt random 5
              lt random 5
            ]
          ]
        ]
        [
          ifelse farTarget != nobody [
            set heading towards farTarget
            set color blue + 1
          ]
          [
            set color blue
            rt random 5
            lt random 5
          ]
        ]

        if xcor >= max-pxcor [ set heading 270 ]
        if xcor <= min-pxcor [ set heading 90 ]
        if ycor >= max-pycor [ set heading 180 ]
        if ycor <= min-pycor [ set heading 0 ]
        ifelse xcor < max-pxcor and xcor > min-pxcor and ycor > min-pycor and ycor < max-pycor [
          set resupplying false
        ]
        [
          if resupplying = false [
            set supplyDelay 20
            set resupplying true
          ]
        ]
      ]
      [
        ifelse heading < towardsxy resupplyX resupplyY [
          rt 5
        ]
        [
          lt 5
        ]
        set color cyan + 1
      ]

      ifelse distancexy resupplyX resupplyY < 2 [
        set bombCount 2
        set rocketCount 10
        set machineGunAmmo 1000
        if resupplying = false [
          set supplyDelay 100
          set resupplying true
          set heading 180
        ]
      ]
      [
        set resupplying false
      ]
      fd moveSpeed
    ]
    [
      set supplyDelay supplyDelay - 1
    ]
  ]
end

to move-allT33
  ask allT33 [
    ifelse supplyDelay = 0 [
      set color blue
      ifelse bombCount > 0 or machineGunAmmo > 0 [

        let potentialTargets (turtle-set (attackers in-cone attackRange 30) (allAttackingB26 in-cone attackRange 30) )
        let farTarget max-one-of potentialTargets [distance myself]
        if bombCount >= 0 [
          let closeTargets attackers in-radius bombRadius
          ask closeTargets [ set healthPoints healthPoints - t33_bombDamage ]
          if count closeTargets > 0 [ set bombCount (bombCount - 1) ]
        ]
        if machineGunAmmo >= 0 [
          ask potentialTargets [
           let currentPatch [patch-type] of patch-here
            ifelse currentPatch = "swamp" [set healthPoints healthPoints - (0.5 * t33_machineGunDamage) ]
            [ set healthPoints healthPoints - t33_machineGunDamage ]
          ]
          set machineGunAmmo (machineGunAmmo - count potentialTargets)
        ]

        if bombCount <= 0 and machineGunAmmo <= 0 [
          set heading towardsxy resupplyX resupplyY
        ]

        ifelse supporting = 1 [
          ifelse target != nobody [;and member? target potentialTargets [
            set heading towards target
          ]
          [
            set supporting 0
            ifelse farTarget != nobody [
              set heading towards farTarget
              set color blue + 1
            ]
            [
              set color blue
              rt random 5
              lt random 5
            ]
          ]
        ]
        [
          ifelse farTarget != nobody [
            set heading towards farTarget
          ]
          [
            rt random 5
            lt random 5
          ]
        ]

        if xcor >= max-pxcor [ set heading 270 ]
        if xcor <= min-pxcor [ set heading 90 ]
        if ycor >= max-pycor [ set heading 180 ]
        if ycor <= min-pycor [ set heading 0 ]
        ifelse xcor < max-pxcor and xcor > min-pxcor and ycor > min-pycor and ycor < max-pycor [
          set resupplying false
        ]
        [
          if resupplying = false [
            set supplyDelay 20
            set resupplying true
          ]
        ]
      ]
      [
        ifelse heading < towardsxy resupplyX resupplyY [
          rt 5
        ]
        [
          lt 5
        ]
        set color cyan + 1
      ]

      ifelse distancexy resupplyX resupplyY < 2 [
        set bombCount 2
        set machineGunAmmo 1000
        if resupplying = false [
          set supplyDelay 100
          set resupplying true
          set heading 180
        ]
      ]
      [
        set resupplying false
      ]
      fd moveSpeed
    ]
    [
      set supplyDelay supplyDelay - 1
    ]
  ]
end

to move-allSeaFury
  ask allSeaFury [
    ifelse supplyDelay = 0 [
      set color blue
      ifelse bombCount > 0 or rocketCount > 0 or machineGunAmmo > 0 [

        let potentialTargets (turtle-set (attackers in-cone attackRange 30) (allAttackingB26 in-cone attackRange 30) )
        let farTarget max-one-of potentialTargets [distance myself]
        if bombCount >= 0 [
          let closeTargets defenders in-radius bombRadius
          ask closeTargets [ set healthPoints healthPoints - seaFury_bombDamage ]
          if count closeTargets > 0 [ set bombCount (bombCount - 1) ]
        ]
        if rocketCount >= 0 [
          let finalTarget one-of potentialTargets
          if finalTarget != nobody [
            ask finalTarget [
              let nearbyTargets attackers in-radius seaFury_rocketRadius
              ask nearbyTargets [
                set healthPoints healthPoints - seaFury_rocketDamage
              ]
            ]
            set rocketCount (rocketCount - 1)
          ]
        ]
        if machineGunAmmo >= 0 [
          ask potentialTargets [
            let currentPatch [patch-type] of patch-here
            ifelse currentPatch = "swamp" [set healthPoints healthPoints - (0.5 * seaFury_machineGunDamage) ]
            [ set healthPoints healthPoints - seaFury_machineGunDamage ]
          ]
          set machineGunAmmo (machineGunAmmo - count potentialTargets)
        ]

        ifelse supporting = 1 [
          ifelse target != nobody [;and member? target potentialTargets [
            set heading towards target
          ]
          [
            set supporting 0
            ifelse farTarget != nobody [
              set heading towards farTarget
              set color blue + 1
            ]
            [
              set color blue
              rt random 5
              lt random 5
            ]
          ]
        ]
        [
          ifelse farTarget != nobody [
            set heading towards farTarget
          ]
          [
            rt random 5
            lt random 5
          ]
        ]

        if xcor >= max-pxcor [ set heading 270 ]
        if xcor <= min-pxcor [ set heading 90 ]
        if ycor >= max-pycor [ set heading 180 ]
        if ycor <= min-pycor [ set heading 0 ]
        ifelse xcor < max-pxcor and xcor > min-pxcor and ycor > min-pycor and ycor < max-pycor [
          set resupplying false
        ]
        [
          if resupplying = false [
            set supplyDelay 20
            set resupplying true
          ]
        ]
      ]
      [
        ifelse heading < towardsxy resupplyX resupplyY [
          rt 5
        ]
        [
          lt 5
        ]
        set color cyan + 1
      ]

      ifelse distancexy resupplyX resupplyY < 2 [
        set bombCount 4
        set rocketCount 12
        set machineGunAmmo 1000
        if resupplying = false [
          set supplyDelay 100
          set resupplying true
          set heading 180
        ]
      ]
      [
        set resupplying false
      ]
      fd moveSpeed
    ]
    [
      set supplyDelay supplyDelay - 1
    ]
  ]
end

to display-labels
  if show-health = false and show-ammo = false [
    ask turtles [ set label "" ]
  ]
  if show-health = true [
    ask turtles [ set label healthPoints ]
  ]
  if show-ammo = true [
    ask allAttackingB26 [ set label machineGunAmmo ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
219
10
1167
437
-1
-1
7.4643
1
10
1
1
1
0
0
0
1
-25
100
-25
30
1
1
1
ticks
30.0

BUTTON
13
22
79
55
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
102
23
165
56
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

MONITOR
12
69
126
114
NIL
count defenders
17
1
11

MONITOR
13
121
122
166
count attackers
count attackers
3
1
11

PLOT
8
277
208
427
Totals
time
totals
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"defenders" 1.0 0 -13345367 true "" "plot count defenders"
"attackers" 1.0 0 -2674135 true "" "plot count attackers"

SLIDER
24
441
196
474
defender-number
defender-number
0
500
500.0
1
1
NIL
HORIZONTAL

SLIDER
22
528
194
561
attacker-number
attacker-number
0
100
46.0
1
1
NIL
HORIZONTAL

SLIDER
213
473
415
506
initial-number-defending-b26
initial-number-defending-b26
0
20
3.0
1
1
NIL
HORIZONTAL

SWITCH
13
175
137
208
show-health
show-health
0
1
-1000

SLIDER
432
477
605
510
initial-number-seaFury
initial-number-seaFury
0
10
3.0
1
1
NIL
HORIZONTAL

SLIDER
212
519
412
552
initial-number-t33
initial-number-t33
0
10
3.0
1
1
NIL
HORIZONTAL

SLIDER
208
561
413
594
initial-number-attacking-b26
initial-number-attacking-b26
0
20
8.0
1
1
NIL
HORIZONTAL

SLIDER
431
519
647
552
attacker-number-beach-a
attacker-number-beach-a
0
100
70.0
1
1
NIL
HORIZONTAL

SLIDER
433
564
650
597
attacker-number-beach-b
attacker-number-beach-b
0
100
30.0
1
1
NIL
HORIZONTAL

SWITCH
16
223
150
256
show-ammo
show-ammo
1
1
-1000

SLIDER
685
474
898
507
defender-number-base-a
defender-number-base-a
0
200
200.0
1
1
NIL
HORIZONTAL

SLIDER
918
474
1133
507
defender-number-base-b
defender-number-base-b
0
200
150.0
1
1
NIL
HORIZONTAL

SLIDER
1150
473
1363
506
defender-number-base-c
defender-number-base-c
0
200
100.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
