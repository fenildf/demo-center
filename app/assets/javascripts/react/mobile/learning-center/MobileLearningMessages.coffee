{ Icon } = antd

module.exports = MobileLearningMessages = React.createClass
  render: ->
    <MobileLearningCenterLayout title='查看更新消息' menu_active={3}>
      <MessagesList messages={@props.messages} />
    </MobileLearningCenterLayout>


MessagesList = React.createClass
  render: ->
    <div className='messages-list shadow-card'>
      <div className='unread'>
        <span>未处理消息</span><span className='number'>7</span>
      </div>
      <div className='list'>
      {
        for message, idx in @props.messages
          <MessageItem key={idx} message={message} />
      }
      </div>
    </div>

MessageItem = React.createClass
  getInitialState: ->
    opened: false

  render: ->
    message = @props.message

    classes = ClassName
      'item': true
      'opened': @state.opened

    <div className={classes}>
      <div className='ct' onClick={@toggle}>
        <div className='title'>{message.title}</div>
        <div className='desc'>{message.desc}</div>
        <div className='time'>{message.time}</div>
      </div>
      <div className='ops'>
        <a className='op add' href='javascript:;'><Icon type='plus' /> 列入计划</a>
        <a className='op later' href='javascript:;'>稍后提醒</a>
        <a className='op ignore' href='javascript:;'>忽略</a>
      </div>
    </div>

  toggle: ->
    @setState opened: not @state.opened