{ Icon } = antd

module.exports = MobileLearningMessagesChannel = React.createClass
  getInitialState: ->
    show_message: null
    open_talker: null

  render: ->
    <div>
      <MobileLearningCenterChatLayout 
        title={@props.messages?.channel?.name}
        back_to='/mobile/learning-center/messages'
        talkers={@props.talkers}
      >
        <ChatBox
          talkers={@props.talkers}
          messages={@props.messages}
          show_detail={@show_detail}
          open_talker={@open_talker}
        >
          <ChatBox.Theme 
            channel={@props.messages?.channel}
          />
        </ChatBox>
      </MobileLearningCenterChatLayout>
      {
        <Detail message={@state.show_message} talkers={@props.talkers} ref='detail' />
      }
    </div>

  show_detail: (message)->
    =>
      @setState show_message: message
      @refs.detail.setState open: true

  open_talker: (talker)->
    # console.log 'open', talker

Detail = React.createClass
  getInitialState: ->
    open: false

  render: ->
    if @state.open
      talker = @props.talkers[@props.message.by]

      <div className='modal-message-detail'>
        <div className='header'>
          <Icon className='l' type='arrow-left' onClick={@close}/>
          <Icon className='r' type='star-o' />
        </div>
        <div className='share-to'>
          <div className='to to-weixin'>转发到微信</div>
          <div className='to to-weibo'>转发到微博</div>
        </div>
        <div className='message-content'>
          <ChatBox.Message 
            message={@props.message} talker={talker} 
          />
        </div>
        <div className='detail-btns'>
        {
          if @props.message.updated_point
            url = "/mobile/learning-center/subjects/outline#2-7"
            <a className='detail-btn' href={url}><Icon type='eye' />查看知识点</a>
        }
        {
          if @props.message.new_point
            url = "/mobile/learning-center/subjects/outline#2-7"
            <div>
              <div>
                <a className='detail-btn' href={url}><Icon type='eye' />查看知识点</a>
              </div>
              <div>
                <a className='detail-btn accept'><Icon type='plus' />列入学习计划</a>
              </div>
              <div>
                <a className='detail-btn ignore'><Icon type='delete' />不再提醒</a>
              </div>
            </div>
        }
        {
          if @props.message.notice
            <a className='detail-btn'><Icon type='eye' />查看通知详情</a>
        }
        {
          if @props.message.file
            <a className='detail-btn'><Icon type='download' />查看文件</a>
        }
        {
          if not @props.message.todo and not @props.new_point
            <a className='detail-btn'><Icon type='calendar' />加入待办事项</a>
        }
        </div>
      </div>
    else
      <div />

  close: ->
    @setState open: false

Talker = React.createClass
  getInitialState: ->
    open: true
  render: ->
    if @state.open
      <div className='modal-talker'>
      </div>
    else
      <div />

