module Capextensions

  DATE_TIME_SUFFIXES = {
          :year   => '1i',
          :month  => '2i',
          :day    => '3i',
          :hour   => '4i',
          :minute => '5i'
  }

  def click_link_within(selector, link_text)
    within(:css, selector) do
      click_link link_text
    end
  end

  def select_date(date_to_select, options={})
    date = date_to_select.is_a?(Date) || date_to_select.is_a?(Time) ?
            date_to_select : Date.parse(date_to_select)

    if options[:id_prefix].blank?
      if options[:from].blank?
        source = locate(:xpath, Capybara::XPath.append("//select[contains(@id, '_#{DATE_TIME_SUFFIXES[:year]}')]"))
        id_prefix = source.node.attributes["id"].value[/(.*?)_#{DATE_TIME_SUFFIXES[:year]}$/, 1]
      else
        msg = "cannot select option, no select box with id, name, or label '#{options[:from]}' found"
        begin
          label = locate(:xpath, Capybara::XPath.append("//label[text()='#{options[:from]}']"), msg)
          id_prefix = label.node.attributes["for"].value
        rescue Capybara::ElementNotFound
          begin
            previous_exception = $!
            label = locate(:xpath, Capybara::XPath.append("//label[text()='#{options[:from].capitalize}']"), msg)
            id_prefix = label.node.attributes["for"].value
          rescue
            raise "#{previous_exception}\nand\n#{$!}"
          end
        end
      end
    end

    id_prefix ||= options[:id_prefix]

    select date.year, :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:year]}"
    select date.strftime('%B'), :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:month]}"
    select date.day, :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:day]}"
  end

  def select_time(time_to_select, options ={})
    time = time_to_select.is_a?(Time) ? time_to_select : Time.parse(time_to_select)

    if options[:id_prefix].blank?
      if options[:from].blank?
        source = locate(:xpath, Capybara::XPath.append("//select[contains(@id, '_#{DATE_TIME_SUFFIXES[:hour]}')]"))
        id_prefix = source.node.attributes["id"].value[/(.*?)_#{DATE_TIME_SUFFIXES[:hour]}$/, 1]
      else
        msg = "cannot select option, no select box with id, name, or label '#{options[:from]}' found"
        begin
          label = locate(:xpath, Capybara::XPath.append("//label[text()='#{options[:from]}']"), msg)
          id_prefix = label.node.attributes["for"].value
        rescue Capybara::ElementNotFound
          begin
            previous_exception = $!
            label = locate(:xpath, Capybara::XPath.append("//label[text()='#{options[:from].capitalize}']"), msg)
            id_prefix = label.node.attributes["for"].value
          rescue
            raise "#{previous_exception}\nand\n#{$!}"
          end
        end
      end
    end

    id_prefix ||= options[:id_prefix]

    select time.hour.to_s.rjust(2, '0'), :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:hour]}"
    select time.min.to_s.rjust(2, '0'), :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:minute]}"
  end

  def select_datetime(time_to_select, options={})
    time = time_to_select.is_a?(Time) ? time_to_select : Time.parse(time_to_select)

    if options[:from]
      msg = "cannot select option, no select box with id, name, or label '#{options[:from]}' found"
      begin
        label = locate(:xpath, Capybara::XPath.append("//label[text()='#{options[:from]}']"), msg)
        id_prefix = label.node.attributes["for"].value
      rescue Capybara::ElementNotFound
        begin
          previous_exception = $!
          label = locate(:xpath, Capybara::XPath.append("//label[text()='#{options[:from].capitalize}']"), msg)
          id_prefix = label.node.attributes["for"].value
        rescue
          raise "#{previous_exception}\nand\n#{$!}"
        end
      end
    end

    options[:id_prefix] ||= (options[:from] ? id_prefix : nil)

    select_date time, options
    select_time time, options
  end

  # Maybe this methos should be defined in the other order, capybara is the default?
  def response(*args, &block)
    page(*args, &block)
  end

  def have_tag(*args, &block)
    text = args[1]
    unless text.blank?
      have_css(args.first, :text => text)
    else
      have_css(args.first)
    end
  end

  def have_selector(path, options = {})
    # content key to text key
    content = options.delete(:content)
    options[:text] = content unless content.nil?
    have_css(path, options)
  end
end

World(Capextensions)