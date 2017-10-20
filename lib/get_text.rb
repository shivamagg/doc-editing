module GetText
	def get_text_from edit
    doc = edit.document
    doc_text = doc.text
    edits = doc.edits.reverse
    edits.each do |e|
      text = ""
      if e.del_start!=-1
        text = doc_text[0..(e.del_start-1)] if e.del_start!=0 
        text = text+doc_text[(e.del_end+1)..(doc_text.length-1)]
      else
        text = doc_text
      end 
      text = text.insert(e.addition, e.addition_text) if e.addition!=-1
      doc_text = text
      break if e.id == edit.id
    end
    return doc_text
  end
end
