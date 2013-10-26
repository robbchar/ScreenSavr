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

Sub DrawImages(photolist, flickr)
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
      
    photo.Info={}
    photo.TagList=[]
    flickr.GetPhotoInfo(photo.GetID(), photo.Info, photo.TagList)

    ' RC until I can figure out how to get this from the image xml
      width = screenWidth ' int(img.width)
      height = screenHeight ' int(img.height)

  	' RC ditto, until i can get the image specs from flickr don't worry about centering
      xpos = 0 ' (screenWidth / 2)  -  (width / 2)
      xpos = 0 ' int(xpos)

      ypos = 0 ' (screenHeight / 2) - (height / 2)
      ' ypos = 0 ' int(ypos - 30)

      ' RC hard coding the image height and width till I can figure it out from flickr'
      height = screenHeight
      width = screenWidth
      canvasItems = [
          {   
              url:photo.GetURL("b")
              TargetRect:{x:xpos,y:ypos,w:width,h:height}
          },
          { 
              Text:photo.Info.TextOverlayUL,
              TextAttrs:{Color:"#FFCCCCCC", Font:"Medium",
              HAlign:"Left", VAlign:"Top",
              Direction:"LeftToRight"},
              TargetRect:{x:125,y:screenHeight - 100,w:screenWidth,h:60}
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