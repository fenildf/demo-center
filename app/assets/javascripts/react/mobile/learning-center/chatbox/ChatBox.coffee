{ Icon, Progress, QueueAnim } = antd

module.exports = ChatBox = React.createClass
  getInitialState: ->
    messages: @props.messages

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
          <div className='title'>{@props.title}</div>
          <div className='desc'>频道说明：{@props.desc}</div>
        </div>

    Messages: React.createClass
      getInitialState: ->
        messages: @props.messages

      render: ->
        <div className='messages'>
          <div className='date'><span>今天</span></div>
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
                <Point name={message.new_point} />
              </div>
          }
          {
            if message.updated_point?
              <div className='attach'>
                <Point name={message.updated_point} />
              </div>
          }
        </div>
      </div>
    </div>


Point = React.createClass
  render: ->
    <div className='point'>
      <Icon type='pay-circle-o' className='icc'/>
      <div className='ct'>
        <div className='title'>{@props.name}</div>
      </div>
    </div>