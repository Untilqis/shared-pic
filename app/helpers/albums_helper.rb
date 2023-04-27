module AlbumsHelper
  def render_with_tags(description)
    description.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/album/tag/#{word.delete("#")}"}.html_safe
  end 
end
