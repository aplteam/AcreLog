﻿:Class  AcreLog
⍝ User Command script for "AcreLog".
⍝ Expects the WS AcreLog.dws to be a sibling of this script.
⍝
⍝ 0.1.0  2019-10-03 kai   First version

    ⎕IO←⎕ML←1

    ∇ r←List
      :Access Shared Public
      r←⎕NS''
      r.Group←'TOOLS'
      r.Name←'AcreLog'
      r.Parse←''
      r.Desc←'Monitors the acre "log" variable with a GUI'
    ∇

    ∇ r←Run(Cmd Args);bool;calledFrom
      :Access Shared Public
      ⍝ We now create a namespace ⎕SE.AcreLog but keep it local to this function!
     
      :If 0=⎕NC 'AcreLog'
          'AcreLog'⎕SE.⎕NS''     
          LoadAcreLog ##.SourceFile
      :EndIf
      r←⎕se.AcreLog.AcreLog.Run Args
    ∇

    ∇ r←l Help Cmd
      :Access Shared Public
      r←''
      :If 0=l
          r,←⊂List.Desc
      :Else
          r,←⊂'Allows you to put acre''s "log" variable on display with a GUI (HTMLRenderer object).'
          r,←⊂'Depending on your work flow you might find this more convinent than watching it with ⎕ED.'
          r,←⊂'The user command creates a namespace "AcreLog" within ⎕SE and then copies the workspace'
          r,←⊂'AcreLog" into it. That means you should avoide saving the session after executing ]AcreLog.'
      :EndIf     
    ∇

    ∇ {r}←LoadAcreLog path;filename;path;ws;failed
      r←⍬
      ws←'AcreLog.dws'
      path←{⍵↓⍨-⌊/'\/'⍳⍨⌽⍵}path
      filename←path,'/',ws
      failed←1
      :Trap 11
          ⎕SE.AcreLog.⎕CY filename  ⍝ Standalone AcreLog expects WS to be a sibling of this script
          failed←0
      :Else
          :Trap 11
              ⎕SE.AcreLog.⎕CY ws       ⍝ Make use of Dyalog workspace search path
              failed←0
          :EndTrap
          (failed/6)⎕SIGNAL⍨'Cannot find ',ws,' in ',path
      :EndTrap
    ∇

:EndClass ⍝ AcreLog