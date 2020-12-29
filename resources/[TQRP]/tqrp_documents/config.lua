Config = {}

Config.MenuKey 			= 182 -- "L" button, change to whatever you want
Config.UseCustomFonts 	= false -- Leave this as is if you don't know how to or haven't loaded custom fonts.
Config.CustomFontFile 	= "greek" -- change only if you turn custom fonts on.
Config.CustomFontId 	= "OpenSans" -- change only if you turn custom fonts ok.
Config.Locale = 'en'

Config.Documents = {
    {
        headerTitle = "WITNESS TESTIMONY",
        headerSubtitle = "Official witness testimony.",
        elements = {
          { label = "DATE", type = "input", value = "", can_be_emtpy = false },
          { label = "TESTIMONY", type = "textarea", value = "", can_be_emtpy = false },
        }
      },
}
