
function getFont (font)
     if tostring(font) == "f1" then
	     return dxCreateFont('fonts/font_1.ttf', 20) or 'default'
	 elseif tostring(font) == "f2" then
	     return dxCreateFont('fonts/font_2.ttf', 80) or 'default'
	 elseif tostring(font) == "f3" then
	     return dxCreateFont('fonts/font_3.ttf', 20) or 'default'
	 elseif tostring(font) == "f4" then
	     return dxCreateFont('fonts/font_4.ttf', 20) or 'default'
	 elseif tostring(font) == "f5" then
	     return dxCreateFont('fonts/font_5.ttf', 20) or 'default'
	 elseif tostring(font) == "f6" then
	     return dxCreateFont('fonts/font_6.otf', 20) or 'default'
	 elseif tostring(font) == "f7" then
	     return dxCreateFont('fonts/font_7.otf', 20) or 'default'
	 elseif tostring(font) == "f8" then
	     return dxCreateFont('fonts/font_8.otf', 20) or 'default' -- montserrant regular
	 elseif tostring(font) == "f9" then
	     return dxCreateFont('fonts/font_9.otf', 20) or 'default' -- montserrant medium
	 elseif tostring(font) == "f10" then
	     return dxCreateFont('fonts/font_10.ttf', 20) or 'default' -- montserrant light
	 elseif tostring(font) == "verif" then
	     return true
	 end
end