{ Icon, Progress } = antd

module.exports = MobileLearningPlanId = React.createClass
  render: ->
    subjects = @props.plan.points.map (id)=>
      arr = id.split('-').map (x)-> x - 1
      subject = 
        children: @props.points
      for idx in arr
        subject = subject.children[idx]
      subject

    <MobileLearningCenterSecondaryLayout 
      title="学习计划夹：#{@props.plan.name}"
      back_to='/mobile/learning-center/plan'
    >
      <Header plan={@props.plan} />

      <h3>计划夹内知识点</h3>
      <SubjectsTree
        key={@props.plan.id}
        subjects={subjects}
        _filter={(x)-> true}
      />
    </MobileLearningCenterSecondaryLayout>

Header = React.createClass
  render: ->
    <div className='plan-header shadow-card'>
      <Icon type='bars' className='icc' />
      <div className='ct'>
        <div className='title'>{@props.plan.name}</div>
        <div className='desc'>{@props.plan?.points?.length} 个知识点</div>
      </div>
      <div className='pgs'>
        <Progress type="circle" percent={37} width={60} strokeWidth={10} />
      </div>
      <div className='updated-at'>
        <Icon type='clock-circle-o' /> 最后更新时间：2016 年 7 月 27 日
      </div>
    </div>