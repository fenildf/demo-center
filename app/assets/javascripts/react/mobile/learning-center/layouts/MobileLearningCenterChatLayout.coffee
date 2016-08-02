{ Icon } = antd

module.exports = MobileLearningCenterChatLayout = React.createClass
  render: ->
    title = @props.title

    <div className='mobile-learning-center chat'>
      <HeaderBar 
        title={title} 
        back_to={@props.back_to} 
        open_talkers={@open_talkers}
      />
      <MobileContent>
        {@props.children}
      </MobileContent>
      <div className='sendbox'>
        <input type='text' placeholder="输入消息 #{title}" ref='ipt'/>
        <Icon className='send' type='enter' onClick={@send}/>
      </div>
      {
        <Talkers ref='talkers' talkers={@props.talkers} />
      }
    </div>

  send: ->
    val = jQuery(ReactDOM.findDOMNode @refs.ipt).val()
    if jQuery.trim(val).length > 0
      jQuery(document).trigger('chatbox:send', message: val)
      jQuery(ReactDOM.findDOMNode @refs.ipt).val('')

  open_talkers: ->
    @refs.talkers.setState open: true


HeaderBar = React.createClass
  render: ->
    <div className='header-bar'>
      <a className='back-to' href={@props.back_to}><Icon type='left' /></a>
      <div className='title'>{@props.title}</div>
      <a className='talkers right-icon' onClick={@props.open_talkers}><Icon type='team' /></a>
    </div>

MobileContent = React.createClass
  render: ->
    <div className='mobile-content'>
      {@props.children}
    </div>


Talkers = React.createClass
  getInitialState: ->
    open: false

  render: ->
    if @state.open
      <div className='modal-talkers'>
        <div className='header'>
          <Icon className='l' type='arrow-left' onClick={@close}/>
          <div className='title'>频道成员</div>
        </div>
        <div className='talkers'>
        {
          for key, talker of @props.talkers
            <Talker key={key} talker={talker} />
        }
          <div style={textAlign: 'center'}>
            <a className='multi-chat'><Icon type='team' /> 发起多人会话</a>
          </div>
        </div>
      </div>
    else
      <div />

  close: ->
    @setState open: false

Talker = React.createClass
  getInitialState: ->
    selected: false

  render: ->
    talker = @props.talker

    classes = ClassName
      'talker': true
      'selected': @state.selected

    <div className={classes} onClick={@toggle}>
      <div 
        className='avatar' 
        style={backgroundImage: "url(#{talker.avatar})"} 
      />
      <div className='role'>
        {
          if talker.role == '系统助手'
            <span className='system'>{talker.role}</span>
          else
            <span>{talker.role}</span>
        }
      </div>
      <div className='name'>{talker.name}</div>
      <Icon className='icc' type='check-circle' />
    </div>

  toggle: ->
    @setState selected: not @state.selected