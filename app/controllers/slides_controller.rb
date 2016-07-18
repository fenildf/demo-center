class SlidesController < ApplicationController
  layout 'slides'

  before_filter :load_slides_data
  def load_slides_data
    @slides_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'slides.yaml')
  end

  def index
    @component_name = 'SlideShow'
    @component_data = {
      slides: @slides_data
    }
  end
end
