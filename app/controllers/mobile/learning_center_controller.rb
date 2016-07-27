class Mobile::LearningCenterController < ApplicationController
  layout 'simulate-mobile'

  def index
    @component_name = 'MobileLearningCenter'
  end

  def progress
    @component_name = 'MobileLearningProgress'
  end

  def messages
    @component_name = 'MobileLearningMessages'
    @component_data = {}
  end

  def messages_channel
    talkers = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'talkers.yaml')
    messages = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'messages.yaml')

    @component_name = 'MobileLearningMessagesChannel'
    @component_data = {
      talkers: talkers,
      messages: messages[params[:channel]]
    }
  end

  def plan
    @component_name = 'MobileLearningPlan'
  end

  def subjects
    @component_name = 'MobileLearningSubjects'
  end

  def subjects_outline
    points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')

    @component_name = 'MobileLearningSubjectsOutline'
    @component_data = {
      points: points_data
    }
  end

  def subjects_posts
    posts_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-posts.yaml')
    points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')

    @component_name = 'MobileLearningSubjectsPosts'
    @component_data = {
      posts: posts_data,
      points: points_data
    }
  end

  def subjects_posts_all
    @component_name = 'MobileLearningSubjectsPostsAll'
  end

  def subjects_target
    @component_name = 'MobileLearningSubjectsTarget'
    @component_data = {
      dashboard_url: '/mobile/learning-center',
      search_url: '/mobile/learning-center/target-search',
      recommend_words: SearchBox::Parser.get_hot_sorted_keywords()[0..2],
    }
  end

  def target_search
    if params[:keywords] == nil
      return render json: {
        recommend_words: SearchBox::Parser.get_hot_sorted_keywords()[0..2],
        results: []
      }
    end
    render json: {
      recommend_words: SearchBox::Parser.get_releated_keywords_by_keyword(params[:keywords])[0..5],
      results: SearchBox::Parser.get_qustions_by_keywords(params[:keywords])[0..5]
    }
  end
end
