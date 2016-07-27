{ Icon, Progress, QueueAnim } = antd

module.exports = ChatBox = React.createClass
  getInitialState: ->
    messages: @props.messages.messages

  render: ->
    <div className='chatbox'>
      {@props.children}

      <ChatBox.Messages 
        talkers={@props.talkers}
        messages={@state.messages}
      />
    </div>

  scrolldown: ->
    setTimeout ->
      $mc = jQuery('.mobile-content')
      height = $mc.height()
      sh = $mc[0].scrollHeight
      $mc[0].scrollTop = sh - height

      # console.log sh - height
    , 1

  componentDidMount: ->
    @scrolldown()

    jQuery(document)
      .off 'chatbox:send'
      .on 'chatbox:send', (evt, obj)=>
        text = obj.message
        message = 
          by: 'me'
          text: text

        messages = @state.messages
        messages.push message
        @setState messages: messages
        @scrolldown()


  statics:
    Theme: React.createClass
      render: ->
        <div className='theme'>
          <div className='title'>{@props.channel?.name}</div>
          <div className='desc'>频道说明：{@props.channel?.desc}</div>
          {
            if @props.channel?.back_to?
              <a className='back-to' href={@props.channel?.back_to}>
                <Icon type='left' /> 回到知识点
              </a>
          }
        </div>

    Messages: React.createClass
      getInitialState: ->
        messages: @props.messages

      render: ->
        <div className='messages'>
          <div className='date'><span>2016 年 7 月 26 日</span></div>
          {
            for message, idx in @state.messages
              talker = @props.talkers[message.by]
              <Message key={idx} message={message} talker={talker} />
          }
        </div>

Message = React.createClass
  render: ->
    talker = @props.talker
    message = @props.message

    <div className="message #{message.by}">
      <div className='avatar' style={backgroundImage: "url(#{talker.avatar})"} />
      <div className='ct'>
        <div className='who-when'>
          <span className='name'>{talker.name}</span>
          <span className='time'>15:00</span>
        </div>
        <div className='text'>
          <div className='t'>{message.text}</div>
          {
            if message.new_point?
              <div className='attach'>
                <Point point={message.new_point} />
              </div>
          }
          {
            if message.updated_point?
              <div className='attach'>
                <Point point={message.updated_point} />
              </div>
          }
          {
            if message.photo?
              <div className='attach'>
                <Photo photo={message.photo} />
              </div>
          }
          {
            if message.comment?
              <div className='comment'>
                <Icon className='c' type='message' /> {message.comment}
              </div>
          }
          {
            if message.question?
              <div className='attach'>
                <Question question={message.question} />
              </div>
          }
        </div>
      </div>
    </div>


Point = React.createClass
  render: ->
    <div>
      <div className='point'>
        <Icon type='pay-circle-o' className='icc'/>
        <div className='ct'>
          <div className='title'>{@props.point?.name}</div>
        </div>
      </div>
      {
        if @props.point?.reason?
          <div className='reason'>{@props.point.reason}</div>
      }
    </div>

Photo = React.createClass
  render: ->
    # console.log @props.photo.surl
    <div className='photo' style={backgroundImage: "url(#{@props.photo.surl})"}>
    </div>

Question = React.createClass
  render: ->
    <div className='question'>
      <div className='qct'><Icon type='question-circle-o' /> {@props.question.content}</div>
      <div className='tags'>
      {
        for tag, idx in @props.question?.tags || []
          <div className='tag' key={idx}><Icon type='tag' /> {tag}</div>
      }
      </div>
    </div>