Tabulous.setup do

  tabs do
    upload_file_tab do
    text {'Log Index'}
    link_path {combat_parsers_path(@combat_parsers)}
    visible_when  { true }
    enabled_when  { true }
    active_when   { in_action('index').of_controller('combat_parsers') }
  end

    combat_text_tab do
      text          { 'Parsed Combat Log Text' }
      link_path     { combat_parser_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('show').of_controller('combat_parsers') }
    end

    breakdown_tab do
      text          { "Combat Log Breakdown" }
      link_path     { "#{combat_parser_path}/breakdown"}
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('breakdown').of_controller('combat_parsers') }
    end
end


  

  customize do

    # which class to use to generate HTML
    :default
    # :default, :html5, :bootstrap, or :bootstrap_pill
    # or create your own renderer class and reference it here
    # renderer :default

    # whether to allow the active tab to be clicked
    # defaults to true
    # active_tab_clickable true

    # what to do when there is no active tab for the current controller action
    # :render -- draw the tabset, even though no tab is active
    # :do_not_render -- do not draw the tabset
    # :raise_error -- raise an error
    # defaults to :do_not_render
    # when_action_has_no_tab :do_not_render

    # whether to always add the HTML markup for subtabs, even if empty
    # defaults to false
    # render_subtabs_when_empty false

  end

  # The following will insert some CSS straight into your HTML so that you
  # can quickly prototype an app with halfway-decent looking tabs.
  #
  # This scaffolding should be turned off and replaced by your own custom
  # CSS before using tabulous in production.
  use_css_scaffolding do
 
    background_color 'black'
    text_color 'white'
    active_tab_color 'red'
    hover_tab_color '#cda509'
    inactive_tab_color 'black'
    inactive_text_color 'white'

  end

end
