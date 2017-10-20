module TextChange
	def text_change old_text, new_text
  	i=0
  	while (i<new_text.length and i<old_text.length)
  		break if new_text[i]!=old_text[i]
  		i=i+1
  	end

  	if i==new_text.length and i==old_text.length
  		return {result: 'no change'}
  	end

  	j = new_text.length-1
  	k = old_text.length-1
  	while (j>=0 and k>=0)
  		break if new_text[j]!=old_text[k]
  		j=j-1
  		k=k-1
  	end

  	change = {}
  	change[:del_start] = -1
  	change[:del_end] = -1
  	change[:addition] = -1
  	change[:addition_text] = ""
  	if k<i
  		change[:del_start] = i
  		change[:del_end] = j
  	elsif j<i
  		change[:addition] = i
  		change[:addition_text] = old_text[i..k]
  	else
  		change[:del_start] = i
  		change[:del_end] = j
  		change[:addition] = i
  		change[:addition_text] = old_text[i..k]
  	end

  	return {result: change}
  end
end