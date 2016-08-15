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
    added: false


  render: ->
    <div>

      <MobileLearningCenterSecondaryLayout 
        title='知识体系导航'
        back_to='/mobile/learning-center/subjects'
      >
        {
          if @state.stack.length
            <StackBreadcrumb stack={@state.stack} enter={@enter} />
        }

        {
          if @state.current_point?
            <PointHeader key={@state.current_point.id} point={@state.current_point} />
          else
            <KNetHeader key={'root'} />
        }

        {
          if @state.current_children.length
            <SubjectCourses added={@state.added} add_to_plan={@add_to_plan} />
          else
            <SubjectCourses added={@state.added} add_to_plan={@add_to_plan} sample />
        }

        {
          if @state.current_children.length
            <div>
              <h3>详细知识构成</h3>
              <SubjectsTree
                subjects={@state.current_children}
                _filter={(x)-> true}
              />
            </div>
          else
        }
      </MobileLearningCenterSecondaryLayout>
      <EnterPlans plans={@props.plans} ref='ep' added={@added} />
    </div>

  enter: (subject)->
    id = if subject then subject.id else ''

    url = URI(location.href)
      .fragment id
      .toString()

    Turbolinks.visit url

  add_to_plan: ->
    @refs.ep.setState open: true

  added: ->
    @setState added: true



StackBreadcrumb = React.createClass
  render: ->
    <div className='stack-breadcrumb shadow-card'>
      <Breadcrumb>
        <Breadcrumb.Item onClick={@enter(null)}>
          <a href='javascript:;'>银行职业知识体系</a>
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
      <div className='title'>银行职业知识体系</div>
      <div className='time'>更新于：5 小时前</div>
      <div className='image' style={backgroundImage: "url(#{imgurl})"} />
      <div className='desc'>银行业从业员工需要掌握的各种知识技能</div>
      <div className='stat'>
        {
          href = "/mobile/learning-center/messages/points"
          <a className='enter-channel' href={href}>
            <Icon type='right' /> 进入互动频道
          </a>
        }

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
        {
          href = "/mobile/learning-center/messages/point-#{@props.point.id}"
          <a className='enter-channel' href={href}>
            <Icon type='right' /> 进入互动频道
          </a>
        }
        <div className='s s2'>
          <Icon type='message' /> 27
        </div>
        <div className='s s1'>
          <Icon type='team' /> 45
        </div>
      </div>
    </div>

# ChildrenSubjects = React.createClass
#   render: ->
#     <div className='knet-subjects'>
#     {
#       for subject, idx in @props.subjects
#         <a key={subject.id} className='subject shadow-card' onClick={@enter(subject)}>
#           <Icon type='pay-circle-o' className='icc'/>
#           <div className='ct'>
#             <div className='title'>{subject.name}</div>
#             <div className='progress'>
#               <Progress percent={66 + idx} />
#             </div>
#           </div>
#         </a>
#     }
#     </div>

#   enter: (subject)->
#     =>
#       @props.enter subject


SubjectCourses = React.createClass
  render: ->
    <div className='subject-courses'>
      {
        if @props.added
          <div className='added-to-plan'>
            <Icon type='check' /> 已经列入学习计划
          </div>
        else
          <div className='add-to-plan'>
            <a href='javascript:;' onClick={@add}><Icon type='plus' /> 列入学习计划</a>
          </div>
      }

      {
        if @props.sample
          <div>
            <div className='demo-tip shadow-card'>
              <Icon type='info-circle-o' /> 演示版本不包括实际课程内容
            </div>

            <div className='courses-list shadow-card'>
              <div className='course with-img' onClick={-> Turbolinks.visit '/mobile/learning-center/subjects/outline/video'}>
                <Icon className='icc' type='video-camera' />
                <div className='ct'>
                  <div className='title'>外汇知识</div>
                  <div className='img' style={backgroundImage: "url(http://i.teamkn.com/i/wtn2Ranl.jpg?imageMogr2/thumbnail/!200x200)"} />
                  <Icon className='play' type='play-circle' />
                </div>
              </div>
              <div className='course'>
                <Icon className='icc' type='file-excel' />
                <div className='ct'>
                  <div className='title'>汇率换算表</div>
                </div>
              </div>
              <div className='course with-img' onClick={-> Turbolinks.visit '/mobile/learning-center/subjects/outline/ppt'}>
                <Icon className='icc' type='file-pdf' />
                <div className='ct'>
                  <div className='title'>国际汇市</div>
                  <div className='img' style={backgroundImage: "url(http://i.teamkn.com/i/mWGdDLFe.jpg?imageMogr2/thumbnail/!200x200)"} />
                </div>
              </div>
              <div className='course'>
                <Icon className='icc' type='share-alt' />
                <div className='ct'>
                  <div className='title'>外汇兑换流程</div>
                </div>
              </div>
            </div>

            <div>
              <a className='demo-test' href='http://csm.mindpin.com/test' target='_blank'>
                <Icon type='check' /> 进行线上测验
              </a> 
            </div>
          </div>
      }
    </div>

  add: ->
    @props.add_to_plan()

EnterPlans = React.createClass
  getInitialState: ->
    open: false

  render: ->
    if @state.open
      <div className='modal-enter-plans'>
        <div className='modal'>
          <h3>将知识点加入计划夹</h3>
          <Plans
            plans={@props.plans}
            submit={@submit}
          />
        </div>
      </div>
    else
      <div />

  submit: ->
    @setState open: false
    @props.added()

Plans = React.createClass
  render: ->
    <div>
      <a className='add-plan' href='javascript:;'>
        <Icon type='plus-circle-o' />
        创建计划夹
      </a>
      <div className='plans'>
      {
        for plan, idx in @props.plans
          <Plan key={idx} plan={plan} />
      }
      </div>
      <div className='submit'>
        <a className='enter-submit' href='javascript:;' onClick={@props.submit}>
          <Icon type='check' />
          确定
        </a>
      </div>
    </div>


Plan = React.createClass
  getInitialState: ->
    selected: false

  render: ->
    classes = ClassName
      'plan': true
      'selected': @state.selected

    <a className={classes} onClick={@toggle}>
      <Icon type='bars' className='icc' />
      <div className='ct'>
        <div className='title'>{@props.plan.name}</div>
        <div className='desc'>{@props.plan?.points?.length} 个知识点</div>
      </div>
      {
        if @state.selected
          <div className='pgs'>
            <Icon type='check-circle' />
          </div>
      }
    </a>

  toggle: ->
    @setState selected: not @state.selected