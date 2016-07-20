{ Icon } = antd

module.exports = MobileLearningSubjects = React.createClass
  render: ->
    <MobileLearningCenterLayout title='课程中心' menu_active={1}>
      <Search placeholder='根据标题，内容搜索课程或问题' />
      <Ways />
    </MobileLearningCenterLayout>

Search = React.createClass
  render: ->
    <div className='search-input'>
      <Icon type='search' />
      <input placeholder={@props.placeholder} />
    </div>

Ways = React.createClass
  render: ->
    <div className='ways'>
      <h3>选择一种查找方式</h3>

      <WayCard
        title='按分级导航'
        desc='全面系统地进行学习'
        icon='book'
        link='/mobile/learning-center/subjects/outline'
      />
      <WayCard
        title='按岗位要求'
        desc='掌握岗位工作技能'
        icon='team'
      />
      <WayCard
        title='按问题目标'
        desc='解决具体问题和任务'
        icon='tags-o'
      />
    </div>

WayCard = React.createClass
  render: ->
    <a className='way-card shadow-card' href={@props.link}>
      <Icon type={@props.icon} />
      <div className='ct'>
        <div className='title'>{@props.title}</div>
        <div className='desc'>{@props.desc}</div>
      </div>
    </a>
