{ Icon } = antd

module.exports = MobileLearningCenterChatLayout = React.createClass
  render: ->
    title = @props.title

    <div className='mobile-learning-center chat'>
      <HeaderBar title={title} back_to={@props.back_to} />
      <MobileContent>
        {@props.children}
      </MobileContent>
      <div className='sendbox'>
        <input type='text' placeholder="输入消息 #{title}" ref='ipt'/>
        <Icon className='send' type='enter' onClick={@send}/>
      </div>
    </div>

  send: ->
    val = jQuery(ReactDOM.findDOMNode @refs.ipt).val()
    if jQuery.trim(val).length > 0
      jQuery(document).trigger('chatbox:send', message: val)
      jQuery(ReactDOM.findDOMNode @refs.ipt).val('')


HeaderBar = React.createClass
  render: ->
    <div className='header-bar'>
      <a className='back-to' href={@props.back_to}><Icon type='left' /></a>
      <div className='title'>{@props.title}</div>
    </div>

MobileContent = React.createClass
  render: ->
    <div className='mobile-content'>
      {@props.children}
    </div>