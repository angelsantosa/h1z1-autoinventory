/*
--------------------------------------------------------------------------------
h1z1-autoinventory
by @angelsantosa
v1.0

Use slot 1 and 2 of inventory automaticaly with given Hotkey and DelayTime

NOTE: It only works with inventory on left!
--------------------------------------------------------------------------------

Please read the gotkey documentation!
https://autohotkey.com/docs/Hotkeys.htm
*/

;Set the Invetory hotkey you use in H1Z1
InventoryKey = {Tab}
;Set hotkey to use slot number 1
SlotOneKey = b
;Set hotkey to use slot number 2
SlotTwoKey = n
;Set your in-game resolution
Resolution := [1280,1050]

;In case script isn't clicking the slots, you can give your custom coordinates here.
;Just delete uncomment and give x and y values

;SlotOneCoordinates := [x,y]
;SlotTwoCoordinates := [x,y]

H1Z1_ahk_exe = H1Z1.exe ;Name of h1z1 exe so it script will only work inside it
DelayTime = 5 ;Delay time to execute script in milliseconds

varExist(ByRef v) { ; Requires 1.0.46+
   return &v = &n ? 0 : v = "" ? 2 : 1
}

get_coordinates(w,h,slot){
    if(slot=1){
      bc := [45,310]
    }else{
      bc := [115,310]
    }
  return [(h*bc[1])/1050,(w*bc[2])/1280]
}

Hotkey,%SlotOneKey%,SO
Hotkey,%SlotTwoKey%,ST
return

SO:
  if (WinActive("ahk_exe" . H1Z1_ahk_exe)){
    SetKeyDelay, DelayTime
    if(varExist(SlotOneCoordinates)=1){
      coordinates := [SlotOneCoordinates[1],SlotOneCoordinates[2]]
    }else{
      coordinates := get_coordinates(Resolution[1],Resolution[2],1)
    }
    Send, %InventoryKey%
    MouseClick,Left, Floor(coordinates[1]), Floor(coordinates[2])
    Send, %InventoryKey%
  }else{
    Send, %SlotOneKey%
  }
Return

ST:
  if (WinActive("ahk_exe" . H1Z1_ahk_exe)){
    SetKeyDelay, DelayTime
    if(varExist(SlotTwoCoordinates)=1){
      coordinates := [SlotTwoCoordinates[1],SlotTwoCoordinates[2]]
    }else{
      coordinates := get_coordinates(Resolution[1],Resolution[2],2)
    }
    Send, %InventoryKey%
    MouseClick,Left, Floor(coordinates[1]), Floor(coordinates[2])
    Send, %InventoryKey%
  }else{
    Send, %SlotTwoKey%
  }
Return
