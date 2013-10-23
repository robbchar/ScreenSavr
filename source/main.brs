' Main() is useful for testing. It should be commented
' out before this is checked in.
Sub Main() 
 facade = CreateObject("roParagraphScreen")
 facade.Show()
 RunScreenSaver()
End Sub

Sub RunScreenSaver()
	LoginToFlickr()
End Sub


Sub DrawImages(photolist)

   di = CreateObject("roDeviceInfo")
   displayMode = di.GetDisplayMode()
   screenWidth = int(di.GetDisplaySize().w)
   screenHeight = int(di.GetDisplaySize().h)

   canvas = CreateObject("roImageCanvas")
   port = CreateObject("roMessagePort")
   canvas.SetMessagePort(port)
   canvas.SetLayer(0, {Color:"#FF000000", CompositionMode:"Source"}) 
   canvas.SetRequireAllImagesToDraw(false)

   while(true)
      for each photo in photolist
      
      ' RC until I can figure out how to get this from the image xml
        width = screenWidth ' int(img.width)
        height = screenHeight ' int(img.height)

        ' calculate the image x axis so we can center it

        if (displayMode = "480i") then
          maxHeight = 370
          
          if (width > maxWidth)
            diff =   width - maxWidth
            percentToScale = abs(1-(diff/width)) 
            print percentToScale
            width = int(width * percentToScale)
            height = int(height * percentToScale)
          end if
        else 

          maxHeight = int(screenHeight) - 185

        end if

        ' print displayMode
        print di.GetDisplaySize()

      'Make sure the image is not too tall
      if (height > maxHeight)
          diff =   height - maxHeight
          percentToScale = abs(1-(diff/height)) 
          print percentToScale
          width = int(width * percentToScale)
          height = int(height * percentToScale)
      end if

		' RC ditto
      xpos = 0 ' (screenWidth / 2)  -  (width / 2)
      xpos = 0 ' int(xpos)

      ypos = 0 ' (screenHeight / 2) - (height / 2)
      ypos = 0 ' int(ypos - 30)

print "photo.GetURL:"
print photo.GetURL()
      canvasItems = [
          {   
              url:photo.GetURL()
              TargetRect:{x:xpos,y:ypos,w:width,h:height}

          },
          { 
              Text:"an image" ' RC use this till the description can be gotten
              TextAttrs:{Color:"#FFCCCCCC", Font:"Medium",
              HAlign:"HCenter", VAlign:"VCenter",
              Direction:"LeftToRight"}
              TargetRect:{x:390,y:0,w:500,h:60}
              ' TargetRect:{x:captionX,y:captionY,w:captionBoxWidth,h:60}
          }
      ] 

     canvas.SetLayer(1, canvasItems)
     canvas.Show() 

         msg = wait(12000,port) 
         if type(msg) = "roImageCanvasEvent" then
             if (msg.isRemoteKeyPressed()) then
                 return
             end if
         end if

      end for



   end while
    
End Sub