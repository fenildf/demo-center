{ Icon, Progress } = antd

module.exports = MobileLearningPlan = React.createClass
  render: ->
    <MobileLearningCenterLayout 
      title='学习计划夹' 
      menu_active={2}
      right_icon='plus'
    >
      <Search placeholder='在计划夹中搜索' />

      <h3 style={marginTop: 28}>指定学习计划</h3>
      <div className='plans must'>
        <a className='plan shadow-card' href="/mobile/learning-center/plan/3">
          <Icon type='lock' className='icc' />
          <div className='ct'>
            <div className='title'>入职必读</div>
            <div className='desc'>6 个知识点</div>
          </div>
          <div className='pgs'>
            <Progress type="circle" percent={80} width={60} strokeWidth={10} />
          </div>
          <div className='from'>来自：人力资源部门</div>
        </a>
      </div>

      <h3>自定义学习计划</h3>
      <Plans
        plans={@props.plans}
      />

    </MobileLearningCenterLayout>

Plans = React.createClass
  render: ->
    <div className='plans'>
    {
      for plan, idx in @props.plans
        <Plan key={idx} plan={plan} />
    }
    </div>

Plan = React.createClass
  render: ->
    <a className='plan shadow-card' href="/mobile/learning-center/plan/#{@props.plan.id}">
      <Icon type='bars' className='icc' />
      <div className='ct'>
        <div className='title'>{@props.plan.name}</div>
        <div className='desc'>{@props.plan?.points?.length} 个知识点</div>
      </div>
      <div className='pgs'>
        <Progress type="circle" percent={37} width={60} strokeWidth={10} />
      </div>
    </a>