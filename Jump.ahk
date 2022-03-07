Esc::ExitApp
r::Reload
CoordMode, Pixel, Relative

j::
Process, priority, , High
FileAppend Started..`n, *

loop 
{
   i = 0
   old = 0
   ; jump intervals
   a = 670
   b = 537
   c = 467
   d = 432
   e = 383
   k = 383
   f = 400
   g = 400
   h = 400
   j = 400
   Gosub, init
   

   ; Detect position
    Loop 
     {
       PixelSearch, x, y, 591, 522, 591, 522, 0x000000, 50, Fast RGB
             If (ErrorLevel = 0) 
             {
                 ;sleep, 100
                 tooltip % "Detected shadow"
                 break
             }
           else
           {
               tooltip % "Not detected, check coordinates and/or color"
           }
     }
   cnt := A_TickCount 
   start := A_TickCount + 50

   loop
   {
       ; Detect if failed and back at the start to retry
       PixelSearch, x, y, 756, 341, 756, 341, 0x606060, 50, Fast RGB
		   if ((old -3) > i) {
				learn = -1
		   } else{
				learn = 1
		   }
           If (ErrorLevel = 0) 
           {
			   FileAppend Restarting i was %i%`n, *
			   FileAppend old was %old%`n, *
			   FileAppend learn will be %learn%`n, *
			   FileAppend ++++++++++++++++++++++++++`n, *
			   FileAppend a %a%`n, *
			   FileAppend b %b%`n, *
			   FileAppend c %c%`n, *
			   FileAppend d %d%`n, *
			   FileAppend e %e%`n, *
			   FileAppend k %k%`n, *
			   FileAppend f %f%`n, *
			   FileAppend g %g%`n, *
			   FileAppend h %h%`n, *
			   FileAppend j %j%`n, *
			   FileAppend ++++++++++++++++++++++++++`n, *
               if (i < 29) 
               {
                   a-=learn
                   ToolTip, Restarting a set to %a%, 400, 400
				   FileAppend Restarting a set to %a%`n, *
               } 
               else if (i < 61) 
               {
                   b-=learn
                   ToolTip, Restarting b set to %b%, 400, 400
				   FileAppend Restarting b set to %b%`n, *
               } 
               else if (i < 111) 
               {
                   c-=learn
                   ToolTip, Restarting c set to %c%, 400, 400
				   FileAppend Restarting c set to %c%`n, *
               } 
               else if (i < 216) 
               {
                   d-=learn
                   ToolTip, Restarting d set to %d%, 400, 400
				   FileAppend Restarting d set to %d%`n, *
               }
			   else if (i < 270) 
               {
                   e-=learn
                   ToolTip, Restarting e set to %e%, 400, 400
				   FileAppend Restarting e set to %e%`n, *
               }
               else if (i < 311) 
               {
                   k-=learn
                   ToolTip, Restarting k set to %k%, 400, 400
				   FileAppend Restarting k set to %k%`n, *
               } 
               else if (i < 411) 
               {
                  f-=learn
                  ToolTip, Restarting f set to %f%, 400, 400
				  FileAppend Restarting f set to %f%`n, *
               }
               else if (i < 560) 
               {
                   g-=learn
                   ToolTip, Restarting g set to %g%, 400, 400
				   FileAppend Restarting g set to %g%`n, *
               }
               else if (i < 810) 
               {
                   h-=learn
                   ToolTip, Restarting h set to %h%, 400, 400
				   FileAppend Restarting h set to %h%`n, *
               }
               else if (i < 1800) 
               {
                   j-=learn
                   ToolTip, Restarting j set to %j%, 400, 400
				   FileAppend Restarting j set to %j%`n, *
               }
               sleep, 3000
               Send {Enter down}  ; Press down the Enter key.
               DllCall("Sleep", "Uint", 100)
               Send {Enter up}  ; Release Enter key.
               sleep, 2000
			   old := i
               i=0
			   Gosub, init
           }
       
       ; Manual override
       GetKeystate, state, Enter
       if (state = "D" and stop = 0)
       {
           break
       }

       timer := A_TickCount - start

       if (i = 1) 
       {
           currentInterval := a
       } 
       else if (i = 20) 
       {
           currentInterval := b
           balancer = 0
       } 
       else if (i = 51) 
       {
           currentInterval := c
           balancer = 0
       } 
       else if (i = 101) 
       {
           currentInterval := d
           balancer = 0
       } 
       else if (i = 201) 
       {
           extraTime = 50
           delay = 70
           currentInterval := e
           balancer = 0
       } 
       else if (i = 260) 
       {
           currentInterval := k
		   extraTime = 20
           balancer = 0
       } 
       else if (i = 301) 
       {
           currentInterval := f
           balancer = 0
       }
       else if (i = 401) 
       {
           currentInterval := g
           balancer = 0
       }
       else if (i = 550) 
       {
           currentInterval := h
           balancer = 0
       }
       else if (i = 800) 
       {
           currentInterval := j
           balancer = 0
       }

       ; If jumps are too late remove the = below
       if(i > 1) 
       {
           DllCall("Sleep", "Uint", (currentInterval - timer + balancer + extraTime))
       }
       Gosub, jump
   }
}
return 

jump:
	fullTime := A_TickCount - start - extraTime
	start := A_TickCount
	if(i > 1) 
	{
	   balancer += currentInterval - fullTime
	} 
	ToolTip, Jump %i% - %fullTime%, 400, 400
	Send {Enter down}  ; Press down the Enter key.
	DllCall("Sleep", "Uint", delay)
	Send {Enter up}  ; Release Enter key.
	ToolTip
	i += 1
	extraTime = 0
	return  

init:
   delay = 100
   balancer = 0
   currentInterval := a
   extraTime = 0
   learn = 1
   ToolTip, start, 400, 400

   ; Initiate steps to begin
   Send {Enter down}  ; Press down the Enter key.
   DllCall("Sleep", "Uint", 100)
   Send {Enter up}  ; Release Enter key.
   Sleep, 2000
   Send {Enter down}  ; Press down the Enter key.
   DllCall("Sleep", "Uint", 100)
   Send {Enter up}  ; Release Enter key.
   Sleep, 3000
   Send {Enter down}  ; Press down the Enter key.
   DllCall("Sleep", "Uint", 100)
   Send {Enter up}  ; Release Enter key.
   return
