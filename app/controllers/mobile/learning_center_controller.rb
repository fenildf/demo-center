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

    if params[:channel].include? 'mypost'

      messages_data = messages['points']
      messages_data['channel']['name'] = '# 岗位频道：' + '对私客户经理'
      messages_data['channel']['back_to'] = "/mobile/learning-center/subjects/posts"

      @component_data = {
        talkers: talkers,
        messages: messages_data
      }

      return
    end

    if params[:channel].include? 'point-'
      id = params[:channel].sub('point-', '')
      arr = id.split('-').map {|x| x.to_i}
      points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')
      
      @point = {
        'children' => points_data
      }
      arr.each { |idx|
        @point = @point['children'][idx - 1]
      }

      messages_data = messages['points']
      messages_data['channel']['name'] = "# 知识频道：" + @point['name']
      messages_data['channel']['back_to'] = "/mobile/learning-center/subjects/outline##{id}"

      @component_data = {
        talkers: talkers,
        messages: messages_data
      }

      return
    end

    @component_data = {
      talkers: talkers,
      messages: messages[params[:channel]]
    }
  end

  def plan
    plans_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'plans.yaml')
    points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')

    @component_name = 'MobileLearningPlan'
    @component_data = {
      plans: plans_data,
      points: points_data
    }
  end

  def plan_id
    plans_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'plans.yaml')
    points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')

    id = params[:id].to_i

    @component_name = 'MobileLearningPlanId'
    @component_data = {
      plan: plans_data[id],
      points: points_data
    }
  end

  def subjects
    @component_name = 'MobileLearningSubjects'
  end

  def subjects_outline
    points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')
    plans_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'plans.yaml')

    @component_name = 'MobileLearningSubjectsOutline'
    @component_data = {
      points: points_data,
      plans: plans_data
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
    posts_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-posts.yaml')
    @component_name = 'MobileLearningSubjectsPostsAll'
    @component_data = {
      posts: posts_data
    }
  end

  def subjects_target
    @component_name = 'MobileLearningSubjectsTarget'
    @component_data = {
      dashboard_url: '/mobile/learning-center',
      search_url: '/mobile/learning-center/target-search',
      recommend_words: SearchBox::Parser.get_hot_sorted_keywords()[0..2],
    }
  end

  def solve
    points_data = YAML.load_file File.join(Rails.root, 'demo-data', 'learning-center', 'common-points.yaml')

    @component_name = 'MobileLearningSubjectsTargetSolve'
    @component_data = {
      points: points_data
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

  def todo
    @component_name = 'MobileLearningTodo'
    @component_data = {
    }
  end
end
