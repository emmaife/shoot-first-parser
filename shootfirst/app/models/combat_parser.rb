class CombatParser < ActiveRecord::Base
  belongs_to :user
  mount_uploader :log, LogUploader
  
  def open_file
    @combat_log = File.open("public/#{self.log}", "r")
  end

  def parse_line(line)
    begin
      a = line.gsub(/\[|\@/, "").split("] ")
      @time = a[0]

      @source_info = a[1].split(" {")
      @source = @source_info[0]
      @source_id = @source_info[1]

      @target_info = a[2].split(" {")
      @target = @target_info[0]
      @target_id = @target_info[1]

      @ability = a[3].split(" {")[0]
      @ability_id = a[3].split(" {")[1]

      @effect = a[4].split(": ")[0]
      @effect_action = a[4].split(": ")[1]

      @value_info = a[5].split(") ")[0]
      @value= @value_info.split(" ")[0].gsub(/\(|\)|\*/, "")
      @value_type= @value_info.split(" ")[1]

      @threat = @value_info.gsub(/\<|\>/, "").split(") ")[1]
    rescue
      # See String#encode
      encoding_options = {
        :invalid           => :replace,  # Replace invalid byte sequences
        :undef             => :replace,  # Replace anything not defined in ASCII
        :replace           => '',        # Use a blank for those replacements
        :universal_newline => true       # Always break lines with \n
      }
      parse_line(line.encode(Encoding.find('ASCII'), encoding_options))
        
    end
  end

  def enter?
    @effect_action.include?("EnterCombat")
  end

  def dmg?
    @effect_action.include?("Damage") && @target != nil
  end

  def heal?
    @effect_action.include?("Heal")
  end

  def exit?
    @effect_action.include?("EnterCombat")
  end

  def parse_log
    @dmg_values = []
    @abilities = []
    @ability_totals = {}
    @ability_avgs={}
    @log_string =""

    open_file
    first_line = @combat_log.each_line.first
    @player = first_line.gsub(/\[|\@/, "").split("] ")[1]

    @combat_log.each_line do |line|
      parse_line(line)
      if dmg? && @source == @player
        @dmg_values << @value.to_i
        @abilities << @ability
      end
      if enter?
        @log_string << "#{@time}: #{@source} entered combat\n"
      elsif exit?
        @log_string << "#{@time}: #{@source} exited combat\n"
      elsif heal?
        @log_string <<  "#{@time}: #{@source} healed #{@target} with #{@ability} for #{@value} points\n"
      elsif (dmg?) && (@value != '0') && (@source != nil)
        @log_string << "#{@time}: #{@source} hit #{@target} with #{@ability} for #{@value} points\n"
      elsif (dmg?) && (@value != '0') && (@source == nil)
        @log_string << "#{@time}: #{@target} was hit with the #{@ability} debuff for #{@value} points\n"
      elsif (dmg?) && (@value == '0')
        @log_string << "#{@time}: #{@source} missed #{@target} with #{@ability}\n"
      end
    end
  end

  def player_character
    parse_log
    @player
  end

  def output_log_string
    parse_log
    @log_string
  end

  def total_dmg
    parse_log
    @total = 0
    @dmg_values.each {|val| @total += val}
    @total
  end

  def average_dmg
    parse_log
    if @dmg_values.empty?
      avg = 0
    else
    avg = @total/@dmg_values.count
  end
    avg
  end

  def dmg_per_ability
    parse_log
    @ability_dmg_vals = @abilities.zip(@dmg_values)
    hash= Hash.new { |h,k| h[k] = [] }
    @ability_dmg_vals.each { |k,v| hash[k] << v }

    hash.each do |k, v|
      sum= 0
      v.each do |val| 
        sum += val
      end
      avg = sum/v.count
      @ability_avgs[k] = avg
      @ability_totals[k] = sum
    end
  end

  def ability_avgs
    dmg_per_ability
    @ability_avgs.sort_by {|_k,v| v}
  end

  def ability_totals
    dmg_per_ability
    @ability_totals.sort_by {|_k,v| v}
  end

  def ability_dmg_percentage
    dmg_per_ability
    @percentage_hash={}
    @ability_totals.each do |k, v|
      @percentage_hash[k] = (v/@total.to_f)*100
    end
    @percentage_hash.sort_by {|_k,v| v}
  end

end