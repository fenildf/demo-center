{ Icon } = antd

module.exports = MobileLearningMessagesChannel = React.createClass
  getInitialState: ->
    show_message: null

  render: ->
    <div>
      <MobileLearningCenterChatLayout 
        title={@props.messages?.channel?.name}
        back_to='/mobile/learning-center/messages'
      >
        <ChatBox
          talkers={@props.talkers}
          messages={@props.messages}
          show_detail={@show_detail}
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
            <a className='detail-btn' href={url}><Icon type='eye' />查看知识点</a>
        }
        {
          if @props.message.notice
            <a className='detail-btn' href={url}><Icon type='eye' />查看通知详情</a>
        }
        {
          if @props.message.file
            <a className='detail-btn' href={url}><Icon type='download' />查看文件</a>
        }
        </div>
      </div>
    else
      <div />

  close: ->
    @setState open: false



