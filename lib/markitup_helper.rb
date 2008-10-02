module MarkitupHelper

  def markitup_init(options = {})
    default_options = {:set => 'default', :skin => 'markitup'}
    @options = default_options.merge(options)

    markitup_element('textarea') if @uses_markitup
  end

  def markitup(element = 'textarea')
    @options = {:set => 'default', :skin => 'markitup'}

    markitup_element(element)
  end

private
  def javascript_include_markitup
    return '' if @included_once
    @included_once = true

    markitup_path = '/javascripts/markitup'

    javascript_include_tag("#{markitup_path}/jquery.markitup.pack.js",
                           "#{markitup_path}/sets/#{@options[:set]}/set.js") +
    stylesheet_link_tag("#{markitup_path}/skins/#{@options[:skin]}/style.css",
                        "#{markitup_path}/sets/#{@options[:set]}/style.css")
  end

  def markitup_element(element)
    content_for :markitup do
      javascript_include_markitup +
      javascript_tag do <<-END
          $(function() {
            $("#{element}").markItUp(mySettings);
          });
        END
      end
    end

    nil
  end

end
