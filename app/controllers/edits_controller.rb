class EditsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_edit, only: [:show]
	include GetText
	
	def show
		@text = get_text_from @edit
		@document = @edit.document
	end

	private
	  # Use callbacks to share common setup or constraints between actions.
	  def set_edit
	    @edit = Edit.find(params[:id])
	  end

end
