class CombatParsersController < ApplicationController

before_action :set_combat_parser, only: [:show, :breakdown, :edit, :update, :destroy]
before_filter :check_current_user, only: [:show, :breakdown, :edit, :destroy]
before_filter :authenticate_user!

  def index    
    @combat_parsers = current_user.combat_parsers
  end

  def new
    @combat_parser = CombatParser.new
  end

  def show
  end

  def breakdown
  end

  def edit
  end

  def create
    @combat_parser = CombatParser.new(combat_parser_params)
    @combat_parser.user = current_user

    respond_to do |format|
      if @combat_parser.save
        format.html { redirect_to @combat_parser, notice: 'Combat parser was successfully created.' }
        format.json { render action: 'show', status: :created, location: @combat_parser }
      else
        format.html { render action: 'new' }
        format.json { render json: @combat_parser.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @combat_parser.update(combat_parser_params)
        format.html { redirect_to @combat_parser, notice: 'Combat parser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @combat_parser.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @combat_parser.destroy
    respond_to do |format|
      format.html { redirect_to combat_parsers_url }
      format.json { head :no_content }
    end
  end

  private
    def set_combat_parser
      @combat_parser = CombatParser.find(params[:id])
      @combat_parser.user == current_user
    end

    def check_current_user
       if current_user != @combat_parser.user
         flash[:notice] = 'You cannot view or edit other user logs'
         redirect_to combat_parsers_path
       end
     end

    def combat_parser_params
      params.require(:combat_parser).permit(:user_id, :log)
    end

end
