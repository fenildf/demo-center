{ Icon, Progress, Breadcrumb } = antd

module.exports = MobileLearningSubjectsOutline = React.createClass
  getInitialState: ->
    current_point_id = URI(location.href).fragment()

    if current_point_id == ''
      current_point = null
      current_children = @props.points
      stack = []

    else
      # 根据 current_point_id 找到对象
      idxes = current_point_id.split('-')
      children = @props.points
      stack = []
      for idx in idxes
        p = children[idx - 1]
        stack.push p
        children = p.children
      current_children = children
      current_point = p


    current_point: current_point
    current_children: current_children || []
    stack: stack


  render: ->
    <MobileLearningCenterSecondaryLayout 
      title='课程分级导航'
      back_to='/mobile/learning-center/subjects'
    >
      {
        if @state.stack.length
          <StackBreadcrumb stack={@state.stack} enter={@enter} />
      }

      {
        if @state.current_point?
          <PointHeader point={@state.current_point} />
        else
          <KNetHeader />
      }

      {
        if @state.current_children.length
          <h3>知识构成</h3>
          <ChildrenSubjects 
            subjects={@state.current_children} 
            enter={@enter}
          />
        else
          <SubjectCourses />
      }
    </MobileLearningCenterSecondaryLayout>

  enter: (subject)->
    id = if subject then subject.id else ''

    url = URI(location.href)
      .fragment id
      .toString()

    Turbolinks.visit url



StackBreadcrumb = React.createClass
  render: ->
    <div className='stack-breadcrumb shadow-card'>
      <Breadcrumb>
        <Breadcrumb.Item onClick={@enter(null)}>
          <a href='javascript:;'>银行职业培训</a>
        </Breadcrumb.Item>
        {
          for subject in @props.stack
            <Breadcrumb.Item key={subject.id} onClick={@enter(subject)}>
              <a href='javascript:;'>{subject.name}</a>
            </Breadcrumb.Item>
        }
      </Breadcrumb>
    </div>

  enter: (subject)->
    =>
      @props.enter subject


KNetHeader = React.createClass
  render: ->
    imgurl = 'http://i.teamkn.com/i/Ivl1XEL0.jpg'

    <div className='knet-header shadow-card'>
      <div className='title'>银行职业培训</div>
      <div className='time'>更新于：5小时前</div>
      <div className='image' style={backgroundImage: "url(#{imgurl})"} />
      <div className='desc'>银行业从业员工需要掌握的各种知识技能</div>
      <div className='stat'>
        <div className='s s2'>
          <Icon type='message' /> 27
        </div>
        <div className='s s1'>
          <Icon type='team' /> 45
        </div>
      </div>
    </div>

PointHeader = React.createClass
  render: ->
    <div className='knet-header shadow-card'>
      <div className='title'>{@props.point.name}</div>
      <div className='time'>更新于：5小时前</div>
      <div className='stat'>
        <div className='s s2'>
          <Icon type='message' /> 27
        </div>
        <div className='s s1'>
          <Icon type='team' /> 45
        </div>
      </div>
    </div>

ChildrenSubjects = React.createClass
  render: ->
    <div className='knet-subjects'>
    {
      for subject, idx in @props.subjects
        <a key={subject.id} className='subject shadow-card' onClick={@enter(subject)}>
          <Icon type='pay-circle-o' className='icc'/>
          <div className='ct'>
            <div className='title'>{subject.name}</div>
            <div className='progress'>
              <Progress percent={66 + idx} />
            </div>
          </div>
        </a>
    }
    </div>

  enter: (subject)->
    =>
      @props.enter subject


SubjectCourses = React.createClass
  render: ->
    <div className='subject-courses'>
      <div className='add-to-plan'>
        <a href='javascript:;'><Icon type='plus' /> 列入学习计划</a>
      </div>

      <div className='demo-tip shadow-card'>
        <Icon type='info-circle-o' /> 演示版本不包括实际课程内容
      </div>
    </div>