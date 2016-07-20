class Mobile::LearningCenterController < ApplicationController
  layout 'simulate-mobile'

  def index
    @component_name = 'MobileLearningCenter'
  end

  def progress
    @component_name = 'MobileLearningProgress'
  end

  def messages
    messages = [1, 2, 3, 4, 5, 6, 7].map {|x|
      {
        title: "消息#{x}",
        desc: "描述#{x} " * 13,
        time: "3 小时前"
      }
    }

    @component_name = 'MobileLearningMessages'
    @component_data = {
      messages: messages
    }
  end

  def plan
    @component_name = 'MobileLearningPlan'
  end

  def subjects
    @component_name = 'MobileLearningSubjects'
  end

  def subjects_outline
    @component_name = 'MobileLearningSubjectsOutline'
  end
end
