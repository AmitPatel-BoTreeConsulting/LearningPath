module LinksHelper
  include ActsAsTaggableOn::TagsHelper

  SORT_OPTIONS = ['Added On', 'Updated On', 'Recently Learned', 'Learn Count']

  def options_for_sorting
    options_for_select(SORT_OPTIONS)
  end

  def is_favourite_link?(link)
    link.favourite
  end

  def set_category_icon(link)
    if link.blank?
      category = link.link_type.name
    else
      category = 'No link'
    end


    # category = link.link_type.name
    case category
      when 'Video'
        "fa fa-video-camera"
      when 'Podcast'
        "fa fa-volume-up"
      when 'BlogPost'
        "fa fa-bold"
      when 'Book'
        "fa fa-book"
      when 'Online Course'
        "fa fa-arrow-circle-up"
      when 'Email Course'
        "fa fa-envelope"
      when 'No link'

        "fa fa-file-text"
    end
  end

  def set_tool_tip(link)
    link_type = link.link_type.name
    case link_type
      when 'Video'
        'Click here if you watched it again'
      when 'Podcast'
        'Click here if you listened it again'
      else
        'Click here if you read it again'
    end
  end
  
  def learning_count(link)
    link.learn_times.count
  end

  def set_tooltip_on_count(number)
      "#{number == 0 ? 'Never' : pluralize(number, 'time')} learned"
  end

  def favourite_action_tooltip(link)
    "#{link.favourite? ? 'Unmark ' : 'Mark'} as Favourite"
  end
end
