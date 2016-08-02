{ Icon, Progress, QueueAnim } = antd

module.exports = ChatBox = React.createClass
  getInitialState: ->
    messages: @props.messages.messages
    responses: @props.messages.responses

  render: ->
    <div className='chatbox'>
      {@props.children}

      <ChatBox.Messages 
        talkers={@props.talkers}
        messages={@state.messages}
        show_detail={@props.show_detail}
        open_talker={@props.open_talker}
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

        @response(text)

  response: (text)->
    sendd = (message)=>
      messages = @state.messages
      messages.push message
      @setState messages: messages
      @scrolldown()


    setTimeout =>
      if @state.responses?[text]
        mgs = @state.responses[text]
        message = mgs[~~(Math.random() * mgs.length)]

        window.correct_msg = message.sends?[message.correct]
        sendd(message)

      else if @state.responses?['any']
        mgs = @state.responses['any']
        message = mgs[~~(Math.random() * mgs.length)]
        sendd(message)


      else if window.correct_msg
        if text == window.correct_msg
          window.correct_msg = null
          message =
            by: 'pbot'
            text: '答对了！'
            sends: ['继续练习']

          sendd(message)

        else
          window.correct_msg = null
          message =
            by: 'pbot'
            text: '答错了！'
            sends: ['继续练习']

          sendd(message)
    , 1000

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
              <Message key={idx} 
                message={message} talker={talker} 
                show_detail={@props.show_detail(message)}
                open_talker={@props.open_talker}
              />
          }
        </div>

Message = React.createClass
  render: ->
    talker = @props.talker
    message = @props.message

    <div className="message #{message.by}" onClick={@show}>
      <div 
        className='avatar' 
        style={backgroundImage: "url(#{talker.avatar})"} 
        onClick={@open_talker(talker)}
      />
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
            if message.new_plan?
              <div className='attach'>
                <Plan plan={message.new_plan} />
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
          {
            if message.notice?
              <div className='attach'>
                <Notice notice={message.notice} />
              </div>
          }
          {
            if message.file?
              <div className='attach'>
                <File file={message.file} />
              </div>
          }
          {
            if message.todo?
              <div className='attach'>
                <Todo todo={message.todo} />
              </div>
          }
          {
            if message.sends?
              <div className='attach'>
              {
                for s, idx in message.sends
                  <div key={idx} className='send-btn'>
                    <a className='send' onClick={@send(s)}><Icon type='enter' /> {s}</a>
                  </div>
              }
              </div>
          }
        </div>
      </div>
    </div>

  show: ->
    if not @props.message.sends?
      @props.show_detail()

  send: (msg)->
    =>
      jQuery(document).trigger('chatbox:send', message: msg)

  open_talker: (talker)->
    (evt)=>
      # evt.stopPropagation()
      # @props.open_talker(talker)


ChatBox.Message = Message

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

Plan = React.createClass
  render: ->
    console.log @props.plan

    <div>
      <div className='plan'>
        <Icon type='lock' className='icc'/>
        <div className='ct'>
          <div className='title'>{@props.plan?.name}</div>
        </div>
      </div>
      {
        if @props.plan?.reason?
          <div className='reason'>{@props.plan.reason}</div>
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

Notice = React.createClass
  render: ->
    <div className='notice'>
      <div className='time'>
        <Icon className='cal' type='calendar' />
        时间：{@props.notice.date}
      </div>
      <div className='name'>
        <Icon className='cal' type='team' />
        {@props.notice.name}
      </div>
    </div>

File = React.createClass
  render: ->
    <div className='file'>
      <div className='name'>
        <Icon type='file-excel' />
        {@props.file.name}
      </div>
    </div>

Todo = React.createClass
  render: ->
    <div className='todo'>
      <div className='name'>
        {
          if @props.todo.done
            <Icon type='check' />
        }
        {@props.todo.text}
      </div>
    </div>