' *********************************************************
' *********************************************************
' **
' **  Roku DVP Yahoo Flickr Channel (BrightScript)
' **
' **  A. Wood, November 2009
' **
' **  Copyright (c) 2009 Anthony Wood. All Rights Reserved.
' **
' *********************************************************
' *********************************************************


' TO DO STILL
'
' Top Level
'  Browse HotTags (flickr.tags.getHotList) -> slideshow
'  Slideshow recent my changes ( flickr.photos.recentlyUpdated)
'  group search (icon)  -> enter keyword -> show results/select -> slideshow
'  tag search (icon) --> enter keyword -> show results/select -> slideshow
'
' slidshow
'  pause - show pause icon, pause.  pause or play to continue
'  ff or rw --> our trick mode screen? or grid of icons that you can scroll through.  Select picks up slide show at that point
'  info (title, photo #/total, etc) displayed in corder of photo
'

Sub LoginToFlickr()
print "LoginToFlickr"
    SetTheme()
'
' The following need to be setup for this application to work with flickr.
' You can get the information from this link:      http://www.flickr.com/services/api/auth.howto.web.html
'
    if RegRead("authorized")=invalid then
     	RegWrite("key", "1e02a9e8a9a74aa51ab3baf3beb52cb0")
	    RegWrite("secret", "c7781d3b7aa0807f")
	    RegWrite("auth_num", "72157636818611425")
	    RegWrite("authorized", "false")

		' Pop up start of UI for some instant feedback while we load the icon data
		poster=uitkPreShowPosterMenu()
		if poster=invalid then
			print "unexpected error in uitkPreShowPosterMenu"
			return
		end if

	    RegWrite("authorized", "true")
    end if

	' Create a flickr connection object.  
	' Defined in the flickrtoolkit.brs.  
	' Pass in our API KEY and SECRET(get it from flickr.com)
	key = RegRead("key")
	secret = RegRead("secret")
	flickr=CreateFlickrConnection(key, secret)
	if flickr=invalid then
		print "unexpected error in CreateFlickrConnection"
		return
	end if
	auth_num = RegRead("auth_num")
    flickr.auth_num = auth_num

	flickr.DisplayMyPhotoStream()
End Sub

' ******************************************************
' Setup theme for the application 
' ******************************************************
Sub SetTheme()
    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")

    theme.OverhangOffsetSD_X = "72"
    theme.OverhangOffsetSD_Y = "25"
    theme.OverhangLogoSD  = "pkg:/images/Logo_Overhang_Flickr_HD.png"
    theme.OverhangSliceSD = "pkg:/images/Home_Overhang_BackgroundSlice_SD43.png"

    theme.OverhangOffsetHD_X = "123"
    theme.OverhangOffsetHD_Y = "48"
    theme.OverhangLogoHD  = "pkg:/images/Logo_Overhang_Flickr_HD.png"
    theme.OverhangSliceHD = "pkg:/images/Home_Overhang_BackgroundSlice_HD.png"

    app.SetTheme(theme)
End Sub


