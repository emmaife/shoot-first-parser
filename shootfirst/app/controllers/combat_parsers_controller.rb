class CombatParsersController < ApplicationController
  before_action :set_combat_parser, only: [:show, :breakdown, :edit, :update, :destroy]

  def index
    @combat_parsers = CombatParser.all
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
    # Use callbacks to share common setup or constraints between actions.
    def set_combat_parser
      @combat_parser = CombatParser.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def combat_parser_params
      params.require(:combat_parser).permit(:log, :time, :source, :source_info, :source_id, :target_info, :target, :target_id,
  :ability, :ability_id, :effect, :effect_action, :value_info, :value, :value_type, 
  :threat, :enter?, :exit?, :dmg?, :heal?, :dmg_values, :abilities, :total, :ability_totals, 
  :ability_avgs, :total_dmg, :average_dmg, :dmg_per_ability, :ability_dmg_percentage, 
  :combat_log, :first_line, :player, :log_string, :output_log_string)
    end


end
