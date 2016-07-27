{ Icon } = antd

module.exports = MobileLearningMessages = React.createClass
  render: ->
    <MobileLearningCenterLayout title='消息中心' menu_active={3}>
      <Search placeholder='查找消息记录' />
      <Boxes />
    </MobileLearningCenterLayout>


Boxes = React.createClass
  render: ->
    <div className='message-boxes'>
      <h3>系统频道</h3>

      <div className='box-list'>
        <Box new name='# 内容更新消息' icon='message' href='/mobile/learning-center/messages/updating' />
        <Box new name='# 企业通知' icon='notification' />
        <Box new name='# 练习测验' icon='check' />
      </div>

      <h3>知识频道</h3>
    </div>

Box = React.createClass
  render: ->
    <a className='box shadow-card' href={@props.href}>
      {
        if @props.new
          <div className='new'>new</div>
      }
      <Icon className='cicon' type={@props.icon} /> {@props.name}
    </a>

# MessagesList = React.createClass
#   render: ->
#     <div className='messages-list shadow-card'>
#       <div className='unread'>
#         <span>未处理消息</span><span className='number'>7</span>
#       </div>
#       <div className='list'>
#       {
#         for message, idx in @props.messages
#           <MessageItem key={idx} message={message} />
#       }
#       </div>
#     </div>

# MessageItem = React.createClass
#   getInitialState: ->
#     opened: false

#   render: ->
#     message = @props.message

#     classes = ClassName
#       'item': true
#       'opened': @state.opened

#     <div className={classes}>
#       <div className='ct' onClick={@toggle}>
#         <div className='title'>{message.title}</div>
#         <div className='desc'>{message.desc}</div>
#         <div className='time'>{message.time}</div>
#       </div>
#       <div className='ops'>
#         <a className='op add' href='javascript:;'><Icon type='plus' /> 列入计划</a>
#         <a className='op later' href='javascript:;'>稍后提醒</a>
#         <a className='op ignore' href='javascript:;'>忽略</a>
#       </div>
#     </div>

#   toggle: ->
#     @setState opened: not @state.opened