module.exports = MobileLearningMessages = React.createClass
  render: ->
    console.log @props
    <MobileLearningCenterLayout title='查看更新消息' menu_active={2}>
      
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
          <div className='item'>
            <div className='title'>{message.title}</div>
            <div className='desc'>{message.desc}</div>
            <div className='time'>{message.time}</div>
          </div>
      }
      </div>
    </div>