{ Calendar, Icon } = antd

module.exports = MobileLearningTodo = React.createClass
  render: ->
    <MobileLearningCenterLayout 
      title='待办事项' 
      menu_active={4}
      right_icon='plus'
    >
      <Search placeholder='搜索待办事项' />
      <Todos />
    </MobileLearningCenterLayout>

Todos = React.createClass
  render: ->
    <div>
      <h3>今天</h3>
      <div className='todos'>
        <Todo title='给老李回电话' due='2016-07-28' />
        <Todo title='整理业务资料' due='2016-07-28' />
        <Todo title='总结上周客户访谈' due='2016-07-28' />
        <Todo title='浏览财经信息' due='2016-07-28' />
      </div>

      <h3>明天</h3>
      <div className='todos'>
        <Todo title='参加支行交流会' due='2016-07-29' />
      </div>

      <h3>8 月 1 日</h3>
      <div className='todos'>
        <Todo title='参加互联网金融讲座' due='2016-08-01' />
      </div>
    </div>


Todo = React.createClass
  getInitialState: ->
    open: false

  render: ->
    classes = ClassName
      'todo shadow-card': true
      'open': @state.open

    <div className={classes}>
      <Icon className='icc' type='calendar' />
      <div className='ct' onClick={@toggle}>
        <div className='title'>{@props.title} <span className='due'>{@props.due}</span></div>
      </div>
      <div className='btns'>
        <a className='gou'><Icon type='check' /> 完成</a>
        <a className='cha'><Icon type='cross' /> 撤销</a>
      </div>
    </div>

  toggle: ->
    @setState open: not @state.open




dateCellRender = (value)->
  date = new Date(value.time)
  if [27, 29, 30, 3, 5].indexOf(date.getDate()) > -1 and date > new Date()
    <DateCell check />
  else
    <DateCell />


DateCell = React.createClass
  render: ->
    <div className='datec' onClick={@click}>
    {
      if @props.check
        <Icon type='check' />
    }
    </div>

  click: ->
    console.log 1111